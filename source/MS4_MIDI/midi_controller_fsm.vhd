-------------------------------------------
-- Block code:  midi_controller_fsm.vhd
-- Function:
-------------------------------------------

-- Library & Use Statements
-------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;


-- Entity Declaration
-------------------------------------------
ENTITY midi_controller_fsm IS
  PORT( clk,reset_n  : IN    std_logic;
        data_valid_i : IN    std_logic;
        midi_data_i  : IN    std_logic_vector(7 downto 0);
      );
END midi_controller_fsm;


-- Architecture Declaration
-------------------------------------------
ARCHITECTURE rtl OF midi_controller_fsm IS
-- Signals & Constants Declaration
-------------------------------------------
  type t_state is (s_wait_status, s_wait_data1, s_wait_data2);
  signal state, next_state : t_state;
	
	signal reg_note, next_reg_note: t_tone_array;
	signal reg_velocity, next_reg_velocity: t_tone_array;
	
	type t_tone_array is array(0 to 9) of std_logic_vector(6 downto 0) ;


-- Begin Architecture
-------------------------------------------
BEGIN

  --------------------------------------------------
  -- PROCESS FOR COMB-INPUT LOGIC
  --------------------------------------------------
  fsm_drive: PROCESS(data_valid_i,state,count)
  BEGIN
    -- Default statement
    next_state <= state;

    case state is
      when s_wait_status =>
        if (data_valid_i = '1') then
          next_state <= s_wait_data1;
        end if;
      when s_wait_data1 =>
        if (data_valid_i = '1') then
          next_state <= s_wait_data2;
        end if;
      when s_wait_data2 =>
			if (data_valid_i = '1') then
          next_state <= s_wait_status;
        end if;
      when others =>
        next_state <= s_idle;
    end case;
  END PROCESS fsm_drive;

  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic: PROCESS(count,state,baud_tick_i)
  BEGIN
      next_count <= count;
    -- start
    IF (state = s_receiving) THEN
      if (baud_tick_i = '1') then
        next_count <= count + 1;
      end if;
    else
      next_count <= (others=>'0');
    END IF;

  END PROCESS comb_logic;

  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : PROCESS(clk, reset_n)
  BEGIN
    IF reset_n = '0' THEN
      state <= s_wait_status;
    ELSIF rising_edge(clk) THEN
      state <= next_state;
    END IF;
  END PROCESS flip_flops;


  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------
  start_bit_o  <= '1' when(state = s_idle AND start_i = '1') else '0';
  shift_enable <= '1' when(state = s_receiving and baud_tick_i = '1') else '0';
  data_valid_o <= '1' when(state = s_checking AND uart_data_i(9) = '1' AND uart_data_i(0) = '0') else '0';
  


 -- End Architecture
-------------------------------------------
END rtl;
