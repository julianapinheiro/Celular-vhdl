library ieee;
use ieee.std_logic_1164.all;

entity Contadores_Topo is
port (
		BTN0: in std_logic;
		SEL_LED: in std_logic;
		SEL_DISP: in std_logic_vector(1 downto 0);
		CLOCK: in std_logic;
		
		CONTA_ASC: out std_logic_vector(19 downto 0);
		CONTA_DES: out std_logic_vector(9 downto 0)
);
end Contadores_Topo;

architecture ARCH of Contadores_Topo is

component Contadores_CONTA_DES
	port (
			CLK2: in std_logic;
			RST: in std_logic;
			SEL: in std_logic;
			contagem: out std_logic_vector(9 downto 0)
	);
end component;

component Contadores_CONTA_ASC
	port (
			CLK1: in std_logic;
			RST_CONT: in std_logic;
			contagem: out std_logic_vector(19 downto 0)
		);
end component;

component Contadores_FSM_clock
	port (
			CLOCK: in std_logic;
			RESET: std_logic;
			CLK1: out std_logic;
			CLK2: out std_logic
	);
end component;

component Contadores_Comb
port ( 
		RESET: in std_logic;
		SEL: in std_logic_vector(1 downto 0);
		RSTCONT: out std_logic
);
end component;

	signal C1, C2, R1: std_logic;

begin

		FSM_CLOCK: Contadores_FSM_clock port map (CLOCK, BTN0, C1, C2);
		COMB: Contadores_Comb port map (BTN0, SEL_DISP, R1);
		ASC: Contadores_CONTA_ASC port map (C1, R1, CONTA_ASC);
		DES: Contadores_CONTA_DES port map (C2, BTN0, SEL_LED, CONTA_DES);
		
end ARCH;