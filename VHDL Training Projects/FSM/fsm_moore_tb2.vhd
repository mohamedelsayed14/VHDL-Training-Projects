----------------------------------------------------------------
-- ---(8th testbench ) Moore FSM using Text_IO method.
----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all;

ENTITY fsm_moore_tb2 IS
END ENTITY fsm_moore_tb2;

ARCHITECTURE tb_arch OF fsm_moore_tb2 IS
  COMPONENT fsm IS
    PORT(    clk, reset: IN std_logic;
        x: IN std_logic;
        y: OUT std_logic);
  END COMPONENT fsm;
  FOR fsm_dft: fsm USE ENTITY work.fsm(moore_2p);  --cfg
  SIGNAL tclk, treset, tx, ty: std_logic;
BEGIN
  fsm_dft: fsm PORT MAP (tclk, treset, tx, ty);

clock_gen: PROCESS is
  BEGIN
  tclk <='0';
  wait for 10 ns;
  tclk <='1';
  wait for 10 ns;
  END PROCESS clock_gen;
  
sim: PROCESS IS
  file in_f: text open read_mode is "moore_input_f.txt";
  file out_f: text open write_mode is "moore_output_f.txt";
  variable in_l,out_l:line;
  variable duration: time;
  variable space : character;
  variable state: string (1 to 4);
  variable in_X:string (1 to 3);
  variable exp_y:string (1 to 12);
  variable ex_y: std_logic;
  BEGIN
  treset<='1' ;
  wait for 10 ns;
  treset<='0';
  wait for 10 ns;
  
 while not endfile (in_f) loop
   readline (in_f,in_l);
   read (in_l,duration);
   read (in_l,space);
   read (in_l,state);
   read (in_l,space);
   read (in_l,in_X);
   read (in_l,space);
   read (in_l,exp_y);
   
   wait for duration ;

   write(out_l,string'(" time now:"));
   write(out_l,now);
   write(out_l,space);
   write(out_l,state);
   write(out_l,space);
   write(out_l,in_X);
   write(out_l,space);
   write(out_l,exp_y);
   write(out_l,space);
   
	case in_X is 
	when "x=0" => tx<='0' ;
	when "x=1" => tx<='1' ;
	when others => null ;
	end case ;

	wait for 2 ns;
	case exp_y is 
	when "expected_y=0" => ex_y:='0' ;
	when "expected_y=1" => ex_y:='1' ;
	when others => null ;
	end case ; 

	if (ty='1') then
	write(out_l,string'(" real_y=1"));
	elsif (ty='0') then
	write(out_l,string'(" real_y=0"));
	end if;
	 
	if (ty=ex_y) then
	write(out_l,string'(" <test passed>"));
	elsif (ty/=ex_y) then
	write(out_l,string'(" <test failed>"));
	end if;

	writeline(out_f,out_l);
end loop;
WAIT;
END PROCESS sim;
END ARCHITECTURE tb_arch;