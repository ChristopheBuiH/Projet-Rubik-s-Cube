library ieee;
use ieee.std_logic_1164.all;

entity command is
generic(
    constant pwm_period : positive := 70000;       --nombre de période de clk par période de pwm
    constant pwm_cycle :  positive :=  35000;       --durée du niveau haut du cycle pwm (en nb de période clk)
    constant quarter : positive := 200               --nombre de steps par 1/4 de tour du moteur
);
port(
    i_clk : in std_logic;
    i_rst : in std_logic;
    i_en : in std_logic;
    i_data : in std_logic_vector(5 downto 0);

    o_en_fetch : out std_logic; -- passe à 1 pendant une période de clk pour récupérer l'instruction suivante.

    o_mXa : out std_logic;  -- sortie pwm moteur A axe X (+X)
    o_mXb : out std_logic;  -- sortie pwm moteur B axe X (-X)
    o_mYa : out std_logic;  -- ...                       (+Y)
    o_mYb : out std_logic;  -- ...                       (-Y)
    o_mZa : out std_logic;  -- ...                       (+Z)
    o_mZb : out std_logic;  -- ...                       (-Z)

    o_dirA : out std_logic; -- inverse la direction de la voie A
    o_dirB : out std_logic -- inverse la direction de la voie B
);
end entity command;


architecture archCommand of command is 
    signal en_motA : std_logic;         -- enable voie A
    signal en_motB : std_logic;         -- enable voie B
    signal pwm : std_logic := '0';
	signal step : natural range 0 to 2*quarter := 0;  -- compteur de pas des moteurs des 2 voies
begin
    -- Generate PWM
    process(i_clk, i_rst, i_en)
        variable counter : natural range 0 to pwm_period := 0;  -- compteur de période de clk
    begin
        if (i_rst = '1') then
			counter := 0;
            step <= 0;
            pwm <= '0';
		elsif (rising_edge(i_clk) and i_en = '1') then         -- generateur pwm
            if (counter < pwm_cycle) then
                pwm <= '1';
				counter := counter + 1;
            elsif (counter < pwm_period) then
                pwm <= '0';
				counter := counter + 1;
			elsif (counter = pwm_period) then
                counter := 0;
                pwm <= '0';
                if not(step = 2*quarter) then
                    step <= step +1;
                end if;
			end if;
		 end if;
    end process;

    -- Enable motors and fetch next instruction
    process(i_clk, i_data)
    begin
        if (rising_edge(i_clk)) then
            if (step < quarter) then
                if ((i_data(3) or i_data(2)) = '1') then    -- (soit not = "00")
                    en_motA <= '1';
                else
                    en_motA <= '0';
                end if;

                if ((i_data(1) or i_data(0)) = '1') then    -- (soit not = "00")
                    en_motB <= '1';
                else
                    en_motB <= '0';
                end if;

            elsif (step < 2*quarter) then
                if (i_data(3 downto 2) = "11") then
                    en_motA <= '1';
                else
                    en_motA <= '0';
                end if;

                if (i_data(1 downto 0) = "11") then
                    en_motB <= '1';
                else
                    en_motB <= '0';
                end if;

            else
                en_motA <= '0';
                en_motB <= '0';
            end if;
        end if;
    end process;

    -- Fetch
    o_en_fetch <= '1' when ((i_rst = '0') and (i_en = '1')) and ((en_motA = '0') and (en_motB = '0')) else
                  '0';

    -- Axe X (01)
    with i_data(5 downto 4) select o_mXa <=
                (en_motA and pwm) when "01",
                '0' when others;
    with i_data(5 downto 4) select o_mXb <=
                (en_motB and pwm) when "01",
                '0' when others;
    
    -- Axe Y (10)
    with i_data(5 downto 4) select o_mYa <=
                (en_motA and pwm) when "10",
                '0' when others;
    with i_data(5 downto 4) select o_mYb <=
                (en_motB and pwm) when "10",
                '0' when others;

    -- Axe Z (11)
    with i_data(5 downto 4) select o_mZa <=
                (en_motA and pwm) when "11",
                '0' when others;
    with i_data(5 downto 4) select o_mZb <=
                (en_motB and pwm) when "11",
                '0' when others;

    -- Direction A & B
    with i_data(3 downto 2) select o_dirA <=
                '1' when "10",
                '0' when others;
    with i_data(1 downto 0) select o_dirB <=
                '1' when "10",
                '0' when others;
end architecture archCommand;