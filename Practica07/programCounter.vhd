library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity programCounter is
port
	(
		CLK , RESET: in std_logic ;
		extendAD: in std_logic_vector(15 downto 0);
		AddressDM: in std_logic_vector(15 downto 0); --Address que se conecta a Data Memory
		fd: in std_logic_vector(2 downto 0);
		Address: out std_logic_vector(15 downto 0)
	);
end programCounter;

architecture ram_arc of programCounter is
	type mem_type is array (2**3 - 1 downto 0) of std_logic_vector (15 downto 0);

	signal memD : mem_type := ( others => X"0000");
	signal PC: std_logic_vector(2 downto 0):="000";

begin
PROCESS (CLK)
begin
	if (CLK' event AND CLK = '1') then
		if (RESET = '1') then
				PC<="000";
		else
			if (fd="000") then
				PC<=PC+1;
			else
				if (fd="100" || fd="101") then
					PC<=PC+NOT(extendAD)+1;
				else
					if (fd="110" || fd="111") then
						PC<=
					end if ;
				end if ;
			end if ;
		
		end if;
	end if;
		
end process;
end ram_arc;