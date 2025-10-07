library ieee;
use ieee.std_logic_1164.all;

entity piso is
    generic(
        W:integer := 25
    );

    port(
        clk:in std_logic;
        rst_n:in std_logic;
        en:in std_logic;
        data:in std_logic_vector(W-1 downto 0);
        load:in std_logic;
        q:out std_logic
    );
end entity piso;

architecture archpiso of piso is
    signal sr: std_logic_vector(W-1 downto 0) := (others=>'0');
begin
    process(clk, rst_n)
    begin
        if (rst_n = '1') then
            sr <= (others => '0');
        elsif (rising_edge(clk)) then
            if (load = '1') then
                sr <= data;
            elsif (en = '1') then
                sr <= '0' & sr(W-1 downto 1);
            end if;
        end if;
    end process;

    q <= sr(0);

end architecture archpiso;