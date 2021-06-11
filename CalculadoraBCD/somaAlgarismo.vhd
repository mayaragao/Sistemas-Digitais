library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity somaAlgarismo is
	Port (A : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
			B : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
			cin : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
			cout : out STD_LOGIC_VECTOR (3 DOWNTO 0);
			S : out STD_LOGIC_VECTOR(3 DOWNTO 0)); 
end SomaAlgarismo;

architecture estrutura of SomaAlgarismo is

	-- criando sinais auxiliares para fazer o tratamento dos dados para bcd!
	signal S_bcd : std_logic_vector(4 DOWNTO 0); 
	signal S_aux : std_logic_vector(4 DOWNTO 0); 
	
	signal A_aux : std_logic_vector(4 DOWNTO 0);
	signal B_aux : std_logic_vector(4 DOWNTO 0);
	signal cin_aux : std_logic_vector(4 DOWNTO 0);
	signal cout_aux : std_logic_vector(4 DOWNTO 0);

	begin
		
		--concatenando variaveis
		
		A_aux <= '0' & A;
		B_aux <= '0' & B;
		cin_aux <= '0' & cin;
		S_aux <= A_aux + B_aux + cin_aux; -- fazendo a soma, mas em formato binario
		
		--utilizando biblioteca unsigned
		
		AjusteBCD: process(S_aux)
			begin
				if S_aux < 10 then -- se soma<10, nao é necessario fazer ajuste
				
					S_bcd <= S_aux;
					cout_aux <= "00000";
					
				elsif S_aux < 20 then -- se 10<soma<20, adicionar 1 ao cout e diminuir 10 da soma!
					
					S_bcd <= S_aux - "01010"; 
					cout_aux <= "00001"; 
				
				else -- se 20<soma<27, adicionar 2 ao cout e diminuir 20 da soma! ( para o caso de A, B e Cin MAX)
					S_bcd <= S_aux - "10100"; 
					cout_aux <= "00010"; 
				
				end if;
			end process;
		
	
		S <= S_bcd(3 DOWNTO 0);
		cout <= cout_aux(3 DOWNTO 0);
		
end estrutura;