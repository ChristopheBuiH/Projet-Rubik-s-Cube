library ieee;
use ieee.std_logic_1164.all;

entity piso6_tb is
end entity piso6_tb;

architecture archpiso6_tb of piso6_tb is	
    -- changed code: déplacer CLK_PERIOD ici pour qu'il soit visible par tous les processus
    constant W : integer := 5;
    constant CLK_PERIOD : time := 20 ns;  -- Période d'horloge (50 MHz)
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal en_tb : std_logic := '0';
    signal data0_tb : std_logic_vector(W-1 downto 0) := (others => '0');
    signal data1_tb : std_logic_vector(W-1 downto 0) := (others => '0');
    signal data2_tb : std_logic_vector(W-1 downto 0) := (others => '0');
    signal data3_tb : std_logic_vector(W-1 downto 0) := (others => '0');
    signal data4_tb : std_logic_vector(W-1 downto 0) := (others => '0');
    signal data5_tb : std_logic_vector(W-1 downto 0) := (others => '0');
    signal load_tb : std_logic := '0'; 
    signal q_tb : std_logic_vector(5 downto 0) := (others => '0');
begin
    uut: entity work.piso6
        generic map(
            N => W
        )
        port map(
                clk => clk_tb,
                rst => rst_tb,
                en => en_tb,
                data0 => data0_tb,
                data1 => data1_tb,
                data2 => data2_tb,
                data3 => data3_tb,
                data4 => data4_tb,
                data5 => data5_tb,
                load => load_tb,
                q => q_tb
            );
    clk_process : process
        constant NUM_CYCLES : integer := 1000;
    begin
        for i in 1 to NUM_CYCLES loop
            clk_tb <= '0';
            wait for CLK_PERIOD/2;
            clk_tb <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        clk_tb <= '0';
        wait;
    end process;

    stim_process : process
    begin
        -- Initialisation
        rst_tb <= '1';
        en_tb <= '0';
        load_tb <= '0';
        data0_tb <= "10101";
        data1_tb <= "11011";
        data2_tb <= "11100";
        data3_tb <= "00011";
        data4_tb <= "10010";
        data5_tb <= "01101";

        -- attendre quelques cycles avec reset actif
        wait for 4 * CLK_PERIOD;

        -- relâcher le reset (rst='0' = fonctionnement)
        rst_tb <= '0';

        -- attendre un quart de période pour éviter d'être exactement sur un front
        wait for CLK_PERIOD/4;

        -- synchroniser l'assertion de load sur un front montant
        wait until rising_edge(clk_tb);
        load_tb <= '1';

        -- garder load pendant un cycle complet (vu par le PISO)
        wait until rising_edge(clk_tb);
        load_tb <= '0';

        -- attendre un front pour laisser le système stabiliser
        wait until rising_edge(clk_tb);

        -- activer l'enregistrement (shift)
        en_tb <= '1';
        wait for 10 * CLK_PERIOD;

        en_tb <= '0';

        wait;
    end process;
end architecture archpiso6_tb;