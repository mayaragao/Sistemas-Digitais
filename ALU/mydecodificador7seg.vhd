library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

ENTITY mydecodificador7seg is
	GENERIC (N: INTEGER := 4); -- Numero de bits
	
	PORT (
			Sinal : in std_logic_vector(N-1 downto 0);
			Display: out std_logic_vector(6 downto 0)
			);
				
END mydecodificador7seg;

ARCHITECTURE Teste of mydecodificador7seg is

BEGIN
	--anodo

	process(Sinal)
	begin
		case Sinal is
		when x"0" => Display<="1000000";
		when x"1" => Display<="1111001";
		when x"2" => Display<="0100100";
		when x"3" => Display<="0110000";
		when x"4" => Display<="0011001";
		when x"5" => Display<="0010010";
		when x"6" => Display<="0000010";
		when x"7" => Display<="1111000";
		when x"8" => Display<="0000000";
		when x"9" => Display<="0010000";
		when x"a" => Display<="0001000"; -- hex(a)
		when x"b" => Display<="0000011"; -- hex(b)
		when x"c" => Display<="1000110"; -- hex(c)
		when x"d" => Display<="0100001"; -- hex(d)
		when x"e" => Display<="0000110"; -- hex(e)
		when x"f" => Display<="0001110"; -- hex(f)

		when others=> Display<="1111111";
		
		end case;
	end process;


END Teste;
