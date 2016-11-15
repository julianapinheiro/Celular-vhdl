library ieee; 
use ieee.std_logic_1164.all;

entity Controlador_Topo is
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
end Controlador_Topo;

architecture ARCH of Controlador_Topo is

component Controlador_FSM_Control
port (	
		CLOCK_50: in std_logic;
		ENTER: in std_logic;
		RST: in std_logic;
		
		PASS_CERTO: in std_logic;
		SALDO: in std_logic;
		
		C0: out std_logic;
		C1: out std_logic;
		C2: out std_logic;
		C3: out std_logic;
		
		ESTADOS: out std_logic_vector(4 downto 0);
		TENTATIVAS: out std_logic_vector(1 downto 0);
		TESTE_PASS: out std_logic;
		SEL_DISP: out std_logic_vector(1 downto 0);
		SEL_LED: out std_logic
);
end component;

begin

		FSM_CONTROL: Controlador_FSM_Control port map (CLOCK, BTN3, BTN0, PASS_CERTO, SALDO, C0, C1, C2, C3, ESTADOS, TENTATIVAS, TESTE_PASS, SEL_DISP, SEL_LED);

end ARCH;