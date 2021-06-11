library ieee;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY mysomador IS

	GENERIC (N: INTEGER := 4); -- Numero de bits
	
	PORT (Cin : IN STD_LOGIC;
			X, Y : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			S : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			Cout : OUT STD_LOGIC ) ;			
END mysomador;


ARCHITECTURE teste OF mysomador IS
	--SIGNAL C : STD_LOGIC_VECTOR(4 DOWNTO 0) ;
BEGIN

	PROCESS(X, Y, Cin)
		VARIABLE C : STD_LOGIC_VECTOR(N DOWNTO 0) ;
	BEGIN
		C(0) := Cin;
		for i in 0 to N-1 loop
		
			S(i) <= X(i) XOR Y(i) XOR C(i) ;
			C(i+1) := (X(i) AND Y(i)) OR (X(i) AND C(i)) OR (Y(i) AND C(i)) ; 
		end loop;
		
		Cout <= C(N);
	END PROCESS;
END teste;