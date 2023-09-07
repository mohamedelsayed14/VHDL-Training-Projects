-- test 1 for condition

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test1_condition IS
END ENTITY test1_condition;

ARCHITECTURE test_b of test1_condition is 
component condition IS
  PORT( a, b, c: IN bit;
        d: OUT bit);
END component condition;

signal ta,tb,tc,td: bit;
begin 
dft1:condition port map (ta,tb,tc,td);
p1:process is 
begin 
ta<='0';tb<='0'; tc<='0';  wait for 10 ns ;
ta<='1';tb<='1'; tc<='0';  wait for 10 ns ;
ASSERT (td<='0') REPORT "Problem With output case1." SEVERITY error; WAIT FOR 10 ns;
ta<='1';tb<='0'; tc<='0';  wait for 10 ns ;
ASSERT (td<='1') REPORT "Problem With output case2." SEVERITY error; WAIT FOR 10 ns;
ta<='1';tb<='1'; tc<='1';  wait for 10 ns ;
ASSERT (td<='1') REPORT "Problem With output case3." SEVERITY error; WAIT FOR 10 ns;
ta<='0';tb<='0'; tc<='1';  wait for 10 ns ;
ASSERT (td<='0') REPORT "Problem With output case4." SEVERITY error; WAIT FOR 10 ns;
ASSERT FALSE SEVERITY failure;
wait;  --end simulation

END PROCESS P1;
END ARCHITECTURE test_b;
