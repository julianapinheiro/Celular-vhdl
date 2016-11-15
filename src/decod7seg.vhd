library IEEE;
use IEEE.Std_Logic_1164.all;

entity decod7seg is
	port (
				C: in std_logic_vector(4 downto 0);
				F: out std_logic_vector(6 downto 0)
	);
end decod7seg;

architecture bhv of decod7seg is
begin

	-- O componente decod7seg recebe uma entrada de 5 bits referente ao número/letra desejado e retorna uma saída de 7 bits que determina o que "acende" nos displays HEX
	-- Para ser possível utilizar todas as 26 letras e os 10 algorismos, como alguns deles são iguais no display HEX, optou-se por serem definidos pelo mesmo número de 5bits

	F <=  "1000000" when C = "00000" else --0
		  "1111001" when C = "00001" else --1 e I
		  "0100100" when C = "00010" else --2 e Z 
		  "0110000" when C = "00011" else --3
		  "0011001" when C = "00100" else --4
		  "0010010" when C = "00101" else --5
		  "0000010" when C = "00110" else --6
		  "1111000" when C = "00111" else --7
		  "0000000" when C = "01000" else --8
		  "0010000" when C = "01001" else --9
		  "0001000" when C = "01010" else --A
		  "0000011" when C = "01011" else --b
		  "1000110" when C = "01100" else --C
		  "0100001" when C = "01101" else --d
		  "0000110" when C = "01110" else --E
		  "0001110" when C = "01111" else --F
		  "0010000" when C = "10000" else --g
		  "0001001" when C = "10001" else --H e X
		  "1100001" when C = "10010" else --J
		  "0000101" when C = "10011" else --K
		  "1000111" when C = "10100" else --L
		  "0101011" when C = "10101" else --m
		  "1001000" when C = "10110" else --N
		  "1000000" when C = "10111" else --O
		  "0001100" when C = "11000" else --P
		  "0011000" when C = "11001" else --q
		  "0101111" when C = "11010" else --r
		  "0010010" when C = "11011" else --S
		  "0000111" when C = "11100" else --t
		  "1000001" when C = "11101" else --U e V
		  "1100011" when C = "11110" else --w
		  "1111111";
end bhv;