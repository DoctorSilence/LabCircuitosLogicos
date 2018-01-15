LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;

entity branchControl is
  port (
	PL,JB,BC,N,Z: in std_logic;
	fd: out std_logic_vector(1 downto 0)
  ) ;
end entity ; -- branchControl

architecture bdf_type of branchControl is

begin

fd <= "00" when PL = '0' else --Operacion normal
					 "10" when PL = '1' and JB = '1' else --Jump
				    "01" when PL = '1' and JB = '0' and BC = '0' and Z = '1' else --Branch on zero
					 "00" when PL = '1' and JB = '0' and BC = '0' and Z = '0' else
					 "00" when PL = '1' and JB = '0' and BC = '1' and N = '0' else
					 "01" when PL = '1' and JB = '0' and BC = '1' and N = '1';

end architecture ; -- bdf_type
