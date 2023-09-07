--------------------------------------------------------
-- An n-bit address, m-bit word size, testbench single-port RAM. using assertion method.
-------------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY tb1_ram_single_port IS
GENERIC(	n: positive := 4;
			m: positive := 4);
END tb1_ram_single_port;
 
ARCHITECTURE behavior OF tb1_ram_single_port IS 
 
	COMPONENT single_port_ram IS
	GENERIC(	n: positive := 4;
				m: positive := 4);
	PORT(	rw, enable: IN std_logic;
			address: IN unsigned (n-1 DOWNTO 0);
			data: INOUT std_logic_vector (m-1 DOWNTO 0));
    END COMPONENT single_port_ram;
    
	for dft : single_port_ram USE ENTITY WORK.single_port_ram (behav);
	
   --Inputs
   signal t_rw, t_enable: std_logic :='0';
   signal  t_address: unsigned (n-1 DOWNTO 0):= (others =>'0');
   signal  t_data: std_logic_vector (n-1 DOWNTO 0);


   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
 -- Instantiate the single-port RAM in VHDL
dft: single_port_ram PORT MAP (t_rw, t_enable,t_address,t_data );
   
stim_proc: process
   begin  
  t_enable <= '0'; 
  t_rw <= '0';
  t_address <= x"1";
  wait for CLOCK_period; 
	  
-- write and read  on/from memory
 for i in 1 to 7 loop
  t_enable <= '1'; 
  t_rw <= '1';
  t_address <= conv_unsigned(i,4);
  t_data <=conv_std_logic_vector(i+i,4);
  wait for CLOCK_period;
  t_enable <= '1';
  t_rw <= '0';
  t_data <=(OTHERS => 'Z'); wait for 2 ns;
  t_address <=conv_unsigned(i,4);
  ASSERT (t_data =conv_std_logic_vector(i+i,4)) REPORT " Wrong Data." SEVERITY error;
  wait for 8 ns;
  end loop;
  
-- read from memory
for j in 1 to 7 loop
  t_enable <= '1';
  t_rw <= '0';
  t_data <=(OTHERS => 'Z'); wait for 2 ns;
  t_address <=conv_unsigned(j,4);
  ASSERT (t_data =conv_std_logic_vector(j+j,4)) REPORT " Wrong Data(expected wrong)." SEVERITY note;
  wait for 8 ns;
  end loop;  
-- end operation 
 t_enable <= '0';
wait;
end process stim_proc;
END behavior;