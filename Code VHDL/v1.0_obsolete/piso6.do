quit -sim

vlib work

vcom piso.vhd
vcom piso6.vhd
vcom piso6_tb.vhd

vsim -c work.piso6_tb

# INPUTS (top-level testbench signals)
add wave -divider Inputs:
add wave -color yellow clk_tb
add wave -color yellow rst_tb
add wave -color yellow en_tb
add wave -color yellow data0_tb
add wave -color yellow data1_tb
add wave -color yellow data2_tb
add wave -color yellow data3_tb
add wave -color yellow data4_tb
add wave -color yellow data5_tb
add wave -color yellow load_tb

# OUTPUTS (top-level)
add wave -divider Outputs:
add wave -color green q_tb

run -all