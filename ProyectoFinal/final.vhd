library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity final is
  port (
	clock, clkAll, reset: in std_logic;
	ExternalData: in std_logic_vector(15 downto 0);
	display: out std_logic_vector(6 downto 0);
	D: out std_logic_vector(3 downto 0);
	selectRF: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	ledClock, ledReset: out std_logic;
	ledPC: out std_logic_vector(5 downto 0)
  ) ;
end entity ; -- final

architecture bdf_type of final is

	signal resN: std_logic;
	signal resZ: std_logic;

	signal resDA: std_logic_vector(2 downto 0);
	signal resBA: std_logic_vector(2 downto 0);
	signal resAA: std_logic_vector(2 downto 0);
	signal resMB: std_logic;
	signal resFS: std_logic_vector(3 downto 0);
	signal resMD: std_logic;
	signal resRW: std_logic;
	signal resMW: std_logic;

	signal resZF: std_logic_vector(15 downto 0);

	signal resAdata: std_logic_vector(15 downto 0);

	signal NclkAll: std_logic;
  signal resetN: std_logic;

	component pract6
		port(
			RW, MB, MD, reset: std_logic;
			BA, DA, AA: std_logic_vector(2 downto 0);
			FS: std_logic_vector(3 downto 0);
			clock: std_logic;
			clockAll: std_logic;
			display: out std_logic_vector(6 downto 0);
			D: out std_logic_vector(3 downto 0);
			CIn: in std_logic_vector(15 downto 0);
			MW: in std_logic;
			ExternalData: in std_logic_vector(15 downto 0);
			resAdata: out std_logic_vector(15 downto 0);
			selectRF: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			resN,resZ: out std_logic
		);
	end component;

	component pract7
		port(
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
		);
	end component;

begin

	NclkAll<= NOT(clkAll);
	ledClock<=NclkAll;

  resetN <= (reset);
  ledReset<=resetN;

	b2v_inst1 : pract6
		PORT  MAP
		(
			RW=>resRW,
			MB=>resMB,
			MD=>resMD,
			reset=>resetN,
			BA=>resBA,
			DA=>resDA,
			AA=>resAA,
			FS=>resFS,
			clock=>clock,
			clockAll=>NclkAll,
			display=>display, --DISPLAY
			D=>D, --DISPLAY
			CIn=>resZF,
			MW=>resMW,
			ExternalData=>ExternalData,
			resAdata=>resAdata,
			selectRF => selectRF,
			resN=>resN,
			resZ=>resZ
		);

	b2v_inst2 : pract7
		PORT  MAP
		(
			clock=>NclkAll,
			reset=>resetN,
			N=>resN,
			Z=>resZ,
			AData=>resAdata,
			resZF=>resZF,
			DA=>resDA,
			AA=>resAA,
			BA=>resBA,
			FS=>resFS,
			MB=>resMB,
			MD=>resMD,
			RW=>resRW,
			MW=>resMW,
			ledPC=>ledPC
		);


end architecture ; -- bdf_type
