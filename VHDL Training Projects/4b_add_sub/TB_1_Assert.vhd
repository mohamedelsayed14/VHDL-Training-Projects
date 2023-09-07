--First_Testbench (assert)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY TB_1_Assert IS
generic (n: positive :=4);
END ENTITY TB_1_Assert;

ARCHITECTURE ADD_SUB_DFT1 OF TB_1_Assert IS
COMPONENT ADD_SUB_4B IS  
generic (n: positive :=4);
PORT (M: IN std_logic;
    A,B: IN std_logic_vector (n-1 DOWNTO 0);
      S: OUT std_logic_vector (n-1 DOWNTO 0);
   COUT: OUT std_logic);
END COMPONENT ADD_SUB_4B;

SIGNAL T_M: std_logic;
SIGNAL T_A,T_B: std_logic_vector (n-1 DOWNTO 0);
SIGNAL T_S: std_logic_vector (n-1 DOWNTO 0);
SIGNAL T_COUT: std_logic;

BEGIN
DFT1:ADD_SUB_4B PORT MAP (T_M, T_A, T_B, T_S, T_COUT);
PRO1:PROCESS IS
BEGIN 
---------------
T_M<='0'; T_A<=b"0000"; T_B<=b"0000"; WAIT FOR 15 ns;
T_M<='0'; T_A<=b"0011"; T_B<=b"0011"; WAIT FOR 15 ns;
ASSERT (T_S=b"0110" AND T_COUT='0') REPORT "Problem With Addation Operation." SEVERITY error; WAIT FOR 15 ns;
T_M<='1'; T_A<=b"0011"; T_B<=b"0001"; WAIT FOR 15 ns;
ASSERT (T_S=b"0010") REPORT "Problem With Subtraction Operation." SEVERITY error;  WAIT FOR 15 ns;
---------------
ASSERT FALSE SEVERITY failure;
END PROCESS PRO1;
END ARCHITECTURE ADD_SUB_DFT1;
-----------------------------------------------------
CONFIGURATION BEHAV_CONFG1 OF TB_1_Assert IS
FOR ADD_SUB_DFT1
	FOR DFT1: ADD_SUB_4B
	USE ENTITY WORK.ADD_SUB_4B (BEHAV);
	END FOR;
END FOR;
END CONFIGURATION BEHAV_CONFG1;
-----------------------------------------------------
CONFIGURATION RTL_CONFG1 OF TB_1_Assert IS
FOR ADD_SUB_DFT1
	FOR DFT1: ADD_SUB_4B
	USE ENTITY WORK.ADD_SUB_4B (RTL);
	END FOR;
END FOR;
END CONFIGURATION RTL_CONFG1;
-----------------------------------------------------
CONFIGURATION STRUCT1_CONFG1 OF TB_1_Assert IS
FOR ADD_SUB_DFT1
	FOR DFT1: ADD_SUB_4B
	USE ENTITY WORK.ADD_SUB_4B (STRUCT1);
	END FOR;
END FOR;
END CONFIGURATION STRUCT1_CONFG1;
------------------------------------------------------