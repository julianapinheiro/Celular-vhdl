library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Contadores_FSM_clock is 
port (
		CLOCK: in std_logic;
		RESET: std_logic;
		CLK1: out std_logic;
		CLK2: out std_logic
);
end Contadores_FSM_clock;

architecture bhv of Contadores_FSM_clock is
   signal contador1: integer;  -- contador para o clock de 1Hz
	signal contador2: integer;  -- contador para o clock de 9Hz
	
	-- Nesse componente, são criados dois clocks para serem utilizados no bloco Contadores, de 1Hz e de 9Hz
	-- Como o clock disponível no kit é de 50MHz, usam-se dois contadores, um até "49.999.999" e outro até "5.555.555", como visto em aula
	
	-- Não foram atribuidos estados, os contadores são incrementados diretamente no process com a subida de clock, assim como ambos os clocks criados
	
begin
	process(CLOCK, RESET)
	begin
		if RESET= '0' then
			contador1 <= 0;
		elsif rising_edge(CLOCK) then
			contador1 <= contador1 + 1;
			if (contador1 = 49999999) then
				contador1 <= 0;
				CLK1 <= '1';
			else
				CLK1 <= '0';
			end if;
		end if;
	end process;

	process(CLOCK, RESET)
	begin
		if RESET= '0' then
			contador2 <= 0;
		elsif rising_edge(CLOCK) then
			contador2 <= contador2 + 1;
			if (contador2 = 5555555) then
				contador2 <= 0;
				CLK2 <= '1';
			else
				CLK2 <= '0';
			end if;
		end if;
	end process;
end bhv;