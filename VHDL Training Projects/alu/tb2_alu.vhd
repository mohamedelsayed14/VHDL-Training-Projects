--testbench 2 for alu (their is an error (read /write files ))
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_bit.ALL;
USE WORK.pack_a.ALL;
use std.textio.all; 
--use ieee.std_logic_unsigned.all;
------------------------------
ENTITY TB2_alu IS
END ENTITY TB2_alu;

ARCHITECTURE TEST2_alu OF  TB2_alu IS 
component  alu IS
   PORT( op: IN op_type;
         a, b : IN signed (31 DOWNTO 0);
         c : OUT signed (31 DOWNTO 0)); 
END component alu;

SIGNAL  top:  op_type;
SIGNAL ta, tb,tc :  signed (31 DOWNTO 0);

BEGIN
DFT1:alu PORT MAP (top,ta,tb,tc);  --- ta > test signal a  ,, and so on
PRO1:PROCESS IS
file alu_test_f: text open read_mode is "alu_test.txt";
file alu_res_f: text open write_mode is "alu_result.txt";
variable test_l,res_l:line;

variable  fop:  op_type;
variable fa, fb ,fc:  signed(31 downto 0);

variable msg: string (1 to 26);
variable int :  integer ;
variable temp_op :string ( 1 to 3) ;

BEGIN 
---------------
while not endfile (alu_test_f) loop
readline (alu_test_f,test_l);
read (test_l,temp_op);
	case temp_op is 
         when "add" => fop := add;
         when "sub" => fop := sub;
         when "mul" => fop := mul;
         when "div" => fop := div;
	 when others =>  top <= add; 
         end case;
write (res_l,temp_op);

wait for 2 ns;
read (test_l,int);
fa := to_signed(int, 32);
write (res_l,string'(" A="));
write (res_l,int);
wait for 2 ns;

read (test_l,int);
fb := to_signed(int, 32);
Write (res_l,string'(" B="));
write (res_l,int);
wait for 2 ns;

read (test_l,int);
fc := to_signed(int, 32);
write (res_l,string'(" Exp_Out="));
write (res_l,int);
wait for 2 ns;

read (test_l,msg);

top<=fop; ta<=fa; tb<=fb; wait for 15 ns;
------------------------------------------------
write (res_l,string'(" Real_Out="));
int:=to_integer(tc);
write(res_l,int);
------------------------------------------------
if (tc=fc)
then
write (res_l,string'(" >> Test Passed."));
else
write (res_l,string'(" >> Test Failed: msg="));
write (res_l,msg);
end if ;

writeline (alu_res_f,res_l);
end loop;
----------------------
wait;--end simulation
END PROCESS PRO1;
END ARCHITECTURE TEST2_alu;
---------------------------------------------