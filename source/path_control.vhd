
-- Library & Use Statements
-------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


-- Entity Declaration 
-------------------------------------------
ENTITY path_control IS
  PORT( 
    	loop_back_i	    : IN    std_logic;
    	dds_l_i 	    : IN    std_logic_vector(15 downto 0);
    	dds_r_i 	    : IN    std_logic_vector(15 downto 0);
    	adcdat_pl_i 	: IN    std_logic_vector(15 downto 0);
    	adcdat_pr_i 	: IN    std_logic_vector(15 downto 0);
    	dacdat_pl_o     : OUT   std_logic_vector(15 downto 0);
    	dacdat_pr_o     : OUT   std_logic_vector(15 downto 0)
    	);
END path_control;


-- Architecture Declaration?
-------------------------------------------
ARCHITECTURE rtl OF path_control IS
-- Signals & Constants Declaration
-------------------------------------------

-- Begin Architecture
-------------------------------------------
BEGIN

  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic: PROCESS(loop_back_i)
  BEGIN	
	IF (loop_back_i = '1') THEN
		dacdat_pl_o <= adcdat_pl_i;
		dacdat_pr_o <= adcdat_pr_i;
  	ELSE 
		dacdat_pl_o <= dds_l_i;
		dacdat_pr_o <= dds_r_i;
  	END IF;
	
  END PROCESS comb_logic;   
  
  
  
 -- End Architecture 
------------------------------------------- 
END rtl;

