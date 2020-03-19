onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/DUT/clock_12m_s
add wave -noupdate /synthi_top_tb/DUT/ws
add wave -noupdate /synthi_top_tb/DUT/adcdat_pr
add wave -noupdate /synthi_top_tb/DUT/adcdat_pl
add wave -noupdate /synthi_top_tb/DUT/dacdat_pl
add wave -noupdate /synthi_top_tb/DUT/dacdat_pr
add wave -noupdate /synthi_top_tb/DUT/load_o
add wave -noupdate /synthi_top_tb/DUT/AUD_BCLK
add wave -noupdate /synthi_top_tb/SW(3)
add wave -noupdate /synthi_top_tb/DUT/i2s_master_1/i2s_decoder_1/shift_l
add wave -noupdate /synthi_top_tb/DUT/i2s_master_1/i2s_decoder_1/shift_r
add wave -noupdate /synthi_top_tb/DUT/i2s_master_1/i2s_decoder_1/bit_cntr_i
add wave -noupdate /synthi_top_tb/DUT/path_control_1/adcdat_pl_i
add wave -noupdate /synthi_top_tb/DUT/path_control_1/adcdat_pr_i
add wave -noupdate /synthi_top_tb/DUT/path_control_1/dacdat_pl_o
add wave -noupdate /synthi_top_tb/DUT/path_control_1/dacdat_pr_o
add wave -noupdate /synthi_top_tb/DUT/path_control_1/loop_back_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 274
configure wave -valuecolwidth 100
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {57320 ns}
