library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Contadores_CONTA_DES is 
port (
		CLK2: in std_logic;
		RST: in std_logic;
		SEL: in std_logic;
		contagem: out std_logic_vector(9 downto 0)
);
end Contadores_CONTA_DES;

architecture bhv of Contadores_CONTA_DES is
   	signal contador: unsigned(9 downto 0);
		
		-- Utilizando o clock 2 do FSM_clock, faz-se uma contagem decresente a partir do saldo inicial estabelecido
		-- O valor do saldo inicial é atribuído à saída contagem e ao sinal contador ao pressionar-se o botão referente ao RST
		-- SALDO INICIAL : "1011"(10) = "1111110011"(2)
   
 begin
	process(CLK2, RST)
	begin
		if RST= '0' then
			contador <= "1111110011";
			contagem <= "1111110011";
		elsif rising_edge(CLK2) then
			if SEL = '1' then
				if contador > "0000000000" then
					contador <= contador - 1;
				end if;
			end if;
			contagem <= std_logic_vector(contador);
		end if;	
	end process;
end bhv;