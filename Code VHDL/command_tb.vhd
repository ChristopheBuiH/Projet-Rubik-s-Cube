library ieee;
use ieee.std_logic_1164.all;

entity test_bench is
    -- Entity of a test bench is always empty
end entity test_bench;

architecture tb of test_bench is
    signal tb_clk : std_logic;
    signal tb_i_rst : std_logic;
    signal tb_i_en : std_logic;
    signal tb_i_data : std_logic_vector(5 downto 0);
    signal tb_o_fetch : std_logic;
    signal tb_o_motor : std_logic_vector(5 downto 0);
    signal tb_o_dir : std_logic_vector(1 downto 0);
begin
    uut : entity work.command
        generic map(
            pwm_period => 10,
            pwm_cycle => 4,
            quarter => 10
        )
        port map(
            i_clk => tb_clk,
            i_rst => tb_i_rst,
            i_en => tb_i_en,
            i_data => tb_i_data,

            o_en_fetch => tb_o_fetch,

            o_mXa => tb_o_motor(0),
            o_mXb => tb_o_motor(1),
            o_mYa => tb_o_motor(2),
            o_mYb => tb_o_motor(3),
            o_mZa => tb_o_motor(4),
            o_mZb => tb_o_motor(5),

            o_dirA => tb_o_dir(0),
            o_dirB => tb_o_dir(1)
        );

    -- clk
    process
    begin
        for i in 1 to 2000 loop
            tb_clk <= '1';
            wait for 5 ps;
            tb_clk <= '0';
            wait for 5 ps;
        end loop;
        wait;
    end process;

    process
    begin 
        tb_i_rst <= '1';
        wait for 25 ps;
        tb_i_data <= "011101";
        tb_i_en <= '1';
        wait for 25 ps;
        tb_i_rst <= '0';
        wait for 3 ns;
        tb_i_rst <= '1';
        tb_i_en <= '0';

        tb_i_data <= "100010";
        wait for 25 ps;
        tb_i_rst <= '0';
        tb_i_en <= '1';
        wait for 3 ns;
        tb_i_rst <= '1';
        tb_i_en <= '0';
        
        tb_i_data <= "110110";
        wait for 25 ps;
        tb_i_rst <= '0';
        tb_i_en <= '1';
        wait for 3 ns;
        tb_i_rst <= '1';
        tb_i_en <= '0';
        
        tb_i_data <= "000000";
        wait for 25 ps;
        tb_i_rst <= '0';
        tb_i_en <= '1';
        wait for 3 ns;
        tb_i_rst <= '1';
        tb_i_en <= '0';

        wait;
        
    end process;
end architecture tb;
