library ieee;
use ieee.std_logic_1164.all;
use  ieee.std_logic_unsigned.all;
use  ieee.std_logic_arith.all;

entity shifter is

	Port (
		S: in std_logic_vector(1 downto 0);
		B: in std_logic_vector(15 downto 0);
		G: out std_logic_vector(15 downto 0)

		);
end entity;

architecture bdf_type of shifter is 
	signal res: std_logic_vector(15 downto 0);
begin
	with S select 	
		res  <= B       			when  "00" ,
			B(14 downto 0) & '0' 		when  "10" ,
			'0' & B(15 downto 1)		when  "01" ,
			"XXXXXXXXXXXXXXXX"   	when  others;
	G <= res;

end architecture ;