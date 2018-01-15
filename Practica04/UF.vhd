LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;

entity unidadFuncional is
	port(
		FS: in std_logic_vector(3 downto 0);
		AIn: in std_logic_vector(15 downto 0);
		BIn: in std_logic_vector(15 downto 0);
		C: out std_logic;
		N: out std_logic;
		F: out std_logic_vector(15 downto 0);
		Z: out std_logic
	);
end entity;

architecture bdf_type of unidadFuncional is

	signal resGA: std_logic_vector(15 downto 0);
	signal resCO: std_logic;
	signal resGL: std_logic_vector(15 downto 0);
	signal resOM1: std_logic_vector(15 downto 0);
	signal resGS: std_logic_vector(15 downto 0);
	signal resOM2: std_logic_vector(15 downto 0);
	signal resAND: std_logic;

	component arithmetic_circuit
		port(
			C_in   : in  std_logic;
			A      : in  std_logic_vector (15  downto  0);
			B      : in  std_logic_vector (15  downto  0);
			S      : in  std_logic_vector (1  downto  0);
			G      : out  std_logic_vector (15  downto  0);
			C_out : out  std_logic
		);
	end component;

	component logic_circuit
		port(
			S: in std_logic_vector(1 downto 0);
			A: in std_logic_vector(15 downto 0);
			B: in std_logic_vector(15 downto 0);
			G: out std_logic_vector(15 downto 0)
		);
	end component;

	component multiplexer_2_to_1
		port(
			S : in std_logic;
			A : in std_logic_vector(15 downto 0);
			B : in std_logic_vector(15 downto 0);
			O 	: out std_logic_vector(15 downto 0)
		);
	end component;

	component shifter
		port(
			S: in std_logic_vector(1 downto 0);
			B: in std_logic_vector(15 downto 0);
			G: out std_logic_vector(15 downto 0)
		);
	end component;

begin
	resAND<= (FS(2) AND FS(3));

	b2v_inst1 : arithmetic_circuit
		PORT  MAP
		(
			C_in   => FS(0),
			A      => AIn,
			B      => BIn,
			S      => FS(2 downto 1),
			G      => resGA,
			C_out => resCO
		);
	b2v_inst2 : logic_circuit
		PORT  MAP
		(
			S=>FS(1 downto 0),
			A=>AIn,
			B=>BIn,
			G=>resGL
		);
	b2v_inst3 : multiplexer_2_to_1
		PORT  MAP
		(
			S=>FS(3),
			A=>resGA,
			B=>resGL,
			O=>resOM1
		);
	b2v_inst4 : multiplexer_2_to_1
		PORT  MAP
		(
			S=> resAND,
			A=>resOM1,
			B=>resGS,
			O=>resOM2
		);
	b2v_inst5 : shifter
		PORT  MAP
		(
			S=>FS(1 downto 0),
			B=>BIn,
			G=>resGS
		);

	with resOM2 select
		Z <= '1'    when  "0000000000000000" ,
			'0' 		when  others;

	F <= resOM2;
	N <= resOM2(15);
	C <= resCO;

end architecture ; -- bdf_type
