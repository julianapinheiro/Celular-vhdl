library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Contadores_CONTA_ASC is 
port (
		CLK1: in std_logic;
		RST_CONT: in std_logic;
		contagem: out std_logic_vector(19 downto 0)
);
end Contadores_CONTA_ASC;

architecture bhv of Contadores_CONTA_ASC is
   	signal minutosD: std_logic_vector(4 downto 0); 
   	signal minutosU: std_logic_vector(4 downto 0);
	signal segundosD: std_logic_vector(4 downto 0); 
	signal segundosU: std_logic_vector(4 downto 0); 
	
	-- Sao utilizados 4 sinais para determinar separadamente as dezenas e unidades de segundos e minutos
	-- A contagem, sendo crescente, inicia com todos os valores em "00000" e retorn a esse valor quando RST = '0'
   
 begin
	process(CLK1, RST_CONT)
	begin
	
		if RST_CONT = '0' then
			minutosD <= "00000";
			minutosU <= "00000";
			segundosD <= "00000";
			segundosU <= "00000";
			contagem <= "00000000000000000000";
		elsif rising_edge(CLK1) then
			if segundosU < "01001" then
				segundosU <= segundosU + '1';
			else
				segundosU <= "00000";
				if segundosD < "00101" then	
					segundosD <= segundosD + '1';
				else
					segundosD <= "00000";	
					if minutosU < "01001" then
						minutosU <= minutosU + '1';
					else
						minutosU <= "00000";
						if minutosD < "01001" then
							minutosD <= minutosD + '1';
						else
							minutosD <= "00000";
							minutosU <= "00000";
							segundosD <= "00000";
							segundosU <= "00000";
						end if;
					end if;
				end if;
			end if;
			contagem <= minutosD & minutosU & segundosD & segundosU;
		end if;
	end process;
end bhv;
