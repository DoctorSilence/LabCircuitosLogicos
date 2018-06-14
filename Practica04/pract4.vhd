LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;

entity pract4 is
	port(
		clk: in std_logic;
		FS: in std_logic_vector(3 downto 0);
		A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0);
		display: out std_logic_vector(6 downto 0);
		D: out std_logic_vector(3 downto 0);
		C: out std_logic;
		N: out std_logic;
		Z: out std_logic
	);
end entity;

architecture bdf_type of pract4 is

	signal resUF: std_logic_vector(15 downto 0);
	signal resBCD: std_logic_vector(15 downto 0);
	signal Amod: std_logic_vector(15 downto 0);
	signal Bmod: std_logic_vector(15 downto 0);

	component unidadFuncional
		port(
			FS: in std_logic_vector(3 downto 0);
			AIn: in std_logic_vector(15 downto 0);
			BIn: in std_logic_vector(15 downto 0);
			C: out std_logic;
			N: out std_logic;
			F: out std_logic_vector(15 downto 0);
			Z: out std_logic
		);
	end component;

	component Practica2
		port(
			clock :  IN  STD_LOGIC;
			dip_0 :  IN  STD_LOGIC_VECTOR(0 TO 3);
			dip_1 :  IN  STD_LOGIC_VECTOR(0 TO 3);
			dip_2 :  IN  STD_LOGIC_VECTOR(0 TO 3);
			dip_3 :  IN  STD_LOGIC_VECTOR(0 TO 3);
			S1 :  OUT  STD_LOGIC;
			S2 :  OUT  STD_LOGIC;
			S3 :  OUT  STD_LOGIC;
			S4 :  OUT  STD_LOGIC;
			sal :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	end component;

	component binary_to_bcd
		GENERIC(
			bits		:	INTEGER := 16;		--size of the binary input numbers in bits
			digits	:	INTEGER := 4);
		port(
			clk		:	IN		STD_LOGIC;
			reset_n	:	IN		STD_LOGIC;
			ena		:	IN		STD_LOGIC;
			binary	:	IN		STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
			busy		:	OUT	STD_LOGIC;
			bcd		:	OUT	STD_LOGIC_VECTOR(digits*4-1 DOWNTO 0)
		);
	end component;

begin

	Amod<="00000000"&A(7 downto 0);
	Bmod<="00000000"&B(7 downto 0);

	-- with FS select
	-- 	F <= ('0' & A) 								when "0000",
	-- 	('0' & A)+1 									when "0001",
	-- 	('0' & A)+('0' & B) 					when "0010",
	-- 	('0' & A)+('0' & B)+1 				when "0011",
	-- 	('0' & A)+NOT('0' & B) 				when "0100",
	-- 	('0' & A)+NOT('0' & B)+1 			when "0101",
	-- 	('0' & A)-1 									when "0110",
	-- 	('0' & A) 										when "0111",
	-- 	('0' & A) AND ('0' & B) 			when "1000",
	-- 	('0' & A) OR ('0' & B) 				when "1001",
	-- 	('0' & A) XOR ('0' & B) 			when "1010",
	-- 	NOT('0' & A) 									when "1011",
	-- 	('0' & B) 										when "1100",
	-- 	("00" & B(15 downto 1))				when "1101",
	-- 	('0' & B(14 downto 0) & '0')	when "1110",
	-- 	"XXXXXXXXXXXXXXXXX"						when others;

	b2v_inst1 : binary_to_bcd
	PORT  MAP
	(
		CLK => clk ,
		reset_n => '1',
		ena => '1',
		binary => resUF,
		bcd => resBCD
	);

	b2v_inst2 : Practica2
		PORT  MAP
		(
			clock =>  clk,
			dip_0 =>  resBCD(15 DOWNTO 12),
			dip_1 =>  resBCD(11 DOWNTO 8),
			dip_2 =>  resBCD(7 DOWNTO 4),
			dip_3 =>  resBCD(3 DOWNTO 0),
			S1 =>  D(0),
			S2 =>  D(1),
			S3 =>  D(2),
			S4 =>  D(3),
			sal =>  display
		);
	b2v_inst3 : unidadFuncional
		PORT  MAP
		(
			FS => FS,
			AIn => Amod,
			BIn => Bmod,
			C => C,
			N => N,
			F => resUF,
			Z => Z
		);

end architecture ; -- bdf_type
