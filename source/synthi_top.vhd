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
    CLOCK_50  	: in     std_logic;
    GPIO_26   	: in     std_logic;
    KEY_0     	: in     std_logic;
    KEY_1     	: in     std_logic;
    SW	      	: in     std_logic_vector(17 downto 0);
    AUD_XCK   	: out    std_logic;
    I2C_SDAT  	: inout  std_logic;
    I2C_SCLK  	: out    std_logic;
	AUD_BCLK  	: out	 std_logic;
	AUD_DACLRCK : out	 std_logic;
	AUD_ADCLRCK : out	 std_logic;	
	load_o		: out    std_logic;
	AUD_DACDAT  : out	 std_logic;
	AUD_ADCDAT  : in	 std_logic;
	
	LEDG_0		: out	std_logic;
	LEDR_3		: out std_logic
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
  signal ws		         : std_logic;
  signal dacdat_pl		 : std_logic_vector(15 downto 0);
  signal dacdat_pr		 : std_logic_vector(15 downto 0);
  signal adcdat_pl		 : std_logic_vector(15 downto 0);
  signal adcdat_pr		 : std_logic_vector(15 downto 0);
  
  -- Milestone 3
  signal dds_l		 	 : std_logic_vector(15 downto 0) := (others => '0');
  signal dds_r		 	 : std_logic_vector(15 downto 0) := (others => '0');
  

  
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
  
  component i2s_master is
    port (
      clk_12m	  : in     std_logic;
	  dacdat_pl_i : in     std_logic_vector(15 downto 0);
      dacdat_pr_i : in     std_logic_vector(15 downto 0);
      dacdat_s_o  : out    std_logic;
      reset_n     : in     std_logic;
      adcdat_pl_o : out    std_logic_vector(15 downto 0);
      adcdat_pr_o : out    std_logic_vector(15 downto 0);
      load_o      : out    std_logic;
      adcdat_s_i  : in     std_logic;
      bclk_o      : out    std_logic;
      ws_o        : out    std_logic);
  end component i2s_master;
  
  component path_control is
    port (
      loop_back_i	  : IN    std_logic;
	  dds_l_i 	      : IN    std_logic_vector(15 downto 0);
      dds_r_i 	      : IN    std_logic_vector(15 downto 0);
      adcdat_pl_i 	  : IN    std_logic_vector(15 downto 0);
      adcdat_pr_i 	  : IN    std_logic_vector(15 downto 0);
      dacdat_pl_o     : OUT   std_logic_vector(15 downto 0);
      dacdat_pr_o     : OUT   std_logic_vector(15 downto 0));
  end component path_control;

begin  -- architecture str

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------
  
  -- instance "i2s_master_1"
  i2s_master_1: i2s_master
    port map (
      clk_12m      	=> clock_12m_s,
      dacdat_pl_i 	=> dacdat_pl,
      dacdat_pr_i   => dacdat_pr,
      dacdat_s_o 	=> AUD_DACDAT,
      reset_n  		=> reset_n_s,
      adcdat_pl_o   => adcdat_pl,
      adcdat_pr_o   => adcdat_pr,
      load_o 		=> OPEN,
      bclk_o 		=> AUD_BCLK,
      ws_o 			=> ws,
      adcdat_s_i    => AUD_ADCDAT);
	  
  -- instance "path_control_1"
  path_control_1: path_control
    port map (
      loop_back_i   => sw_sync(3),
      dds_l_i 		=> dds_l,
      dds_r_i   	=> dds_r,
      adcdat_pl_i	=> adcdat_pl,
      adcdat_pr_i  	=> adcdat_pr,
      dacdat_pl_o  	=> dacdat_pl,
      dacdat_pr_o  	=> dacdat_pr);
  
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
	  
	  AUD_XCK 	  <= clock_12m_s;
	  AUD_DACLRCK <= ws;
	  AUD_ADCLRCK <= ws;
	  
	  LEDG_0 <= sw_sync(3);
	  LEDR_3 <= SW(3);

end architecture str;

-------------------------------------------------------------------------------
