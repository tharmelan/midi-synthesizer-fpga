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

-- Entity Declaration 
-------------------------------------------
entity counter is
  generic (width : positive := 5);
  port(clk 		 : in  std_logic;
	   clk_count : in  std_logic;
	   reset_n   : in  std_logic;
       counter   : out std_logic_vector(width-1 downto 0)
       );
end counter;

-- Architecture Declaration 
-------------------------------------------
architecture rtl of counter is
-- Signals & Constants Declaration 
-------------------------------------------
  signal count, next_count : unsigned(width-1 downto 0) := (others => '0');
-- Begin Architecture
-------------------------------------------
begin

  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic : process(count)
  begin
    -- increment        
    next_count <= count + 1;
  end process comb_logic;

  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : process(clk,clk_count, reset_n)
  begin
    if reset_n = '0' then
      count <= to_unsigned(0, width);
    elsif rising_edge(clk) then
		-- clk_count ist verzögert, desshalb haben wir uns für clk_count high entschieden.
		if clk_count = '1' then 
			count <= next_count;
		end if;
    end if;
  end process flip_flops;

  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------
	counter <= std_logic_vector(count);

-- End Architecture 
------------------------------------------- 
end rtl;

