library IEEE;
use IEEE.Std_Logic_1164.all;

entity Comparadores_AND is
port (	
		x: in std_logic;
		y: in std_logic;
		z: out std_logic
);
end Comparadores_AND;

architecture ARCH of Comparadores_AND is

	-- Componente de lógica combinacional simples utilizando a operação AND

begin

	z <= x and y; 
	
end ARCH;
	