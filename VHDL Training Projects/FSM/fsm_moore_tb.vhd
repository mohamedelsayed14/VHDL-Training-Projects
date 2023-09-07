----------------------------------------------------------------
-- ---(7th testbench ) Moore FSM using assertion method.
----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fsm_moore_tb IS
END ENTITY fsm_moore_tb;

ARCHITECTURE tb_arch OF fsm_moore_tb IS
  COMPONENT fsm IS
    PORT(    clk, reset: IN std_logic;
        x: IN std_logic;
        y: OUT std_logic);
  END COMPONENT fsm;
  FOR fsm_dft: fsm USE ENTITY work.fsm(moore_2p);  --cfg
  SIGNAL clk, reset, x, y: std_logic;
BEGIN
  fsm_dft: fsm PORT MAP (clk, reset, x, y);
  
  clock: PROCESS IS
  BEGIN
    clk <= '0', '1' AFTER 10 ns;
    WAIT FOR 20 ns;
  END PROCESS clock;

  sg: PROCESS IS
  BEGIN
    reset <= '1';
    WAIT FOR 20 ns;
    ASSERT y = '0' REPORT "Error: Reset" SEVERITY warning;
	
    reset <= '0';           
    x <= '0';
    WAIT FOR 20 ns;
    ASSERT y = '0' REPORT "Error: state even when x = 0" SEVERITY warning;
	
  
    x <= '1';
    WAIT FOR 20 ns;
    ASSERT y = '1' REPORT "Error: state even when x = 1" SEVERITY warning;
	
   
    x <= '0';
    WAIT FOR 20 ns;
    ASSERT y = '1' REPORT "Error: state odd when x = 0" SEVERITY warning;
	
   
    x <= '1';
    WAIT FOR 20 ns;
    ASSERT y ='0' REPORT "Error: state odd when x = 1" SEVERITY warning;
	
    WAIT;
  END PROCESS sg;
  
END ARCHITECTURE tb_arch;
-----------------------------------------------------------------
