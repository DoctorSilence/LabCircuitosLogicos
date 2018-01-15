library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cont2 is
   port(
 	 Clock: in std_logic;
 	 Reset: in std_logic;
	 D: out std_logic_VECTOR(0 TO 1)
	 );
end cont2;
 
architecture Behavioral of cont2 is
   signal temp: std_logic_vector(0 to 1) := "00";
begin   process(Clock,Reset)
   begin
      if Reset='1' then
         temp <= "00";
      elsif(rising_edge(Clock)) then
         if temp="11" then
            temp<="00";
         else
            temp <= temp + 1;
         end if;
      end if;
   end process;
   D <= temp;
end Behavioral;


