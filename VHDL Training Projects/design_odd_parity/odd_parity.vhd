library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity odd_parity is 
port (reset,clk:in std_logic; x:in std_logic; y:out std_logic);
end entity odd_parity ;

architecture mealy_odd_checker of odd_parity is 
type state_type is (even , odd);
signal c_state,n_state : state_type ;
begin 
cs:process (clk) is begin
if(rising_edge(clk)) then 
	if(reset='1') then c_state<=even;
	else c_state<=n_state;
	end if;
end if;	
end process cs;

ns:process (c_state,x) is begin
	case(c_state) is	
		when even =>if (x='0') then 	y<='0'; n_state<=even;
						else 				   y<='1'; n_state<=odd;
						end if;   
		when odd => if (x='0') then 	y<='1'; n_state<=odd;
						else 				   y<='0'; n_state<=even;
						end if;	
	end case;				 
end process ns;
end architecture mealy_odd_checker;