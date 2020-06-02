-------------------------------------------
-- Block code:  counter.vhd
-- History:     12.03.2020 - 1st version (bodenma2)
-- Function: counter with generic width.
-------------------------------------------

-- Library & Use Statements
-------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tone_gen_pkg.all;

-- Entity Declaration 
-------------------------------------------
entity visualisierung is
  port(clk 		   : in  std_logic;
	   reset_n     : in  std_logic;
	   audiodata_i : in  std_logic_vector(15 downto 0);
      led_o       : out std_logic_vector(17 downto 0)
       );
end visualisierung;

-- Architecture Declaration 
-------------------------------------------
architecture rtl of visualisierung is
-- Signals & Constants Declaration 
-------------------------------------------
	--signal led_s : std_logic_vector(17 downto 0);
	--signal data_s, next_data_s : signed(N_AUDIO-1 downto 0);
	signal data_s : signed(N_AUDIO-1 downto 0);

-- Begin Architecture
-------------------------------------------
begin
	
  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic : process(all)
  begin
		--data_s <= next_data_s;

  end process comb_logic;

  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : process(clk, reset_n)
  begin
    if reset_n = '0' then
		--next_data_s <= to_signed(0, N_AUDIO);
    elsif rising_edge(clk) then
		--next_data_s <= signed(audiodata_i);
    end if;
  end process flip_flops;

  --------------------------------------------------
  -- CONCURRENT ASSIGNMENT
  --------------------------------------------------
	data_s <= signed(audiodata_i);
  
	led_o <=		"000000000000000000" WHEN (data_s >= 5000 OR data_s <= -5000)
			 ELSE "011111111111111111" WHEN (data_s >= 4500 OR data_s <= -4500)
			 ELSE "001111111111111111" WHEN (data_s >= 4000 OR data_s <= -4000)
			 ELSE	"000111111111111111" WHEN (data_s >= 3750 OR data_s <= -3750)
			 ELSE	"000011111111111111" WHEN (data_s >= 3500 OR data_s <= -3500)
			 ELSE	"000001111111111111" WHEN (data_s >= 3250 OR data_s <= -3250)
			 ELSE	"000000111111111111" WHEN (data_s >= 3000 OR data_s <= -3000)
			 ELSE	"000000011111111111" WHEN (data_s >= 2750 OR data_s <= -2700)
			 ELSE	"000000001111111111" WHEN (data_s >= 2500 OR data_s <= -2500)
			 ELSE	"000000000111111111" WHEN (data_s >= 2250 OR data_s <= -2250)
			 ELSE	"000000000011111111" WHEN (data_s >= 2000 OR data_s <= -2000)
			 ELSE	"000000000001111111" WHEN (data_s >= 1750 OR data_s <= -1250)
			 ELSE	"000000000000111111" WHEN (data_s >= 1500 OR data_s <= -1500)
			 ELSE	"000000000000011111" WHEN (data_s >= 1250 OR data_s <= -1250)
			 ELSE	"000000000000001111" WHEN (data_s >= 1000 OR data_s <= -1000)
			 ELSE	"000000000000000111" WHEN (data_s >=  750 OR data_s <= -750)
			 ELSE	"000000000000000011" WHEN (data_s >=  500 OR data_s <= -500)
			 ELSE	"000000000000000001" WHEN (data_s >=  250 OR data_s <= -250)
			 ELSE "000000000000000000";
			 
	

-- End Architecture 
------------------------------------------- 
end rtl;

