LIBRARY  ieee;
USE  ieee.std_logic_1164.all;
LIBRARY  work;

ENTITY  pract3  IS
PORT
	(
	clk      :   IN    STD_LOGIC;
	I_0      :   IN    STD_LOGIC_VECTOR (0 TO 3);
	I_1      :   IN    STD_LOGIC_VECTOR (0 TO 3);
	I_2      :   IN    STD_LOGIC_VECTOR (0 TO 3);
	I_3      :   IN    STD_LOGIC_VECTOR (0 TO 3);
	Oper     :   IN    STD_LOGIC_VECTOR (2  DOWNTO  0);
	act_dis1:   OUT   STD_LOGIC;
	act_dis2:   OUT   STD_LOGIC;
	act_dis4:   OUT   STD_LOGIC;
	act_dis3:   OUT   STD_LOGIC;
	C_out    :   OUT   STD_LOGIC;
	--D        :   OUT   STD_LOGIC_VECTOR (0 TO 1);
	display :   OUT   STD_LOGIC_VECTOR (6  DOWNTO  0);
	oper_led:   OUT   STD_LOGIC_VECTOR (2  DOWNTO  0)
	);
END  pract3;
ARCHITECTURE bdf_type OF pract3 IS

COMPONENT  Practica2
	PORT
	(
		CLK     : IN  STD_LOGIC;
		dip_1   : IN  STD_LOGIC_VECTOR (0 TO 3);
		dip_2   : IN  STD_LOGIC_VECTOR (0 TO 3);
		dip_3   : IN  STD_LOGIC_VECTOR (0 TO 3);
		dip_4   : IN  STD_LOGIC_VECTOR (0 TO 3);
		pin_name1 : OUT  STD_LOGIC;
		pin_name2 : OUT  STD_LOGIC;
		pin_name3 : OUT  STD_LOGIC;
		pin_name4 : OUT  STD_LOGIC;
		--D       : OUT  STD_LOGIC_VECTOR (0 TO 1);
		sal     : OUT  STD_LOGIC_VECTOR (6  DOWNTO  0)
	);
END  COMPONENT;

COMPONENT  arithmetic_circuit
	PORT
	(
		C_in   : IN  STD_LOGIC;
		A      : IN  STD_LOGIC_VECTOR (15  DOWNTO  0);
		B      : IN  STD_LOGIC_VECTOR (15  DOWNTO  0);
		S      : IN  STD_LOGIC_VECTOR (1  DOWNTO  0);
		C_out  : OUT  STD_LOGIC;
		G      : OUT  STD_LOGIC_VECTOR (15  DOWNTO  0)
	);
END  COMPONENT;

COMPONENT  binary_to_bcd
	GENERIC
	(
		bits    : INTEGER  := 16;  --bits of the  binary  input
		digits : INTEGER  := 4    --number  of BCD  digits  to  convert  to
	);
	PORT
	(
		clk      : IN   STD_LOGIC; --sys clk
		reset_n 	: IN   STD_LOGIC;
		ena      : IN   STD_LOGIC; --enable
		binary   : IN   STD_LOGIC_VECTOR(bits -1  DOWNTO  0);  --num to  convert
		busy     : OUT  STD_LOGIC; --indicates  conversion  in  progress
		bcd      : OUT  STD_LOGIC_VECTOR(digits *4-1  DOWNTO  0) --BCD  number
	);
END  COMPONENT;

SIGNAL   A_in :   STD_LOGIC_VECTOR (15  DOWNTO  0);
SIGNAL   B_in :   STD_LOGIC_VECTOR (15  DOWNTO  0);
SIGNAL   BCD :   STD_LOGIC_VECTOR (0 TO 15);
SIGNAL   G   :   STD_LOGIC_VECTOR (15  DOWNTO  0);
BEGIN
	oper_led  <= Oper;
	b2v_inst_pract2 : Practica2
	PORT  MAP
	(
		CLK => clk ,
		dip_1 => BCD(12 TO 15),
		dip_2 => BCD(8 TO 11),
		dip_3 => BCD(4 TO 7),
		dip_4 => BCD(0 TO 3),
		pin_name1 => act_dis1 ,
		pin_name2 => act_dis2 ,
		pin_name3 => act_dis3 ,
		pin_name4 => act_dis4 ,
		--D => D,
		sal => display
	);
	b2v_instac : arithmetic_circuit
	PORT  MAP
	(
		C_in => Oper(2),
		A => A_in ,
		B => B_in ,
		S => Oper(1  DOWNTO 0),
		C_out => C_out ,
		G => G
	);
	stbin : binary_to_bcd
	PORT  MAP
	(
		CLK => clk ,
		reset_n => '1',
		ena => '1',
		binary => G,
		bcd => BCD
	);
	A_in(7  DOWNTO  4)  <= I_0;
	A_in(3  DOWNTO  0)  <= I_1;
	B_in(7  DOWNTO  4)  <= I_2;
	B_in(3  DOWNTO  0)  <= I_3;
	A_in (8)   <=   '0';
	A_in (9)   <=   '0';
	A_in (10)  <=  '0';
	A_in (11)  <=  '0';
	A_in (12)  <=  '0';
	A_in (13)  <=  '0';
	A_in (14)  <=  '0';
	A_in (15)  <=  '0';
	B_in (8)   <=  '0';
	B_in (9)   <=  '0';
	B_in (10)  <=  '0';
	B_in (11)  <=  '0';
	B_in (12)  <=  '0';
	B_in (13)  <=  '0';
	B_in (14)  <=  '0';
	B_in (15)  <=  '0';
END  bdf_type;