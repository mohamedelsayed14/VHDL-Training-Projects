--------------------------------------------------------
-- (fourth testbench ) An n-bit address, m-bit word size, testbench dual-port RAM. using text_io method.
-------------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
use std.textio.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY tb2_dual_port_ram IS
GENERIC(n: positive := 4; m: positive := 4);
END tb2_dual_port_ram;
 
ARCHITECTURE behavior OF tb2_dual_port_ram IS 
 
COMPONENT dual_port_ram IS
	GENERIC(n: positive := 4;m: positive := 4);
	PORT(	r, w: IN std_logic;
			address_in: IN unsigned (n-1 DOWNTO 0);
			address_out: IN unsigned (n-1 DOWNTO 0);
			data_in: IN std_logic_vector (m-1 DOWNTO 0);
			data_out: OUT std_logic_vector (m-1 DOWNTO 0));
END COMPONENT dual_port_ram;
    
	for dft : dual_port_ram USE ENTITY WORK.dual_port_ram (behav);
	
signal tr, tw: std_logic;
signal taddress_in,taddress_out: unsigned (n-1 DOWNTO 0);
signal tdata_in,tdata_out: std_logic_vector (m-1 DOWNTO 0);
	

BEGIN
 -- Instantiate the single-port RAM in VHDL
   dft: dual_port_ram PORT MAP (tr, tw,taddress_in,taddress_out ,tdata_in ,tdata_out);
   
stim_proc: process is 
file in_f: text open read_mode is "din_dual_ram.txt";
file out_f: text open write_mode is "dout_dual_ram.txt";
variable in_l,out_l:line;
variable space : character ;
variable s_w,s_r: string(1 to 3);
variable s_in_addr,s_in_data: string(1 to 8);
variable faddress_in,fdata_in,faddress_out: integer;
variable s_out_addr: string(1 to 9);
 
BEGIN 
while not endfile (in_f) loop
readline (in_f,in_l);
read(in_l,s_w);
write(out_l,s_w);
read(in_l,space);
write(out_l,space);
read(in_l,s_in_addr);
write(out_l,s_in_addr);
read(in_l,faddress_in);
write(out_l,faddress_in);
read(in_l,space);
write(out_l,space);
read(in_l,s_in_data);
write(out_l,s_in_data);
read(in_l,fdata_in);
write(out_l,fdata_in);
read(in_l,space);
write(out_l,space);
read(in_l,s_r);
write(out_l,s_r);
read(in_l,space);
write(out_l,space);
read(in_l,s_out_addr);
write(out_l,s_out_addr);
read(in_l,faddress_out);
write(out_l,faddress_out);
write(out_l,space);


case s_w is 
when "w=1" => tw<='1' ;
when "w=0" => tw<='0' ;
when others => null ;
end case ;

case s_r is 
when "r=1" => tr<='1' ;
when "r=0" => tr<='0' ;
when others => null ;
end case ;

taddress_in <= conv_unsigned(faddress_in,4);
tdata_in <= conv_std_logic_vector(fdata_in,4);
taddress_out <= conv_unsigned(faddress_out,4);

wait for 10 ns ;

if (tr='1') then 
write(out_l,string'(" out_data="));
write(out_l,conv_integer(tdata_out));
	if (tdata_out=(taddress_out+taddress_out)) then  --check dout = address_out *2
	write(out_l,string'(" <test passed..>"));
	else write(out_l,string'(" <test failed..>"));
	end if;
end if;
writeline(out_f,out_l);	
end loop;
wait;
end process stim_proc;
END architecture behavior;