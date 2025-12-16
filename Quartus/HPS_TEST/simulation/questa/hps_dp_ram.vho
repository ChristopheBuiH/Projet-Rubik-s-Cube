-- Copyright (C) 2025  Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Altera and sold by Altera or its authorized distributors.  Please
-- refer to the Altera Software License Subscription Agreements 
-- on the Quartus Prime software download page.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 24.1std.0 Build 1077 03/04/2025 SC Lite Edition"

-- DATE "12/16/2025 13:53:12"

-- 
-- Device: Altera 5CSEMA4U23C6 Package UFBGA672
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hps_dp_ram IS
    PORT (
	avs_s1_clk : IN std_logic;
	avs_s1_reset : IN std_logic;
	avs_s1_address : IN std_logic_vector(4 DOWNTO 0);
	avs_s1_write : IN std_logic;
	avs_s1_writedata : IN std_logic_vector(5 DOWNTO 0);
	avs_s1_read : IN std_logic;
	avs_s1_readdata : BUFFER std_logic_vector(5 DOWNTO 0);
	o_mXa : BUFFER std_logic;
	o_mXb : BUFFER std_logic;
	o_mYa : BUFFER std_logic;
	o_mYb : BUFFER std_logic;
	o_mZa : BUFFER std_logic;
	o_mZb : BUFFER std_logic;
	o_dirA : BUFFER std_logic;
	o_dirB : BUFFER std_logic
	);
END hps_dp_ram;

-- Design Ports Information
-- avs_s1_readdata[0]	=>  Location: PIN_AH22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[1]	=>  Location: PIN_AA23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[2]	=>  Location: PIN_AE17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[3]	=>  Location: PIN_AF27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[4]	=>  Location: PIN_AG28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[5]	=>  Location: PIN_Y4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_mXa	=>  Location: PIN_AH16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_mXb	=>  Location: PIN_AB23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_mYa	=>  Location: PIN_U14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_mYb	=>  Location: PIN_AH5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_mZa	=>  Location: PIN_T11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_mZb	=>  Location: PIN_AE19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_dirA	=>  Location: PIN_V10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_dirB	=>  Location: PIN_AE25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_reset	=>  Location: PIN_AH14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_write	=>  Location: PIN_AE26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[0]	=>  Location: PIN_U10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[1]	=>  Location: PIN_Y5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[2]	=>  Location: PIN_AH17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[3]	=>  Location: PIN_AA20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[4]	=>  Location: PIN_T8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[0]	=>  Location: PIN_AF5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[1]	=>  Location: PIN_AE24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[2]	=>  Location: PIN_T13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[3]	=>  Location: PIN_AG11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[4]	=>  Location: PIN_AE11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[5]	=>  Location: PIN_AG21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_clk	=>  Location: PIN_AF17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_read	=>  Location: PIN_AH27,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF hps_dp_ram IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_avs_s1_clk : std_logic;
SIGNAL ww_avs_s1_reset : std_logic;
SIGNAL ww_avs_s1_address : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_avs_s1_write : std_logic;
SIGNAL ww_avs_s1_writedata : std_logic_vector(5 DOWNTO 0);
SIGNAL ww_avs_s1_read : std_logic;
SIGNAL ww_avs_s1_readdata : std_logic_vector(5 DOWNTO 0);
SIGNAL ww_o_mXa : std_logic;
SIGNAL ww_o_mXb : std_logic;
SIGNAL ww_o_mYa : std_logic;
SIGNAL ww_o_mYb : std_logic;
SIGNAL ww_o_mZa : std_logic;
SIGNAL ww_o_mZb : std_logic;
SIGNAL ww_o_dirA : std_logic;
SIGNAL ww_o_dirB : std_logic;
SIGNAL \avs_s1_reset~input_o\ : std_logic;
SIGNAL \avs_s1_write~input_o\ : std_logic;
SIGNAL \avs_s1_address[0]~input_o\ : std_logic;
SIGNAL \avs_s1_address[1]~input_o\ : std_logic;
SIGNAL \avs_s1_address[2]~input_o\ : std_logic;
SIGNAL \avs_s1_address[3]~input_o\ : std_logic;
SIGNAL \avs_s1_address[4]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[0]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[1]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[2]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[3]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[4]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[5]~input_o\ : std_logic;
SIGNAL \avs_s1_clk~input_o\ : std_logic;
SIGNAL \avs_s1_read~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;

BEGIN

ww_avs_s1_clk <= avs_s1_clk;
ww_avs_s1_reset <= avs_s1_reset;
ww_avs_s1_address <= avs_s1_address;
ww_avs_s1_write <= avs_s1_write;
ww_avs_s1_writedata <= avs_s1_writedata;
ww_avs_s1_read <= avs_s1_read;
avs_s1_readdata <= ww_avs_s1_readdata;
o_mXa <= ww_o_mXa;
o_mXb <= ww_o_mXb;
o_mYa <= ww_o_mYa;
o_mYb <= ww_o_mYb;
o_mZa <= ww_o_mZa;
o_mZb <= ww_o_mZb;
o_dirA <= ww_o_dirA;
o_dirB <= ww_o_dirB;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X59_Y0_N53
\avs_s1_readdata[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_avs_s1_readdata(0));

-- Location: IOOBUF_X68_Y13_N56
\avs_s1_readdata[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_avs_s1_readdata(1));

-- Location: IOOBUF_X44_Y0_N19
\avs_s1_readdata[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_avs_s1_readdata(2));

-- Location: IOOBUF_X66_Y0_N36
\avs_s1_readdata[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_avs_s1_readdata(3));

-- Location: IOOBUF_X65_Y0_N36
\avs_s1_readdata[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_avs_s1_readdata(4));

-- Location: IOOBUF_X2_Y0_N93
\avs_s1_readdata[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_avs_s1_readdata(5));

-- Location: IOOBUF_X46_Y0_N53
\o_mXa~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_o_mXa);

-- Location: IOOBUF_X68_Y12_N56
\o_mXb~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_o_mXb);

-- Location: IOOBUF_X34_Y0_N2
\o_mYa~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_o_mYa);

-- Location: IOOBUF_X21_Y0_N53
\o_mYb~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_o_mYb);

-- Location: IOOBUF_X12_Y0_N2
\o_mZa~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_o_mZa);

-- Location: IOOBUF_X48_Y0_N42
\o_mZb~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_o_mZb);

-- Location: IOOBUF_X6_Y0_N19
\o_dirA~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_o_dirA);

-- Location: IOOBUF_X68_Y11_N39
\o_dirB~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_o_dirB);

-- Location: IOIBUF_X44_Y0_N52
\avs_s1_reset~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_reset,
	o => \avs_s1_reset~input_o\);

-- Location: IOIBUF_X68_Y10_N95
\avs_s1_write~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_write,
	o => \avs_s1_write~input_o\);

-- Location: IOIBUF_X6_Y0_N1
\avs_s1_address[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(0),
	o => \avs_s1_address[0]~input_o\);

-- Location: IOIBUF_X2_Y0_N75
\avs_s1_address[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(1),
	o => \avs_s1_address[1]~input_o\);

-- Location: IOIBUF_X46_Y0_N35
\avs_s1_address[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(2),
	o => \avs_s1_address[2]~input_o\);

-- Location: IOIBUF_X68_Y10_N44
\avs_s1_address[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(3),
	o => \avs_s1_address[3]~input_o\);

-- Location: IOIBUF_X4_Y0_N18
\avs_s1_address[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(4),
	o => \avs_s1_address[4]~input_o\);

-- Location: IOIBUF_X15_Y0_N35
\avs_s1_writedata[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(0),
	o => \avs_s1_writedata[0]~input_o\);

-- Location: IOIBUF_X62_Y0_N41
\avs_s1_writedata[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(1),
	o => \avs_s1_writedata[1]~input_o\);

-- Location: IOIBUF_X18_Y0_N1
\avs_s1_writedata[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(2),
	o => \avs_s1_writedata[2]~input_o\);

-- Location: IOIBUF_X38_Y0_N35
\avs_s1_writedata[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(3),
	o => \avs_s1_writedata[3]~input_o\);

-- Location: IOIBUF_X14_Y0_N18
\avs_s1_writedata[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(4),
	o => \avs_s1_writedata[4]~input_o\);

-- Location: IOIBUF_X55_Y0_N75
\avs_s1_writedata[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(5),
	o => \avs_s1_writedata[5]~input_o\);

-- Location: IOIBUF_X40_Y0_N41
\avs_s1_clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_clk,
	o => \avs_s1_clk~input_o\);

-- Location: IOIBUF_X65_Y0_N52
\avs_s1_read~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_read,
	o => \avs_s1_read~input_o\);

-- Location: LABCELL_X58_Y7_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


