--------------------------------------------------------
-- An n-bit address, m-bit word size, testbench single-port RAM. using text_io method.
-------------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY tb2_ram_single_port IS
GENERIC(	n: positive := 4;
			m: positive := 4);
END tb2_ram_single_port;
 
ARCHITECTURE behavior OF tb2_ram_single_port IS 
 
	COMPONENT single_port_ram IS
	GENERIC(	n: positive := 4;
				m: positive := 4);
	PORT(	rw, enable: IN std_logic;
			address: IN unsigned (n-1 DOWNTO 0);
			data: INOUT std_logic_vector (m-1 DOWNTO 0));
    END COMPONENT single_port_ram;
--for dft : single_port_ram USE ENTITY WORK.single_port_ram (behav);
   --Inputs
   signal t_rw, t_enable: std_logic :='0';
   signal  t_address: unsigned (n-1 DOWNTO 0);
   signal  t_data: std_logic_vector (m-1 DOWNTO 0);

BEGIN
 -- Instantiate the single-port RAM in VHDL
   dft: single_port_ram PORT MAP (t_rw, t_enable, t_address, t_data );
   
stim_proc: process is 
file in_f: text open read_mode is "din_single_ram.txt";
file out_f: text open write_mode is "dout_single_ram.txt";

variable in_l,out_l:line;

variable f_rw: string(1 to 4);
variable f_enable: string(1 to 4);
variable f_address , f_data : integer;
variable space : character ;
variable addr,datain: string(1 to 8);
variable int_a,int_d  : integer;
  
BEGIN 
while not endfile (in_f) loop
readline (in_f,in_l);

read(in_l,f_rw);---rw
write(out_l,f_rw);

case f_rw is 
when "w_op" => 
read(in_l,space);
write(out_l,space);
read(in_l,f_enable);--en
write(out_l,f_enable);
read(in_l,space);
write(out_l,space);
read(in_l,addr);
write(out_l,addr);
read(in_l,f_address);----addr
write(out_l,f_address);
read(in_l,space);
write(out_l,space);
read(in_l,datain);
write(out_l,datain);
read(in_l,f_data);
write(out_l,f_data);

case f_enable is 
when "en=1" => t_enable<='1';
when "en=0" => t_enable<='0';
when others => null;
end case ;
t_rw <= '1';
t_address <= conv_unsigned (f_address,4);
t_data <= conv_std_logic_vector(f_data,4);
wait for 15 ns ;		

when "r_op" => 
read(in_l,space);
write(out_l,space);
read(in_l,f_enable);--en
write(out_l,f_enable);
read(in_l,space);
write(out_l,space);
read(in_l,addr);
write(out_l,addr);
read(in_l,f_address);----addr
write(out_l,f_address);
write(out_l,space);
write(out_l,string'("data_out="));

case f_enable is 
when "en=1" => t_enable<='1';
when "en=0" => t_enable<='0';
when others => null;
end case ;
t_rw <= '0';
t_data <=(OTHERS => 'Z'); wait for 2 ns;
t_address <= conv_unsigned (f_address,4);
wait for 13 ns ;
write(out_l,conv_integer(t_data));
when others => null;
end case;
 
writeline(out_f,out_l);	
end loop;
wait;
end process stim_proc;
END architecture behavior;