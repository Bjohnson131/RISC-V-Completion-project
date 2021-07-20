library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;
library riscv;
use riscv.reg32b;

entity IF_ID_DIV is
	port (
		--INPUTS

		clock, clear : in std_logic;

		--Data
		instruction_address_in : in std_logic_vector(31 downto 0);
		instruction_data_in : in std_logic_vector(31 downto 0);

		--OUTPUTS

		--Data
		instruction_address_out : out std_logic_vector(31 downto 0);
		instruction_data_out : out std_logic_vector(31 downto 0)

	);
end IF_ID_DIV;

architecture behavioral of IF_ID_DIV is
constant ones : std_logic := '1';
attribute keep_hierarchy : string;
attribute keep_hierarchy of behavioral : architecture is "yes";

	--INTERNAL SIGNALS

	--Data
	signal instruction_address_input_signal : std_logic_vector(31 downto 0);
	signal instruction_data_input_signal : std_logic_vector(31 downto 0);

	--Data
	signal instruction_address_output_signal : std_logic_vector(31 downto 0);
	signal instruction_data_output_signal : std_logic_vector(31 downto 0);

begin

	--INTERNAL REGISTERS

	--Data
	instruction_address_reg : entity riscv.reg32b port map(reg_in=>instruction_address_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>instruction_address_output_signal);
	instruction_data_reg : entity riscv.reg32b port map(reg_in=>instruction_data_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>instruction_data_output_signal);

	--WIRING OUTPUT PORTS

	--Data
	instruction_address_out <= instruction_address_output_signal;
	instruction_data_out <= instruction_data_output_signal;

	instruction_address_input_signal <= instruction_address_in;
	instruction_data_input_signal <= instruction_data_in;

end behavioral;