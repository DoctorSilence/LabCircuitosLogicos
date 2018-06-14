library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder_2_to_4 is
   port(
 	 S: in std_logic_vector(0 to 1);
 	 D0: out std_logic;
	 D1: out std_logic;
	 D2: out std_logic;
	 D3: out std_logic
	 );
end decoder_2_to_4;
 
architecture function_table of decoder_2_to_4 is
	signal temp: std_logic_vector(0 to 3) := "0000";
	begin
		with S select
			temp <= "1000" when "00",
					  "0100" when "01",
				     "0010" when "10",
				     "0001" when "11",
					  "XXXX" when others;
		D0 <= temp(0);
		D1 <= temp(1);
		D2 <= temp(2);
		D3 <= temp(3);
	end function_table;