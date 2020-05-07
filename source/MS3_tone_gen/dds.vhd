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
library work;
use work.tone_gen_pkg.all;

-------------------------------------------------------------------------------

entity dds is

  port (
    clk_12m	    : in     std_logic;
    reset_n     : in     std_logic;
    phi_incr_i  : in     std_logic_vector(N_CUM-1 downto 0);
    tone_on_i		: in     std_logic;
    load_i      : in     std_logic;
    attenu_i		: in     std_logic_vector(2 downto 0);
    dds_o       : out    std_logic_vector(N_AUDIO-1 downto 0)
    );

end entity dds;

-------------------------------------------------------------------------------

architecture rtl of dds is
  --SIGNALS
  signal dds_s		: integer range -2**(N_AUDIO-1) to 2**(N_AUDIO-1)-1;
  signal next_count : unsigned(N_CUM-1 downto 0);
  signal count 		: unsigned(N_CUM-1 downto 0);
  signal lut_addr   : integer range 0 to (L-1);
  signal lut_val    : signed(N_AUDIO-1 downto 0);
  
begin  -- architecture rtl

  -- Counter Register
  flip_flops : process(clk_12m, reset_n)
  begin
    if reset_n = '0' then
      count <= to_unsigned(0, N_CUM);
    elsif rising_edge(clk_12m) then
      count <= next_count;
    end if;
  end process flip_flops;
	  
	  
-- Concurrent Assignments

--Mux for 48 khz clock signal (load_i)
--phi_increment is used for definging the frequency of the tone
  next_count <=      unsigned(phi_incr_i) + count when load_i = '1'
				else count;

  --LUT has only 256 values, so we have to truncate the counter				
  lut_addr	 <= to_integer(count(N_CUM-1 downto N_CUM-N_LUT));
  
  --Lookup the value of a sinus at specific phase
  lut_val	 <= to_signed(LUT_VIOLA(lut_addr), N_AUDIO);
  
	
  --Decrese volume of output
	dds_s <= to_integer(shift_right(lut_val,to_integer(unsigned(attenu_i))));
  
  dds_o 	 <=  std_logic_vector(to_signed(dds_s, dds_o'length)) when tone_on_i = '1'
							 else (others => '0');
	  
  
end architecture rtl;

-------------------------------------------------------------------------------
