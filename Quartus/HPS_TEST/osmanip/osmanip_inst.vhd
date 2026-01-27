	component osmanip is
		port (
			clk_clk                                  : in  std_logic                    := 'X'; -- clk
			reset_reset_n                            : in  std_logic                    := 'X'; -- reset_n
			motor_control_external_connection_export : out std_logic_vector(7 downto 0)         -- export
		);
	end component osmanip;

	u0 : component osmanip
		port map (
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                               clk.clk
			reset_reset_n                            => CONNECTED_TO_reset_reset_n,                            --                             reset.reset_n
			motor_control_external_connection_export => CONNECTED_TO_motor_control_external_connection_export  -- motor_control_external_connection.export
		);

