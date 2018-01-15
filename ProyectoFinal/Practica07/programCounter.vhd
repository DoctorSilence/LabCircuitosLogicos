library ieee;
use ieee.std_logic_1164.all;
use  ieee.std_logic_unsigned.all;
use  ieee.std_logic_arith.all;

entity programCounter is
port
	(
		CLK , RESET: in std_logic ;
		extendAD: in std_logic_vector(15 downto 0);
		AData: in std_logic_vector(15 downto 0); --Register
		fd: in std_logic_vector(1 downto 0);
		Address: out std_logic_vector(15 downto 0)
	);
end programCounter;

architecture ram_arc of programCounter is
	signal PC: std_logic_vector(15 downto 0):="0000000000000000";

begin
PROCESS (CLK)
begin
	if (CLK' event AND CLK = '1') then
		if (RESET = '1') then
				PC<="0000000000000000";
		else
			if(fd = "00") then
						PC <= PC + 1;
					else
						if(fd = "01") then
							PC <= PC + extendAD;
						else
							if(fd = "10") then
								PC <= AData;
							end if;	
						end if;
					end if;
		end if;

		Address<=PC;
	end if;

end process;
end ram_arc;
