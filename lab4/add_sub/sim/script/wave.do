onerror {resume}
radix define States {
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
    "7'b1111111" " " -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_tb/clk
add wave -noupdate /counter_tb/reset
add wave -noupdate -radix States -childformat {{/counter_tb/seven_seg_out(6) -radix States} {/counter_tb/seven_seg_out(5) -radix States} {/counter_tb/seven_seg_out(4) -radix States} {/counter_tb/seven_seg_out(3) -radix States} {/counter_tb/seven_seg_out(2) -radix States} {/counter_tb/seven_seg_out(1) -radix States} {/counter_tb/seven_seg_out(0) -radix States}} -subitemconfig {/counter_tb/seven_seg_out(6) {-height 15 -radix States} /counter_tb/seven_seg_out(5) {-height 15 -radix States} /counter_tb/seven_seg_out(4) {-height 15 -radix States} /counter_tb/seven_seg_out(3) {-height 15 -radix States} /counter_tb/seven_seg_out(2) {-height 15 -radix States} /counter_tb/seven_seg_out(1) {-height 15 -radix States} /counter_tb/seven_seg_out(0) {-height 15 -radix States}} /counter_tb/seven_seg_out
add wave -noupdate /counter_tb/uut/enable
add wave -noupdate /counter_tb/uut/sum
add wave -noupdate /counter_tb/uut/sum_sig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {33 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 58
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
WaveRestoreZoom {0 ns} {1197 ns}
