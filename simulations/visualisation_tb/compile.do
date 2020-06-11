# create work library
vlib work

# compile project files

vcom -2008 -explicit -work work ../../support/simulation_pkg.vhd
vcom -2008 -explicit -work work ../../support/standard_driver_pkg.vhd
vcom -2008 -explicit -work work ../../support/user_driver_pkg.vhd

#MS5

vcom -2008 -explicit -work work ../../../source/MS5_Visualisierung/visualisierung.vhd



vcom -2008 -explicit -work work ../../../source/MS5_Visualisierung/tb/visualisierung_tb.vhd


# run the simulation
vsim -novopt -t 1ns -lib work work.visualisierung_tb
do ./wave.do
run 150 ms
