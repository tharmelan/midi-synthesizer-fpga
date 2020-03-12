onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/DUT/CLOCK_50
add wave -noupdate /synthi_top_tb/DUT/GPIO_26
add wave -noupdate /synthi_top_tb/DUT/KEY_0
add wave -noupdate /synthi_top_tb/DUT/KEY_1
add wave -noupdate /synthi_top_tb/DUT/SW_17_0
add wave -noupdate /synthi_top_tb/DUT/AUD_XCK
add wave -noupdate /synthi_top_tb/DUT/I2C_SDAT
add wave -noupdate /synthi_top_tb/DUT/I2C_SCLK
add wave -noupdate /synthi_top_tb/DUT/key_1_sync
add wave -noupdate /synthi_top_tb/DUT/sw_sync
add wave -noupdate /synthi_top_tb/DUT/reset_n_s
add wave -noupdate /synthi_top_tb/DUT/clock_12m_s
add wave -noupdate /synthi_top_tb/DUT/write_s
add wave -noupdate /synthi_top_tb/DUT/write_data
add wave -noupdate /synthi_top_tb/DUT/write_done
add wave -noupdate /synthi_top_tb/DUT/ack_error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {13 us}
