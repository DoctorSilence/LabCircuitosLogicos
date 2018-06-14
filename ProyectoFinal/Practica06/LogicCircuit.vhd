library ieee;
use ieee.std_logic_1164.all;
use  ieee.std_logic_unsigned.all;
use  ieee.std_logic_arith.all;

entity logic_circuit is

	Port (
		S: in std_logic_vector(1 downto 0);
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		G: out std_logic_vector(15 downto 0)

		);
end entity;

architecture bdf_type of logic_circuit is 
	signal res: std_logic_vector(15 downto 0);
begin
	with S select 	
		res  <= A and B       			when  "00" ,
			A or B 					when  "01" ,
			A xor B 				when  "10" ,
			not(A)       			when  "11" ,
			"XXXXXXXXXXXXXXXX"   	when  others;
	G <= res;

end architecture ;