LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;
use  ieee.std_logic_unsigned.all;
use  ieee.std_logic_arith.all;


entity pract6 is
	port(
		RW, MB, MD, reset: in std_logic;
		BA, DA, AA: in std_logic_vector(2 downto 0);
		FS: in std_logic_vector(3 downto 0);
		clock: in std_logic;
		clockAll: in std_logic;
		display: out std_logic_vector(6 downto 0);
		D: out std_logic_vector(3 downto 0);
		CIn: in std_logic_vector(15 downto 0);
		MW: in std_logic;
		ExternalData: in std_logic_vector(15 downto 0);
		resAdata: out std_logic_vector(15 downto 0);
		selectRF: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		resN,resZ: out std_logic
	);
end entity;

architecture bdf_type of pract6 is

	signal resMuxD: std_logic_vector(15 downto 0);
	signal resMuxB: std_logic_vector(15 downto 0);
	signal resB: std_logic_vector(15 downto 0);
	signal resA: std_logic_vector(15 downto 0);
	signal resF: std_logic_vector(15 downto 0);
	signal DIn: std_logic_vector (15 downto 0);
	signal DispAddress: STD_LOGIC_VECTOR(2 downto 0);
	signal DispData: STD_LOGIC_VECTOR(15 downto 0);
	
	signal resetN: std_logic;

	component register_file
		port(
			CLK , RESET , RW : in std_logic ;
			Ddata : in std_logic_vector (15 downto 0);
			Aadd, Badd, Dadd : in std_logic_vector (2 downto 0);
			Adata, Bdata : out std_logic_vector (15 downto 0);
			DispData: out std_logic_vector(15 downto 0);
			DispAddress: in std_logic_vector(2 downto 0)
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
			In0 :  IN  STD_LOGIC_VECTOR(0 TO 3);
			In1 :  IN  STD_LOGIC_VECTOR(0 TO 3);
			In2 :  IN  STD_LOGIC_VECTOR(0 TO 3);
			In3 :  IN  STD_LOGIC_VECTOR(0 TO 3);
			S1 :  OUT  STD_LOGIC;
			S2 :  OUT  STD_LOGIC;
			S3 :  OUT  STD_LOGIC;
			S4 :  OUT  STD_LOGIC;
			sal :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
			DispAddress: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			selectRF: IN STD_LOGIC_VECTOR(2 DOWNTO 0)
		);
	end component;

	component data_memory
		port(
			CLK , RESET , MW : in std_logic ;
			Data_in : in std_logic_vector (15 downto 0);
			Address : in std_logic_vector (15 downto 0);
			ExternalData : in std_logic_vector (15 downto 0);
			Data_out : out std_logic_vector (15 downto 0)
		);
	end component;

begin

	resetN <= NOT(reset);

	b2v_inst1 : register_file
		PORT  MAP
		(
			CLK => clockAll,
			RESET => resetN,
			RW=> RW,
			Ddata=> resMuxD,
			Aadd=> AA,
			Badd=> BA,
			Dadd=> DA,
			Adata=> resA,
			Bdata=> resB,
			DispData=> DispData,
			DispAddress=> DispAddress
		);

	b2v_inst2 : multiplexer_2_to_1
		PORT  MAP
		(
			S => MB,
			B => CIn,
			A => resB,
			O => resMuxB
		);

	b2v_inst3 : multiplexer_2_to_1
		PORT  MAP
		(
			S => MD,
			A => resF,
			B => DIn,
			O => resMuxD
		);

	b2v_inst4 : unidadFuncional
		PORT  MAP
		(
			FS=>FS,
			AIn=>resA,
			BIn=>resMuxB,
			F=>resF,
			N=>resN,
			Z=>resZ
		);

	b2v_inst5 : Practica2
		PORT  MAP
		(
			clock =>clock,
			In0 =>DispData(15 downto 12),
			In1 =>DispData(11 downto 8),
			In2 =>DispData(7 downto 4),
			In3 =>DispData(3 downto 0),
			S1 =>D(0),
			S2 =>D(1),
			S3 =>D(2),
			S4 =>D(3),
			sal => display,
			DispAddress => DispAddress,
			selectRF => selectRF
		);

	b2v_inst6 : data_memory
		PORT MAP
		(
			CLK => clockAll,
			RESET => resetN,
			MW => MW,
			Data_in => resMuxB,
			Address => resA,
			ExternalData=> ExternalData,
			Data_out => DIn
		);

	resAdata<= resA;

end architecture ; -- bdf_type
