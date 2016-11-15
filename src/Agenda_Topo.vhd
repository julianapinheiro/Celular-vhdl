library ieee;
use ieee.std_logic_1164.all;

entity Agenda_Topo is
port (	
		SW: in std_logic_vector (3 downto 0);
		AGENDA: out std_logic_vector(19 downto 0)
);
end Agenda_Topo;

architecture ARCH of Agenda_Topo is

component Agenda_ROM 
port ( 	
		address : in std_logic_vector(3 downto 0);
		data : out std_logic_vector(19 downto 0) 
);
end component;

begin

		ROM: Agenda_ROM port map (SW, AGENDA);

end ARCH;
