library ieee;
use ieee.std_logic_1164.all;

entity command is
generic(
    constant PWM_PERIOD : positive := 70000;       --nombre de période de clk par période de pwm
    constant PWM_CYCLE :  positive :=  35000;       --durée du niveau haut du cycle pwm (en nb de période clk)
    constant QUARTER : positive := 200               --nombre de steps par 1/4 de tour du moteur
);
port(
    i_clk   : in std_logic;
    i_rst   : in std_logic; -- reset pwm and instructions
    i_en    : in std_logic;

    i_data  : in std_logic_vector(5 downto 0);

    o_mXa   : out std_logic; -- sortie pwm moteur A axe X (+X)
    o_mXb   : out std_logic; -- sortie pwm moteur B axe X (-X)
    o_mYa   : out std_logic; -- ...                       (+Y)
    o_mYb   : out std_logic; -- ...                       (-Y)
    o_mZa   : out std_logic; -- ...                       (+Z)
    o_mZb   : out std_logic; -- ...                       (-Z)

    o_dirA  : out std_logic; -- inverse la direction de la voie A
    o_dirB  : out std_logic; -- inverse la direction de la voie B

    o_next_cmd  : out std_logic
);
end entity command;


architecture archCommand of command is 
    signal s_en_motA    : std_logic;         -- enable voie A
    signal s_en_motB    : std_logic;         -- enable voie B
    signal s_pwm        : std_logic := '0';
	signal s_step       : natural range 0 to 2*QUARTER := 0;  -- compteur de pas des moteurs des 2 voies
    signal s_done       : std_logic;
begin
    -- Generate PWM
    process(i_clk)
        variable counter : natural range 0 to PWM_PERIOD := 0;  -- compteur de période de clk
    begin
		if (rising_edge(i_clk)) then         -- generateur pwm
            if (i_rst = '1') then
                counter := 0;
                s_step <= 0;
                s_pwm <= '0';
            elsif (i_en = '1') then
                if (counter < PWM_CYCLE) then
                    s_pwm <= '1';
                    counter := counter + 1;
                elsif (counter < PWM_PERIOD) then
                    s_pwm <= '0';
                    counter := counter + 1;
                elsif (counter = PWM_PERIOD) then
                    counter := 0;
                    s_pwm <= '0';
                    if not(s_step = 2*QUARTER) then
                        s_step <= s_step +1;
                    end if;
                end if;
            end if;
		 end if;
    end process;

    -- Enable motors, and go to next instruction
    process(i_clk)
    begin
        if (rising_edge(i_clk)) then
            if (i_rst = '1') then
                s_done <= '0';
            elsif (i_en = '1') then
                if (s_step < QUARTER) then
                    if ((i_data(3) or i_data(2)) = '1') then    -- (soit not = "00")
                        s_en_motA <= '1';
                    else
                        s_en_motA <= '0';
                    end if;

                    if ((i_data(1) or i_data(0)) = '1') then    -- (soit not = "00")
                        s_en_motB <= '1';
                    else
                        s_en_motB <= '0';
                    end if;

                elsif (s_step < 2*QUARTER) then
                    if (i_data(3 downto 2) = "11") then
                        s_en_motA <= '1';
                    else
                        s_en_motA <= '0';
                    end if;

                    if (i_data(1 downto 0) = "11") then
                        s_en_motB <= '1';
                    else
                        s_en_motB <= '0';
                    end if;

                else
                    s_en_motA <= '0';
                    s_en_motB <= '0';
                    s_done <= '1';
                end if;
            end if;
        end if;
    end process;

    -- Axe X (01)
    with i_data(5 downto 4) select o_mXa <=
                (s_en_motA and s_pwm) when "01",
                '0' when others;
    with i_data(5 downto 4) select o_mXb <=
                (s_en_motB and s_pwm) when "01",
                '0' when others;
    
    -- Axe Y (10)
    with i_data(5 downto 4) select o_mYa <=
                (s_en_motA and s_pwm) when "10",
                '0' when others;
    with i_data(5 downto 4) select o_mYb <=
                (s_en_motB and s_pwm) when "10",
                '0' when others;

    -- Axe Z (11)
    with i_data(5 downto 4) select o_mZa <=
                (s_en_motA and s_pwm) when "11",
                '0' when others;
    with i_data(5 downto 4) select o_mZb <=
                (s_en_motB and s_pwm) when "11",
                '0' when others;

    -- Direction A & B
    with i_data(3 downto 2) select o_dirA <=
                '1' when "10",
                '0' when others;
    with i_data(1 downto 0) select o_dirB <=
                '1' when "10",
                '0' when others;

    o_next_cmd <= s_done;
end architecture archCommand;