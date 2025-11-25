library ieee;
use ieee.std_logic_1164.all;

entity circuit_tb is
end entity circuit_tb;

architecture tb of circuit_tb is
    signal tb_i_clk : std_logic;
    signal tb_i_rst : std_logic;
    signal tb_i_en : std_logic;

    signal tb_i_data : std_logic_vector(6*5-1 downto 0);

    signal tb_o_mXa : std_logic;
    signal tb_o_mXb : std_logic;
    signal tb_o_mYa : std_logic;
    signal tb_o_mYb : std_logic;
    signal tb_o_mZa : std_logic;
    signal tb_o_mZb : std_logic;

    signal tb_o_dirA : std_logic;
    signal tb_o_dirB : std_logic;

begin
    uut : entity work.circuit
        generic map(
            pwm_period => 10,
            pwm_cycle => 4,
            quarter => 10,
            N => 5
        )
        port map(
            i_clk => tb_i_clk,
            i_rst => tb_i_rst,
            i_en => tb_i_en,

            i_data => tb_i_data,

            o_mXa => tb_o_mXa,
            o_mXb => tb_o_mXb,
            o_mYa => tb_o_mYa,
            o_mYb => tb_o_mYb,
            o_mZa => tb_o_mZa,
            o_mZb => tb_o_mZb,

            o_dirA => tb_o_dirA,
            o_dirB => tb_o_dirB
            
        );

    -- clk
    process
    begin
        for i in 1 to 2000 loop
            tb_i_clk <= '1';
            wait for 5 ps;
            tb_i_clk <= '0';
            wait for 5 ps;
        end loop;
        wait;
    end process;
    
    -- test
    process
    begin 
        tb_i_rst <= '1';
        tb_i_en <= '0';
        tb_i_data <= "001100110101001101010011000001"; -- 011101 100010 110110 011000 000100 ==> 00110011010101001101010011000001
        wait for 25 ps;
        tb_i_en <= '1';
        wait for 15 ps;
        tb_i_rst <= '0';
        wait;
    end process;
end architecture tb;
