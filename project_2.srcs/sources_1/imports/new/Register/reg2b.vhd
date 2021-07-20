library ieee;
use ieee.std_logic_1164.all;

entity reg2b is
	port (
		reg_in : in std_logic_vector(1 downto 0);
		load, clock, clear : in std_logic;
		reg_out : out std_logic_vector(1 downto 0)
	);
end reg2b;

architecture description of reg2b is
	signal internal_value,internal_value_next : std_logic_vector(1 downto 0) := "00";
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of description : architecture is "yes";
begin
internal_value_next <= 
"00" when (clear = '1') else
reg_in when (load = '1') else
internal_value;

reg_out <= internal_value;

	process (clock)
	begin
		if (rising_edge(clock)) then
		  internal_value <= internal_value_next;
		end if;
	end process;
	
end description;