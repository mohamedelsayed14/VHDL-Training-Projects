--Design For 3 Different Implementations For ADD_SUB_N=4BITS

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY ADD_SUB_4B IS  
generic (n: positive :=4);
PORT (M: IN std_logic;
    A,B: IN std_logic_vector (n-1 DOWNTO 0);
      S: OUT std_logic_vector (n-1 DOWNTO 0);
   COUT: OUT std_logic);
END ENTITY ADD_SUB_4B;
---------------------------------------------
--behavioral implementation------------------
ARCHITECTURE BEHAV OF  ADD_SUB_4B IS
BEGIN
P1:PROCESS (M,A,B) IS
VARIABLE result:std_logic_vector (n DOWNTO 0) ;
BEGIN
IF (M='0') THEN
    result :=('0'&A)+('0'&B); 
ELSe
    result :=('0'&A)-('0'&B);
END IF;
S <=result(n-1 DOWNTO 0);
COUT<=result(n);
END PROCESS P1;
END ARCHITECTURE BEHAV;
---------------------------------------------
---------------------------------------------
--Data Flow Implementation-------------------
ARCHITECTURE RTL OF ADD_SUB_4B IS
SIGNAL result:std_logic_vector (n DOWNTO 0) ;
BEGIN
result<=('0'&A)+('0'&B) WHEN M='0' ELSE ('0'&A)-('0'&B);
S <=result(n-1 DOWNTO 0);
COUT<=result(n);  
END ARCHITECTURE RTL;
---------------------------------------------
---------------------------------------------
--First structural implementation Using (n)FULL_ADDER AND (n)XOR_GATE
--XOR_GATE_block-----------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
ENTITY XOR_GATE IS 
PORT (A,B: IN std_logic; Y: OUT std_logic);
END ENTITY XOR_GATE;

ARCHITECTURE XOR_GATE OF  XOR_GATE IS
BEGIN
Y<=A XOR B; 
END ARCHITECTURE XOR_GATE;
---------------------------------------------
--FULL_ADDER_block---------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
ENTITY F_A IS 
PORT (A,B,CI: IN std_logic; CO,S: OUT std_logic);
END ENTITY F_A;

ARCHITECTURE F_A OF  F_A IS
BEGIN
S<=A XOR B XOR CI ;
CO<=(A AND B) OR (CI AND (A XOR B)); 
END ARCHITECTURE F_A;
---------------------------------------------
--ADDER_SUBTRACTOR_Using (n)FULL_ADDER AND (n)XOR_GATE
ARCHITECTURE STRUCT1 OF ADD_SUB_4B IS
COMPONENT XOR_GATE IS 
PORT (A,B: IN std_logic; Y: OUT std_logic);
END COMPONENT XOR_GATE;

COMPONENT F_A IS 
PORT (A,B,CI: IN std_logic; CO,S: OUT std_logic);
END COMPONENT F_A;

SIGNAL RC:std_logic_vector (n DOWNTO 0) ;   -- RIPLE CARRY (INTERNAL CARRY)
SIGNAL BM:std_logic_vector (n-1 DOWNTO 0) ; -- XOR GATE OUTPUT
BEGIN
RC(0)<=M;

GEN_I:FOR I IN 0 TO (n-1) GENERATE
FOR ALL:XOR_GATE USE ENTITY WORK.XOR_GATE (XOR_GATE);
FOR ALL:F_A USE ENTITY WORK.F_A (F_A);
BEGIN
XOR_I:XOR_GATE PORT MAP (M, B(I), BM(I));  -- BM(I)<=M XOR B(I);
F_A_I:F_A PORT MAP (A(I), BM(I), RC(I), RC(I+1), S(I));
END GENERATE;

COUT<=RC(n);
END ARCHITECTURE STRUCT1;
---------------------------------------------
---------------------------------------------
--Second structural implementation Using n_bit_ADDER AND n_bit_MUX
--n_bit_MUX----------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
ENTITY mux2to1_n_bit IS 
generic (n: positive :=4);
PORT (SEL: IN std_logic;
    D0,D1: IN std_logic_vector (n-1 DOWNTO 0);
	Y: OUT std_logic_vector (n-1 DOWNTO 0));
END ENTITY mux2to1_n_bit;

ARCHITECTURE mux2to1_n_bit OF  mux2to1_n_bit IS
BEGIN
Y<=D0 WHEN SEL='0' ELSE D1; 
END ARCHITECTURE mux2to1_n_bit;
---------------------------------------------
--n_bit_ADDER--------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
ENTITY ADDER_n_bit IS 
generic (n: positive :=4);
PORT (C_I: IN std_logic;
  IN1,IN2: IN std_logic_vector (n-1 DOWNTO 0);
      SUM: OUT std_logic_vector (n-1 DOWNTO 0);
      C_O: OUT std_logic);
END ENTITY ADDER_n_bit;

ARCHITECTURE ADDER_n_bit OF ADDER_n_bit IS
SIGNAL TEMP:std_logic_vector (n DOWNTO 0) ;
BEGIN
TEMP<=('0'&IN1)+('0'&IN2)+C_I;
SUM <=TEMP(n-1 DOWNTO 0);
C_O<=TEMP(n);  
END ARCHITECTURE ADDER_n_bit;
---------------------------------------------
--ADDER_SUBTRACTOR Using n_bit_ADDER AND n_bit_MUX
ARCHITECTURE STRUCT2 OF ADD_SUB_4B IS
COMPONENT ADDER_n_bit IS
generic (n: positive :=4); 
PORT (C_I: IN std_logic;
  IN1,IN2: IN std_logic_vector (n-1 DOWNTO 0);
      SUM: OUT std_logic_vector (n-1 DOWNTO 0);
      C_O: OUT std_logic);
END COMPONENT ADDER_n_bit;
FOR ALL:ADDER_n_bit USE ENTITY WORK.ADDER_n_bit (ADDER_n_bit);

COMPONENT mux2to1_n_bit IS
generic (n: positive :=4); 
PORT (SEL: IN std_logic;
    D0,D1: IN std_logic_vector (n-1 DOWNTO 0);
	Y: OUT std_logic_vector (n-1 DOWNTO 0));
END COMPONENT mux2to1_n_bit;
FOR ALL:mux2to1_n_bit USE ENTITY WORK.mux2to1_n_bit (mux2to1_n_bit);

SIGNAL BB,B_INV: std_logic_vector (n-1 DOWNTO 0);  --mux output (B or B_INV)
BEGIN
B_INV<=NOT(B);
N_MUX:mux2to1_n_bit generic map (n) PORT MAP (M,B,B_INV,BB);
N_ADDER:ADDER_n_bit generic map (n) PORT MAP (M,A,BB,S,COUT);
END ARCHITECTURE STRUCT2;
---------------------------------------------