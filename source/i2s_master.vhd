-------------------------------------------------------------------------------
-- Title      : i2s_master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2s_master.vhd
-- Author     : Markus Bodenmann
-- Company    : 
-- Created    : 2020-03-12
-- Last update: 2020-03-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity i2s_master is

  port (
    clk_12m	  : in     std_logic;
    DACDAT_pl : in     std_logic_vector(15 downto 0);
    DACDAT_pr : in     std_logic_vector(15 downto 0);
    INIT_N    : in     std_logic;
    s_data_i  : in     std_logic;
    ADCDAT_pl : out    std_logic_vector(15 downto 0);
    ADCDAT_pr : out    std_logic_vector(15 downto 0);
    STROBE    : out    std_logic;
    s_data_o  : out    std_logic;
    BCKL      : out    std_logic;
    ws        : out    std_logic
    );

end entity i2s_master;

-------------------------------------------------------------------------------

architecture rtl of i2s_master is
  --SIGNALS
  signal BCLK_INT   : std_logic;


  --COMPONENTS
  component modulo_divider is
    generic (
      width      : positive);
    port (
      clk, reset_n : IN  std_logic;
      clk_12m      : OUT std_logic);
  end component modulo_divider;
  
  component counter is
    generic (
      width      : positive);
    port (
      clk 		: in  std_logic;
	  clk_count : in  std_logic;
	  reset_n   : in  std_logic;
      counter   : out std_logic_vector(width-1 downto 0));
  end component counter;
  
  
begin  -- architecture str

  --PROCESSES
  
  -- PORTMAPS
  bclk_gen: modulo_divider
    generic map (
      width      => 1 )
    port map (
      clk     => clk_12m,
      reset_n => '1',
      clk_12m => BCLK_INT);
	  
	bit_cntr: counter
    generic map (
      width      => 7 )
    port map (
      clk       => clk_12m,
      clk_count => BCLK_INT,
      reset_n   => '1',
      counter   => --direkt ans i2s decoder hängen);
	  
	  BCLK <= BCLK_INT;
  
end architecture str;

-------------------------------------------------------------------------------
