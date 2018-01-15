LIBRARY ieee;
USE ieee.std_logic_1164.all; 
LIBRARY work;

ENTITY pract5 IS 
	PORT
	(
		clock :  IN  STD_LOGIC;
		write1 :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		dip_0 :  IN  STD_LOGIC_VECTOR(0 TO 3);
		dip_1 :  IN  STD_LOGIC_VECTOR(0 TO 3);
		dip_2 :  IN  STD_LOGIC_VECTOR(0 TO 3);
		dip_3 :  IN  STD_LOGIC_VECTOR(0 TO 3);
		S1 :  OUT  STD_LOGIC;
		S2 :  OUT  STD_LOGIC;
		S3 :  OUT  STD_LOGIC;
		S4 :  OUT  STD_LOGIC;
		salida :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END pract5;

ARCHITECTURE bdf_type OF pract5 IS 

COMPONENT  pract2
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
		sal     : OUT  STD_LOGIC_VECTOR (6  DOWNTO  0)
	);
END  COMPONENT;

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

COMPONENT  binary_to_bcd
	GENERIC
	(
		bits    : INTEGER  := 16;  
		digits : INTEGER  := 4    
	);
	PORT
	(
		clk      : IN   STD_LOGIC; 
		reset_n 	: IN   STD_LOGIC;
		ena      : IN   STD_LOGIC; 
		binary   : IN   STD_LOGIC_VECTOR(bits -1  DOWNTO  0); 
		bcd      : OUT  STD_LOGIC_VECTOR(digits *4-1  DOWNTO  0) 
	);
END  COMPONENT;

SIGNAL  BCD :   STD_LOGIC_VECTOR (0 TO 15);
SIGNAL  datos :   STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL  G :   STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL	led_write :  STD_LOGIC;
SIGNAL	led_reset :  STD_LOGIC;

BEGIN
led_write <= NOT(write1);
led_reset <= NOT(reset);
datos(3 DOWNTO 0) <= dip_0;
datos(7 DOWNTO 4) <= dip_1;
datos(11 DOWNTO 8) <= dip_2;
datos(15 DOWNTO 12) <= dip_3;

b2v_inst_practica2 : pract2
	PORT  MAP
	(
		CLK => clock,
		dip_1 => BCD(12 TO 15),
		dip_2 => BCD(8 TO 11),
		dip_3 => BCD(4 TO 7),
		dip_4 => BCD(0 TO 3),
		pin_name1 => S1,
		pin_name2 => S2,
		pin_name3 => S3,
		pin_name4 => S4,
		sal => salida
	);
	
stbin : binary_to_bcd
	PORT  MAP
	(
		clk => clock ,
		reset_n => '1',
		ena => '1',
		binary => G,
		bcd => BCD
	);
	
b2v_inst_memory : data_memory
	PORT  MAP
	(
		CLK => clock,
		RESET => led_reset,
		MW  => led_write,
		Data_in => datos,
		Address => datos,
		Data_out => G
	);	
END bdf_type;