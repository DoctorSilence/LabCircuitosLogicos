LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;

entity compDos is
  port (
	number: in std_logic_vector(15 downto 0);
	compNumber: out std_logic_vector(15 downto 0)
  ) ;
end entity ; -- compDos

architecture bdf_type of compDos is

	signal res1: out std_logic_vector(15 downto 0);
	signal res2: out std_logic_vector(15 downto 0);

	for i in 16 downto 0 loop
		res(i)<=NOT(number(i));
	end loop ;

	res2<=res1+1;

	compNumber<=res2;

begin

end architecture ; -- bdf_type