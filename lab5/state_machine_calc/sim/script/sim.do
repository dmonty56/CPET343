vlib work
vcom -93 -work work ../../src/num_to_ssd.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../src/calc_tb.vhd
vsim -voptargs=+acc calc_tb
do wave.do
run 6000 ns
