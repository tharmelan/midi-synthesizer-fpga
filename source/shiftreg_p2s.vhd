
-- Library & Use Statements
-------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


-- Entity Declaration 
-------------------------------------------
ENTITY shiftreg_p2s IS
  PORT( clk,set_n		: IN    std_logic;
  		load_i			: IN    std_logic;
    	par_i 	     	: IN    std_logic_vector(7 downto 0);
    	ser_o       	: OUT   std_logic
    	);
END shiftreg_p2s;


-- Architecture Declaration?
-------------------------------------------
ARCHITECTURE rtl OF shiftreg_p2s IS
-- Signals & Constants Declaration
-------------------------------------------
SIGNAL 		state, next_state: 	std_logic_vector(7 downto 0);	 


-- Begin Architecture
-------------------------------------------
BEGIN

  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic: PROCESS(load_i,state,par_i)
  BEGIN	
	-- load	
	IF (load_i = '1') THEN
		next_state <= par_i;
  	-- shift
  	ELSE 
  		next_state <= '1' & state(3 downto 1);
  	END IF;
	
  END PROCESS comb_logic;   
  
  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : PROCESS(clk, set_n)
  BEGIN	
  	IF set_n = '0' THEN
		state <= (Others => '1'); 
    ELSIF rising_edge(clk) THEN
		state <= next_state ;
    END IF;
  END PROCESS flip_flops;		
  
  
  ser_o <= state(0);
  
  
 -- End Architecture 
------------------------------------------- 
END rtl;

