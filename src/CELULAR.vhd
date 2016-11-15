library ieee;
use ieee.std_logic_1164.all;

entity CELULAR is
port (
		KEY: in std_logic_vector (3 downto 0);
		SW: in std_logic_vector (9 downto 0);
		CLOCK_50: in std_logic;
		
		LEDR: out std_logic_vector (9 downto 0);	-- LEDOUT
		HEX5: out std_logic_vector (6 downto 0);	--"0000110"
		HEX4: out std_logic_vector (6 downto 0);	--ESTADOS
		HEX3: out std_logic_vector (6 downto 0);	--SEQ_3
		HEX2: out std_logic_vector (6 downto 0);	--SEQ_2
		HEX1: out std_logic_vector (6 downto 0);	--SEQ_1
		HEX0: out std_logic_vector (6 downto 0)	--SEQ_0
);
end CELULAR;

architecture ARCH of CELULAR is

---------------------------------------------------------------

component Registradores_Topo
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
end component;

---------------------------------------------------------------

component Comparadores_Topo
port (	
		SEQ_0: in std_logic_vector (4 downto 0);
		SEQ_1: in std_logic_vector (4 downto 0);
		SEQ_2: in std_logic_vector (4 downto 0);
		SEQ_3: in std_logic_vector (4 downto 0);
		TESTE_PASS: in std_logic;
		CONTA_DES: in std_logic_vector (9 downto 0);   
		
		PASS_CERTO: out std_logic;
		SALDO: out std_logic
);
end component;

---------------------------------------------------------------

component Contadores_Topo 
port (
		BTN0: in std_logic;
		SEL_LED: in std_logic;
		SEL_DISP: in std_logic_vector(1 downto 0);
		CLOCK: in std_logic;
		
		--CLK1: out std_logic;
		CONTA_ASC: out std_logic_vector(19 downto 0);
		CONTA_DES: out std_logic_vector(9 downto 0)
);
end component;

---------------------------------------------------------------

component Controlador_Topo
port (	
		PASS_CERTO: in std_logic;
		BTN3: in std_logic;
		BTN0: in std_logic;
		SALDO: in std_logic;
		CLOCK: in std_logic;
		
		C0: out std_logic;
		C1: out std_logic;
		C2: out std_logic;
		C3: out std_logic;
		SEL_LED: out std_logic;
		SEL_DISP: out std_logic_vector (1 downto 0);
		TESTE_PASS: out std_logic;
		TENTATIVAS: out std_logic_vector (1 downto 0);
		ESTADOS: out std_logic_vector (4 downto 0)
);
end component;

---------------------------------------------------------------

component Agenda_Topo is
port (	
		SW: in std_logic_vector (3 downto 0);
		AGENDA: out std_logic_vector(19 downto 0)
);
end component;

---------------------------------------------------------------

component Seletores_Topo is
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
end component;

---------------------------------------------------------------

component ButtonSync is
port(
		-- Input ports
		key0	: in  std_logic;
		key1	: in  std_logic;
		key2	: in  std_logic;
		key3	: in  std_logic;	
		clk : in std_logic;
		-- Output ports
		btn0	: out std_logic;
		btn1	: out std_logic;
		btn2	: out std_logic;
		btn3	: out std_logic
	);
end component;

---------------------------------------------------------------

component decod7seg is
port (
		C: in std_logic_vector(4 downto 0);
		F: out std_logic_vector(6 downto 0)
);
end component;

---------------------------------------------------------------

		--signal CLK1: std_logic;
		
		signal SEQ0, SEQ1, SEQ2, SEQ3: std_logic_vector (4 downto 0);
		signal C0, C1, C2, C3: std_logic;
		signal BTN0, BTN1, BTN2, BTN3: std_logic;
		
		signal REG, CONTA_ASC, AGENDA: std_logic_vector (19 downto 0);
		signal CONTA_DES, LED_OUT: std_logic_vector (9 downto 0);
		signal ESTADOS: std_logic_vector (4 downto 0);
		signal TENTATIVAS, SEL_DISP: std_logic_vector (1 downto 0);
		signal SEL_LED, TESTE_PASS, PASS_CERTO, SALDO: std_logic;

begin

		BUTTONS: ButtonSync port map (KEY(0), KEY(1), KEY(2), KEY(3), CLOCK_50, BTN0, BTN1, BTN2, BTN3);
		
		REGISTRADORES: Registradores_Topo port map (BTN0, C0, C1, C2, C3, REG, CLOCK_50, SEQ0, SEQ1, SEQ2, SEQ3);
		
		COMPARADORES: Comparadores_Topo port map (SEQ0, SEQ1, SEQ2, SEQ3, TESTE_PASS, CONTA_DES, PASS_CERTO, SALDO);
		
		CONTADORES: Contadores_Topo port map (BTN0, SEL_LED, SEL_DISP, CLOCK_50, CONTA_ASC, CONTA_DES);
		
		CONTROLADOR: Controlador_Topo port map (PASS_CERTO, BTN3, BTN0, SALDO, CLOCK_50, C0, C1, C2, C3, SEL_LED, SEL_DISP, TESTE_PASS, TENTATIVAS, ESTADOS);
		
		AGENDA0: Agenda_Topo port map (SW(3 downto 0), AGENDA);
		
		SELETORES: Seletores_Topo port map (SW(9 downto 0), AGENDA, CONTA_ASC, CONTA_DES, SEL_DISP, SEL_LED, TENTATIVAS, LED_OUT, REG);
		
		DECOD5: decod7seg port map ("01110", HEX5);
		
		DECOD4: decod7seg port map (ESTADOS, HEX4);
		
		DECOD3: decod7seg port map (SEQ3, HEX3);
		
		DECOD2: decod7seg port map (SEQ2, HEX2);
		
		DECOD1: decod7seg port map (SEQ1, HEX1);
		
		DECOD0: decod7seg port map (SEQ0, HEX0);
		
		LEDR <= LED_OUT;
		
end ARCH;