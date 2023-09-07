--------------------------------------------------------
--test 2 for  comparator (using  R/W files)
LIBRARY ieee;
use std.textio.all;
USE ieee.std_logic_1164.ALL;
  
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_1164.STD_LOGIC;

entity test2_comp is 
end entity test2_comp;
ARCHITECTURE T1_comp OF  test2_comp IS 
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
------
file comp_test_f: text open read_mode is "comp_test.txt";
file comp_res_f: text open write_mode is "comp_result.txt";
variable test_l,res_l:line;

variable fa,fb :std_logic_vector (7 DOWNTO 0);
variable fout,fnout:bit;

variable r,w: integer;
variable msg: string (1 to 14);
BEGIN 
------

ta<="00000000"; tb<="00000000"; WAIT FOR 15 ns;
while not endfile (comp_test_f) loop
readline (comp_test_f,test_l);
read (test_l,r);
fa:=conv_std_logic_vector(r,8);
read (test_l,r);
fb:=conv_std_logic_vector(r,8);
read (test_l,fout);

read (test_l,fnout);

read (test_l,msg);

ta<=fa;
tb<=fb;
wait for 15 ns;
-----------
write (res_l,string'(" a= "));
w:=conv_integer(fa);
write (res_l,w);
write (res_l,string'(" b= "));
w:=conv_integer(fb);
write (res_l,w);
write (res_l,string'(" eq= "));
write (res_l,fout);
write (res_l,string'(" neq= "));
write (res_l,fnout);
write (res_l,string'("  real eq= "));
write (res_l,tout);
write (res_l,string'("  real neq= "));
write (res_l,tnout);


if (tout/=fout or tnout/=fnout)
then
write (res_l,string'(" faild error msg:"));
write (res_l,msg);
else
write (res_l,string'(" test passed:"));
end if ;
writeline (comp_res_f,res_l);
end loop;
---------------
wait;  --end simulation
END PROCESS PRO1;
END ARCHITECTURE T1_comp;
------------------------------------------------------------------