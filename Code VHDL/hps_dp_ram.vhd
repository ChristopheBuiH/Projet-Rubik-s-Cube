library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity hps_dp_ram is
generic(
    constant ADDR_WIDTH     : natural := 5;
    constant ARRAY_SIZE     : natural := 32; -- doit être inférieur ou égal à 2**ADDR_WIDTH
    constant DATA_LENGTH    : natural := 6;
    constant START_ADDR     : natural := 32;

    constant PWM_PERIOD     : positive := 70000;    --nombre de période de clk par période de pwm
    constant PWM_CYCLE      :  positive :=  35000;  --durée du niveau haut du cycle pwm (en nb de période clk)
    constant QUARTER        : positive := 200       --nombre de steps par 1/4 de tour du moteur
);
port(
    -- IP
    avs_s1_clk      : in std_logic;
    avs_s1_reset    : in std_logic; 
    
    avs_s1_address  : in std_logic_vector(ADDR_WIDTH-1 downto 0); 
    
    avs_s1_write    : in std_logic;		
    avs_s1_writedata : in std_logic_vector(DATA_LENGTH-1 downto 0);

    avs_s1_read     : in std_logic;		
    avs_s1_readdata : out std_logic_vector(DATA_LENGTH-1 downto 0);

    -- Moteurs
    o_mXa   : out std_logic; -- sortie pwm moteur A axe X (+X)
    o_mXb   : out std_logic; -- sortie pwm moteur B axe X (-X)
    o_mYa   : out std_logic; -- ...                       (+Y)
    o_mYb   : out std_logic; -- ...                       (-Y)
    o_mZa   : out std_logic; -- ...                       (+Z)
    o_mZb   : out std_logic; -- ...                       (-Z)

    o_dirA  : out std_logic; -- inverse la direction de la voie A
    o_dirB  : out std_logic  -- inverse la direction de la voie B
);
end entity hps_dp_ram;


architecture arch_hps_dp_ram of hps_dp_ram is 
    type array_cmd is array (0 to ARRAY_SIZE) of std_logic_vector(DATA_LENGTH-1 downto 0);
    signal table    : array_cmd;

    type state is (LOAD, START, DONE);
    signal present  : state;

    signal readdata : std_logic_vector(DATA_LENGTH-1 downto 0);

    signal s_cmd_rst    : std_logic;
    signal s_cmd_en     : std_logic;
    signal s_data_cmd       : std_logic_vector(DATA_LENGTH-1 downto 0);
    signal s_next_cmd   : std_logic;

    component command
    generic(
        constant PWM_PERIOD : positive;
        constant PWM_CYCLE :  positive;
        constant QUARTER : positive
    );
    port(
        i_clk  : in std_logic;
        i_rst  : in std_logic;
        i_en   : in std_logic;

        i_data : in std_logic_vector(5 downto 0);

        o_mXa  : out std_logic;
        o_mXb  : out std_logic;
        o_mYa  : out std_logic;
        o_mYb  : out std_logic;
        o_mZa  : out std_logic;
        o_mZb  : out std_logic;

        o_dirA : out std_logic;
        o_dirB : out std_logic;

        o_next_cmd : out std_logic
    );
    end component;


begin
    cmd0 : component command
    generic map(
        PWM_PERIOD => PWM_PERIOD,
        PWM_CYCLE => PWM_CYCLE,
        QUARTER => QUARTER

    )
    port map(
        i_clk => avs_s1_clk,
        i_rst => s_cmd_rst,
        i_en => s_cmd_en,

        i_data => s_data_cmd,

        o_mXa => o_mXa,
        o_mXb => o_mXb,
        o_mYa => o_mYa,
        o_mYb => o_mYb,
        o_mZa => o_mZa,
        o_mZb => o_mZb,

        o_dirA => o_dirA,
        o_dirB => o_dirB,

        o_next_cmd => s_next_cmd
    );
    process(avs_s1_clk)
		variable index : integer range 0 to ARRAY_SIZE-1;
		variable writedata : STD_LOGIC_VECTOR(DATA_LENGTH-1 downto 0);
        variable addr_cmd : integer range 0 to ARRAY_SIZE-1 := 0;
	begin
		if (rising_edge(avs_s1_clk)) then
            -------------------------------- RESET
			if (avs_s1_reset = '1') then
				present <= LOAD;
			-------------------------------- WRITE
			elsif (avs_s1_write = '1') then
                ----------------------------------- Calc START
				if (avs_s1_address = conv_std_logic_vector(START_ADDR, ADDR_WIDTH)) then 
					present <= START;
				else
                    ------------------------------- WRITING
					writedata := avs_s1_writedata;
					index := CONV_INTEGER(avs_s1_address);  -- obtenir l'index dans a table
					table(index) <= writedata;              -- on écrit la donnée dans la table à la position donnée par l'index
					present <= LOAD;
				end if;
			------------------------------- READ
			elsif (avs_s1_read = '1') then
				-- si l'adresse correspond à START_ADDR
				if (avs_s1_address = conv_std_logic_vector(START_ADDR, ADDR_WIDTH)) then 
                    if (present = DONE) then
					    readdata <= (others => '1');
                    else 
                        readdata <= (others => '0');
                    end if;
				else
					index := CONV_INTEGER(avs_s1_address);  -- obtenir l'index dans la table				
					readdata <= table(index);               -- on sort la valeur demandée
				end if;
				present <= LOAD;
			end if;

            case (present) is
                when LOAD =>
                    present <= LOAD;
                    s_cmd_rst <= '1';
                    s_cmd_en <= '0';
                    addr_cmd := 0;

                when START =>
                    if (avs_s1_reset = '1') then
                        s_cmd_rst <= '1';
                        s_cmd_en <= '0';
                    elsif (addr_cmd = START_ADDR) then
                        present <= DONE;
                        s_cmd_rst <= '1';
                        s_cmd_en <= '0';
                    elsif(s_next_cmd = '1') then
                        s_cmd_rst <= '1';
                        s_cmd_en <= '0';
                        addr_cmd := addr_cmd + 1;
                    else
                        s_data_cmd <= table(addr_cmd);
                        s_cmd_rst <= '0';
                        s_cmd_en <= '1';
                    end if;

                when DONE =>
                    present <= DONE;
                    s_cmd_rst <= '1';
                    s_cmd_en <= '0';
            end case;
		end if;
	end process;
    
end architecture arch_hps_dp_ram;