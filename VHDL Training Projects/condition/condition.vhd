
-------------------------------------------------------------------------------------
-- Combinational network using conditional concurrent signal assignment statements.
-------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY condition IS
  PORT( a,b, c: IN bit;
        d: OUT bit);
END ENTITY condition;

ARCHITECTURE test OF condition IS
BEGIN 
  d <= a XOR b WHEN c = '0' ELSE      -- a xor b
       a OR b;
END ARCHITECTURE test;