library ieee;
use ieee.std_logic_1164.all;
use  ieee.std_logic_unsigned.all;
use  ieee.std_logic_arith.all;

entity  arithmetic_circuit  is
	port
	(
		C_in   : in  std_logic;
		A      : in  std_logic_vector (15  downto  0);
		B      : in  std_logic_vector (15  downto  0);
		S      : in  std_logic_vector (1  downto  0);
		G      : out  std_logic_vector (15  downto  0);
		C_out : out  std_logic
	);
end  arithmetic_circuit;

architecture  function_table  of  arithmetic_circuit  is
	signal  input     : std_logic_vector (2  downto  0) := C_in & S;
	signal  res       : std_logic_vector (16  downto  0) :=  "00000000000000000";
begin
	input  <= C_in & S;
	with  input  select
		res  <= '0' & A       				when  "000" ,
		('0' & A) + ('0' & B) 				when  "001" ,
		('0' & A) + ('0' & not(B)) 		when  "010" ,
		('0' & A) - '1'       				when  "011" ,
		('0' & A) + '1'        				when  "100" ,
		('0' & A) + ('0' & B) + '1'		when  "101" ,
		('0' & A) + ('0' & not(B)) + '1'	when  "110" ,
		('0' & A)         					when  "111" ,
		"XXXXXXXXXXXXXXXXX"   				when  others;
	c_out  <= res (16);
	G      <= res(15  downto  0);
end  function_table;
