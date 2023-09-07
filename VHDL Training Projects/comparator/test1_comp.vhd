--------------------------------------------------------
--test 1 for  comparator (using assertion)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity test1_comp is 
end entity test1_comp;
ARCHITECTURE T1_comp OF  test1_comp IS 
component comparator IS
   Port( a : IN  std_logic_vector (7 DOWNTO 0);
         b: IN std_logic_vector (7 DOWNTO 0);
         equal_out : OUT bit;
         not_equal_out: OUT bit);
END component comparator;

signal ta,tb :std_logic_vector (7 DOWNTO 0);
signal tout,tnout:bit;

BEGIN
DFT1:comparator PORT MAP (ta,tb,tout,tnout);
PRO1:PROCESS IS
BEGIN 
ta<="00000000"; tb<="00000000"; WAIT FOR 15 ns;
ta<="11111111"; tb<="11111111"; WAIT FOR 15 ns;
ASSERT (tout='1' AND tnout='0') REPORT "Problem found1." SEVERITY error; WAIT FOR 15 ns;
ta<="11111110"; tb<="11111111"; WAIT FOR 15 ns;
ASSERT (tout='0' AND tnout='1') REPORT "Problem found2." SEVERITY error; WAIT FOR 15 ns;

ASSERT FALSE SEVERITY failure;  --end simulation
END PROCESS PRO1;
END ARCHITECTURE T1_comp;
-------------------------------------------------------------------------


