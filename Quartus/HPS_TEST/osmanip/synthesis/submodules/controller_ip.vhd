library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity controller_ip is
generic(
    constant ADDR_WIDTH          : natural := 5;
    constant ARRAY_SIZE          : natural := 32; -- doit être inférieur ou égal à 2**ADDR_WIDTH
    constant DATA_LENGTH         : natural := 8;  -- taille des mots de l'interface avalon
    constant EXERNAL_DATA_LENGTH : natural := 8;
    constant START_ADDR          : natural := 31  -- position du bit de démarrage (entre 0 et ARRAY_SIZE-1)
);
port(
    -- IP
    avs_s1_clk       : in  std_logic;
    avs_s1_reset     : in  std_logic; 
    
    avs_s1_address   : in  std_logic_vector(ADDR_WIDTH-1 downto 0); 
    
    avs_s1_write     : in  std_logic;		
    avs_s1_writedata : in  std_logic_vector(DATA_LENGTH-1 downto 0);

    avs_s1_read      : in  std_logic;		
    avs_s1_readdata  : out std_logic_vector(DATA_LENGTH-1 downto 0);

    -- pio motors
    pio_out          : out std_logic_vector(7 downto 0)
);
end entity controller_ip;


architecture ctrl of controller_ip is 
    type array_cmd is array (0 to ARRAY_SIZE) of std_logic_vector(DATA_LENGTH-1 downto 0);
    signal table        : array_cmd;

    type state is (LOAD, START, SOLVED);
    signal present      : state;

    signal readdata     : std_logic_vector(DATA_LENGTH-1 downto 0);


    component command
    port(
        i_clk  : in std_logic;
        i_rst  : in std_logic;
        i_en   : in std_logic;

        i_data : in std_logic_vector(5 downto 0);
        o_next_cmd : out std_logic;

        o_mXa  : out std_logic;
        o_mXb  : out std_logic;
        o_mYa  : out std_logic;
        o_mYb  : out std_logic;
        o_mZa  : out std_logic;
        o_mZb  : out std_logic;

        o_dirA : out std_logic;
        o_dirB : out std_logic
    );
    end component;

    signal s_cmd_done   : std_logic;
    signal s_cmd_rst    : std_logic;
    signal s_cmd_en     : std_logic;
    signal s_cmd_data   : std_logic_vector(EXERNAL_DATA_LENGTH-3 downto 0);

begin
    cmd0 : component command
    port map(
        i_clk => avs_s1_clk,
        i_rst => s_cmd_rst,
        i_en => s_cmd_en,
        i_data => s_cmd_data,

        o_next_cmd => s_cmd_done,

        o_mXa => pio_out(0),
        o_mXb => pio_out(1),
        o_mYa => pio_out(2),
        o_mYb => pio_out(3),
        o_mZa => pio_out(4),
        o_mZb => pio_out(5),

        o_dirA => pio_out(6),
        o_dirB => pio_out(7)
    );

    process(avs_s1_clk, avs_s1_reset)
		variable index      : integer range 0 to ARRAY_SIZE-1;
		variable writedata  : STD_LOGIC_VECTOR(DATA_LENGTH-1 downto 0);
        variable cmd_addr   : integer range 0 to ARRAY_SIZE-1 := 0;
	begin
		if (rising_edge(avs_s1_clk)) then
            -------------------------------- RESET
			if (avs_s1_reset = '1') then
				present <= LOAD;
                s_cmd_rst <= '1';
                s_cmd_en  <= '0';
			-------------------------------- WRITE
			elsif (avs_s1_write = '1') then
                ----------------------------------- Solving START
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
                    if (present = SOLVED) then
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
                    s_cmd_en  <= '0';
                when START =>
                    ---------------------------------- RESET
                    if (avs_s1_reset = '1') then
                        s_cmd_rst <= '1';
                        s_cmd_en  <= '0';
                    ---------------------------------- SOLVED
                    elsif (cmd_addr = START_ADDR) then
                        present <= SOLVED;
                        s_cmd_rst <= '1';
                        s_cmd_en  <= '0';
                    ---------------------------------- NEXT
                    elsif(s_cmd_done = '1') then
                        s_cmd_rst <= '1';
                        s_cmd_en  <= '0';
                        cmd_addr := cmd_addr + 1;
                    ---------------------------------- MOVE
                    else
                        s_cmd_data <= table(cmd_addr)(EXERNAL_DATA_LENGTH-3 downto 0);
                        s_cmd_rst <= '0';
                        s_cmd_en  <= '1';
                    end if;
                when SOLVED =>
                    present <= SOLVED;
                    s_cmd_rst <= '1';
                    s_cmd_en  <= '0';
            end case;
		end if;
	end process;    
end architecture ctrl;