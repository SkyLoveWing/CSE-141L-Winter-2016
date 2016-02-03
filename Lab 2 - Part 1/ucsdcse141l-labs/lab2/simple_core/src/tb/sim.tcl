#Alvin Edits
# Load simulation
#vsim work.simple_core_tb

#                       Group Name                  Radix               Signal(s)
#add wave    -noupdate   -group {core_tb}            -radix hexadecimal  /core_tb/*
#add wave    -noupdate   -group {simple_reg_file}     -radix hexadecimal  /simple_core_tb/*
#add wave    -noupdate   -group {simple_alu}     -radix hexadecimal  /simple_core_tb/dut/alu/*


#add wave    -noupdate   -group {cl_state_machine}   -radix hexadecimal  /core_tb/dut/core1/state_machine/*

# Use short names

# TODO: Fill this out.
#Edited by Adam
#Load simulation
vsim work.simple_core_tb

#				Group Name      	        Radix 				  Signal(s)
add wave    -noupdate	  -group {simple_reg_file}     		-radix hexadecimal    /simple_core_tb/dut/rf/*
add wave    -noupdate     -group {simple_alu}               	-radix hexadecimal    /simple_core_tb/dut/alu/rd_i
add wave    -noupdate           -group {simple_alu}              	-radix hexadecimal    /simple_core_tb/dut/alu/rs_i
add wave    -noupdate           -group {simple_alu}              	-radix hexadecimal    /simple_core_tb/dut/alu/op_i
add wave    -noupdate           -group {simple_alu}               	-radix hexadecimal    /simple_core_tb/dut/alu/result_o
add wave    -noupdate           -group {simple_alu}              	-radix hexadecimal    /simple_core_tb/dut/alu/writes_rf_o
add wave    -noupdate           -group {simple_alu}              	-radix hexadecimal    /simple_core_tb/dut/alu/stop_o
 
 
#use short names
configure wave -signalnamewidth 1
