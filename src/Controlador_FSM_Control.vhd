library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Controlador_FSM_control is
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
end Controlador_FSM_control;

architecture ARCH of Controlador_FSM_control is

	type STATES is (E0, E1, E2, E3, E4, E5, E6, E7, E8);
	signal EA, PE : STATES;
	signal TENTATIVAS_ATUAL, TENTATIVAS_PROXIMO: std_logic_vector(1 downto 0) := "00";
	
	-- São definidos os 9 estados E0, E1, E2, E3, E4, E5, E6, E7, E8 para a FSM
	-- Respectivamente são: DESL, Intro_PASS, REG3, REG2, REG1, REG0, TESTE, ON, LIGA
	
	-- São definidos dois sinais (TENTATIVAS_ATUAL e TENTATIVAS_PROXIMO) para possibilitar o incremento da saída TENTATIVAS
	
	-- As entradas RST e ENTER, referente aos botões KEY(0) e KEY(3) são negadas, isto é, quando o botão é pressionado, a entrada tem valor de '0'
	
	begin
	
		TENTATIVAS <= TENTATIVAS_ATUAL;
		
		process (CLOCK_50, RST)
			begin
				if RST = '0' then
					EA <= E0;
				elsif rising_edge(CLOCK_50) then
					EA <= PE;
					TENTATIVAS_ATUAL <= TENTATIVAS_PROXIMO;
				end if;
		end process;
		
		process (EA, ENTER, TENTATIVAS_ATUAL, TENTATIVAS_PROXIMO, PASS_CERTO, SALDO)
			begin
			
				-- Valores definidos para evitar problemas de latch/unsafe behavior
				
				C3 <= '0';
				C2 <= '0';
				C1 <= '0';
				C0 <= '0';
				SEL_LED <= '0';
				TESTE_PASS <= '0';
				TENTATIVAS_PROXIMO <= TENTATIVAS_ATUAL;
				
				case EA is
				
				when E0 =>                    -- DESL
					ESTADOS <= "00000";
					SEL_DISP <= "00";
					C0 <= '1';
					C1 <= '1';
					C2 <= '1';
					C3 <= '1';
					SEL_LED <= '0';
					TENTATIVAS_PROXIMO <= "00";
					if (ENTER = '1') then
						PE <= E0;
					else
						PE <= E1;
					end if;
					
				when E1 =>                    -- Intro_PASS
					ESTADOS <= "00001";
					TESTE_PASS <= '0';
					SEL_DISP <= "01";
					if (ENTER = '1') then
						PE <= E1;
					else
						PE <= E2;
					end if;
					
				-- Nos estados seguintes (E2..E5), a senha de 4 algarismos é inserida por meio dos switches SW(9..0)	
					
				when E2 =>                    -- REG3
					ESTADOS <= "00010";
					SEL_DISP <= "01";
					C3 <= '1';
					C2 <= '0';
					C1 <= '0';
					C0 <= '0';
					if (ENTER = '1') then
						PE <= E2;
					else
						PE <= E3;
					end if;
					
				when E3 =>                    -- REG2
					ESTADOS <= "00011";
					SEL_DISP <= "01";
					C3 <= '0';
					C2 <= '1';
					C1 <= '0';
					C0 <= '0';
					if (ENTER = '1') then
						PE <= E3;
					else
						PE <= E4;
					end if;
					
				when E4 =>                    -- REG1
					ESTADOS <= "00100";
					SEL_DISP <= "01";
					C3 <= '0';
					C2 <= '0';
					C1 <= '1';
					C0 <= '0';
					if (ENTER = '1') then
						PE <= E4;
					else
						PE <= E5;
					end if;
					
				when E5 =>                    -- REG0
					ESTADOS <= "00101";
					SEL_DISP <= "01";
					C3 <= '0';
					C2 <= '0';
					C1 <= '0';
					C0 <= '1';
					if (ENTER = '1') then
						PE <= E5;
					else
						PE <= E6;
					end if;
					
				when E6 =>                    -- TESTE : testa se a senha inserida é correta
					ESTADOS <= "00110";
					SEL_DISP <= "01";
					TENTATIVAS_PROXIMO <= TENTATIVAS_ATUAL + 1;
					TESTE_PASS <= '1';
					C0 <= '0';
					if (TENTATIVAS_ATUAL = "11" and PASS_CERTO = '0') then		-- Senha incorreta e se esgotaram as tentativas, próximo estado é E0
						PE <= E0;
					elsif (TENTATIVAS_ATUAL < "11" and PASS_CERTO = '0') then	-- Senha incorreta mas é permitido mais tentativas, próximo estado é E1
						PE <= E1;
					else
						PE <= E7;
					end if;
					
				when E7 =>                    -- ON : possível escolher um nome da agenda pelos SW(9..0)
					ESTADOS <= "00111";
					SEL_DISP <= "10";
					C0 <= '1';
					C1 <= '1';
					C2 <= '1';
					C3 <= '1';
					if (ENTER = '1') then		
						PE <= E7;
					else								-- Ao pressionar o botão ENTER, inicia-se uma ligação no próximo estado, E8
						PE <= E8;
					end if;
				
				when E8 =>                    -- LIGA
					ESTADOS <= "01000";
					SEL_DISP <= "11";
					SEL_LED <= '1';
					C0 <= '1';
					C1 <= '1';
					C2 <= '1';
					C3 <= '1';
					if (SALDO = '0') then							-- Quando o saldo acaba (SALDO = 0), próximo estado é E0 (Desl)
						PE <= E0;
					elsif (SALDO = '1' and ENTER = '0') then  -- Quando o saldo não acabou, mas o botão ENTER é pressionado, próximo estado é E7 (ON)
						PE <= E7;
					else
						PE <= E8;
					end if;

				end case;
		end process;
end ARCH;