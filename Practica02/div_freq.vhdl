
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity div_freq is
	generic (DIV : integer := 100000) ;
	Port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		clk_out: out STD_LOGIC
	);
end div_freq;
 
architecture Behavioral of div_freq is
 signal temporal: STD_LOGIC;
 signal counter : integer range 0 to DIV := 0;
begin
	freq_divider: process (reset, clk) begin
		if (reset = '1') then
			temporal <= '0';
			counter <= 0;
		elsif rising_edge(clk) then
			if (counter = DIV) then
				temporal <= NOT(temporal);
				counter <= 0;
			else
			counter <= counter + 1;
			end if;
		end if;
	end process;
 
	clk_out <= temporal;
end Behavioral;