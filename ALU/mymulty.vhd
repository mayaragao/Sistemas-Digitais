library ieee;
use ieee.std_logic_1164.all;

entity mymulty is 

	GENERIC (N: INTEGER := 4); -- Numero de bits
   port (
        X: in  std_logic_vector (N-1 downto 0);
        Y: in  std_logic_vector (N-1 downto 0);
        S: out std_logic_vector ((2*N)-1 downto 0) );
	
end entity mymulty;

architecture teste of mymulty is
    component mysomador
        port ( 
            X, Y:   in  std_logic_vector (3 downto 0);
            Cin:    in  std_logic;
            S:      out std_logic_vector (3 downto 0);
           Cout:    out std_logic );
    end component;
	 
-- Termos Gi para AND de X com y(i+1):
    signal G0, G1, G2:  std_logic_vector (3 downto 0);

-- Termos Bj -> serão sinais recebidos pelo modulo somador e
-- deslocados para proxima soma(B0 tem os bits de AND com y0)
    signal B0, B1, B2:  std_logic_vector (3 downto 0);

begin

    G0 <= (X(3) and Y(1), X(2) and Y(1), X(1) and Y(1), X(0) and Y(1));
    G1 <= (X(3) and Y(2), X(2) and Y(2), X(1) and Y(2), X(0) and Y(2));
    G2 <= (X(3) and Y(3), X(2) and Y(3), X(1) and Y(3), X(0) and Y(3));
    B0 <=  ('0',          X(3) and Y(0), X(2) and Y(0), X(1) and Y(0));

soma_1: 
    mysomador port map ( X => G0,
								 Y => B0,
								 Cin => '0',
								 Cout => B1(3),
								 S(3) => B1(2),
								 S(2) => B1(1),
								 S(1) => B1(0),
								 S(0) => S(1) );
				
soma_2: 
    mysomador port map ( X => G1,
								 Y => B1,
								 Cin => '0',
								 Cout => B2(3),
								 S(3) => B2(2),
								 S(2) => B2(1),
								 S(1) => B2(0),
								 S(0) => S(2) );
				
soma_3: 
    mysomador port map ( X => G2,
								 Y => B2,
								 Cin => '0',
								 Cout => S(7),	 
								 S => S(6 downto 3) );  -- ultima soma deslocada para a esquerda em 3 casas
									  
    S(0) <= X(0) and Y(0); 
end architecture teste;