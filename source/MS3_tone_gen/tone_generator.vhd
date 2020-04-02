-------------------------------------------

-------------------------------------------

-- Library & Use Statements
-------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.tone_gen_pkg.all;

-- Entity Declaration 
-------------------------------------------
entity tone_generator is
  port(
		clk_12m	    	: in     std_logic;
		reset_n      	: in     std_logic;
		note_vector  	: in     std_logic_vector(6 downto 0);
		tone_on_i		: in     std_logic;
		load_i      	: in     std_logic;
		attenu_i			: in     std_logic_vector(2 downto 0);
		dds_o       	: out    std_logic_vector(N_AUDIO-1 downto 0));
end tone_generator;

-- Architecture Declaration
-------------------------------------------
architecture rtl of tone_generator is

 component dds is
    port (
      clk_12m	    : in     std_logic;
			reset_n     : in     std_logic;
			phi_incr_i  : in     std_logic_vector(N_CUM-1 downto 0);
			tone_on_i		: in     std_logic;
			load_i      : in     std_logic;
			attenu_i		: in     std_logic_vector(2 downto 0);
			dds_o       : out    std_logic_vector(N_AUDIO-1 downto 0));
  end component dds;
  
  signal phi_increment	:		std_logic_vector(N_CUM-1 downto 0);

-------------------------------------------
-- Begin Architecture
-------------------------------------------
begin


  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  
  -- Port Maps -----
  
dds1: dds
    port map (
      clk_12m     => clk_12m,
      reset_n     => reset_n,
      phi_incr_i  => phi_increment,
      tone_on_i   => tone_on_i,
      load_i      => load_i,
      attenu_i    => attenu_i,
      dds_o 	   	=> dds_o);

-- Concurent Assignments --

	phi_increment	<=	LUT_midi2dds(to_integer(unsigned(note_vector)));

-- End Architecture 
------------------------------------------- 
end rtl;

