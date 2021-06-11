library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Soma32 is
	Port (A : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			B : in STD_LOGIC_VECTOR(31 DOWNTO 0);
			S : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			cin : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : out STD_LOGIC_VECTOR(3 DOWNTO 0));
end Soma32;

architecture estrutura of Soma32 is

	component somaAlgarismo is
	Port (A : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			cin : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : out STD_LOGIC_VECTOR (3 DOWNTO 0);
			S : out STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component;
	
	signal cout0: std_logic_vector(3 DOWNTO 0);
	signal cout1: std_logic_vector(3 DOWNTO 0); 
	signal cout2: std_logic_vector(3 DOWNTO 0); 
	signal cout3: std_logic_vector(3 DOWNTO 0); 
	signal cout4: std_logic_vector(3 DOWNTO 0);
	signal cout5: std_logic_vector(3 DOWNTO 0); 
	signal cout6: std_logic_vector(3 DOWNTO 0);
	
	begin
		Soma0: SomaAlgarismo Port Map(A => A(3 downto 0),
												B => B(3 downto 0),
												cin => cin,
												cout => cout0,
												S => S(3 downto 0));
												
		Soma1: SomaAlgarismo Port Map(A => A(7 downto 4),
												B => B(7 downto 4),
												cin => cout0,
												cout => cout1,
												S => S(7 downto 4));
											
		Soma2: SomaAlgarismo Port Map(A => A(11 downto 8),
												B => B(11 downto 8),
												cin => cout1,
												cout => cout2,
												S => S(11 downto 8));
											
		Soma3: SomaAlgarismo Port Map(A => A(15 downto 12),
												B => B(15 downto 12),
												cin => cout2,
												cout => cout3,
												S => S(15 downto 12));
												
		Soma4: SomaAlgarismo Port Map(A => A(19 downto 16),
												B => B(19 downto 16),
												cin => cout3,
												cout => cout4,
												S => S(19 downto 16));
												
		Soma5: SomaAlgarismo Port Map(A => A(23 downto 20),
												B => B(23 downto 20),
												cin => cout4,
												cout => cout5,
												S => S(23 downto 20));
											
		Soma6: SomaAlgarismo Port Map(A => A(27 downto 24),
												B => B(27 downto 24),
												cin => cout5,
												cout => cout6,
												S => S(27 downto 24));
											
		Soma7: SomaAlgarismo Port Map(A => A(31 downto 28),
												B => B(31 downto 28),
												cin => cout6,
												cout => cout,
												S => S(31 downto 28));
												
end estrutura;
