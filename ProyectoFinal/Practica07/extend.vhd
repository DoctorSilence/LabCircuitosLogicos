library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity extend is
  port (
	number: in std_logic_vector(5 downto 0);
	extendNumber: out std_logic_vector(15 downto 0)
  );
end entity; -- extend

architecture bdf_type of extend is

	signal resCompDos: std_logic_vector(5 downto 0);
	signal resNumber: std_logic; -- Es el bit más significativo de number

	component compDos
		port(
			number: in std_logic_vector(5 downto 0);
			compNumber: out std_logic_vector(5 downto 0)
		);
	end component;

begin
	resNumber<= number(5);

	b2v_inst1 : compDos
		PORT MAP
		(
			number => number,
			compNumber => resCompDos
		);

	with resNumber select
		extendNumber <=
						"0000000000"&number when '0',
						"0000000000"&resCompDos when '1',
						"XXXXXXXXXXXXXXXX" when others;

end architecture ; -- bdf_type