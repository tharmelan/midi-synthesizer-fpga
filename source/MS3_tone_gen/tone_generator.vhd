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
		clk_12m	    	 : in     std_logic;
		reset_n      	 : in     std_logic;
		tone_on_i			 : in     std_logic;
		load_i      	 : in     std_logic;
		note_array  	 : in     t_tone_array;
		velocity_array : in     t_tone_array;
		note_on_array  : in 		t_note_on;
		dds_o       	 : out    std_logic_vector(N_AUDIO-1 downto 0));
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
	
	-- TODO: create attenuator MS3 page 15
	
	type t_dds_o_array is array(0 to 9) of std_logic_vector(N_AUDIO-1 downto 0);
	
	signal dds_o_array: t_dds_o_array;

-------------------------------------------
-- Begin Architecture
-------------------------------------------
begin

	tone_sum : process(all)
	variable dds_sum		: unsigned(N_AUDIO-1 downto 0);
  begin
	
	dds_sum := (others => '0'); 
		For i IN 0 TO 9 LOOP
			IF note_on_array(i) = '1' THEN
					dds_sum := dds_sum + unsigned(dds_o_array(i));
			END IF;
		END LOOP;
	dds_o <= std_logic_vector(dds_sum);
  end process tone_sum;

  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  
  -- Port Maps -----
  
dds_inst_gen: for i in 0 to 9 generate
		inst_dds: dds
			port map(clk_12m        => clk_12m,
							 reset_n		=> reset_n,
							 tone_on_i  => tone_on_i,
							 phi_incr_i	=> LUT_midi2dds(to_integer(unsigned(note_array(i)))), 
							 load_i			=> load_i, 
							 attenu_i		=> "001", 
							 dds_o			=> dds_o_array(i)
							);
	end generate dds_inst_gen;

-- End Architecture 
------------------------------------------- 
end rtl;

