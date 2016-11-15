library IEEE;
use IEEE.Std_Logic_1164.all;

entity Comparadores_comparador10bit is
port (	
		CONTA: in std_logic_vector( 9 downto 0);
		SAIDA: out std_logic
);
end Comparadores_comparador10bit;

architecture ARCH of Comparadores_comparador10bit is

begin

	SAIDA <= '0' when CONTA = "0000000000" else
		 '1';  
	-- SALDO recebe '0' quando a contagem descendente acaba (="0000000000")
		 
end ARCH;
