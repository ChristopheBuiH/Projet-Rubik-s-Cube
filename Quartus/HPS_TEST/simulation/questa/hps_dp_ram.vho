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

-- DATE "03/24/2026 14:24:54"

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

ENTITY 	controller_ip IS
    PORT (
	avs_s1_clk : IN std_logic;
	avs_s1_reset : IN std_logic;
	avs_s1_address : IN std_logic_vector(4 DOWNTO 0);
	avs_s1_write : IN std_logic;
	avs_s1_writedata : IN std_logic_vector(7 DOWNTO 0);
	avs_s1_read : IN std_logic;
	avs_s1_readdata : BUFFER std_logic_vector(7 DOWNTO 0);
	pio_out : BUFFER std_logic_vector(7 DOWNTO 0)
	);
END controller_ip;

-- Design Ports Information
-- avs_s1_readdata[0]	=>  Location: PIN_AA23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[1]	=>  Location: PIN_AG20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[2]	=>  Location: PIN_AF28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[3]	=>  Location: PIN_Y17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[4]	=>  Location: PIN_Y5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[5]	=>  Location: PIN_AG18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[6]	=>  Location: PIN_AH9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_readdata[7]	=>  Location: PIN_AE26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pio_out[0]	=>  Location: PIN_AE7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pio_out[1]	=>  Location: PIN_T13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pio_out[2]	=>  Location: PIN_AF5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pio_out[3]	=>  Location: PIN_AF4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pio_out[4]	=>  Location: PIN_AH3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pio_out[5]	=>  Location: PIN_AH4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pio_out[6]	=>  Location: PIN_AH5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pio_out[7]	=>  Location: PIN_T8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[6]	=>  Location: PIN_AG9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[7]	=>  Location: PIN_AF18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_clk	=>  Location: PIN_AF7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_reset	=>  Location: PIN_AE25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_read	=>  Location: PIN_AA13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[0]	=>  Location: PIN_AH6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[1]	=>  Location: PIN_U10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[2]	=>  Location: PIN_Y4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[3]	=>  Location: PIN_Y19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_address[4]	=>  Location: PIN_U9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_write	=>  Location: PIN_V11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[5]	=>  Location: PIN_AE12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[4]	=>  Location: PIN_AD11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[3]	=>  Location: PIN_AG11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[2]	=>  Location: PIN_AE22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[0]	=>  Location: PIN_Y15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- avs_s1_writedata[1]	=>  Location: PIN_AF27,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF controller_ip IS
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
SIGNAL ww_avs_s1_writedata : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_avs_s1_read : std_logic;
SIGNAL ww_avs_s1_readdata : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_pio_out : std_logic_vector(7 DOWNTO 0);
SIGNAL \avs_s1_writedata[6]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[7]~input_o\ : std_logic;
SIGNAL \avs_s1_clk~input_o\ : std_logic;
SIGNAL \avs_s1_reset~input_o\ : std_logic;
SIGNAL \avs_s1_read~input_o\ : std_logic;
SIGNAL \avs_s1_address[0]~input_o\ : std_logic;
SIGNAL \avs_s1_address[1]~input_o\ : std_logic;
SIGNAL \avs_s1_address[2]~input_o\ : std_logic;
SIGNAL \avs_s1_address[3]~input_o\ : std_logic;
SIGNAL \avs_s1_address[4]~input_o\ : std_logic;
SIGNAL \avs_s1_write~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[5]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[4]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[3]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[2]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[0]~input_o\ : std_logic;
SIGNAL \avs_s1_writedata[1]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;

BEGIN

ww_avs_s1_clk <= avs_s1_clk;
ww_avs_s1_reset <= avs_s1_reset;
ww_avs_s1_address <= avs_s1_address;
ww_avs_s1_write <= avs_s1_write;
ww_avs_s1_writedata <= avs_s1_writedata;
ww_avs_s1_read <= avs_s1_read;
avs_s1_readdata <= ww_avs_s1_readdata;
pio_out <= ww_pio_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X68_Y13_N56
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

-- Location: IOOBUF_X53_Y0_N53
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

-- Location: IOOBUF_X66_Y0_N53
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

-- Location: IOOBUF_X68_Y11_N5
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

-- Location: IOOBUF_X2_Y0_N76
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

-- Location: IOOBUF_X50_Y0_N36
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

-- Location: IOOBUF_X36_Y0_N53
\avs_s1_readdata[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_avs_s1_readdata(6));

-- Location: IOOBUF_X68_Y10_N96
\avs_s1_readdata[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_avs_s1_readdata(7));

-- Location: IOOBUF_X12_Y0_N36
\pio_out[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_pio_out(0));

-- Location: IOOBUF_X18_Y0_N2
\pio_out[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_pio_out(1));

-- Location: IOOBUF_X15_Y0_N36
\pio_out[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_pio_out(2));

-- Location: IOOBUF_X10_Y0_N93
\pio_out[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_pio_out(3));

-- Location: IOOBUF_X18_Y0_N36
\pio_out[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_pio_out(4));

-- Location: IOOBUF_X19_Y0_N53
\pio_out[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_pio_out(5));

-- Location: IOOBUF_X21_Y0_N53
\pio_out[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_pio_out(6));

-- Location: IOOBUF_X4_Y0_N19
\pio_out[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_pio_out(7));

-- Location: IOIBUF_X34_Y0_N35
\avs_s1_writedata[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(6),
	o => \avs_s1_writedata[6]~input_o\);

-- Location: IOIBUF_X48_Y0_N75
\avs_s1_writedata[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(7),
	o => \avs_s1_writedata[7]~input_o\);

-- Location: IOIBUF_X17_Y0_N75
\avs_s1_clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_clk,
	o => \avs_s1_clk~input_o\);

-- Location: IOIBUF_X68_Y11_N38
\avs_s1_reset~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_reset,
	o => \avs_s1_reset~input_o\);

-- Location: IOIBUF_X38_Y0_N18
\avs_s1_read~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_read,
	o => \avs_s1_read~input_o\);

-- Location: IOIBUF_X21_Y0_N35
\avs_s1_address[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(0),
	o => \avs_s1_address[0]~input_o\);

-- Location: IOIBUF_X6_Y0_N1
\avs_s1_address[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(1),
	o => \avs_s1_address[1]~input_o\);

-- Location: IOIBUF_X2_Y0_N92
\avs_s1_address[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(2),
	o => \avs_s1_address[2]~input_o\);

-- Location: IOIBUF_X68_Y10_N61
\avs_s1_address[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(3),
	o => \avs_s1_address[3]~input_o\);

-- Location: IOIBUF_X4_Y0_N1
\avs_s1_address[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_address(4),
	o => \avs_s1_address[4]~input_o\);

-- Location: IOIBUF_X15_Y0_N1
\avs_s1_write~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_write,
	o => \avs_s1_write~input_o\);

-- Location: IOIBUF_X19_Y0_N1
\avs_s1_writedata[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(5),
	o => \avs_s1_writedata[5]~input_o\);

-- Location: IOIBUF_X14_Y0_N1
\avs_s1_writedata[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(4),
	o => \avs_s1_writedata[4]~input_o\);

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

-- Location: IOIBUF_X57_Y0_N18
\avs_s1_writedata[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(2),
	o => \avs_s1_writedata[2]~input_o\);

-- Location: IOIBUF_X46_Y0_N1
\avs_s1_writedata[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(0),
	o => \avs_s1_writedata[0]~input_o\);

-- Location: IOIBUF_X66_Y0_N35
\avs_s1_writedata[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_avs_s1_writedata(1),
	o => \avs_s1_writedata[1]~input_o\);

-- Location: LABCELL_X15_Y24_N0
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


