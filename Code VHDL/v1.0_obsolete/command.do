quit -sim

vlib work

vcom command.vhd
vcom command_tb.vhd

vsim -c work.test_bench

# INPUTS
add wave -divider Inputs:
add wave -color green uut/i_clk
add wave -color yellow uut/i_rst
add wave -color yellow uut/i_en
add wave -color yellow uut/i_data

# OUTPUTS
add wave -divider Outputs:
add wave uut/o_en_fetch
add wave uut/o_mXa
add wave uut/o_mXb
add wave uut/o_mYa
add wave uut/o_mYb
add wave uut/o_mZa
add wave uut/o_mZb
add wave uut/o_dirA
add wave uut/o_dirB

run -all

