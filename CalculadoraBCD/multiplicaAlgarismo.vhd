library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity multiplicaAlgarismo is
	Port (A : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
			B : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
			D : out STD_LOGIC_VECTOR(3 DOWNTO 0); -- Dezena
			U : out STD_LOGIC_VECTOR(3 DOWNTO 0)); --Unidade
end multiplicaAlgarismo;

architecture estrutura of multiplicaAlgarismo is

	signal mult : unsigned (7 downto 0) := "00000000";
	
	-- separar em dezenas e unidades
	signal dez : unsigned (7 downto 0);
	signal uni : unsigned (7 downto 0);
	
	signal s_d : STD_LOGIC_VECTOR (7 downto 0); 
	signal s_u : STD_LOGIC_VECTOR(7 downto 0);
	
	begin
		mult <= unsigned(A) * unsigned(B);
		
		dez <= mult / 10; 
		uni <= mult mod 10; --mod
		
		s_d <= STD_LOGIC_VECTOR(dez); 
		s_u <= STD_LOGIC_VECTOR(uni); 
		
		--convertendo o resultado para bcd:
		
		D <= s_d(3 DOWNTO 0); 
		U <= s_u(3 DOWNTO 0); 

end estrutura;