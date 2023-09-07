--------------------------------------------------------
---- (third testbench ) An n-bit address, m-bit word size, testbench dual-port RAM. using assertion method.
-------------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY tb1_dual_port_ram IS
GENERIC(n: positive := 4; m: positive := 4);
END tb1_dual_port_ram;
 
ARCHITECTURE behavior OF tb1_dual_port_ram IS 
 
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
  begin  
  tr <= '0'; 
  tw <= '0';
  taddress_out <= x"0";
  taddress_in <= x"0";
  tdata_in <= x"0";
  wait for 10 ns; 
	  
  tr <= '0'; 
  tw <= '0';
  taddress_out <= x"0";
  taddress_in <= x"1";
  tdata_in <= x"1";	  
-- write and read  on/from memory
 for i in 1 to 7 loop
  tr <= '1'; 
  tw <= '1';
  taddress_in <= conv_unsigned(i,4);
  tdata_in <= conv_std_logic_vector(i+i,4);
  wait for 10 ns;
  taddress_out <= conv_unsigned(i,4);
  ASSERT (tdata_out =conv_std_logic_vector(i+i-2 ,4)) REPORT " Wrong Data." SEVERITY error;
  end loop;
-- end operation 
wait;
end process stim_proc;
END behavior;