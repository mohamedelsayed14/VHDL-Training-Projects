--------------------------------------------------------------
-- A procedure to be used in comparing two std_logic_vectors.
--------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY comparator IS
   Port( a : IN  std_logic_vector (7 DOWNTO 0);
         b: IN std_logic_vector (7 DOWNTO 0);
         equal_out : OUT bit;
         not_equal_out: OUT bit);
END ENTITY comparator;

ARCHITECTURE Behavioral OF comparator IS
BEGIN
   cp: PROCESS ( b) IS   --  a  not found 
     PROCEDURE compare(in_1, in_2: IN std_logic_vector;
                       equal, not_equal: OUT bit) IS
     BEGIN
       IF a = b THEN
         equal := '1';
         not_equal := '0';
       ELSE
         equal := '0';
         not_equal := '1';
       END IF;
     END PROCEDURE compare;

     VARIABLE equal, not_equal: bit;
   BEGIN
     compare(a, b, equal, not_equal);
     equal_out <= equal;
     not_equal_out <= not_equal;
   END PROCESS cp;
END ARCHITECTURE Behavioral;
---------------------------------------------------------------
