library ieee;
use ieee.std_logic_1164.all;

entity Agenda_ROM is
  port ( 
			address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(19 downto 0) 
);
end entity Agenda_ROM;

architecture ARCH of Agenda_ROM is
  type mem is array ( 0 to 2**4 - 1) of std_logic_vector(19 downto 0);
  constant my_Rom : mem := (
    0  => "11100010100000111011", --TAIS
    1  => "10101010101101000001", --MARI
    2  => "11000010101110000001", --PATI
    3  => "01100010101110101010", --CAUA
    4  => "10000010100101100001", --GABI
    5  => "11010010100111101010", --RAFA
    6  => "11110000011010010100", --WILL
    7  => "10100111010110000001", --LUCI
    8  => "01110101100000110111", --ENIO
    9  => "01101011100000101010", --DEIA
    10 => "10110000011011001010", --NINA
    11 => "01010101000111010001", --ALEX
    12 => "10100111010000111011", --LUIS
    13 => "11010010101110110100", --RAUL
    14 => "10001111011000010111", --HUGO
	 15 => "10001111011000010111" --ISIS
	);
begin
   process (address)
   begin
     case address is
       when "0000" => data <= my_rom(0);
       when "0001" => data <= my_rom(1);
       when "0010" => data <= my_rom(2);
       when "0011" => data <= my_rom(3);
       when "0100" => data <= my_rom(4);
       when "0101" => data <= my_rom(5);
       when "0110" => data <= my_rom(6);
       when "0111" => data <= my_rom(7);
       when "1000" => data <= my_rom(8);
       when "1001" => data <= my_rom(9);
       when "1010" => data <= my_rom(10);
       when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
       when "1101" => data <= my_rom(13);
       when "1110" => data <= my_rom(14);
       when "1111" => data <= my_rom(15);
       when others => data <= "00000000000000000000";
	 end case;
  end process;
end architecture ARCH;
