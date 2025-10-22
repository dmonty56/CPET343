onerror {resume}
radix define States {
    "4'b0001" "input a" -color "cyan",
    "4'b0010" "input b" -color "cyan",
    "4'b0100" "display add" -color "cyan",
    "4'b1000" "display sub" -color "cyan",
    -default default
}
radix define SSD {
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    "7'b1111111" "blank" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /calc_tb/clk
add wave -noupdate /calc_tb/reset
add wave -noupdate -radix binary /calc_tb/a
add wave -noupdate -radix binary /calc_tb/b
add wave -noupdate /calc_tb/btn
add wave -noupdate /calc_tb/uut/btn_res/input_z
add wave -noupdate /calc_tb/uut/btn_res/input_zz
add wave -noupdate /calc_tb/uut/btn_res/input_zzz
add wave -noupdate /calc_tb/uut/btn_sig
add wave -noupdate -radix SSD /calc_tb/HEX2
add wave -noupdate -radix SSD /calc_tb/HEX1
add wave -noupdate -radix SSD /calc_tb/HEX0
add wave -noupdate -radix States /calc_tb/uut/state_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1887 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 69
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {6300 ns}
