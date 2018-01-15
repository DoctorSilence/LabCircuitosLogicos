library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
port
	(
		CLK , RESET , RW : in std_logic ;
		Ddata : in std_logic_vector (15 downto 0);
		Aadd, Badd, Dadd : in std_logic_vector (2 downto 0);
		Adata, Bdata : out std_logic_vector (15 downto 0);
		DispData: out std_logic_vector(15 downto 0);
		DispAddress: in std_logic_vector(2 downto 0)
	);
end register_file;

architecture ram_arc of register_file is
	type mem_type is array (2**3 - 1 downto 0) of std_logic_vector (15 downto 0);

	signal memD : mem_type := ( others => X"0000");

begin
PROCESS (CLK)
begin
	if (CLK' event AND CLK = '1') then
		if (RESET = '1') then
				memD <= ( others => X"0000");
		else
			if (RW = '1') then
				memD(to_integer(unsigned(Dadd))) <= (Ddata);
			end if;
		end if;
		-- Adata <= memD(to_integer(unsigned(Aadd)));
		-- Bdata <= memD(to_integer(unsigned(Badd)));
		-- DispData <= memD(to_integer(unsigned(DispAddress)));
	end if;

end process;

Adata <= memD(to_integer(unsigned(Aadd)));
Bdata <= memD(to_integer(unsigned(Badd)));
DispData <= memD(to_integer(unsigned(DispAddress)));

end ram_arc;
