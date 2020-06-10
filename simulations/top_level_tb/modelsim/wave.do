onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/DUT/tone_gen/phi_increment
add wave -noupdate -format Analog-Step -height 456 -max 4094.9999999999995 -min -4096.0 -radix decimal /synthi_top_tb/DUT/tone_gen/dds_o
add wave -noupdate /synthi_top_tb/SW
add wave -noupdate -radix hexadecimal /synthi_top_tb/switch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {590 ns} 0} {{Cursor 2} {1304381 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 192
configure wave -valuecolwidth 316
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {896025 ns} {2006630 ns}
