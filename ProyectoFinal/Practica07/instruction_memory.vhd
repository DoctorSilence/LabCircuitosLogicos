library ieee;
use ieee.std_logic_1164.all ;


entity instruction_memory is
	port
	(
		CLK, RESET: in std_logic;
		IE : in std_logic_vector(15 downto 0);
		I : out std_logic_Vector(15 downto 0)
	);
end instruction_memory;


architecture flujo1 of instruction_memory is
	signal R0   : std_logic_vector(2 downto 0) := "000";   	      --REGISTRO '0'
	signal R1   : std_logic_vector(2 downto 0) := "001";    	  --REGISTRO '1'
	signal R2   : std_logic_vector(2 downto 0) := "010";          --REGISTRO '2'
	signal R3   : std_logic_vector(2 downto 0) := "011";    	  --REGISTRO '3'
	signal R4   : std_logic_vector(2 downto 0) := "100";	      --REGISTRO '4'
	signal R5   : std_logic_vector(2 downto 0) := "101";	      --REGISTRO '5'
	signal R6   : std_logic_vector(2 downto 0) := "110";	      --REGISTRO '6'
	signal R7   : std_logic_vector(2 downto 0) := "111";	      --REGISTRO '7'
	signal MOVA : std_logic_vector(6 downto 0) := "0000000";	  --RD, RA
	signal INC  : std_logic_vector(6 downto 0) := "0000001";	  --RD, RA
	signal ADD  : std_logic_vector(6 downto 0) := "0000010";	  --RD, RA, RB
	signal SUB  : std_logic_vector(6 downto 0) := "0000101";	  --RD, RA, RB
	signal DEC  : std_logic_vector(6 downto 0) := "0000110";	  --RD, RA
	signal ANDD : std_logic_vector(6 downto 0) := "0001000";	  --RD, RA, RB
	signal OOR  : std_logic_vector(6 downto 0) := "0001001";	  --RD, RA, RB
	signal ORX  : std_logic_vector(6 downto 0) := "0001010";	  --RD, RA, RB
	signal NNO  : std_logic_vector(6 downto 0) := "0001011";	  --RD, RA
	signal MOVB : std_logic_vector(6 downto 0) := "0001100";	  --RD, RB
	signal SHR  : std_logic_vector(6 downto 0) := "0001101";	  --RD, RB
	signal SHL  : std_logic_vector(6 downto 0) := "0001110";   --RD, RB
	signal LDI  : std_logic_vector(6 downto 0) := "1001100";	  --RD, OP
	signal ADI  : std_logic_vector(6 downto 0) := "1000010";	  --RD, RA, OP
	signal LD   : std_logic_vector(6 downto 0) := "0010000";	  --RD, RA
	signal ST   : std_logic_vector(6 downto 0) := "0100000";	  --RD, RB
	signal BRZ  : std_logic_vector(6 downto 0) := "1100000";	  --RD, AD
	signal BRN  : std_logic_vector(6 downto 0) := "1100001";	  --RD, AD
	signal JMP  : std_logic_vector(6 downto 0) := "1110000";	  --RA

	BEGIN

		R0 <= "000";          --REGISTRO '0'
		R1 <= "001";    	  --REGISTRO '1'
		R2 <= "010";    	  --REGISTRO '2'
		R3 <= "011";    	  --REGISTRO '3'
		R4 <= "100";	      --REGISTRO '4'
		R5 <= "101";	      --REGISTRO '5'
		R6 <= "110";	      --REGISTRO '6'
		R7 <= "111";	      --REGISTRO '7'
		MOVA <= "0000000";	  --RD, RA
		INC  <= "0000001";	  --RD, RA
		ADD  <= "0000010";	  --RD, RA, RB
		SUB  <= "0000101";	  --RD, RA, RB
		DEC  <= "0000110";	  --RD, RA
		ANDD <= "0001000";	  --RD, RA, RB
		OOR  <= "0001001";	  --RD, RA, RB
		ORX  <= "0001010";	  --RD, RA, RB
		NNO  <= "0001011";	  --RD, RA
		MOVB <= "0001100";	  --RD, RB
		SHR  <= "0001101";	  --RD, RB
		SHL  <= "0001110";    --RD, RB
		LDI  <= "1001100";	  --RD, OP
		ADI  <= "1000010";	  --RD, RA, OP
		LD   <= "0010000";	  --RD, RA
		ST   <= "0100000";	  --RD, RB
		BRZ  <= "1100000";	  --RD, AD
		BRN  <= "1100001";	  --RD, AD
		JMP   <= "1110000";	  --RA

		I <=  "0000000"   &    O"0"  &    O"0"   &    O"0"   WHEN RESET = '1' ELSE

-- Éste programa carga dos valores de data memory a los registros R0 y R1 para operar
-- con estos valores y guardar el resultado de cada operación en los registros restantes
------------------------ STORE-DISPLAY TEST --------------------------------------
			--REGISTROS usados:
			-- 0 - resultado
			-- 1 - X
			-- 2 - Y
			-- 3 - '1' para hacer el XOR
			-- 4 - Y AND '1'
			-- 5 - VARIABLE DE POSICIÓN PARA EL PC (Esta cambiando)
			-- 6 - Valor del índice de la memoria

			ST 		&	  O"0"    &     O"6"   &    O"1"    when IE = X"0000" else  -- CARGAMOS X EN LA MEMORIA[0]
			--0100000 000 000 001
			--0100000000000001
			LD    &   O"0"    &     O"6"   &    O"1"    when IE = X"0001" else  -- CARGAMOS X EN REGISTRO[0] para visualizar en el display
			--0010000 000 110 001
			--0010000000110001
			MOVA	&		O"1"		&		  O"0"	 &		O"1"		when IE = X"0002" else  -- CAMBIAMOS EL REGISTRO[0] AL REGISTRO[1] PARA PONER EL SIGUIENTE NÚMERO (Aquí esta X)
			ST 		&	  O"0"    &     O"0"   &    O"1"    when IE = X"0003" else  -- CARGAMOS Y EN LA MEMORIA[0]
			LD    &   O"0"    &     O"6"   &    O"1"    when IE = X"0004" else  -- CARGAMOS Y EN REGISTRO[0] para visualizar en el display
			MOVA	&		O"2"		&		  O"0"	 &		O"1"		when IE = X"0005" else  -- CAMBIAMOS EL REGISTRO[0] AL REGISTRO[2] (Aquí esta Y)
			LDI   &   O"0"    &     O"0"   &    O"0"    when IE = X"0006" else  -- CARGAMOS CONSTANTE 0 EN REGISTRO[0] (El que despliega el resultado)
			--While y>=1
			BRN   &   O"3"    &     O"2"   &    O"7"  	when IE = X"0007" else  -- Si Y>0 -> Se va al siguiente PC normal, sino, cambia hacia el resultado R[0] porque no cumple con la condicion
			BRZ   &   O"3"    &     O"2"   &    O"7"    when IE = X"0008" else  -- Si Y≥0 xq ya paso el registro pasado, sino, regresamos el resultado R[0] porque no cumple con la condicion
			-- Checar si el número es par:
			-- Guardamos un 1 en un registro para después hacer un AND con Y, pues si es IMPAR=> Respuesta es 1, si es PAR=> es 0
			LDI   &   O"3"    &     O"0"   &    O"1"    when IE = X"0009" else  -- CARGAMOS cte. 1 en REGISTRO[3]
			ANDD 	&  	O"4"		&  	  O"2"	 & 		O"3" 	  when IE = X"000A" else  -- HACEMOS oper: Y XOR R[3], lo guardamos en el REGISTRO[4]
			BRZ  &   O"0"    &     O"4"   &    O"5"    when IE = X"000B" else  -- *** Si R[4] es 0 hacemos la suma en el tiempo 16, sino multiplicanos y dividimos a X y Y
			SHL		&		O"1"		& 		O"0"	 &		O"1"    when IE = X"000C" else  -- MULTIPLICACION X=X*2
			SHR		&		O"2"		& 		O"0"	 &		O"2"    when IE = X"000D" else  -- DIVIDIMOS Y=Y/2
			-- BRINCAMOS A LA INSTURCCIÓN DEL WHILE PARA QUE NO SE INCREMENTE DE NUEVO
			LDI   &   O"5"    &     O"0"   &    O"7"    when IE = X"000E" else  -- CARGAMOS cte. 7 en REGISTRO[5]
			JMP		& 	O"0"		& 		O"5"   &    O"0"	  when IE = X"000F" else  -- ENTRAMOS A R[5] PARA OBTENER EL 7 Y DESPUÉS ESO ASIGNARLO AL PC

			INC		& 	O"0" 		& 		O"0"	 & 	  O"1"	  when IE = X"0010" else 	-- Hacemos la suma Res=Res+X (R[0]=R[0]+R[1])
			-- BRINCAMOS A LA INSTURCCIÓN DEL CAMBIO DE X y Y
			LDI   &   O"5"    &     O"0"   &    O"7"    when IE = X"0011" else  -- CARGAMOS cte. 7 en REGISTRO[5]
			ADI		&		O"5"		&			O"5"	 &		O"5"		when IE = X"0012" else	-- SUMAMOS cte. 5 PARA DESPUÉS IR AL PC 12
			JMP		& 	O"0"		& 		O"5"	 &    O"0"	  when IE = X"0013" else



			--LDI      &    O"0"  &    O"0"   &    O"1"   when IE = X"0000" else    -- Se asigna una constante 1 al registro 0
			--LD       &    O"0"  &    O"0"   &    O"0"   when IE = X"0001" else 	  -- Se carga de data memory el valor en el registro ?
			--LDI      &    O"1"  &    O"0"   &    O"2"   when IE = X"0002" else    -- Se asigna una constante 2 al registro 1
			--LD       &    O"1"  &    O"1"   &    O"0"   when IE = X"0003" else    -- Se carga de data memory el valor en el registro !
			--ADD      &    O"2"  &    O"0"   &    O"1"   when IE = X"0004" else
			--ORX      &    O"3"  &    O"0"   &    O"1"   when IE = X"0005" else
			--OOR      &    O"4"  &    O"2"   &    O"3"   when IE = X"0006" else
			--SHL      &    O"5"  &    O"0"   &    O"3"   when IE = X"0007" else
			--NNO      &    O"6"  &    O"3"   &    O"0"   when IE = X"0008" else
			--ORX      &    O"7"  &    O"3"   &    O"1"   when IE = X"0009" else
			
------------------------ STORE-DISPLAY TEST --------------------------------------

			"0101010" & "101" & "010" & "101" ;

end flujo1;
