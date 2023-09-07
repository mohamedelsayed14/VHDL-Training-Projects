library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ud_counter is 
generic (n: positive :=4);
port (clear,preset,up_down,clk:in std_logic;
		d_in:in unsigned (n-1 downto 0);
		d_out:out unsigned (n-1 downto 0));
end entity ud_counter ;

architecture counter of ud_counter is
signal count : unsigned (n-1 downto 0); 
 begin 
p1:process(clk) is begin
if (rising_edge (clk)) then
	if (clear='1') then count<=(others =>'0');
	elsif (preset='1') then count<=d_in;
	elsif (up_down='1') then count<=count +1;
	else count<=count-1;
	end if;
end if;
end process p1;
d_out <= count;
end architecture counter;