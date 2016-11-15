library IEEE;
use IEEE.Std_Logic_1164.all;

entity Seletores_DECOD is
	port (	C: in std_logic_vector(9 downto 0);
			F: out std_logic_vector(4 downto 0)
	);
end Seletores_DECOD;

architecture bhv of Seletores_DECOD is

		-- O DECOD é utilizado para decodificar a entrada de algarismos da senha pelos switches SW(9..0)
		-- Ele retorna o número do switch se apenas um deles for pressionado, 
		-- isto é, se SW(9) é pressionado, e apenas ele, a saída do DECOD será "01001"(2) = "9"(10)
		-- Se mais de um switch é pressionado, ou nenhum é pressionado, a saída será "11111", referente a " " (espaço/em branco), no decod7seg

begin
	F <=  "00000" when C = "0000000001" else --0
		  "00001" when C = "0000000010" else --1
		  "00010" when C = "0000000100" else --2
		  "00011" when C = "0000001000" else --3
		  "00100" when C = "0000010000" else --4
		  "00101" when C = "0000100000" else --5
		  "00110" when C = "0001000000" else --6
		  "00111" when C = "0010000000" else --7
		  "01000" when C = "0100000000" else --8
		  "01001" when C = "1000000000" else --9
		  "11111"; -- else " "
end bhv;