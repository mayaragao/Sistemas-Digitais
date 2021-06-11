library ieee;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY myula IS

	GENERIC (N: INTEGER := 4); -- Numero de bits
	
	PORT (Selector : IN STD_LOGIC_VECTOR(2 DOWNTO 0) ;
			X, Y : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
			S : OUT STD_LOGIC_VECTOR((2*N)-1 DOWNTO 0) ;
			Cout : OUT STD_LOGIC ) ;
			
END myula;

ARCHITECTURE teste OF myula IS

	signal Saida_Multy: STD_LOGIC_VECTOR((2*N)-1 DOWNTO 0) ;

	component mymulty
				port( 
					X: in  std_logic_vector (N-1 downto 0);
					Y: in  std_logic_vector (N-1 downto 0);
					S: out std_logic_vector ((2*N)-1 downto 0));
	end component;	
	
	component mysomador
        port ( 
            X, Y:      in  std_logic_vector (3 downto 0);
            Cin:    in  std_logic;
            S:      out std_logic_vector (3 downto 0);
           Cout:    out std_logic
        );
    end component;
	 
	 		
	SIGNAL S_Aux: STD_LOGIC_VECTOR(N-1 DOWNTO 0) ; --para complemento de 2 na subtracao

BEGIN

	multiplicacao: mymulty port map ( X => X, Y => Y, S => Saida_Multy );
		
	my_case : process (Selector, X, Y) is
	
	--Variaveis auxiliares para a ULA:
		VARIABLE C : STD_LOGIC_VECTOR(N DOWNTO 0) ;
		VARIABLE Comp2 : STD_LOGIC_VECTOR(3 DOWNTO 0);	
		VARIABLE NOTX : STD_LOGIC_VECTOR(3 DOWNTO 0);
		VARIABLE NOTY : STD_LOGIC_VECTOR(3 DOWNTO 0);
		VARIABLE NOTS : STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
		
	begin
	
		CASE Selector IS
-------------------------------------------------------------------------------
		-- AND
			when "000" =>
			
				for i in 0 to N-1 loop
					S(i) <= X(i) AND Y(i);
				end loop;
				
				Cout <= '0';
				
				for j in N to (2*N)-1 loop
					S(j) <= '0'; --completando os bits de saida mais significativos com 0
				end loop;

			
--------------------------------------------------------------------------------
			-- OR
			when "001" => 

				for i in 0 to N-1 loop
					S(i) <= X(i) OR Y(i);
				end loop;
				
				Cout <= '0';
				
				for j in N to (2*N)-1 loop
					S(j) <= '0'; --completando os bits de saida mais significativos com 0
				end loop;

--------------------------------------------------------------------------------
			-- NOT
			when "010" => 
			
				for i in 0 to N-1 loop
				
					S(i) <= NOT X(i) ;
				
				end loop;
				
				Cout <= '0';
				
				for j in N to (2*N)-1 loop
					S(j) <= '0'; --completando os bits de saida mais significativos com 0
				end loop;

			
--------------------------------------------------------------------------------
			-- xOR
			when "011" => 

				for i in 0 to N-1 loop
					S(i) <= X(i) XOR Y(i) ;
				end loop;
				
				Cout <= '0';
				
				for j in N to (2*N)-1 loop
					S(j) <= '0'; --completando os bits de saida mais significativos com 0
				end loop;

			
--------------------------------------------------------------------------------
			-- SOMADOR
			when "100" => 
				
					-- Setando o CarryIn em 0 para a soma do fulladder
					
					C(0) := '0';
					
					for i in 0 to N-1 loop
						S(i) <= X(i) XOR Y(i) XOR C(i) ;
						C(i+1) := (X(i) AND Y(i)) OR (X(i) AND C(i)) OR (Y(i) AND C(i)) ; 
					end loop;
					
					Cout <= '0'; -- Para sinal sempre positivo!
					S(N) <= C(N); --atribuindo o Carry para o S(4), pois saida da ULA tem 8 bits
					
					for j in N+1 to (2*N)-1 loop
						S(j) <= '0'; --completando os bits de saida mais significativos com 0
					end loop;
		
--------------------------------------------------------------------------------
			-- SUBTRATOR
			when "101" => 
						
					C(0) := '0';
					
					for i in 0 to N-1 loop
						NOTX(i) := NOT X(i);
					
						S_Aux(i) <= X(i) XOR Y(i) XOR C(i) ;
						C(i+1) := (NOTX(i) AND Y(i)) OR (NOTX(i) AND C(i)) OR (Y(i) AND C(i)) ; 
					end loop;
					
					-- Aplicando agora complemento de 2 no resultado,
					--	caso negativo, para tratar numa flag de sinal
					
					Cout <= C(N); --flag de sinal
					
					if(C(N) = '1') then 
					
						Comp2(0) := '1';
						Comp2(1) := '0';
						Comp2(2) := '0';
						Comp2(3) := '0';
					
						for i in 0 to N-1 loop	
							NOTS(i) := NOT S_Aux(i);	
							
							S(i) <= NOTS(i) XOR Comp2(i) XOR C(i) ;
							C(i+1) := (NOTS(i) AND Comp2(i)) OR (NOTS(i) AND C(i)) OR (Comp2(i) AND C(i)) ; 
						end loop;
						
					else 
						for i in 0 to N-1 loop
							S(i) <= S_Aux(i);
						end loop;
					end if;
					
					for j in N to (2*N)-1 loop
						S(j) <= '0'; --completando os bits de saida mais significativos com 0
					end loop;
			
--------------------------------------------------------------------------------
			-- MULTIPLICAÇÃO
			
			when "110" => 
				
				for i in 0 to (2*N)-1 loop
					S(i) <= Saida_Multy(i); -- saida recebe resultado do componente mymulty
				end loop;
				
				Cout <= '0'; --sinal sempre positivos
			
				
--------------------------------------------------------------------------------
			-- COMPLEMENTO DE 2
			when others => 
			
			-- Setando o CarryIn em 0 para a soma do fulladder
					
					Cout <= X(3); -- Sinal do numero passado em Complemento de 2
					
					if(X(3) = '1') then 
					
						Comp2(0) := '1';
						Comp2(1) := '0';
						Comp2(2) := '0';
						Comp2(3) := '0';
						
						C(0) := '0';
					
						for i in 0 to N-1 loop
							NOTX(i) := NOT X(i);
						
							S(i) <= NOTX(i) XOR Comp2(i) XOR C(i) ;
							C(i+1) := (NOTX(i) AND Comp2(i)) OR (NOTX(i) AND C(i)) OR (Comp2(i) AND C(i)) ; 
						end loop;
					
						--Cout <= C(N);
					else 
						for i in 0 to N-1 loop
							S(i) <= X(i);
						end loop;

					end if;
					
					for j in N to (2*N)-1 loop
						S(j) <= '0';
					end loop;

		END CASE;
	end process my_case;

END teste;