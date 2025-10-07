library ieee;
use ieee.std_logic_1164.all;

entity piso6 is
    generic(
        W:integer := 25
    );

    port(
        clk:in std_logic;
        rst_n:in std_logic;
        load:in std_logic;
        en:in std_logic;
        data0:in std_logic_vector(W-1 downto 0);
        data1:in std_logic_vector(W-1 downto 0);
        data2:in std_logic_vector(W-1 downto 0);
        data3:in std_logic_vector(W-1 downto 0);
        data4:in std_logic_vector(W-1 downto 0);
        data5:in std_logic_vector(W-1 downto 0);

        --On a les data qui correspondent aux entrées des différents PISO

        q:out std_logic_vector(5 downto 0)

        --On doit avoir une sortie en vecteur, par conséquent. On restitue le bon caractère du vecteur pour chaque PISO
    );
end entity;

architecture archpiso6 of piso6 is
    begin
        p0: entity work.piso(archpiso)
        generic map(
            W => W
        );
        port map(
            clk => clk,
            rst_n => rst_n,
            en => en,
            data => data0,
            load => load,
            q => q(0)
        );

        p1: entity work.piso(archpiso)
        generic map(
            W => W
        );
        port map(
            clk => clk,
            rst_n => rst_n,
            en => en,
            data => data1,
            load => load,
            q => q(1)
        );

        p2: entity work.piso(archpiso)
        generic map(
            W => W
        );
        port map(
            clk => clk,
            rst_n => rst_n,
            en => en,
            data => data2,
            load => load,
            q => q(2)
        );

        p3: entity work.piso(archpiso)
        generic map(
            W => W
        );
        port map(
            clk => clk,
            rst_n => rst_n,
            en => en,
            data => data3,
            load => load,
            q => q(3)
        );

        p4: entity work.piso(archpiso)
        generic map(
            W => W
        );
        port map(
            clk => clk,
            rst_n => rst_n,
            en => en,
            data => data4,
            load => load,
            q => q(4)
        );

        p5: entity work.piso(archpiso)
        generic map(
            W => W
        );
        port map(
            clk => clk,
            rst_n => rst_n,
            en => en,
            data => data5,
            load => load,
            q => q(5)
        );
end architecture archpiso6;