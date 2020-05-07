# create work library
vlib work

# compile project files
vcom -2008 -explicit -work work ../../support/simulation_pkg.vhd
vcom -2008 -explicit -work work ../../support/standard_driver_pkg.vhd
vcom -2008 -explicit -work work ../../support/user_driver_pkg.vhd
vcom -2008 -explicit -work work ../../../source/reg_table_pkg.vhd

vcom -2008 -explicit -work work ../../../source/codec_controller.vhd
vcom -2008 -explicit -work work ../../../source/i2c_master.vhd
vcom -2008 -explicit -work work ../../../source/i2c_slave_bfm.vhd
vcom -2008 -explicit -work work ../../../source/infrastructure.vhd
vcom -2008 -explicit -work work ../../../source/modulo_divider.vhd
vcom -2008 -explicit -work work ../../../source/synchronize.vhd

vcom -2008 -explicit -work work ../../../source/i2s_decoder.vhd
vcom -2008 -explicit -work work ../../../source/counter.vhd
vcom -2008 -explicit -work work ../../../source/i2s_master.vhd
vcom -2008 -explicit -work work ../../../source/shiftreg_p2s.vhd
vcom -2008 -explicit -work work ../../../source/shiftreg_s2p.vhd
vcom -2008 -explicit -work work ../../../source/path_control.vhd

#MS3

vcom -2008 -explicit -work work ../../../source/MS3_tone_gen/tone_gen_pkg.vhd
vcom -2008 -explicit -work work ../../../source/MS3_tone_gen/dds.vhd
vcom -2008 -explicit -work work ../../../source/MS3_tone_gen/tone_generator.vhd

#MS4

vcom -2008 -explicit -work work ../../../source/MS4_MIDI/baud_tick.vhd
vcom -2008 -explicit -work work ../../../source/MS4_MIDI/flanken_detect.vhd
vcom -2008 -explicit -work work ../../../source/MS4_MIDI/midi_controller.vhd
vcom -2008 -explicit -work work ../../../source/MS4_MIDI/midi_controller_fsm.vhd
vcom -2008 -explicit -work work ../../../source/MS4_MIDI/midi_uart.vhd
vcom -2008 -explicit -work work ../../../source/MS4_MIDI/shiftreg_s2p_ms4.vhd
vcom -2008 -explicit -work work ../../../source/MS4_MIDI/uart_controller_fsm.vhd

vcom -2008 -explicit -work work ../../../source/synthi_top.vhd
vcom -2008 -explicit -work work ../../../source/synthi_top_tb.vhd


# run the simulation
vsim -novopt -t 1ns -lib work work.synthi_top_tb
do ./wave.do
run 150 ms
