library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity multiplicaLinha is
	Port (A : in STD_LOGIC_VECTOR(15 DOWNTO 0); 
			B : in STD_LOGIC_VECTOR( 3 DOWNTO 0); 
			S : out STD_LOGIC_VECTOR(19 DOWNTO 0));
end multiplicaLinha;

architecture estrutura of multiplicaLinha is

	component multiplicaAlgarismo is
		Port (A : in STD_LOGIC_VECTOR(3 DOWNTO 0);
				B : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
				D : out STD_LOGIC_VECTOR(3 DOWNTO 0); 
				U : out STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component;
	
	component somaAlgarismo is
		Port (A : in STD_LOGIC_VECTOR(3 DOWNTO 0);
				B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
				cin : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
				cout : out STD_LOGIC_VECTOR(3 DOWNTO 0);
				S : out STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component;
	
	--Sinais para armazenar cada resultado da multiplicacao por Algarismo
	signal D0 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal D1 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal D2 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal D3 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	
	signal U0 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal U1 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal U2 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal U3 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	
	--Sinais Para armazenar os carryout auxiliares da soma da unidade com a dezena do resultado anterior
	signal C0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal C1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal C2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal C3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	--Sinais para armazenar os algarismos em bcd da saida
	
	signal S0 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal S1 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal S2 : STD_LOGIC_VECTOR(3 DOWNTO 0); 
	signal S3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal S4 : STD_LOGIC_VECTOR(3 DOWNTO 0); 

	begin
	
	--primeiramente fazer as multiplicacoes individuais de cada algarimo de A pelo algarismo de B.
	
	Multiplicao0: multiplicaAlgarismo Port Map ( A => A(3 DOWNTO 0),
																B => B,
																D => D0,
																U => U0);
												
	Multiplicao1: multiplicaAlgarismo Port Map ( A => A(7 DOWNTO 4),
																B => B,
																D => D1,
																U => U1);
											
	Multiplicao2: multiplicaAlgarismo Port Map ( A => A(11 DOWNTO 8),
																B => B,
																D => D2,
																U => U2);
												
	Multiplicao3: multiplicaAlgarismo Port Map ( A => A(15 DOWNTO 12),
																B => B,
																D => D3,
																U => U3);

	
	
	--fazer a soma da unidade de Mx encontrado com a dezena de Mx-1
												

	S0 <= U0;									
										
	Soma0: somaAlgarismo Port Map(A => D0,
											B => U1,
											cin => "0000",
											cout => C0,
											S => S1);
										
	Soma1: somaAlgarismo Port Map(A => D1,
											B => U2,
											cin => C0,
											cout => C1,
											S => S2);
										
	Soma2: somaAlgarismo Port Map(A => D2,
											B => U3,
											cin => C1,
											cout => C2,
											S => S3);
										
	Soma3: somaAlgarismo Port Map(A => D3,
											B => "0000",
											cin => C2,
											cout => C3,
											S => S4);
	S(3 DOWNTO 0) <= S0; 
	S(7 DOWNTO 4) <= S1; 
	S(11 DOWNTO 8) <= S2; 
	S(15 DOWNTO 12) <= S3; 
	S(19 DOWNTO 16) <= S4;
	
end estrutura;
	
	
	
	