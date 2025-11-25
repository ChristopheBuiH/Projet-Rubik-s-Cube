library ieee;
use ieee.std_logic_1164.all;

entity piso6 is
    generic(
        constant N : integer := 5  --nombre max d'opérations sur le cube
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
end entity;

architecture archpiso6 of piso6 is

    component piso
    generic(
        constant N : integer
    );
    port(
        clk     : in std_logic;
        rst   : in std_logic;
        en      : in std_logic;
        data    : in std_logic_vector(N-1 downto 0);
        load    : in std_logic;
        q       : out std_logic
    );
    end component;

begin
    p0 : component piso
        generic map(
            N => N
        )
        port map(
            clk => clk,
            rst => rst,
            en => en,
            data => data0,
            load => load,
            q => q(0)
        );

    p1 : component piso
        generic map(
            N => N
        )
        port map(
            clk => clk,
            rst => rst,
            en => en,
            data => data1,
            load => load,
            q => q(1)
        );

    p2 : component piso
        generic map(
            N => N
        )
        port map(
            clk => clk,
            rst => rst,
            en => en,
            data => data2,
            load => load,
            q => q(2)
        );
    p3 : component piso
        generic map(
            N => N
        )
        port map(
            clk => clk,
            rst => rst,
            en => en,
            data => data3,
            load => load,
            q => q(3)
        );
    p4 : component piso
        generic map(
            N => N
        )
        port map(
            clk => clk,
            rst => rst,
            en => en,
            data => data4,
            load => load,
            q => q(4)
        );
    p5 : component piso
        generic map(
            N => N
        )
        port map(
            clk => clk,
            rst => rst,
            en => en,
            data => data5,
            load => load,
            q => q(5)
        );
end architecture archpiso6;