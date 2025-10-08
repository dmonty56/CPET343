vlib work
vcom -93 -work work ../../src/num_to_ssd.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/add_sub.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../src/add_sub_tb.vhd
vsim -voptargs=+acc add_sub_tb
do wave.do
run 3000 ns
