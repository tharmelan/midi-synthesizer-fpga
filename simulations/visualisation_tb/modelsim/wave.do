onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /visualisierung_tb/DUT/clk
add wave -noupdate /visualisierung_tb/DUT/reset_n
add wave -noupdate /visualisierung_tb/DUT/audiodata_i
add wave -noupdate /visualisierung_tb/DUT/led_o
add wave -noupdate /visualisierung_tb/DUT/switch
add wave -noupdate /visualisierung_tb/DUT/data_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 72
configure wave -valuecolwidth 257
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ns} {17318 ns}
