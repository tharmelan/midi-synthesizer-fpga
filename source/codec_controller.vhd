-------------------------------------------
-- Block code:  uart_controller_fsm.vhd
-- Function:
-------------------------------------------

-- Library & Use Statements
-------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


-- Entity Declaration
-------------------------------------------
entity codec_controller IS
  PORT( clk          : IN    std_logic;
        initialize_i : IN    std_logic;
        reset_n      : IN    std_logic;
        write_done_i : IN    std_logic;
        ack_error_i  : IN    std_logic;
        sw_sync_i    : IN    std_logic_vector(2 downto 0);
        write_o      : OUT   std_logic;
        write_data_o : OUT   std_logic_vector(15 downto 0);
        mute_o       : OUT   std_logic      
      );
END codec_controller;


-- Architecture Declaration
-------------------------------------------
ARCHITECTURE rtl OF uart_controller_fsm IS
-- Signals & Constants Declaration
-------------------------------------------
  type t_state is (s_idle, s_start_write, s_wait);
  signal state, next_state : t_state;
  signal count, next_count : integer(3 downto 0);


-- Begin Architecture
-------------------------------------------
BEGIN

  --------------------------------------------------
  -- PROCESS FOR COMB-INPUT LOGIC
  --------------------------------------------------
  fsm_drive: PROCESS(initialize_i,ack_err_i,state,count)
  BEGIN
    -- Default statement
    next_state <= state;
    write_o <= '0';

    case state is
      when s_idle =>
        if (initialize_i = '1') then
          next_state <= s_write;
        end if;
      when s_start_write =>
        next_state <= s_wait;
        write_o <= '1';
      when s_wait =>
        if write_done_i = '1' then
          if count < 9 then
            next_state <= start_write;
            next_count <= count + 1;
          else
            next_state <= s_idle;
            next_count <= (others=>'0');
          end if;
        end if;

        if ack_err_i then
          next_state <= s_start_write;
        end if;
      when others =>
        next_state <= s_idle;
    end case;
  END PROCESS fsm_drive;

  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------

  flip_flops : PROCESS(clk, reset_n)
  BEGIN
    IF reset_n = '0' THEN
      count <= (others=>'0');
      state <= s_idle;
    ELSIF rising_edge(clk) THEN
      count <= next_count;
      state <= next_state;
    END IF;
  END PROCESS flip_flops;


  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------

  with sw select
    write_data_o <=
    C_W8731_ANALOG_MUTE_LEFT(counter)  when "100",
    C_W8731_ANALOG_MUTE_RIGHT(counter) when "011",
    C_W8731_ANALOG_MUTE_BOTH(counter) when "111",
    C_W8731_ANALOG_BYPASS(counter) when "001",
    C_W8731_ADC_DAC_0DB_48K(counter) when others;

 -- End Architecture
-------------------------------------------
END rtl;
