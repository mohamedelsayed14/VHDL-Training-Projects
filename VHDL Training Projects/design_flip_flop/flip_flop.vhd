library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flip_flop is 
port (d_in,clear,set,clk:in std_logic; d_out:out std_logic);
end entity flip_flop ;


architecture async_ff of flip_flop is begin
p1: process (clear,set,clk) is begin
		if (clear='1') then d_out<='0';
		elsif (set='1') then d_out<='1';
		elsif (rising_edge (clk)) then d_out<=d_in;  
		end if;
	end process p1;
end architecture async_ff;


