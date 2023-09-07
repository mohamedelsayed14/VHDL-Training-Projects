--First_Testbench (READ/ WRITE FIELS)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY TB_2_RW_FILE IS
generic (n: positive :=4);
END ENTITY TB_2_RW_FILE;

ARCHITECTURE ADD_SUB_DFT2 OF TB_2_RW_FILE IS
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
DFT2:ADD_SUB_4B PORT MAP (T_M, T_A, T_B, T_S, T_COUT);
PRO2:PROCESS IS
FILE test_f: text OPEN READ_MODE IS "test_file.txt";
FILE result_f: text OPEN WRITE_MODE IS "result_file.txt";
VARIABLE test_line,res_line: line;

VARIABLE V_M: std_logic;
VARIABLE V_A,V_B: std_logic_vector (n-1 DOWNTO 0);
VARIABLE V_S: std_logic_vector (n-1 DOWNTO 0);
VARIABLE V_COUT: std_logic;

VARIABLE pause: time;
VARIABLE message: string (1 TO 44);
-------------
BEGIN
T_M<='0'; T_A<=b"0000"; T_B<=b"0000"; WAIT FOR 15 ns;
WHILE NOT endfile (test_f) LOOP
READLINE (test_f, test_line);
READ (test_line, d in file);
READ (stimuli l, clock in file);
READ (stimuli l, pause);
READ (stimuli l, q out file);
READ (stimuli l, message);
d in <= d in file; clock <= clock in file; WAIT FOR pause;
WRITE (res l, string?("Time is now "));
WRITE (res l, NOW); -- Current simulation time
WRITE (res l, string?(" D = "));
WRITE (res l, d in file);
WRITE (res l, string?(", Clock = "));
WRITE (res l, clock in file);
WRITE (res l, string?(", Expected Q = "));
WRITE (res l, q out file);
WRITE (res l, string?(", Actual Q = "));
WRITE (res l, q out);
IF q out /= q out file THEN
WRITE (res l, string?(". Test failed! Error message:"));
WRITE (res l, message);
ELSE
WRITE (res l, string?(". Test passed."));
END IF;
WRITELINE (results f, res l);
END LOOP;
-------------
WAIT;
END PROCESS PRO2;
END ARCHITECTURE ADD_SUB_DFT2;
-----------------------------------------------------
CONFIGURATION BEHAV_CONFG2 OF TB_2_RW_FILE IS
FOR ADD_SUB_DFT2
	FOR DFT2: ADD_SUB_4B
	USE ENTITY WORK.ADD_SUB_4B (BEHAV);
	END FOR;
END FOR;
END CONFIGURATION BEHAV_CONFG2;
-----------------------------------------------------
CONFIGURATION RTL_CONFG2 OF TB_2_RW_FILE IS
FOR ADD_SUB_DFT2
	FOR DFT2: ADD_SUB_4B
	USE ENTITY WORK.ADD_SUB_4B (RTL);
	END FOR;
END FOR;
END CONFIGURATION RTL_CONFG2;
-----------------------------------------------------
CONFIGURATION STRUCT1_CONFG2 OF TB_2_RW_FILE IS
FOR ADD_SUB_DFT2
	FOR DFT2: ADD_SUB_4B
	USE ENTITY WORK.ADD_SUB_4B (STRUCT1);
	END FOR;
END FOR;
END CONFIGURATION STRUCT1_CONFG2;
------------------------------------------------------
