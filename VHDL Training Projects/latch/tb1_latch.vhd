--testbench 1 for latch 
ENTITY TB1_LATCH IS
END ENTITY TB1_LATCH;

ARCHITECTURE TEST1_LATCH OF  TB1_LATCH IS 
COMPONENT latch IS
  PORT( d, clk: IN bit;
        q, nq: OUT bit);
END COMPONENT latch;
SIGNAL  TD,TCLK,TQ,TNQ:BIT;
BEGIN
DFT1:latch PORT MAP (TD,TCLK,TQ,TNQ);
PRO1:PROCESS IS
BEGIN 
---------------
TD<='0'; TCLK<='0';  WAIT FOR 15 ns;
TD<='1'; TCLK<='1';  WAIT FOR 15 ns;
ASSERT (TQ='1' AND TNQ='0') REPORT "Problem With output case1." SEVERITY error; WAIT FOR 15 ns;
TD<='1'; TCLK<='0';  WAIT FOR 15 ns;
ASSERT (TQ='1' AND TNQ='0') REPORT "Problem With output case2." SEVERITY error; WAIT FOR 15 ns;
TD<='0'; TCLK<='1';  WAIT FOR 15 ns;
ASSERT (TQ='0' AND TNQ='1') REPORT "Problem With output case3." SEVERITY error; WAIT FOR 15 ns;
---------------
ASSERT FALSE SEVERITY failure;  --end simulation
END PROCESS PRO1;
END ARCHITECTURE TEST1_LATCH;
---------------------------------------------
----TEST CONGIG FOR RIGHT DESIGN ARCH
CONFIGURATION RIGHT_TEST1_CFG OF TB1_LATCH IS
FOR TEST1_LATCH
	FOR DFT1: latch
	USE ENTITY WORK.latch (behav);
	END FOR;
END FOR;
END CONFIGURATION RIGHT_TEST1_CFG;
-----------------------------------------------
----TEST CONGIG FOR wrong DESIGN ARCH
CONFIGURATION WRONG_TEST1_CFG OF TB1_LATCH IS
FOR TEST1_LATCH
	FOR DFT1: latch
	USE ENTITY WORK.latch (wrong_behav);
	END FOR;
END FOR;
END CONFIGURATION WRONG_TEST1_CFG;
----------------------------------------------