library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY mycontador3bits IS
PORT ( 	clk: in std_logic; -- clock input
			reset: in std_logic; -- reset input
			contador: out STD_LOGIC_VECTOR(2 downto 0) -- output 3bits 
		);

END mycontador3bits;

ARCHITECTURE Teste OF mycontador3bits IS
	SIGNAL contador_up: std_logic_vector(2 downto 0);

BEGIN

	PROCESS(clk)
	BEGIN
	
		if(rising_edge(clk)) then
			if(reset='1') then
				contador_up <= "000";
			else 
				if(contador_up = "000") then contador_up <= "001";
				elsif (contador_up = "001") then contador_up <= "010";
				elsif (contador_up = "010") then contador_up <= "011";
				elsif (contador_up = "011") then contador_up <= "100";
				elsif (contador_up = "100") then contador_up <= "101";
				elsif (contador_up = "101") then contador_up <= "110";
				elsif (contador_up = "110") then contador_up <= "111";
				elsif (contador_up = "111") then contador_up <= "000";
				end if;
			end if;
		end if;
		
	END PROCESS;
	contador <= contador_up;
END Teste;