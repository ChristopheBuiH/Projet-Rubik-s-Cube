quit -sim

vlib work

vcom circuit.vhd
vcom circuit_tb.vhd

vsim -c work.circuit_tb

# INPUTS
add wave -divider Inputs:
add wave -color green uut/i_clk
add wave -color yellow uut/i_rst
add wave -color yellow uut/i_en
add wave -color yellow uut/i_data

add wave -color blue uut/s_current_state
add wave -color blue uut/s_next_state
add wave -color blue uut/s_load
add wave -color blue uut/piso_rst
add wave -color blue uut/s_data

add wave -color blue uut/cmd_rst
add wave -color blue uut/cmd_en
add wave -color blue uut/s_en_fetch


# OUTPUTS
add wave -divider Outputs:
add wave uut/o_mXa
add wave uut/o_mXb
add wave uut/o_mYa
add wave uut/o_mYb
add wave uut/o_mZa
add wave uut/o_mZb
add wave uut/o_dirA
add wave uut/o_dirB

run -all

