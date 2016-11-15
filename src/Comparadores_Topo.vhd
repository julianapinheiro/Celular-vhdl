library ieee;
use ieee.std_logic_1164.all;

entity Comparadores_Topo is
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
end Comparadores_Topo;

architecture ARCH of Comparadores_Topo is

component Comparadores_comparador20bit
	port (	
			S0: in std_logic_vector(4 downto 0);
			S1: in std_logic_vector(4 downto 0);
			S2: in std_logic_vector(4 downto 0);
			S3: in std_logic_vector(4 downto 0);
			SENHA: in std_logic_vector(19 downto 0);
			SAIDA: out std_logic	
	);
end component;

component Comparadores_comparador10bit
	port (	
			CONTA: in std_logic_vector(9 downto 0);
			SAIDA: out std_logic
	);
end component;

component Comparadores_AND
	port (	
			x: in std_logic;
			y: in std_logic;
			z: out std_logic
	);
end component;

			signal F: std_logic;

begin
		-- A senha de 20 bits estabelecida é inserida no comparador de 20 bits pelo port map
		-- PASSWORD: "0737"(10) = "00000001110001100111"(2)
		
		COMP20: Comparadores_comparador20bit port map (SEQ_0, SEQ_1, SEQ_2, SEQ_3, "00000001110001100111", F);
		COMP_AND: Comparadores_AND port map (TESTE_PASS, F, PASS_CERTO);
		COMP10: Comparadores_comparador10bit port map (CONTA_DES, SALDO);
		
end ARCH;