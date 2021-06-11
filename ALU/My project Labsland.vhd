library ieee;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY myprojectLABSLAND IS

	GENERIC (N: INTEGER := 4); -- Numero de bits
	
	PORT (
			CLOCK_50: in std_logic; --Recebe o clock da FPGA
			V_SW: in std_logic_vector(8 downto 0); --Reset_Seletor, X3,X2,X1,X0,Y3,Y2,Y1,Y0
			HEX0, HEX1: out std_logic_vector (6 downto 0); --Representacao de X,Y em displays.
			HEX2, HEX3: out std_logic_vector (6 downto 0); --Resultado da ULA EM 2 Displays 
			HEX4: out std_logic_vector (6 downto 0);-- Display pro Seletor.
			LEDG: out std_logic_vector(3 downto 0)  --LEDG(3) flag de sinal
			);
			
			
END myprojectLABSLAND;

ARCHITECTURE estrutura OF myprojectLABSLAND IS

	component myula
			port( 
					Selector : IN STD_LOGIC_VECTOR(2 DOWNTO 0) ;
					X : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
					Y : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
					
					S : OUT STD_LOGIC_VECTOR((2*N)-1 DOWNTO 0) ;
					Cout : OUT STD_LOGIC
				);
	end component;	
	
	component myclock 
		port(
				clk_in, reset : in std_logic;
				clk_out: out std_logic
			);
	end component myclock;
	
	component mycontador3bits
		port (
			clk: in std_logic; -- clock input
			reset: in std_logic; -- reset input
			contador: out std_logic_vector(2 downto 0) -- output 3-bit contador para seletor
		);
	end component mycontador3bits;
	
	component mydecodificador7seg --Precisaremos de 4 desses, um para cada display.
		port (
			Sinal : in std_logic_vector(3 downto 0);
			Display : out std_logic_vector(6 downto 0)
		);
	end component mydecodificador7seg;
	
	--Declação de sinais:
	
	SIGNAL clk1seg: std_logic;
	SIGNAL contadorSeletor: std_logic_vector(2 downto 0);
	SIGNAL contadorDisplay: std_logic_vector(3 downto 0);
	SIGNAL saidaUla: std_logic_vector(7 downto 0);
	--SIGNAL CarryOutUla: std_logic;

BEGIN


   clock50MHz: myclock port map(CLOCK_50,'0',clk1seg); --clk_in, reset, clk_out.
	 
   contador3bits: mycontador3bits port map(clk1seg, V_SW(8), contadorSeletor);
	
	ula: myula port map (
		contadorSeletor(2 downto 0),
		V_SW(7 downto 4),
		V_SW(3 downto 0),
		saidaUla,
		LEDG(3)
		); 
		
	contadorDisplay(3) <= '0';
	contadorDisplay(2 downto 0) <= contadorSeletor(2 downto 0);
	
	dec0: mydecodificador7seg port map(V_SW(7 downto 4),HEX0); --V_SW, HEX0.
	dec1: mydecodificador7seg port map(V_SW(3 downto 0),HEX1);
	
	dec2: mydecodificador7seg port map(saidaUla(3 downto 0),HEX2);
	dec3: mydecodificador7seg port map(saidaUla(7 downto 4),HEX3);
	
	dec4: mydecodificador7seg port map(	contadorDisplay,HEX4);
	

END estrutura;