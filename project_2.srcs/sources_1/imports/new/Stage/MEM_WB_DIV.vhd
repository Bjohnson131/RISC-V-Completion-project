library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;
library riscv;
use riscv.all;

entity MEM_WB_DIV is
	port (
		--INPUTS

		clock, clear : in std_logic;

		--WB control signals
		mux0_sel_in : in std_logic_vector(1 downto 0);
		reg_file_write_in : in std_logic;
		reg_file_write_address_in : in std_logic_vector(4 downto 0);
		CSR_file_write_address_in : in std_logic_vector(11 downto 0);
		CSR_file_write_in : in std_logic;

		--Data
		ALU_output_in : in std_logic_vector(31 downto 0);
		datamem_output_in : in std_logic_vector(31 downto 0);
		instruction_address_in : in std_logic_vector(31 downto 0);
		CSR_file_write_data_in : in std_logic_vector(31 downto 0);

		--OUTPUTS

		--WB control signals
		mux0_sel_out : out std_logic_vector(1 downto 0);
		reg_file_write_out : out std_logic;
		reg_file_write_address_out : out std_logic_vector(4 downto 0);
		CSR_file_write_address_out : out std_logic_vector(11 downto 0);
		CSR_file_write_out : out std_logic;

		--Data
		ALU_output_out : out std_logic_vector(31 downto 0);
		datamem_output_out : out std_logic_vector(31 downto 0);
		instruction_address_out : out std_logic_vector(31 downto 0);
		CSR_file_write_data_out : out std_logic_vector(31 downto 0)

	);
end MEM_WB_DIV;

architecture behavioral of MEM_WB_DIV is
constant ones : std_logic := '1';
attribute DONT_TOUCH : string;
attribute DONT_TOUCH of behavioral : architecture is "true";

	--INTERNAL SIGNALS

	--WB control signals
	signal mux0_sel_input_signal : std_logic_vector(1 downto 0);
	signal reg_file_write_input_signal : std_logic;
	signal reg_file_write_address_input_signal : std_logic_vector(4 downto 0);
	signal CSR_file_write_address_input_signal : std_logic_vector(11 downto 0);
	signal CSR_file_write_input_signal : std_logic;
	signal CSR_file_write_data_input_signal : std_logic_vector(31 downto 0);

	--Data
	signal ALU_output_input_signal : std_logic_vector(31 downto 0);
	signal datamem_output_input_signal : std_logic_vector(31 downto 0);
	signal instruction_address_input_signal : std_logic_vector(31 downto 0);
	--WB control signals
	signal mux0_sel_output_signal : std_logic_vector(1 downto 0);
	signal reg_file_write_output_signal : std_logic;
	signal reg_file_write_address_output_signal : std_logic_vector(4 downto 0);
	signal CSR_file_write_address_output_signal : std_logic_vector(11 downto 0);
	signal CSR_file_write_output_signal : std_logic;
	signal CSR_file_write_data_output_signal : std_logic_vector(31 downto 0);

	--Data
	signal ALU_output_output_signal : std_logic_vector(31 downto 0);
	signal datamem_output_output_signal : std_logic_vector(31 downto 0);
	signal instruction_address_output_signal : std_logic_vector(31 downto 0);
    
    attribute extract_reset : string;
    attribute extract_enable : string;
    attribute extract_reset of CSR_file_write_address_input_signal: signal is "no";
    attribute extract_reset of CSR_file_write_address_output_signal: signal is "no";
    attribute extract_enable of CSR_file_write_address_input_signal: signal is "no";
    attribute extract_enable of CSR_file_write_address_output_signal: signal is "no";
    attribute fpga_dont_touch : string;
    attribute fpga_dont_touch of CSR_file_write_address_reg: label is "true";
begin

	--INTERNAL REGISTERS

	--WB control signals
	mux0_sel_reg : entity riscv.reg2b port map(reg_in=>mux0_sel_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>mux0_sel_output_signal);
	reg_file_write_reg : entity riscv.reg1b port map(reg_in=>reg_file_write_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>reg_file_write_output_signal);
	csr_file_write_reg : entity riscv.reg1b port map(reg_in=>CSR_file_write_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>CSR_file_write_output_signal);
	reg_file_write_address_reg : entity riscv.reg5b port map(reg_in=>reg_file_write_address_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>reg_file_write_address_output_signal);
	CSR_file_write_address_reg : entity riscv.reg12b port map(reg_in=>CSR_file_write_address_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>CSR_file_write_address_output_signal);

	--Data
	ALU_output_reg : entity riscv.reg32b port map(reg_in=>ALU_output_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>ALU_output_output_signal);
	datamem_output_reg : entity riscv.reg32b port map(reg_in=>datamem_output_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>datamem_output_output_signal);
	instruction_address_reg : entity riscv.reg32b port map(reg_in=>instruction_address_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>instruction_address_output_signal);
	CSR_file_write_data_reg : entity riscv.reg32b port map(reg_in=>CSR_file_write_data_input_signal, load=>ones, clock=>clock, clear=>clear, reg_out=>CSR_file_write_data_output_signal);

	--WIRING INPUT PORTS

	--WB control signals
	mux0_sel_input_signal <= mux0_sel_in;
	reg_file_write_input_signal <= reg_file_write_in;
	reg_file_write_address_input_signal <= reg_file_write_address_in;
	CSR_file_write_input_signal <= CSR_file_write_in;
	CSR_file_write_address_input_signal <= CSR_file_write_address_in;
	CSR_file_write_data_input_signal <= CSR_file_write_data_in;
	
	--Data
	ALU_output_input_signal <= ALU_output_in;
	datamem_output_input_signal <= datamem_output_in;
	instruction_address_input_signal <= instruction_address_in;

	--WIRING OUTPUT PORTS

	--WB control signals
	mux0_sel_out <= mux0_sel_output_signal;
	reg_file_write_out <= reg_file_write_output_signal;
	reg_file_write_address_out <= reg_file_write_address_output_signal;
	CSR_file_write_out <= CSR_file_write_output_signal ;
	CSR_file_write_address_out <= CSR_file_write_address_output_signal;
    CSR_file_write_data_out <= CSR_file_write_data_output_signal;

	--Data
	ALU_output_out <= ALU_output_output_signal;
	datamem_output_out <= datamem_output_output_signal;
	instruction_address_out <= instruction_address_output_signal;

end behavioral;