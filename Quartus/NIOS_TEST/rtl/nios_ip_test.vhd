library ieee;
use ieee.std_logic_1164.all;

library nios_test_osmanip;
use nios_test_osmanip.nios_test_osmanip;

entity nios_ip_test is
    port (
        i_clk : in std_logic;
        i_rst_n : in std_logic;
        o_pio : out std_logic_vector(7 downto 0);
        o_led : out std_logic_vector(7 downto 0)
    );
end entity nios_ip_test;

architecture rtl of nios_ip_test is
    
begin
    nios0 : entity nios_test_osmanip.nios_test_osmanip
    port map (
        clk_clk                                 => i_clk,
        reset_reset_n                           => i_rst_n,
        osmanip_0_external_connection_export    => o_pio,
        pio_0_external_connection_export        => o_led
    );
end architecture rtl;