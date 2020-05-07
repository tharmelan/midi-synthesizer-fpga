onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/DUT/midi_uart1/uart_data
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/note_o
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/midi_data_i
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/data_valid_i
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/new_data_s
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/sel_status_s
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/sel_data1_s
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/sel_data2_s
add wave -noupdate /synthi_top_tb/DUT/midi_uart1/ser_data_i
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/reg_data1
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/reg_data2
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/reg_status
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/next_reg_note_on
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/reg_note_on
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/reg_note
add wave -noupdate /synthi_top_tb/DUT/midi_ctr/next_reg_note
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1087597 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 299
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
WaveRestoreZoom {0 ns} {2539154 ns}
