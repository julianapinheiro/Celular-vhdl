library IEEE;
use IEEE.Std_Logic_1164.all;

entity Seletores_mux2x1 is
port (	
		x: in std_logic_vector(1 downto 0); 
		y: in std_logic_vector(9 downto 0);
		s: in std_logic;
		m: out std_logic_vector(9 downto 0)
		);
end Seletores_mux2x1;

architecture bhv of Seletores_mux2x1 is

begin
	m <= "00000000" & x when s = '0' else
		 y;
end bhv;