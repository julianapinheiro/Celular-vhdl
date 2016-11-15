library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Comparadores_comparador20bit is
port (	
		S0: in std_logic_vector (4 downto 0);
		S1: in std_logic_vector (4 downto 0);
		S2: in std_logic_vector (4 downto 0);
		S3: in std_logic_vector (4 downto 0);
		SENHA: in std_logic_vector( 19 downto 0);
		SAIDA: out std_logic	
);
end Comparadores_comparador20bit;

architecture ARCH of Comparadores_comparador20bit is

	signal SEQ: std_logic_vector (19 downto 0);
	
begin

	SEQ <= S3 & S2 & S1 & S0;
	SAIDA <= '1' when SEQ = SENHA else
			 '0';
	-- A saida recebe '1' quando a sequencia de entrada é igual a senha estabelecida em Comparadores_Topo
			 
end ARCH;
