LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;

entity zeroFill is
  port (
	number: in std_logic_vector(2 downto 0);
	zeroNumber: out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- zeroFill

architecture bdf_type of zeroFill is

	signal res: std_logic_vector(15 downto 0);

begin
	res<= "0000000000000" & number;
	zeroNumber<=res;
end architecture ; -- bdf_type