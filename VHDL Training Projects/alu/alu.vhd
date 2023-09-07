---------------------------------------------------------------------------
-- Entity and architecture declarations for an ALU using a CASE statement.
---------------------------------------------------------------------------

PACKAGE pack_a IS
   TYPE op_type IS (add, sub, mul, div);
END PACKAGE pack_a;

LIBRARY ieee;
USE ieee.numeric_bit.ALL;
USE WORK.pack_a.ALL;

ENTITY alu IS
   PORT( op: IN op_type;
         a, b : IN signed (31 DOWNTO 0);
         c : OUT signed (31 DOWNTO 0)); 
END ENTITY alu;

ARCHITECTURE alu OF alu IS
BEGIN 
   Palu: PROCESS (op, a, b) IS
   VARIABLE temp: signed (63 DOWNTO 0) := x"0000000000000000";
   BEGIN 
     CASE op IS
       WHEN add => c <= a + b;   ----c=a+b
       WHEN sub => c <= a - b; 
       WHEN mul => temp := a * b; c <= temp (31 DOWNTO 0);
       WHEN div => c <= a / b; 
     END CASE;
   END PROCESS Palu;
END ARCHITECTURE alu;
