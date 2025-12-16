	component osmanip is
		port (
			clk_clk                              : in  std_logic := 'X'; -- clk
			osmanip_0_external_connection_o_mxa  : out std_logic;        -- o_mxa
			osmanip_0_external_connection_o_mxb  : out std_logic;        -- o_mxb
			osmanip_0_external_connection_o_mya  : out std_logic;        -- o_mya
			osmanip_0_external_connection_o_myb  : out std_logic;        -- o_myb
			osmanip_0_external_connection_o_mza  : out std_logic;        -- o_mza
			osmanip_0_external_connection_o_mzb  : out std_logic;        -- o_mzb
			osmanip_0_external_connection_o_dirb : out std_logic;        -- o_dirb
			osmanip_0_external_connection_o_dira : out std_logic;        -- o_dira
			reset_reset_n                        : in  std_logic := 'X'  -- reset_n
		);
	end component osmanip;

	u0 : component osmanip
		port map (
			clk_clk                              => CONNECTED_TO_clk_clk,                              --                           clk.clk
			osmanip_0_external_connection_o_mxa  => CONNECTED_TO_osmanip_0_external_connection_o_mxa,  -- osmanip_0_external_connection.o_mxa
			osmanip_0_external_connection_o_mxb  => CONNECTED_TO_osmanip_0_external_connection_o_mxb,  --                              .o_mxb
			osmanip_0_external_connection_o_mya  => CONNECTED_TO_osmanip_0_external_connection_o_mya,  --                              .o_mya
			osmanip_0_external_connection_o_myb  => CONNECTED_TO_osmanip_0_external_connection_o_myb,  --                              .o_myb
			osmanip_0_external_connection_o_mza  => CONNECTED_TO_osmanip_0_external_connection_o_mza,  --                              .o_mza
			osmanip_0_external_connection_o_mzb  => CONNECTED_TO_osmanip_0_external_connection_o_mzb,  --                              .o_mzb
			osmanip_0_external_connection_o_dirb => CONNECTED_TO_osmanip_0_external_connection_o_dirb, --                              .o_dirb
			osmanip_0_external_connection_o_dira => CONNECTED_TO_osmanip_0_external_connection_o_dira, --                              .o_dira
			reset_reset_n                        => CONNECTED_TO_reset_reset_n                         --                         reset.reset_n
		);

