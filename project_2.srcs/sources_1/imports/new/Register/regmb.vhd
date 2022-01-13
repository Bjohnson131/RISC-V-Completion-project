library ieee;
use ieee.std_logic_1164.all;
library riscv;
use riscv.types;

entity regmb is
	port (
		reg_in : in types.MEMORY_MUX_SEL;
		load, clock, clear : in std_logic;
		reg_out : out types.MEMORY_MUX_SEL
	);
end regmb;

architecture description of regmb is
	signal internal_value,internal_value_next : types.MEMORY_MUX_SEL := types.NOP;
    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of description : architecture is "true";
begin
internal_value_next <= 
types.NOP when (clear = '1') else
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