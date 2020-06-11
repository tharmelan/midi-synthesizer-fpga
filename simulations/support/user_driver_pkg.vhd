-------------------------------------------------------------------------------
-- Title      : user_driver_pkg
-- Project    : DTP2
-------------------------------------------------------------------------------
-- File       : user_driver_pkg.vhd
-- Author     : Hans-Joachim Gelke
-- Company    : 
-- Created    : 2018-10-21
-- Last update: 2019-2-13
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: For Students to add their own drivers
-------------------------------------------------------------------------------
-- Copyright (c) 2018 - 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-02-13  1.0      Hans-Joachim    Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.simulation_pkg.all;

package user_driver_pkg is
  procedure vis_sim
    (
      variable tv    : inout test_vect;
      signal out_sig : out   std_logic_vector(15 downto 0)
      );

end user_driver_pkg;

package body user_driver_pkg is

procedure vis_sim
    (
      variable tv    : inout test_vect;
      signal out_sig : out   std_logic_vector(15 downto 0)
      ) is

    variable line_out : line;           -- Line buffers

  begin
    out_sig(15 downto 8)  <= tv.arg1(7 downto 0);
    out_sig(7 downto 0)   <= tv.arg2(7 downto 0);


    write(line_out, string'("HEX VALUE "));
    hwrite(line_out, tv.arg1);
    hwrite(line_out, tv.arg2);
    write(line_out, string'(" as Audio Signal DUT"));
    writeline(OUTPUT, line_out);        -- write the message
  end vis_sim;

end user_driver_pkg;
