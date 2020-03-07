-------------------------------------------------------------------------------
-- Title      : Testbench for design "synthi_top"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : synthi_top_tb.vhd
-- Author     :   <Admin@LAPTOP-4OQR1GUI>
-- Company    : 
-- Created    : 2020-03-07
-- Last update: 2020-03-07
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-03-07  1.0      Admin	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
use std.textio.all;
use work.simulation_pkg.all;
use work.standard_driver_pkg.all;
use work.user_driver_pkg.all;


-------------------------------------------------------------------------------

entity synthi_top_tb is

end entity synthi_top_tb;

-------------------------------------------------------------------------------

architecture struct of synthi_top_tb is

  component synthi_top is
    port (
      CLOCK_50 : in    std_logic;
      GPIO_26  : in    std_logic;
      KEY_0    : in    std_logic;
      KEY_1    : in    std_logic;
      SW_17_0  : in    std_logic_vector(17 downto 0);
      AUD_XCK  : out   std_logic;
      I2C_SDAT : inout std_logic;
      I2C_SCLK : out   std_logic);
  end component synthi_top;

  component i2c_slave_bfm is
    generic (
      verbose : boolean);
    port (
      AUD_XCK   : in    std_logic;
      I2C_SDAT  : inout std_logic := 'H';
      I2C_SCLK  : inout std_logic := 'H';
      reg_data0 : out   std_logic_vector(31 downto 0);
      reg_data1 : out   std_logic_vector(31 downto 0);
      reg_data2 : out   std_logic_vector(31 downto 0);
      reg_data3 : out   std_logic_vector(31 downto 0);
      reg_data4 : out   std_logic_vector(31 downto 0);
      reg_data5 : out   std_logic_vector(31 downto 0);
      reg_data6 : out   std_logic_vector(31 downto 0);
      reg_data7 : out   std_logic_vector(31 downto 0);
      reg_data8 : out   std_logic_vector(31 downto 0);
      reg_data9 : out   std_logic_vector(31 downto 0));
  end component i2c_slave_bfm;
  
  -- component ports
  signal CLOCK_50 : std_logic;
  signal GPIO_26  : std_logic;
  signal KEY_0    : std_logic;
  signal KEY_1    : std_logic;
  signal SW_17_0  : std_logic_vector(17 downto 0);
  signal AUD_XCK  : std_logic;
  signal I2C_SDAT : std_logic;
  signal I2C_SCLK : std_logic;

  constant clock_freq   : natural := 50_000_000;
  constant clock_period : time    := 1000 ms/clock_freq;

begin  -- architecture struct

  -- component instantiation
  DUT: synthi_top
    port map (
      CLOCK_50 => CLOCK_50,
      GPIO_26  => GPIO_26,
      KEY_0    => KEY_0,
      KEY_1    => KEY_1,
      SW_17_0  => SW_17_0,
      AUD_XCK  => AUD_XCK,
      I2C_SDAT => I2C_SDAT,
      I2C_SCLK => I2C_SCLK);

  slave: i2c_slave_bfm
  generic map (
      verbose      => true )
  port map (
      AUD_XCK   => AUD_XCK,
      I2C_SDAT  => I2C_SDAT,
      I2C_SCLK  => I2C_SCLK);

  readcmd : process
    -- This process loops through a file and reads one line
    -- at a time, parsing the line to get the values and
    -- expected result.

    variable cmd          : string(1 to 7);  --stores test command
    variable line_in      : line; --stores the to be processed line     
    variable tv           : test_vect; --stores arguments 1 to 4
    variable lincnt       : integer := 0;  --counts line number in testcase file
    variable fail_counter : integer := 0;--counts failed tests



  begin
    -------------------------------------
    -- Open the Input and output files
    -------------------------------------
    FILE_OPEN(cmdfile, "../testcase.dat", read_mode);
    FILE_OPEN(outfile, "../results.dat", write_mode);

    -------------------------------------
    -- Start the loop
    -------------------------------------


    loop

      --------------------------------------------------------------------------
      -- Check for end of test file and print out results at the end
      --------------------------------------------------------------------------


      if endfile(cmdfile) then          -- Check EOF
        end_simulation(fail_counter);
        exit;
      end if;

      --------------------------------------------------------------------------
      -- Read all the argumnents and commands
      --------------------------------------------------------------------------

      readline(cmdfile, line_in);       -- Read a line from the file
      lincnt := lincnt + 1;


      next when line_in'length = 0;     -- Skip empty lines
      next when line_in.all(1) = '#';   -- Skip lines starting with #

      read_arguments(tv, line_in, cmd);
      tv.clock_period := clock_period;  -- set clock period for driver calls

      -------------------------------------
      -- Reset the circuit
      -------------------------------------

      if cmd = string'("rst_sim") then
        rst_sim(tv, key_0);
      elsif cmd = string'("run_sim") then
        run_sim(tv);
      elsif cmd = string'("ini_cod") then
        ini_cod(tv, SW_17_0(2 downto 0), KEY_1);

        -- add further test commands below here


      else
        assert false
          report "Unknown Command"
          severity failure;
      end if;

      if tv.fail_flag = true then --count failures in tests
        fail_counter := fail_counter + 1;
      else fail_counter := fail_counter;
      end if;

    end loop; --finished processing command line

    wait; -- to avoid infinite loop simulator warning

  end process;

  clkgen : process
  begin
    clock_50 <= '0';
    wait for clock_period/2;
    clock_50 <= '1';
    wait for clock_period/2;

  end process clkgen;

  

end architecture struct;

-------------------------------------------------------------------------------
