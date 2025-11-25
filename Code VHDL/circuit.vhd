library ieee;
use ieee.std_logic_1164.all;

entity circuit is
generic(
    constant pwm_period : positive := 100000;       --nombre de période de clk par période de pwm
    constant pwm_cycle :  positive :=  50000;       --durée du niveau haut du cycle pwm (en nb de période clk)
    constant quarter : positive := 50;              --nombre de steps par 1/4 de tour du moteur
    constant N : integer := 20                      --nombre max d'opérations sur le cube
);
port(
    i_clk : in std_logic;   -- clock (50MHz)
    i_rst : in std_logic;   -- reset
    i_en  : in std_logic;   -- start bit

    i_data : in std_logic_vector(6*N-1 downto 0);   -- soling data

    o_mXa : out std_logic;  -- sortie pwm moteur A axe X (+X)
    o_mXb : out std_logic;  -- sortie pwm moteur B axe X (-X)
    o_mYa : out std_logic;  -- ...                       (+Y)
    o_mYb : out std_logic;  -- ...                       (-Y)
    o_mZa : out std_logic;  -- ...                       (+Z)
    o_mZb : out std_logic;  -- ...                       (-Z)

    o_dirA : out std_logic; -- inverse la direction de la voie A
    o_dirB : out std_logic  -- inverse la direction de la voie B
);
end entity circuit;

architecture archCircuit of circuit is 

    component piso6
    generic(
        constant N : integer
    );
    port(
        clk:in std_logic;
        rst:in std_logic;
        load:in std_logic;
        en:in std_logic;
        
        data0:in std_logic_vector(N-1 downto 0);
        data1:in std_logic_vector(N-1 downto 0);
        data2:in std_logic_vector(N-1 downto 0);
        data3:in std_logic_vector(N-1 downto 0);
        data4:in std_logic_vector(N-1 downto 0);
        data5:in std_logic_vector(N-1 downto 0);


        q:out std_logic_vector(5 downto 0)
    );
    end component;

    component command
    generic(
        constant pwm_period : positive;
        constant pwm_cycle :  positive;
        constant quarter : positive
    );
    port(
        i_clk  : in std_logic;
        i_rst  : in std_logic;
        i_en   : in std_logic;
        i_data : in std_logic_vector(5 downto 0);

        o_en_fetch : out std_logic;

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
    
    signal piso_rst         : std_logic;
    signal s_data           : std_logic_vector(5 downto 0); -- current instruction
    signal s_en_fetch       : std_logic;                    -- get next instruction
    signal cmd_rst          : std_logic;
    signal cmd_en           : std_logic;

    signal s_current_state  : std_logic_vector(1 downto 0);  -- current state (used for the starting sequence)
    signal s_next_state     : std_logic_vector(1 downto 0);
    signal s_load           : std_logic;    -- load piso6

begin
    piso6_0 : component piso6
    generic map(
        N => N
    )
    port map(
        clk => i_clk,
        rst => piso_rst,
        load => s_load,
        en => s_en_fetch,
        data0 => i_data(N-1 downto 0),
        data1 => i_data(2*N-1 downto N),
        data2 => i_data(3*N-1 downto 2*N),
        data3 => i_data(4*N-1 downto 3*N),
        data4 => i_data(5*N-1 downto 4*N),
        data5 => i_data(6*N-1 downto 5*N),

        q => s_data
    );

    cmd0 : component command
    generic map(
        pwm_period => pwm_period,
        pwm_cycle => pwm_cycle,
        quarter => quarter

    )
    port map(
        i_clk => i_clk,
        i_rst => cmd_rst,
        i_en => cmd_en,
        i_data => s_data,

        o_en_fetch => s_en_fetch,

        o_mXa => o_mXa,
        o_mXb => o_mXb,
        o_mYa => o_mYa,
        o_mYb => o_mYb,
        o_mZa => o_mZa,
        o_mZb => o_mZb,

        o_dirA => o_dirA,
        o_dirB => o_dirB
    );

    process(i_clk, i_en, i_rst)
    begin
        if(i_rst = '1') then
            s_current_state <= "00";
            s_next_state <= "00";
            piso_rst <= '1';
            s_load <= '0';
            cmd_rst <= '1';
        else
            if (i_en = '1' and rising_edge(i_clk)) then
                case s_current_state is
                    when "00" =>    -- chargement des données
                        s_next_state <= "01";
                        s_load <= '1';
                        cmd_rst <= '1';
                    when "01" =>    -- activation des commandes
                        s_next_state <= "10";
                        piso_rst <= '0';
                        cmd_rst <= '0';
                        cmd_en <= '1';
                    when "10" =>    -- arrêt du chargement
                        s_next_state <= "11";
                        s_load <= '0';
                    when "11" =>    -- fonctionnement normal
                        if (s_en_fetch = '1') then
                            cmd_rst <= '1';
                            cmd_en <= '0';
                        else
                            cmd_rst <= '0';
                            cmd_en <= '1';
                        end if;
                    when others =>  -- erreur => restart
                        s_next_state <= "00";
                        piso_rst <= '1';
                end case;
                s_current_state <= s_next_state;
            end if;
        end if;
    end process;


end architecture archCircuit;