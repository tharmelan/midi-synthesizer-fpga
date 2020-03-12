-------------------------------------------------------------------------------
-- Title      : synthi_top
-- Project    : 
-------------------------------------------------------------------------------
-- File       : synthi_top.vhd
-- Author     :   <beats@SURFACE>
-- Company    : 
-- Created    : 2020-03-05
-- Last update: 2020-03-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-03-05  1.0      beats	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity synthi_top is


  port (
    CLOCK_50  : in     std_logic;
    GPIO_26   : in     std_logic;
    KEY_0     : in     std_logic;
    KEY_1     : in     std_logic;
    SW	      : in     std_logic_vector(17 downto 0);
    AUD_XCK   : out    std_logic;
    I2C_SDAT  : inout  std_logic;
    I2C_SCLK  : out    std_logic
    );

end entity synthi_top;

-------------------------------------------------------------------------------

architecture str of synthi_top is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

  signal key_1_sync      : std_logic;
  signal sw_sync         : std_logic_vector(17 downto 0);
  signal reset_n_s       : std_logic;
  signal clock_12m_s     : std_logic;
  signal write_s         : std_logic;
  signal write_data      : std_logic_vector(15 downto 0);
  signal write_done      : std_logic;
  signal ack_error       : std_logic;
  

  
  component codec_controller is
    port (
      clk          : IN  std_logic;
      initialize_i : IN  std_logic;
      reset_n      : IN  std_logic;
      write_done_i : IN  std_logic;
      ack_error_i  : IN  std_logic;
      sw_sync_i    : IN  std_logic_vector(2 downto 0);
      write_o      : OUT std_logic;
      write_data_o : OUT std_logic_vector(15 downto 0);
      mute_o       : OUT std_logic);
  end component codec_controller;

  component infrastructure is
    port (
      clk_50         : IN  std_logic;
      key_0_i        : IN  std_logic;
      key_1_i        : IN  std_logic;
      sw_17_0_i      : IN  std_logic_vector(17 downto 0);
      gpio_26_i      : IN  std_logic;
      clk_12m_o      : OUT std_logic;
      reset_n_o      : OUT std_logic;
      key_1_sync_o   : OUT std_logic;
      gpio_26_sync_o : OUT std_logic;
      sw_17_0_sync_o : OUT std_logic_vector(17 downto 0));
  end component infrastructure;

  component i2c_master is
    port (
      clk          : in    std_logic;
      reset_n      : in    std_logic;
      write_i      : in    std_logic;
      write_data_i : in    std_logic_vector(15 downto 0);
      sda_io       : inout std_logic;
      scl_o        : out   std_logic;
      write_done_o : out   std_logic;
      ack_error_o  : out   std_logic);
  end component i2c_master;

begin  -- architecture str

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------

  AUD_XCK <= clock_12m_s;
  
  -- instance "codec_controller_1"
  codec_controller_1: codec_controller
    port map (
      clk          => clock_12m_s,
      initialize_i => key_1_sync,
      reset_n      => reset_n_s,
      write_done_i => write_done,
      ack_error_i  => ack_error,
      sw_sync_i    => sw_sync(2 downto 0),
      write_o      => write_s,
      write_data_o => write_data,
      mute_o       => OPEN);

  -- instance "infrastructure_1"
  infrastructure_1: infrastructure
    port map (
      clk_50         => CLOCK_50,
      key_0_i        => KEY_0,
      key_1_i        => KEY_1,
      sw_17_0_i      => SW,
      gpio_26_i      => GPIO_26,
      clk_12m_o      => clock_12m_s,
      reset_n_o      => reset_n_s,
      key_1_sync_o   => key_1_sync,
      gpio_26_sync_o => OPEN,
      sw_17_0_sync_o => sw_sync);

  -- instance "i2c_master_1"
  i2c_master_1: i2c_master
    port map (
      clk          => clock_12m_s,
      reset_n      => reset_n_s,
      write_i      => write_s,
      write_data_i => write_data,
      sda_io       => I2C_SDAT,
      scl_o        => I2C_SCLK,
      write_done_o => write_done,
      ack_error_o  => ack_error);

end architecture str;

-------------------------------------------------------------------------------
