--testbench 1 for alu 

LIBRARY ieee;
USE ieee.numeric_bit.ALL;
USE WORK.pack_a.ALL;

ENTITY TB1_alu IS
END ENTITY TB1_alu;

ARCHITECTURE TEST1_alu OF  TB1_alu IS 
component  alu IS
   PORT( op: IN op_type;
      a, b : IN signed (31 DOWNTO 0);
         c : OUT signed (31 DOWNTO 0)); 
END component alu;

SIGNAL  top :  op_type;
SIGNAL ta,tb :  signed (31 DOWNTO 0);
SIGNAL tc :  signed (31 DOWNTO 0); 

BEGIN
DFT1:alu PORT MAP (top,ta,tb,tc);  --- ta > test signal a  ,, and so on
PRO1:PROCESS IS
BEGIN 
---------------
top<=add; ta<=x"00000000"; tb<=x"00000000";  WAIT FOR 15 ns;
top<=add; ta<=x"00000004"; tb<=x"00000002";  WAIT FOR 15 ns;
ASSERT (tc=x"00000006") REPORT "Problem With additiion." SEVERITY error; WAIT FOR 15 ns;
top<=sub; ta<=x"00000004"; tb<=x"00000002";  WAIT FOR 15 ns;
ASSERT (tc=x"00000002") REPORT "Problem With subtraction." SEVERITY error; WAIT FOR 15 ns;
---------------
wait; --end simulation
END PROCESS PRO1;
END ARCHITECTURE TEST1_alu;
-----------------------------------------------