LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;

entity instSpec is
  port (
	opcode: in std_logic_vector(6 downto 0);
	X,Y,Z: in std_logic_vector(2 downto 0);
	CLK , RESET: in std_logic ;
	Ddata : in std_logic_vector (15 downto 0);
	Adata, Bdata : out std_logic_vector (15 downto 0);
	statusPC,statusN,statusZ: out std_logic
  ) ;
end entity ; -- instSpec

architecture bdf_type of instructionSpecification is

	signal RZ: std_logic_vector(15 downto 0);
	signal srRZ: std_logic_vector(15 downto 0);
	signal slRZ: std_logic_vector(15 downto 0);
	signal RY: std_logic_vector(15 downto 0);
	signal MX: std_logic_vector(15 downto 0);
	signal Reg: std_logic_vector(15 downto 0);
	signal seAD: std_logic_vector(15 downto 0);
	signal resMem: std_logic_vector(6 downto 0);
	signal zfZ: std_logic_vector(6 downto 0);

	component register_file
		port(
			CLK , RESET , RW : in std_logic ;
			Ddata : in std_logic_vector (15 downto 0);
			Aadd, Badd, Dadd : in std_logic_vector (2 downto 0);
			Adata, Bdata : out std_logic_vector (15 downto 0)
		);
	end component;

	COMPONENT  data_memory
	PORT
	(
		CLK : in std_logic ;
		RESET : in std_logic ;
		MW : in std_logic ;
		Data_in : in std_logic_vector (15 downto 0);
		Address : in std_logic_vector (15 downto 0);
		Data_out : out std_logic_vector (15 downto 0)
	);
	END  COMPONENT;

	COMPONENT shifter
		PORT(
			S: in std_logic_vector(1 downto 0);
			B: in std_logic_vector(15 downto 0);
			G: out std_logic_vector(15 downto 0)
		);
	end component;

	COMPONENT zeroFill
		PORT(
			number: in std_logic_vector(2 downto 0);
			zeroNumber: out std_logic_vector(15 downto 0)
		);
	end component;

	COMPONENT compDos
		PORT(
			number: in std_logic_vector(15 downto 0);
			compNumber: out std_logic_vector(15 downto 0)
		);
	end component;

begin
	statusPC<='0'

	b2v_inst_memory : data_memory
		PORT  MAP
		(
			CLK => CLK,
			RESET => RESET,
			MW  => '1',
			Data_in => MX,
			Address => Y,
			Data_out => resMem
		);
	b2v_inst1 : register_file
	PORT  MAP
	(
		CLK => CLK,
		RESET => RESET,
		RW=> RWN,
		Ddata=> Reg,
		Aadd=> Y,
		Badd=> Z,
		Dadd=> X,
		Adata=> RY,
		Bdata=> RZ
	);
	b2v_inst2 : shifter
	PORT  MAP
	(
		S=>"01",
		B=>RZ,
		G=>srRZ
	);
	b2v_inst3 : shifter
	PORT  MAP
	(
		S=>"10",
		B=>RZ,
		G=>slRZ
	);
	b2v_inst4:zeroFill
	PORT MAP
	(
		number=>Z,
		zeroNumber=>zfZ
	);
	AD=X&Z;
	b2v_inst5:compDos
	PORT MAP
	(
		number=>AD,
		compNumber=>seAD
	);

	with opcode select
		Reg<=
			RY				WHEN "0000000",
			RY+1			WHEN "0000001",
			RY+RZ			WHEN "0000010",
			RY-RZ			WHEN "0000101",
			RY-1			WHEN "0000110",
			RY AND RZ 		WHEN "0001000",
			RY OR RZ 		WHEN "0001001",
			RY XOR RZ 		WHEN "0001010",
			NOT(RY)			WHEN "0001011",
			RZ 				WHEN "0001100",
			srRZ 			WHEN "0001101",
			slRZ 			WHEN "0001110",
			zfZ				WHEN "1001100",
			RY+zfZ			WHEN "1000010",
			resMem			WHEN "0010000",
		"XXXXXXXXXXXXXXXX" 	WHEN OTHERS;
	if (opcode="0100000") then
		MX<=RZ;
		statusPC<='1';
	end if ;
	if (opcode="0000000") OR (opcode="0000001") OR (opcode="0000010") OR (opcode="0000101") OR (opcode="0000110") OR (opcode="0001000") OR (opcode="0001001") OR (opcode="0001010") OR (opcode="0001011") OR (opcode="0001100") OR (opcode="0001101") OR (opcode="0001110") OR (opcode="1001100") OR (opcode="1000010") OR (opcode="0010000") then
		statusPC<='1';
	end if ;
	if (opcode="1100000") then
		if (RY=0) then
			PC<=PC+seAD;
		else
			PC<=PC+1;
		end if ;
	end if ;
	if (opcode="1100001") then
		if (RY<0) then
			PC<=PC+seAD;
		else
			PC<=PC+1;
		end if ;
	end if ;
	if (opcode="1110000") then
		PC<=RY;
	end if ;

end architecture ; -- bdf_type