library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Contadores_Comb is 
port ( 	
		RESET: in std_logic;
		SEL: in std_logic_vector(1 downto 0);
		RSTCONT: out std_logic
);
end Contadores_Comb;

architecture ARCH of Contadores_Comb is
begin 

	-- A lógica definida para o reset da contagem crescente (ascendente):
	-- RSTCONT = '0' quando se pressiona o botão de RESET (RESET = '0') ou quando o estado atual não é o de ligação (quando SEL é diferente de "11")
	-- Optou-se então por permanecer com um reset negado
	
	RSTCONT <= '0' when RESET = '0' or not (SEL = "11") else
		'1';
end ARCH;