library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
library riscv;
use riscv.all;

entity program_counter is
	port (
		clear, clock : in std_logic;
		mux_sel : in std_logic;
		address_in_0 : in std_logic_vector(31 downto 0);
		address_in_1 : in std_logic_vector(31 downto 0);																																 
		address_out : out std_logic_vector(31 downto 0);  --THIS IS THE REAL PC OUTPUT, USE THIS IF YOUR MEMORY DOES NOT HAVE A REGISTER IN ITS INPUT.
		HALT_FETCH : in std_logic := '0'
	);														 
end program_counter;

architecture behavioral of program_counter is
	signal internal_address : std_logic_vector (31 downto 0) := X"00000000";
	signal halt_load : std_logic;
begin
	internal_mux : entity riscv.mux_2_1 port map(mux_sel, address_in_0, address_in_1, internal_address);
	internal_register : entity riscv.reg32b port map(internal_address, halt_load, clock, clear, address_out);

	next_address <= internal_address;
	halt_load <= not HALT_FETCH;									   
end behavioral;