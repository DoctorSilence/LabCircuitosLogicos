LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;

entity instDec is
	port(
		Instruction: in std_logic_vector(15 downto 0);
		--Palabra de CONTROL
		DA,AA,BA: out std_logic_vector(2 downto 0);
		FS: out std_logic_vector(3 downto 0);
		MB,MD,RW,MW,PL,JB,BC: out std_logic
	);
end entity ;--instDec

architecture bdf_type of instDec is

	signal opcode: std_logic_vector(6 downto 0);
	signal DR: std_logic_vector(2 downto 0);
	signal SA: std_logic_vector(2 downto 0);
	signal SB: std_logic_vector(2 downto 0);

	signal resToFS: std_logic;
	signal resToPL: std_logic;
	signal resToMW: std_logic;

begin
	opcode <= Instruction(15 downto 9);
	DR <= Instruction(8 downto 6);
	SA <= Instruction(5 downto 3);
	SB <= Instruction(2 downto 0);

	--OPERACIONES LOGICAS
	resToMW <= opcode(5) AND NOT(opcode(6));
	resToPL <= opcode(5) AND opcode(6);
	resToFS <= opcode(0) AND NOT(resToPL);

	--ASIGNACION DE SALIDAS
	DA<=DR;
	AA<=SA;
	BA<=SB;
	MB<=opcode(6);
	FS(3)<=opcode(3);
	FS(2)<=opcode(2);
	FS(1)<=opcode(1);
	FS(0)<=resToFS;
	MD<=opcode(4);
	RW<=NOT(opcode(5));
	MW<=resToMW;
	PL<=resToPL;
	JB<=opcode(4);
	BC<=opcode(0);

end architecture; -- bdf_type