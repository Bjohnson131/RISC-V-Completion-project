library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;

entity flushing_unit is
	port (
		clear, clock : in std_logic;
		flushing_control : in std_logic;
		flushing_output : out std_logic
	);
end flushing_unit;

architecture behavioural of flushing_unit is

	signal internal_flushing_output : std_logic := '0';

begin

	process (clear, clock, flushing_control, internal_flushing_output) is
	begin
	if(rising_edge(clock)) then
		if (clear = '1') then
			internal_flushing_output <= '0';
		elsif ( flushing_control = '1') then
			internal_flushing_output <= '1';
		else
			internal_flushing_output <= '0';
		end if;
	end if;
	end process;

	flushing_output <= internal_flushing_output;

end architecture behavioural;