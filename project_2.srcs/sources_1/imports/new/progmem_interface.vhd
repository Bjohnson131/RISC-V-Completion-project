library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
library riscv;
use riscv.all;

entity progmem_interface is
	port (
		clock : in std_logic;
		byte_address : in std_logic_vector(31 downto 0);
		output_data : out std_logic_vector(31 downto 0)
	);
end entity progmem_interface;

architecture behavioural of progmem_interface is

	signal memory_address : std_logic_vector(31 downto 0) := X"00000000";

begin		 
	-- TODO: this currently outputs the address as its data. fix this.
	address_acquirement : process (byte_address)
	begin
		memory_address <= std_logic_vector(shift_right(unsigned(byte_address), 2)); --Dividing by 4 since 32 = 4*8
	end process;

    process(clock)
    begin
    if (rising_edge(clock)) then
        output_data <= byte_address;
    end if;
    end process;
	--progmem_0 : entity riscv.progmem port map(memory_address(15 downto 0), clock, output_data);

end architecture behavioural;