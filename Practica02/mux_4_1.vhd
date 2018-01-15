library ieee;
use ieee.std_logic_1164.all;
entity multiplexer_4_to_1 is
	port (
		S : in std_logic_vector(0 to 1);
		I0 : in std_logic_vector(0 to 3);
		I1 : in std_logic_vector(0 to 3);
		I2 : in std_logic_vector(0 to 3);
		I3 : in std_logic_vector(0 to 3);
		Y 	: out std_logic_vector(0 to 3)
		);
end multiplexer_4_to_1;

architecture function_table of multiplexer_4_to_1 is
	begin
		with S select
			Y <= I0 when "00",
				  I1 when "01",
				  I2 when "10",
				  I3 when "11",
				  "XXXX" when others;
	end function_table;