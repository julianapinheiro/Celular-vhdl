library ieee;
use ieee.std_logic_1164.all;

entity Registradores_Topo is
port (	
		BTN0: in std_logic;
		C0: in std_logic;
		C1: in std_logic;
		C2: in std_logic;
		C3: in std_logic;
		REG: in std_logic_vector (19 downto 0);
		CLOCK: in std_logic;
		SEQ_0: out std_logic_vector (4 downto 0);
		SEQ_1: out std_logic_vector (4 downto 0);
		SEQ_2: out std_logic_vector (4 downto 0);
		SEQ_3: out std_logic_vector (4 downto 0)
);
end Registradores_Topo;

architecture ARCH of Registradores_Topo is

component Registradores_REG_5
	port (	
			CLK: in std_logic;
			RST: in std_logic;
			EN: in std_logic;
			D: in std_logic_vector(4 downto 0);
			Q: out std_logic_vector(4 downto 0)
	);
end component;

begin

		REG0: Registradores_REG_5 port map (CLOCK, BTN0, C0, REG(4 downto 0), SEQ_0);
		REG1: Registradores_REG_5 port map (CLOCK, BTN0, C1, REG(9 downto 5), SEQ_1);
		REG2: Registradores_REG_5 port map (CLOCK, BTN0, C2, REG(14 downto 10), SEQ_2);
		REG3: Registradores_REG_5 port map (CLOCK, BTN0, C3, REG(19 downto 15), SEQ_3);
		
end ARCH;