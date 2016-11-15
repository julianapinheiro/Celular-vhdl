library IEEE;
use IEEE.Std_Logic_1164.all;

entity Seletores_mux4x1 is
port (	
		x: in std_logic_vector(4 downto 0); 
		y: in std_logic_vector(19 downto 0); 
		z: in std_logic_vector(19 downto 0);
		s: in std_logic_vector(1 downto 0);
		m: out std_logic_vector(19 downto 0)
		);
end Seletores_mux4x1;

architecture bhv of Seletores_mux4x1 is

begin
	m <= "00000000000000000000" when s = "00" else
		 x & x & x & x when s = "01" else
		 y when s = "10" else
		 z;
end bhv;