library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mycalculadora is
	
	Port (A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			OP : in STD_LOGIC; -- 0(soma) , 1(multiplicacao)
			S : out STD_LOGIC_VECTOR(31 DOWNTO 0)); 

end mycalculadora ;

architecture estrutura of mycalculadora is
	
	component Soma is
	Port (A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			S : out STD_LOGIC_VECTOR(15 DOWNTO 0);
			cin : in STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : out STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component;

	component Multiplicacao is
	Port (A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			S : out STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
		
	signal cout0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	signal S_soma : STD_LOGIC_VECTOR(15 DOWNTO 0); 
	signal S_mult : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	begin
		
		Somador: Soma 
		Port Map(A => A,
					B => B,
					cin => "0000",
					cout => cout0,
					S => S_soma);
												
		
		Multiplicador: Multiplicacao 
		Port Map(A => A,
					B => B,
					S => S_mult); 
		
		Operacao: process (S_soma, S_mult, OP)
		begin
			if OP = '0' then
				S <= "000000000000"  & cout0 & S_soma;
			else
				S <= S_mult;
			end if;
		end process;
				
		
end estrutura;