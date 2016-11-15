library ieee;
use ieee.std_logic_1164.all;

entity Seletores_Topo is
port (	
		SW: in std_logic_vector (9 downto 0);
		AGENDA: std_logic_vector (19 downto 0);
		CONTA_ASC: in std_logic_vector (19 downto 0);
		CONTA_DES: in std_logic_vector (9 downto 0);
		SEL_DISP: in std_logic_vector (1 downto 0);
		SEL_LED: in std_logic;
		TENTATIVAS: in std_logic_vector (1 downto 0);
		
		LED_OUT: out std_logic_vector (9 downto 0);
		REG: out std_logic_vector (19 downto 0)
);
end Seletores_Topo;

architecture bhv of Seletores_Topo is

component Seletores_DECOD
	port (	C: in std_logic_vector(9 downto 0);
			F: out std_logic_vector(4 downto 0)
	);
end component;

component Seletores_mux2x1
	port (	x: in std_logic_vector(1 downto 0); 
			y: in std_logic_vector(9 downto 0);
			s: in std_logic;
			m: out std_logic_vector(9 downto 0)
	);
end component;

component Seletores_mux4x1
	port (	x: in std_logic_vector(4 downto 0); 
			y: in std_logic_vector(19 downto 0); 
			z: in std_logic_vector(19 downto 0);
			s: in std_logic_vector(1 downto 0);
			m: out std_logic_vector(19 downto 0)
	);
end component;

signal IN_PASS: std_logic_vector(4 downto 0);

begin

		-- Quando SEL_LED = '0', a saída do mux2X1 (para LEDR) é "00000000" concatenado ao número de tentativas (referentes a senha)
		-- Quando SEL_LED = '1', a saída no LEDR é a conta decrescente (descendente) referente ao saldo/crédito 
		
		-- Quando SEL_DISP = '00', a saída do mux4x1 (para os registradores) é "00000000000000000000"
		-- Quando SEL_DISP = '01', a saída é a concatenação de IN_PASS
		-- Quando SEL_DISP = '10', a saída são nomes definidos na Agenda_ROM
		-- Quando SEL_DISP = '11', a saída é a conta ascendente referente ao tempo de ligação

		DECOD: Seletores_DECOD port map (SW(9 downto 0), IN_PASS);
		MUX2X1: Seletores_mux2x1 port map (TENTATIVAS, CONTA_DES, SEL_LED, LED_OUT);
		MUX4X1: Seletores_mux4x1 port map (IN_PASS, AGENDA, CONTA_ASC, SEL_DISP, REG);
		
end bhv;