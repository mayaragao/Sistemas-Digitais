library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myproject is
	Port (SW: in std_logic_vector(17 downto 0) ;
		   KEY: in std_logic_vector(3 downto 0); -- default 1/ press 0
			HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)); 

end myproject ;

architecture estrutura of myproject is
	
	component mycalculadora is
	Port (  A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			B : in STD_LOGIC_VECTOR(15 DOWNTO 0);
			OP : in STD_LOGIC; -- 0(soma) , 1(multiplicacao)
			S : out STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
	
	component mydecodificadorBCD is
		PORT (Sinal : in std_logic_vector(3 downto 0);
				Display: out std_logic_vector(6 downto 0));
	end component;
	
	signal Saida: STD_LOGIC_VECTOR(31 DOWNTO 0) ;
	signal A: STD_LOGIC_VECTOR(15 DOWNTO 0) ;
	signal B: STD_LOGIC_VECTOR(15 DOWNTO 0) ; 
	
	signal A_HEX4: std_logic_vector(6 downto 0); 
	signal A_HEX5: std_logic_vector(6 downto 0); 
	signal A_HEX6: std_logic_vector(6 downto 0); 
	signal A_HEX7: std_logic_vector(6 downto 0); 

	signal B_HEX0: std_logic_vector(6 downto 0);
	signal B_HEX1: std_logic_vector(6 downto 0);
	signal B_HEX2: std_logic_vector(6 downto 0);
	signal B_HEX3: std_logic_vector(6 downto 0);
	
	signal S_HEX0: std_logic_vector(6 downto 0);
	signal S_HEX1: std_logic_vector(6 downto 0);
	signal S_HEX2: std_logic_vector(6 downto 0);
	signal S_HEX3: std_logic_vector(6 downto 0);
	signal S_HEX4: std_logic_vector(6 downto 0);
	signal S_HEX5: std_logic_vector(6 downto 0);
	signal S_HEX6: std_logic_vector(6 downto 0);
	signal S_HEX7: std_logic_vector(6 downto 0);
	
	
	begin
	    
		Chaveamento: process (SW(17 downto 0), KEY(3 downto 0))
		begin
			if KEY(0) = '0' then
				A <= SW(15 downto 0);				
		    end if;
		    
		    if KEY(1) = '0' then
				B <= SW(15 downto 0);
			end if;

		end process;
		
		Calcular: mycalculadora 
		Port Map(   A => A,
					B => B,
					OP => SW(17),
					S =>  Saida);
		
		dec0: mydecodificadorBCD port map(A(3 downto 0),A_HEX4); 
		dec1: mydecodificadorBCD port map(A(7 downto 4),A_HEX5);
		dec2: mydecodificadorBCD port map(A(11 downto 8),A_HEX6);
		dec3: mydecodificadorBCD port map(A(15 downto 12),A_HEX7);
	
		dec4: mydecodificadorBCD port map(B(3 downto 0),B_HEX0); 
		dec5: mydecodificadorBCD port map(B(7 downto 4),B_HEX1);
		dec6: mydecodificadorBCD port map(B(11 downto 8),B_HEX2);
		dec7: mydecodificadorBCD port map(B(15 downto 12),B_HEX3);
				
		dec8: mydecodificadorBCD port map(Saida(3 downto 0),S_HEX0); 
		dec9: mydecodificadorBCD port map(Saida(7 downto 4),S_HEX1);
		dec10: mydecodificadorBCD port map(Saida(11 downto 8),S_HEX2);
		dec11: mydecodificadorBCD port map(Saida(15 downto 12),S_HEX3);
		dec12: mydecodificadorBCD port map(Saida(19 downto 16),S_HEX4); 
		dec13: mydecodificadorBCD port map(Saida(23 downto 20),S_HEX5);
		dec14: mydecodificadorBCD port map(Saida(27 downto 24),S_HEX6);
		dec15: mydecodificadorBCD port map(Saida(31 downto 28),S_HEX7);
		
		
		EscolherDisplay: process (KEY(2))
		begin
			if KEY(2) = '1' then
				HEX0 <= B_HEX0;
				HEX1 <= B_HEX1;
				HEX2 <= B_HEX2;
				HEX3 <= B_HEX3;
				
				HEX4 <= A_HEX4;
				HEX5 <= A_HEX5;
				HEX6 <= A_HEX6;
				HEX7 <= A_HEX7;			
		    end if;
		    
		    if KEY(2) = '0' then
				HEX0 <= S_HEX0;
				HEX1 <= S_HEX1;
				HEX2 <= S_HEX2;
				HEX3 <= S_HEX3;	
				HEX4 <= S_HEX4;
				HEX5 <= S_HEX5;
				HEX6 <= S_HEX6;
				HEX7 <= S_HEX7;
			end if;
		end process;

	
end estrutura;