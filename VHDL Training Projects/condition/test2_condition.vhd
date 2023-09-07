--test 2 for condition

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

use std.textio.all;

ENTITY test2_condition IS
END ENTITY test2_condition;

ARCHITECTURE test_b of test2_condition is 
component condition IS
  PORT( a, b, c: IN bit;
        d: OUT bit);
END component condition;

signal ta,tb,tc,td: bit;
begin 
dft1:condition port map (ta,tb,tc,td);
p1:process is
file in_f: text open read_mode is "cond_file_in.txt";
file out_f: text open write_mode is "cond_file_out.txt";
variable test_l,res_l:line;
variable fa,fb,fc,fd: bit;
begin 
while not endfile (in_f) loop
readline (in_f,test_l);
read (test_l,fa);
read (test_l,fb);
read (test_l,fc);
read (test_l,fd);

ta<=fa;  tb<=fb; tc<=fc; wait for 15 ns ;
----
write (res_l,string'(" a= "));
write (res_l,fa);
write (res_l,string'(" b= "));
write (res_l,fb);
write (res_l,string'(" c= "));
write (res_l,fc);
write (res_l,string'(" d= "));
write (res_l,fd);
write (res_l,string'("  real d= "));
write (res_l,td);


if (td=fd)
then
write (res_l,string'(" test passed"));
else
write (res_l,string'(" test failed"));
end if ;
writeline (out_f,res_l);
end loop;


wait;  --end simulation

END PROCESS P1;
END ARCHITECTURE test_b;
