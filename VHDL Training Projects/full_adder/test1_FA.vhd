-- test 1 for full adder 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity test1_fa is
end entity test1_fa;

ARCHITECTURE test OF test1_fa IS
component full_adder IS
   PORT( a, b, c_in : IN bit;
         s, c_out : OUT bit); 
END component full_adder;

signal ta,tb,tci,ts,tco:bit;

BEGIN 
dft:full_adder port map (ta,tb,tci,ts,tco);
p1:process is 
begin 
ta<='0'; tb<='0'; tci<='0';  wait for 10 ns ;
ta<='1';tb<='0'; tci<='0';  wait for 10 ns ;
ASSERT (ts<='1' and tco<='0') REPORT "Problem With output case1" SEVERITY error; WAIT FOR 10 ns;
ta<='1';tb<='1'; tci<='1';  wait for 10 ns ;
ASSERT (ts<='1' and tco<='1') REPORT "Problem With output case2" SEVERITY error; WAIT FOR 10 ns;
ta<='0';tb<='0'; tci<='0';  wait for 10 ns ;
ASSERT (ts<='0' and tco<='0') REPORT "Problem With output case2" SEVERITY error; WAIT FOR 10 ns;

wait;  --end simulation

END PROCESS P1;
END ARCHITECTURE test;
