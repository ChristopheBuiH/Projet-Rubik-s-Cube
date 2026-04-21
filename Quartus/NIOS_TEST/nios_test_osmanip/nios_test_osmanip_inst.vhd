	component nios_test_osmanip is
		port (
			clk_clk                              : in  std_logic                    := 'X'; -- clk
			osmanip_0_external_connection_export : out std_logic_vector(7 downto 0);        -- export
			pio_0_external_connection_export     : out std_logic_vector(7 downto 0);        -- export
			reset_reset_n                        : in  std_logic                    := 'X'  -- reset_n
		);
	end component nios_test_osmanip;

	u0 : component nios_test_osmanip
		port map (
			clk_clk                              => CONNECTED_TO_clk_clk,                              --                           clk.clk
			osmanip_0_external_connection_export => CONNECTED_TO_osmanip_0_external_connection_export, -- osmanip_0_external_connection.export
			pio_0_external_connection_export     => CONNECTED_TO_pio_0_external_connection_export,     --     pio_0_external_connection.export
			reset_reset_n                        => CONNECTED_TO_reset_reset_n                         --                         reset.reset_n
		);

