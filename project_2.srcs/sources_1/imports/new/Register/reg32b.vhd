library ieee;
use ieee.std_logic_1164.all;

entity reg32b is
	port (
		reg_in : in std_logic_vector(31 downto 0);
		load, clock, clear : in std_logic;
		reg_out : out std_logic_vector(31 downto 0)
	);
end reg32b;

architecture description of reg32b is
	signal internal_value : std_logic_vector(31 downto 0) := X"00000000";
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of description : architecture is "yes";
begin		  		  
	-- Zeroes when clear is 1,
	-- Reg in when load signal is high
	-- otherwise, maintain value.
	internal_value <= 	 
X"00000000" when ( clear = '1') else
reg_in      when ( load = '1' ) else
internal_value;

process (clock)
	begin
		if rising_edge(clock) then
		  reg_out <= internal_value;		
		end if;
	end process;
end description;