library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplicacao is
	Port (A : in STD_LOGIC_VECTOR(15 DOWNTO 0); 
			B : in STD_LOGIC_VECTOR(15 DOWNTO 0); 
			S : out STD_LOGIC_VECTOR(31 DOWNTO 0));
end Multiplicacao;

architecture estrutura of Multiplicacao is
	
	component multiplicaLinha is
	Port (A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			S : out STD_LOGIC_VECTOR(19 DOWNTO 0));
	end component;
	
	component Soma32 is
	Port (A : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			B : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			S : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			cin : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : out STD_LOGIC_VECTOR (3 DOWNTO 0));
	end component;

	signal M0 : STD_LOGIC_VECTOR(19 DOWNTO 0);
	signal M1 : STD_LOGIC_VECTOR(19 DOWNTO 0);
	signal M2 : STD_LOGIC_VECTOR(19 DOWNTO 0);
	signal M3 : STD_LOGIC_VECTOR(19 DOWNTO 0);
	
	signal S0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal S1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal S2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal S3 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	signal SS1 : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Saidas da soma dois a dois
	signal SS2 : STD_LOGIC_VECTOR(31 DOWNTO 0);  
	
	signal CS1 : STD_LOGIC_VECTOR(3 DOWNTO 0); -- carrys
	signal CS2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal CS3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	begin
	
	Mult_0 : multiplicaLinha 
	Port Map(A => A,
				B => B(3 downto 0),
				S => M0);
				
	Mult_1 : multiplicaLinha  
	Port Map(A => A,
				B => B(7 downto 4),
				S => M1);
	
	Mult_2 : multiplicaLinha 
	Port Map(A => A,
				B => B(11 downto 8),
				S => M2);
	
	Mult_3 : multiplicaLinha  
	Port Map(A => A,
				B => B(15 downto 12),
				S => M3);

	--ajustando as saidas da multiplicacao para 32 bits para fazer a soma:
	
	S0 <= "000000000000" & M0; 
	S1 <= "00000000" & M1 & "0000";
	S2 <= "0000" & M2 & "00000000"; 
	S3 <= M3 & "000000000000"; 
	
	Soma0 : Soma32 
	Port Map(A => S0,
				B => S1,
				S => SS1, 
				cin => "0000",
				cout => CS1);
				
	Soma1 : Soma32
	Port Map(A => S2,
				B => S3,
				S => SS2,
				cin => "0000",
				cout => CS2);
				
	Soma2 : Soma32 
	Port Map(A => SS1,
				B => SS2,
				S => S, --SS1 + SS2
				cin => "0000",
				cout => CS3);
	
	
end estrutura;