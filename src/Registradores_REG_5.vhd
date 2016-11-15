library ieee;
use ieee.std_logic_1164.all;

entity Registradores_REG_5 is 
	port (	
			CLK: in std_logic;
			RST: in std_logic;
			EN: in std_logic;
			D: in std_logic_vector(4 downto 0);
			Q: out std_logic_vector(4 downto 0)
	);
end Registradores_REG_5;

architecture ARCH of Registradores_REG_5 is

begin
	process(CLK, RST, D)
	begin
		if RST = '0' then
			Q <= "00000";
		elsif (CLK'event and CLK = '1') then
			if EN = '1' then                      -- Enable determinado pela FSM_Control
				Q <= D;
			end if;
		end if;
	end process;
	
end ARCH;