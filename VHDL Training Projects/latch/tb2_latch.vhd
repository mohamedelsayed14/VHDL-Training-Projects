--testbench 2 for latch using read write files 
library ieee;
use std.textio.all;

ENTITY TB1_LATCH IS
END ENTITY TB1_LATCH;

ARCHITECTURE TEST2_LATCH OF  TB1_LATCH IS 
COMPONENT latch IS
  PORT( d, clk: IN bit;
        q, nq: OUT bit);
END COMPONENT latch;
SIGNAL  TD,TCLK,TQ,TNQ:BIT;
BEGIN
DFT1:latch PORT MAP (TD,TCLK,TQ,TNQ);
PRO1:PROCESS IS
file latch_test_f: text open read_mode is "latch_test.txt";
file latch_res_f: text open write_mode is "latch_result.txt";
variable test_l,res_l:line;
variable  fD,fCLK,fQ,fNQ:BIT;
variable puse: time;
variable msg: string (1 to 27);
BEGIN 
---------------
TD<='0'; TCLK<='0';  WAIT FOR 15 ns;
while not endfile (latch_test_f) loop
readline (latch_test_f,test_l);
read (test_l,fd);
read (test_l,fclk);
read (test_l,puse);
read (test_l,fq);
read (test_l,fnq);
read (test_l,msg);

td<=fd; tclk<=fclk; wait for puse;

write (res_l,string'("time is now"));
write (res_l,now);
write (res_l,string'(" d= "));
write (res_l,fd);
write (res_l,string'(" clk= "));
write (res_l,fclk);
write (res_l,string'(" q= "));
write (res_l,fq);
write (res_l,string'(" nq= "));
write (res_l,fnq);
write (res_l,string'("  real q= "));
write (res_l,tq);
write (res_l,string'("  real nq= "));
write (res_l,tnq);

if (tq/=fq or tnq/=fnq)
then
write (res_l,string'(" faild error msg:"));
write (res_l,msg);
else
write (res_l,string'(" test passed:"));
end if ;
writeline (latch_res_f,res_l);
end loop;

----------------------
wait;  --end simulation
END PROCESS PRO1;
END ARCHITECTURE TEST2_LATCH;
---------------------------------------------
----TEST CONGIG FOR RIGHT DESIGN ARCH
CONFIGURATION RIGHT_TEST2_CFG OF TB1_LATCH IS
FOR TEST2_LATCH
	FOR DFT1: latch
	USE ENTITY WORK.latch (behav);
	END FOR;
END FOR;
END CONFIGURATION RIGHT_TEST2_CFG;
-----------------------------------------------
----TEST CONGIG FOR wrong DESIGN ARCH
CONFIGURATION WRONG_TEST2_CFG OF TB1_LATCH IS
FOR TEST2_LATCH
	FOR DFT1: latch
	USE ENTITY WORK.latch (wrong_behav);
	END FOR;
END FOR;
END CONFIGURATION WRONG_TEST2_CFG;
----------------------------------------------