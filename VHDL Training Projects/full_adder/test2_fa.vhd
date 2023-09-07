----------------------------------------
-- test 2 for full adder
----------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all;
entity test2_fa is
end entity test2_fa;

ARCHITECTURE test OF test2_fa IS
component full_adder IS
   PORT( a, b, c_in : IN bit;
         s, c_out : OUT bit); 
END component full_adder;

signal ta,tb,tci,ts,tco:bit;

BEGIN 
dft:full_adder port map (ta,tb,tci,ts,tco);

p1:process is 
file in_f: text open read_mode is "fa_file_in.txt";
file out_f: text open write_mode is "fa_file_out.txt";
variable test_l,res_l:line;
variable fa,fb,fci,fs,fco:bit;
begin 
while not endfile (in_f) loop
readline (in_f,test_l);
read (test_l,fa);
read (test_l,fb);
read (test_l,fci);
read (test_l,fs);
read (test_l,fco);

ta<=fa;  tb<=fb; tci<=fci; wait for 15 ns ;
----
write (res_l,string'(" a= "));
write (res_l,fa);
write (res_l,string'(" b= "));
write (res_l,fb);
write (res_l,string'(" c= "));
write (res_l,fci);
write (res_l,string'(" s= "));
write (res_l,fs);
write (res_l,string'(" co= "));
write (res_l,fco);
write (res_l,string'("  real s = "));
write (res_l,ts);
write (res_l,string'("  real co = "));
write (res_l,tco);
wait for 15 ns ;
if (ts=fs and tco=fco)
then
write (res_l,string'(" test passed"));
else
write (res_l,string'(" test failed"));
end if ;
writeline (out_f,res_l);
end loop;

wait;  --end simulation

END PROCESS P1;
END ARCHITECTURE test;
