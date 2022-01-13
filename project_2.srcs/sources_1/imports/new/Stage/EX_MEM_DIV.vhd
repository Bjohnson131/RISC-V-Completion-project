library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.all;
library riscv;
use riscv.all;


entity EX_MEM_DIV is
	port (
		--INPUTS--
		clock, clear : in std_logic;

		--MEM control signals
		data_format_in : in std_logic_vector(2 downto 0);
		datamem_write_in : in std_logic;
		jump_flag_in : in std_logic;

		--WB control signals
		mux0_sel_in : in std_logic_vector(1 downto 0);
		reg_file_write_in : in std_logic;
		reg_file_write_address_in : in std_logic_vector(4 downto 0);
	    CSR_file_write_address_in : in std_logic_vector(11 downto 0);
	    CSR_file_write_in : in std_logic;

		--Data
		ALU_output_in : in std_logic_vector(31 downto 0);
		register_file_output_1_in : in std_logic_vector(31 downto 0);
		ALU_branch_response_in : in std_logic;
		instruction_address_in : in std_logic_vector(31 downto 0);

		--OUTPUTS--

		--MEM control signals
		data_format_out : out std_logic_vector(2 downto 0);
		datamem_write_out : out std_logic;
		jump_flag_out : out std_logic;

		--WB control signals
		mux0_sel_out : out std_logic_vector(1 downto 0);
		reg_file_write_out : out std_logic;
		reg_file_write_address_out : out std_logic_vector(4 downto 0);
	    CSR_file_write_address_out : out std_logic_vector(11 downto 0);
	    CSR_file_write_out : out std_logic;

		--Data
		ALU_output_out : out std_logic_vector(31 downto 0);
		register_file_output_1_out : out std_logic_vector(31 downto 0);
		ALU_branch_response_out : out std_logic;
		instruction_address_out : out std_logic_vector(31 downto 0)

	);

end EX_MEM_DIV;
architecture behavioral of EX_MEM_DIV is
	constant ones : std_logic := '1';
	attribute dont_touch : string;
	attribute dont_touch of behavioral : architecture is "true";
begin
	--INTERNAL REGISTERS

	--MEM control signals
	data_format_reg : entity riscv.reg3b port map(data_format_in, ones, clock, clear, data_format_out);
	datamem_write_reg : entity riscv.reg1b port map(datamem_write_in, ones, clock, clear, datamem_write_out);
	jump_flag_reg : entity riscv.reg1b port map(jump_flag_in, ones, clock, clear, jump_flag_out);

	--WB control signals
	mux0_sel_reg : entity riscv.reg2b port map(mux0_sel_in, ones, clock, clear, mux0_sel_out);
	reg_file_write_reg : entity riscv.reg1b port map(reg_file_write_in, ones, clock, clear, reg_file_write_out);
	reg_file_write_address_reg : entity riscv.reg5b port map(reg_file_write_address_in, ones, clock, clear, reg_file_write_address_out);
	csr_file_write_reg : entity riscv.reg1b port map(CSR_file_write_in, ones, clock, clear, CSR_file_write_out);
	csr_file_write_address_reg : entity riscv.reg12b port map(CSR_file_write_address_in, ones, clock, clear, CSR_file_write_address_out);
	
	--Data
	ALU_output_reg : entity riscv.reg32b port map(
	reg_in => ALU_output_in, 
	load  => ones, 
	clock => clock, 
	clear => clear,
	reg_out => ALU_output_out);
	
	register_file_output_1_reg : entity riscv.reg32b port map(register_file_output_1_in, ones, clock, clear, register_file_output_1_out);
	ALU_branch_respose_reg : entity riscv.reg1b port map(ALU_branch_response_in, ones, clock, clear, ALU_branch_response_out);
	instruction_address_reg : entity riscv.reg32b port map(instruction_address_in, ones, clock, clear, instruction_address_out);
end behavioral;