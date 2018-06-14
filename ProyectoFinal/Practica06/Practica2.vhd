-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 17.0.0 Build 595 04/25/2017 SJ Lite Edition"
-- CREATED		"Wed Sep  6 13:46:41 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Practica2 IS 
	PORT
	(
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
END Practica2;

ARCHITECTURE bdf_type OF Practica2 IS 

COMPONENT multiplexer_4_to_1
	PORT(I0 : IN STD_LOGIC_VECTOR(0 TO 3);
		 I1 : IN STD_LOGIC_VECTOR(0 TO 3);
		 I2 : IN STD_LOGIC_VECTOR(0 TO 3);
		 I3 : IN STD_LOGIC_VECTOR(0 TO 3);
		 S : IN STD_LOGIC_VECTOR(0 TO 1);
		 Y : OUT STD_LOGIC_VECTOR(0 TO 3)
	);
END COMPONENT;

COMPONENT cont2
	PORT(Clock : IN STD_LOGIC;
		 Reset : IN STD_LOGIC;
		 D : OUT STD_LOGIC_VECTOR(0 TO 1)
	);
END COMPONENT;

COMPONENT decoder_2_to_4
	PORT(S : IN STD_LOGIC_VECTOR(0 TO 1);
		 D0 : OUT STD_LOGIC;
		 D1 : OUT STD_LOGIC;
		 D2 : OUT STD_LOGIC;
		 D3 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT G
	PORT(m0 : IN STD_LOGIC;
		 m1 : IN STD_LOGIC;
		 m2 : IN STD_LOGIC;
		 m3 : IN STD_LOGIC;
		 a : OUT STD_LOGIC;
		 b : OUT STD_LOGIC;
		 c : OUT STD_LOGIC;
		 e : OUT STD_LOGIC;
		 d : OUT STD_LOGIC;
		 f : OUT STD_LOGIC;
		 g : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT div_freq
GENERIC (DIV : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 clk_out : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	BCD :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	salida :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(0 TO 1);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;


BEGIN 
SYNTHESIZED_WIRE_6 <= '0';

DispAddress<=selectRF;

b2v_inst : multiplexer_4_to_1
PORT MAP(I0 => In0,
		 I1 => In1,
		 I2 => In2,
		 I3 => In3,
		 S => SYNTHESIZED_WIRE_5,
		 Y => BCD);


b2v_inst3 : cont2
PORT MAP(Clock => SYNTHESIZED_WIRE_1,
		 Reset => SYNTHESIZED_WIRE_6,
		 D => SYNTHESIZED_WIRE_5);



b2v_inst6 : decoder_2_to_4
PORT MAP(S => SYNTHESIZED_WIRE_5,
		 D0 => S1,
		 D1 => S2,
		 D2 => S3,
		 D3 => S4);


b2v_inst7 : G
PORT MAP(m0 => BCD(0),
		 m1 => BCD(1),
		 m2 => BCD(2),
		 m3 => BCD(3),
		 a => salida(6),
		 b => salida(5),
		 c => salida(4),
		 e => salida(3),
		 d => salida(2),
		 f => salida(1),
		 g => salida(0));


b2v_inst8 : div_freq
GENERIC MAP(DIV => 100000
			)
PORT MAP(clk => clock,
		 reset => SYNTHESIZED_WIRE_6,
		 clk_out => SYNTHESIZED_WIRE_1);

sal <= salida;

END bdf_type;