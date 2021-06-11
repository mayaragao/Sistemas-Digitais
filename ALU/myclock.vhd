library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY myclock is
PORT (
			clk_in, reset : in std_logic_vector(0 downto 0);
			clk_out: out std_logic_vector(0 downto 0)
		);
END myclock;

ARCHITECTURE Teste of myclock is
	signal novo_clk: std_logic_vector(0 downto 0);
	signal contador : integer range 0 to 49999999 := 0;

BEGIN

	myfrequency: process (reset, clk_in)
	BEGIN
	
		if (reset = "1") then
			novo_clk <= "0";
			contador <= 0;
		elsif rising_edge(clk_in(0)) then --Subida do clock
		
			if (contador = 49999999) then --(50000000) - 1
				novo_clk <= NOT(novo_clk);
				contador <= 0;
			else
				contador <= contador + 1;
			end if;
		end if;
		
	END process;
	
	clk_out <= novo_clk;

END Teste;
