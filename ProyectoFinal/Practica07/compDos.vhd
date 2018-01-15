LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;
use  ieee.std_logic_unsigned.all;
use  ieee.std_logic_arith.all;

entity compDos is
  port (
	number: in std_logic_vector(5 downto 0);
	compNumber: out std_logic_vector(5 downto 0)
  ) ;
end entity ; -- compDos

architecture bdf_type of compDos is

	signal res1: std_logic_vector(5 downto 0);
	signal res2: std_logic_vector(5 downto 0);

begin

	res1<= NOT(number);

	res2<=res1+1;

	compNumber<=res2;

end architecture ; -- bdf_type