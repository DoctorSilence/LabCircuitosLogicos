LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity displayHex is
	port(
		clock: in std_logic;
		InA,InB: in std_logic_vector(0 to 3);
		Oper: in std_logic_vector(1 downto 0);
		OperLed: out std_logic_vector(1 downto 0);
		display: out std_logic_vector(6 downto 0);
		actD0,actD1, actD2, actD3: out std_logic
	);
end entity;

architecture bdf_type of displayHex is
	component cont2
		port(
			Clock : in std_logic;
		 	Reset : in std_logic;
		 	D : out std_logic_vector(0 TO 1)
		);
	end component;

	component decoder_2_to_4
		port(
			S : in std_logic_vector(0 TO 1);
			D0 : out std_logic;
			D1 : out std_logic;
			D2 : out std_logic;
			D3 : out std_logic
		);
	end component;

	component div_freq
		generic (DIV : INTEGER
				);
		port(
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			clk_out : OUT STD_LOGIC
		);
	end component;

	COMPONENT multiplexer_4_to_1
		PORT(
			I0 : IN STD_LOGIC_VECTOR(0 TO 3);
			I1 : IN STD_LOGIC_VECTOR(0 TO 3);
			I2 : IN STD_LOGIC_VECTOR(0 TO 3);
			I3 : IN STD_LOGIC_VECTOR(0 TO 3);
			S : IN STD_LOGIC_VECTOR(0 TO 1);
			Y : OUT STD_LOGIC_VECTOR(0 TO 3)
		);
	END COMPONENT;

	component M
		port(
		    a,b: in std_logic_vector(0 to 3);
		    s: in std_logic_vector(1 downto 0);
		    r1, r2: out std_logic_vector(0 to 3)
	  	);
	end component;

	component G
		port(
		    m0,m1,m2,m3: in std_logic;
    		a,b,c,d,e,f,g: out std_logic
	  	);
	end component;

	signal resD: std_logic_vector(0 to 1);
	signal resClock: std_logic;
	signal R1M: std_logic_vector(0 to 3);
	signal R2M: std_logic_vector(0 to 3);
	signal resY: std_logic_vector(0 to 3);

	begin
		OperLed <= Oper;
		b2v_inst1 : cont2
			PORT  MAP
			(
				Clock => resClock,
			 	Reset => '0',
			 	D => resD
			);
		b2v_inst2 : decoder_2_to_4
			PORT  MAP
			(
				S => resD,
				D0 => actD0,
				D1 => actD1,
				D2 => actD2,
				D3 => actD3
			);
		b2v_inst3 : div_freq
			GENERIC MAP(DIV => 100000)
			PORT MAP(
				clk => clock,
				reset => '0',
				clk_out => resClock
			);
		b2v_inst4 : multiplexer_4_to_1
			PORT MAP(
				I0 => R2M,
				I1 => R1M,
				I2 => InB,
				I3 => InA,
				S => resD,
				Y => resY
			);
		b2v_inst5 : M
			PORT MAP(
				a => InA,
				b => InB,
			    s => Oper,
			    r1 => R1M,
			    r2 => R2M
			);
		b2v_inst6 : G
			PORT MAP(
				m0 => resY(3),
				m1 => resY(2),
				m2 => resY(1),
				m3 => resY(0),
    			g => display(0),
    			f => display(1),
    			e => display(2),
    			d => display(3),
    			c => display(4),
    			b => display(5),
    			a => display(6)
			);
end bdf_type;