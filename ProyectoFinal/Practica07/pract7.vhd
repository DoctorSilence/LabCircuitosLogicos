library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pract7 is
  port (
	clock: in std_logic;
	reset: in std_logic;
	N,Z: in std_logic;
	AData: in std_logic_vector (15 downto 0);
	resZF: out std_logic_vector(15 downto 0);
	--Palabra de CONTROL
	DA,AA,BA: out std_logic_vector(2 downto 0);
	FS: out std_logic_vector(3 downto 0);
	MB,MD,RW,MW: out std_logic;
	ledPC: out std_logic_vector(5 downto 0)
  ) ;
end entity ; -- pract7

architecture bdf_type of pract7 is

	signal resBCont: std_logic_vector(1 downto 0);
	signal resPC: std_logic_vector(15 downto 0);
	signal resIM: std_logic_vector(15 downto 0);
	signal resEx: std_logic_vector(15 downto 0);
	signal resNumberEx: std_logic_vector(5 downto 0);

  signal resPL: std_logic;
  signal resJB: std_logic;
  signal resBC: std_logic;
  
  signal resetN: std_logic;

	component programCounter
		port(
			CLK , RESET: in std_logic ;
			extendAD: in std_logic_vector(15 downto 0);
			AData: in std_logic_vector(15 downto 0); --Register
			fd: in std_logic_vector(1 downto 0);
			Address: out std_logic_vector(15 downto 0)
		);
	end component;

	component extend
		port(
			number: in std_logic_vector(5 downto 0);
			extendNumber: out std_logic_vector(15 downto 0)
		);
	end component;

	component branchControl
		port (
			PL,JB,BC,N,Z: in std_logic;
			fd: out std_logic_vector(1 downto 0)
	  	);
	end component;

	component instruction_memory
		port (
			CLK, RESET: in std_logic;
			IE : in std_logic_vector(15 downto 0);
			I : out std_logic_Vector(15 downto 0)
	  	);
	end component;

	component zeroFill
		port (
			number: in std_logic_vector(2 downto 0);
			zeroNumber: out std_logic_vector(15 downto 0)
	  	);
	end component;

	component instDec
		port(
			Instruction: in std_logic_vector(15 downto 0);
			--Palabra de CONTROL
			DA,AA,BA: out std_logic_vector(2 downto 0);
			FS: out std_logic_vector(3 downto 0);
			MB,MD,RW,MW,PL,JB,BC: out std_logic
		);
	end component;

begin

	resNumberEx<=resIM(8 downto 6) & resIM(2 downto 0);
	
	resetN <= NOT(reset);

	b2v_inst1 : branchControl
		PORT  MAP
		(
			PL => resPL,
			JB => resJB,
			BC => resBC,
			N => N,
			Z => Z,
			fd => resBCont
		);

	b2v_inst2 : programCounter
		PORT  MAP
		(
			CLK => clock,
			RESET => resetN,
			extendAD => resEx,
			AData => AData,
			fd => resBCont,
			Address => resPC
		);

	b2v_inst3 : instruction_memory
		PORT  MAP
		(
			CLK => clock,
			RESET => resetN,
			IE => resPC,
			I => resIM
		);

	b2v_inst4 : instDec
		PORT  MAP
		(
			Instruction => resIM,
			DA => DA,
			AA => AA,
			BA => BA,
			FS => FS,
			MB => MB,
			MD => MD,
			RW => RW,
			MW => MW,
			PL => resPL,
			JB => resJB,
			BC => resBC
		);

	b2v_inst5 : zeroFill
		PORT  MAP
		(
			number=> resIM(2 downto 0),
			zeroNumber => resZF
		);

	b2v_inst6 : extend
		PORT  MAP
		(
			number => resNumberEx,
			extendNumber => resEx
		);

		ledPC<=resPC(5 downto 0);
		
end architecture ; -- bdf_type
