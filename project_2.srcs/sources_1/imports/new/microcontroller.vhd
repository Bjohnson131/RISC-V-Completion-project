library ieee;
use ieee.std_logic_1164.all;
use work.all;
library riscv;
use riscv.all;	 

entity microcontroller is
	port (
		clock : in std_logic;
		reset : in std_logic;
		--instruction_in : in std_logic_vector(31 downto 0);
		debug_pc_output : out std_logic_vector(31 downto 0);
		debug_regfile_x31_output : out std_logic_vector(31 downto 0);
		debug_regfile_x1_output : out std_logic_vector(31 downto 0);
		debug_regfile_x2_output : out std_logic_vector(31 downto 0);
		debug_ALU_output : out std_logic_vector(31 downto 0);
		debug_regfile_write : out std_logic;
		debug_ALU_input_0 : out std_logic_vector(31 downto 0);
		debug_ALU_input_1 : out std_logic_vector(31 downto 0);
		debug_reg_file_read_address_0 : out std_logic_vector(4 downto 0);
		debug_reg_file_read_address_1 : out std_logic_vector(4 downto 0);
		debug_mux0_sel : out std_logic_vector(1 downto 0);
		debug_immediate : out std_logic_vector(31 downto 0);
		debug_ALU_operation : out std_logic_vector(3 downto 0);
		debug_forward_mux_0 : out std_logic_vector(2 downto 0);
		debug_forward_mux_1 : out std_logic_vector(2 downto 0);
		debug_reg_file_read_address_0_ID_EXE : out std_logic_vector(4 downto 0);
		debug_reg_file_write_address_EX_MEM : out std_logic_vector(4 downto 0);
		debug_mux0_sel_MEM_WB : out std_logic_vector(1 downto 0);
		debug_reg_file_write_MEM_WB : out std_logic;
		debug_reg_file_write_address_MEM_WB : out std_logic_vector(4 downto 0);
		debug_ALU_output_MEM_WB : out std_logic_vector(31 downto 0);
		debug_ALU_output_EX_MEM : out std_logic_vector(31 downto 0);
		debug_register_file_output_0 : out std_logic_vector(31 downto 0);
		debug_register_file_output_1 : out std_logic_vector(31 downto 0);
		debug_register_file_output_0_ID_EX : out std_logic_vector(31 downto 0);
		debug_register_file_output_1_ID_EX : out std_logic_vector(31 downto 0);
		debug_instruction : out std_logic_vector(31 downto 0)
	);
end entity microcontroller;

architecture structural of microcontroller is
	signal IF_ID_flush : std_logic;
	signal reg_file_read_address_0 : std_logic_vector(4 downto 0);
	signal reg_file_read_address_1 : std_logic_vector(4 downto 0);
	signal csr_file_read_address_0 : std_logic_vector(11 downto 0);
	signal CSR_file_write : std_logic;
	signal reg_file_write : std_logic;
	signal reg_file_write_address : std_logic_vector(4 downto 0);
	signal immediate : std_logic_vector(31 downto 0);
	signal ALU_operation : std_logic_vector(3 downto 0);
	signal ALU_branch : std_logic;
	signal ALU_branch_control : std_logic_vector(2 downto 0);
	signal JTU_mux_sel : std_logic;
	signal data_format : std_logic_vector(2 downto 0);
	signal datamem_write : std_logic;
	signal jump_flag : std_logic;
	signal mux0_sel : std_logic_vector(1 downto 0);
	signal mux1_sel : std_logic_vector(1 downto 0);
	signal instruction : std_logic_vector(31 downto 0);

begin

    --instruction <= instruction_in;

	controller_0 : entity riscv.controller port map(
	clock=>clock, 
	reset=>reset, 
	instruction=>instruction, 
	reg_file_read_address_0=>reg_file_read_address_0, 
	reg_file_read_address_1=>reg_file_read_address_1, 
	csr_file_read_address_0=>csr_file_read_address_0,
	CSR_file_write=>CSR_file_write,
	reg_file_write=>reg_file_write, 
	reg_file_write_address=>reg_file_write_address, 
	immediate=>immediate, 
	ALU_operation=>ALU_operation, 
	ALU_branch=>ALU_branch, 
	ALU_branch_control=>ALU_branch_control, 
	JTU_mux_sel=>JTU_mux_sel, 
	data_format=>data_format, 
	datamem_write=>datamem_write, 
	jump_flag=>jump_flag, 
	mux0_sel=>mux0_sel, 
	mux1_sel=>mux1_sel);
	
	datapath_0 : entity riscv.datapath port map(
	clock=>clock, 
	reset=>reset, 
	reg_file_read_address_0=>reg_file_read_address_0, 
	reg_file_read_address_1=>reg_file_read_address_1, 
	CSR_File_read_addr=>csr_file_read_address_0,
	CSR_file_write=>CSR_file_write,
	reg_file_write=>reg_file_write, 
	reg_file_write_address=>reg_file_write_address, 
	immediate=>immediate, 
	ALU_operation=>ALU_operation, 
	ALU_branch=>ALU_branch, 
	ALU_branch_control=>ALU_branch_control, 
	JTU_mux_sel=>JTU_mux_sel, 
	data_format=>data_format, 
	datamem_write=>datamem_write, 
	jump_flag=>jump_flag,
	mux0_sel=>mux0_sel, 
	mux1_sel=>mux1_sel, 
	instruction=>instruction, 
	debug_instruction_address=>debug_pc_output, 
	debug_regfile_x31_output=>debug_regfile_x31_output, 
	debug_regfile_x1_output=>debug_regfile_x1_output, 
	debug_regfile_x2_output=>debug_regfile_x2_output, 
	debug_ALU_output=>debug_ALU_output, 
	debug_ALU_input_0=>debug_ALU_input_0, 
	debug_ALU_input_1=>debug_ALU_input_1, 
	debug_forward_mux_0=>debug_forward_mux_0, 
	debug_forward_mux_1=>debug_forward_mux_1, 
	debug_reg_file_read_address_0_ID_EXE=>debug_reg_file_read_address_0_ID_EXE, 
	debug_reg_file_write_address_EX_MEM=>debug_reg_file_write_address_EX_MEM, 
	debug_mux0_sel_MEM_WB=>debug_mux0_sel_MEM_WB, 
	debug_reg_file_write_MEM_WB=>debug_reg_file_write_MEM_WB, 
	debug_reg_file_write_address_MEM_WB=>debug_reg_file_write_address_MEM_WB, 
	debug_ALU_output_MEM_WB=>debug_ALU_output_MEM_WB, 
	debug_ALU_output_EX_MEM=>debug_ALU_output_EX_MEM, 
	debug_register_file_output_0=>debug_register_file_output_0, 
	debug_register_file_output_1=>debug_register_file_output_1, 
	debug_register_file_output_0_ID_EX=>debug_register_file_output_0_ID_EX, 
	debug_register_file_output_1_ID_EX=>debug_register_file_output_1_ID_EX, 
	debug_instruction=>debug_instruction);
	   
	debug_regfile_write <= reg_file_write;
	debug_reg_file_read_address_0 <= reg_file_read_address_0;
	debug_reg_file_read_address_1 <= reg_file_read_address_1;
	debug_mux0_sel <= mux0_sel;
	debug_immediate <= immediate;
	debug_ALU_operation <= ALU_operation;

end architecture structural;