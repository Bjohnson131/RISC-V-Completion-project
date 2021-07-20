library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
library riscv;
use riscv.all;	

entity datapath is
	port (
		clock : in std_logic;
		reset : in std_logic;
		reg_file_read_address_0 : in std_logic_vector(4 downto 0);
		reg_file_read_address_1 : in std_logic_vector(4 downto 0);
		CSR_File_read_addr : in std_logic_vector(11 downto 0);
		reg_file_write : in std_logic;
		CSR_file_write : in std_logic;
		reg_file_write_address : in std_logic_vector(4 downto 0);
		immediate : in std_logic_vector(31 downto 0);
		ALU_operation : in std_logic_vector(3 downto 0);
		ALU_branch : in std_logic;
		ALU_branch_control : in std_logic_vector(2 downto 0);
		JTU_mux_sel : in std_logic;
		data_format : in std_logic_vector(2 downto 0);
		datamem_write : in std_logic;
		jump_flag : in std_logic;
		mux0_sel : in std_logic_vector(1 downto 0);
		mux1_sel : in std_logic_vector(1 downto 0);
		instruction : out std_logic_vector(31 downto 0); --change it back to output later (from buffer)
		debug_instruction_address : out std_logic_vector(31 downto 0);
		debug_regfile_x31_output : out std_logic_vector(31 downto 0);
		debug_regfile_x1_output : out std_logic_vector(31 downto 0);
		debug_regfile_x2_output : out std_logic_vector(31 downto 0);
		debug_ALU_output : out std_logic_vector(31 downto 0);
		debug_ALU_input_0 : out std_logic_vector(31 downto 0);
		debug_ALU_input_1 : out std_logic_vector(31 downto 0);
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
end entity datapath;

architecture structural of datapath is


	signal PC_output : std_logic_vector(31 downto 0); -- use this as your progmem input when your memory does not have a registered input
	signal PC_next_address : std_logic_vector(31 downto 0); --use this when it does
	signal progmem_output : std_logic_vector(31 downto 0);

	signal flushing_unit_output : std_logic;

	signal mux_0_output : std_logic_vector(31 downto 0);
	signal mux_1_output : std_logic_vector(31 downto 0);

	signal register_file_output_0 : std_logic_vector(31 downto 0);
	signal register_file_output_1 : std_logic_vector(31 downto 0);

	signal ALU_branch_response : std_logic;
	signal ALU_output : std_logic_vector(31 downto 0);

	signal datamem_output : std_logic_vector(31 downto 0);

	signal instruction_address_IF_ID : std_logic_vector(31 downto 0);

	signal ALU_operation_ID_EX : std_logic_vector(3 downto 0);
	signal ALU_branch_ID_EX : std_logic;
	signal ALU_branch_control_ID_EX : std_logic_vector(2 downto 0);
	signal mux1_sel_ID_EX : std_logic_vector(1 downto 0);
	signal JTU_mux_sel_ID_EX : std_logic;

	signal data_format_ID_EX : std_logic_vector(2 downto 0);
	signal datamem_write_ID_EX : std_logic;
	signal jump_flag_ID_EX : std_logic;

	signal mux0_sel_ID_EX : std_logic_vector(1 downto 0);
	signal reg_file_write_ID_EX : std_logic;
	signal reg_file_write_address_ID_EX : std_logic_vector(4 downto 0);

	signal register_file_read_address_0_ID_EX : std_logic_vector (4 downto 0);
	signal register_file_read_address_1_ID_EX : std_logic_vector (4 downto 0);
	signal register_file_output_0_ID_EX : std_logic_vector(31 downto 0);
	signal register_file_output_1_ID_EX : std_logic_vector(31 downto 0);
	signal immediate_ID_EX : std_logic_vector(31 downto 0);
	signal instruction_address_ID_EX : std_logic_vector(31 downto 0);

	signal forward_mux_0_control : std_logic_vector(2 downto 0);
	signal forward_mux_1_control : std_logic_vector(2 downto 0);
	signal forward_mux_2_control : std_logic_vector(1 downto 0);

	signal forward_mux_0_output : std_logic_vector(31 downto 0);
	signal forward_mux_1_output : std_logic_vector(31 downto 0);

	signal JTU_output : std_logic_vector(31 downto 0);

	signal data_format_EX_MEM : std_logic_vector(2 downto 0);
	signal datamem_write_EX_MEM : std_logic;
	signal jump_flag_EX_MEM : std_logic;

	signal mux0_sel_EX_MEM : std_logic_vector(1 downto 0);
	signal reg_file_write_EX_MEM : std_logic;
	signal reg_file_write_address_EX_MEM : std_logic_vector(4 downto 0);
	signal ALU_branch_response_EX_MEM : std_logic;

	signal ALU_output_EX_MEM : std_logic_vector(31 downto 0);
	signal register_file_output_1_EX_MEM : std_logic_vector(31 downto 0);
	signal instruction_address_EX_MEM : std_logic_vector(31 downto 0);

	signal mux0_sel_MEM_WB : std_logic_vector(1 downto 0);
	signal reg_file_write_MEM_WB : std_logic;
	signal reg_file_write_address_MEM_WB : std_logic_vector(4 downto 0);

	signal ALU_output_MEM_WB : std_logic_vector(31 downto 0);
	signal datamem_output_MEM_WB : std_logic_vector(31 downto 0);
	signal instruction_address_MEM_WB : std_logic_vector(31 downto 0);
	signal debug_regfile_x31_output_signal : std_logic_vector(31 downto 0);
	signal debug_regfile_x1_output_signal : std_logic_vector(31 downto 0);
	signal debug_regfile_x2_output_signal : std_logic_vector(31 downto 0);
	signal program_counter_mux_sel : std_logic;
	signal pc_addr_0 : std_logic_vector(31 downto 0);
	signal mux_0_in_2 : std_logic_vector(31 downto 0);
	signal flushing_control : std_logic;
	
	--signal CSR_File_write_data_EX : std_logic_vector(31 downto 0);
	--signal CSR_File_write_data_EX_MEM : std_logic_vector(31 downto 0);
	signal CSR_File_write_data_MEM_WB : std_logic_vector(31 downto 0);
	signal CSR_File_write_addr : std_logic_vector(11 downto 0);
	signal CSR_File_read_addr_ID_EX : std_logic_vector(11 downto 0);
	signal CSR_File_read_addr_EX_MEM : std_logic_vector(11 downto 0);
	signal CSR_File_write_addr_MEM_WB : std_logic_vector(11 downto 0);
	signal CSR_write_enable : std_logic;
	signal CSR_file_write_ID_EX : std_logic;
	signal CSR_file_write_EX_MEM : std_logic;
	signal CSR_file_write_MEM_WB : std_logic;
	signal CSR_File_read_data : std_logic_vector(31 downto 0);
	signal CSR_File_read_data_ID_EX : std_logic_vector(31 downto 0);
	signal CSR_File_read_data_mux1 : std_logic_vector(31 downto 0);

    
begin

	program_counter_0 : entity riscv.program_counter port map(
	clear=>reset, 
	clock=>clock, 
	mux_sel=>program_counter_mux_sel, 
	address_in_0=>pc_addr_0, 
	address_in_1=>JTU_output, 
	next_address=>PC_next_address, 
	address_out=>PC_output);
	progmem_module_0 : entity riscv.progmem_interface port map(clock=>clock, byte_address=>PC_next_address, output_data=>progmem_output);


	mux_0 : entity riscv.mux_3_1 port map(
	selection=>mux0_sel_MEM_WB, 
	input_0=>ALU_output_MEM_WB, 
	input_1=>datamem_output_MEM_WB, 
	input_2=>mux_0_in_2, 
	output_0=>mux_0_output);
	
	CSR : entity riscv.CSR_Regfile port map(
	clock=> clock,
	clear=>reset,	
	write_data => CSR_File_write_data_MEM_WB,
	write_address => CSR_File_write_addr_MEM_WB,
	write_state => "11",
	read_state => "11",
	read_address_0 => CSR_File_read_addr,
	output_data_0=>CSR_File_read_data,
	write_control=>CSR_file_write_MEM_WB	
	);
	
	register_file_0 : entity riscv.register_file port map(
	write_data=>mux_0_output, 
	write_address=>reg_file_write_address_MEM_WB, 
	read_address_0=>reg_file_read_address_0, 
	read_address_1=>reg_file_read_address_1, 
	write_control=>reg_file_write_MEM_WB, 
	clock=>clock, 
	clear=>reset, 
	output_data_0=>register_file_output_0, 
	output_data_1=>register_file_output_1, 
	debug_x31_output=>debug_regfile_x31_output_signal, 
	debug_x1_output=>debug_regfile_x1_output_signal, 
	debug_x2_output=>debug_regfile_x2_output_signal);


    --No logic, just a simple set of regs.--
	ID_EX_PLR : entity riscv.ID_EX_DIV port map(
	 --System Things--
	 clock=>clock,
	 clear=>program_counter_mux_sel, 
	 
	 --INPUTS [PORT IN]--
	 ALU_operation_in=>ALU_operation, 
	 ALU_branch_in=>ALU_branch, 
	 ALU_branch_control_in=>ALU_branch_control, 
	 mux1_sel_in=>mux1_sel, 
	 JTU_mux_sel_in=>JTU_mux_sel, 
	 
	 --MEM SIGS [PORT IN]--
	 data_format_in=>data_format, 
	 datamem_write_in=>datamem_write, 
	 jump_flag_in=>jump_flag, 
	 
	 --WB CONTROL ? [PORT IN]--
	 mux0_sel_in=>mux0_sel, 
	 reg_file_write_in=>reg_file_write, 
	 CSR_file_write_in=>CSR_file_write,
	 reg_file_write_address_in=>reg_file_write_address, 
	 
	 --read addrs [PORT IN]--
	 register_file_read_address_0_in=>reg_file_read_address_0, 
	 register_file_read_address_1_in=>reg_file_read_address_1, 
	 CSR_file_read_address_0_in => CSR_File_read_addr,
	 
	 -- DATA [MUXED]--
	 register_file_output_0_in=>register_file_output_0, 
	 register_file_output_1_in=>register_file_output_1, 
	 immediate_in=>immediate, 
	 instruction_address_in=>instruction_address_IF_ID, 
	 CSR_file_output_1_in=>CSR_File_read_data,
	 
	 --Outs--	 
	 ALU_operation_out=>ALU_operation_ID_EX, 
	 ALU_branch_out=>ALU_branch_ID_EX, 
	 ALU_branch_control_out=>ALU_branch_control_ID_EX, 
	 mux1_sel_out=>mux1_sel_ID_EX, 
	 JTU_mux_sel_out=>JTU_mux_sel_ID_EX, 	 
	 data_format_out=>data_format_ID_EX, 
	 datamem_write_out=>datamem_write_ID_EX, 
	 jump_flag_out=>jump_flag_ID_EX, 	 
	 mux0_sel_out=>mux0_sel_ID_EX, 
	 reg_file_write_out=>reg_file_write_ID_EX, 
	 CSR_file_write_out=>CSR_file_write_ID_EX,
	 reg_file_write_address_out=>reg_file_write_address_ID_EX, 	 
	 register_file_read_address_0_out=>register_file_read_address_0_ID_EX, 
	 register_file_read_address_1_out=>register_file_read_address_1_ID_EX, 
	 CSR_file_read_address_0_out=>CSR_File_read_addr_ID_EX,	 
	 register_file_output_0_out=>register_file_output_0_ID_EX, 
	 register_file_output_1_out=>register_file_output_1_ID_EX, 
	 immediate_out=>immediate_ID_EX, 
	 instruction_address_out=>instruction_address_ID_EX,
	 CSR_file_output_1_out =>CSR_File_read_data_ID_EX
	 
	 );

	FU_REG : entity riscv.forwarding_unit port map(
	reg_file_read_address_0_ID_EXE=>register_file_read_address_0_ID_EX, 
	reg_file_read_address_1_ID_EXE=>register_file_read_address_1_ID_EX, 
	reg_file_write_EX_MEM=>reg_file_write_EX_MEM, --CHANGE--
	reg_file_write_address_EX_MEM=>reg_file_write_address_EX_MEM,  --CHANGE--
	mux_0_sel_EX_MEM=>mux0_sel_EX_MEM,  --CHANGE--
	reg_file_write_MEM_WB=>reg_file_write_MEM_WB,  --CHANGE--
	reg_file_write_address_MEM_WB=>reg_file_write_address_MEM_WB,  --CHANGE--
	mux_0_sel_MEM_WB=>mux0_sel_MEM_WB,  --CHANGE--
	forward_mux_0_control=>forward_mux_0_control, 
	forward_mux_1_control=>forward_mux_1_control);

	FU_CSR : entity riscv.forwarding_unit_CSR port map(
	reg_file_read_address_0_ID_EXE=>CSR_File_read_addr_ID_EX, 
	reg_file_write_EX_MEM=>CSR_file_write_EX_MEM, 
	reg_file_write_address_EX_MEM=>CSR_File_read_addr_EX_MEM, 
	reg_file_write_MEM_WB=>CSR_file_write_MEM_WB, 
	reg_file_write_address_MEM_WB=>CSR_File_write_addr_MEM_WB, 
	forward_mux_0_control=>forward_mux_2_control);
	
	FU_CSR_MUX_0: entity riscv.mux_3_1 port map(
	selection=>forward_mux_2_control,
	input_0=>CSR_File_read_data_ID_EX,
	input_1=>register_file_output_1_EX_MEM,
	input_2=>CSR_File_write_data_MEM_WB,
	output_0=>CSR_File_read_data_mux1);
	
	forward_mux_0 : entity riscv.mux_5_1 port map(
	forward_mux_0_control, 
	register_file_output_0_ID_EX, 
	ALU_output_EX_MEM, 
	datamem_output, 
	ALU_output_MEM_WB, 
	datamem_output_MEM_WB, 
	forward_mux_0_output);
	
	forward_mux_1 : entity riscv.mux_5_1 port map(
	forward_mux_1_control, 
	register_file_output_1_ID_EX, 
	ALU_output_EX_MEM, 
	datamem_output, 
	ALU_output_MEM_WB, 
	datamem_output_MEM_WB, 
	forward_mux_1_output);

	mux_1 : entity riscv.mux_4_1 port map(
	mux1_sel_ID_EX, 
	forward_mux_1_output, 
	immediate_ID_EX, 
	CSR_File_read_data_mux1,
	x"00000000",
	mux_1_output);
	
	ALU_0 : entity riscv.ALU port map(
	forward_mux_0_output, 
	mux_1_output, 
	ALU_operation_ID_EX, 
	ALU_branch_ID_EX, 
	ALU_branch_control_ID_EX, 
	ALU_branch_response, 
	ALU_output);

	JTU_0 : entity riscv.jump_target_unit port map(JTU_mux_sel_ID_EX, instruction_address_ID_EX, register_file_output_0_ID_EX, immediate_ID_EX, JTU_output);

	EX_MEM_PLR : entity riscv.EX_MEM_DIV port map(
	clock=>clock, 
	clear=>reset, 
	
	data_format_in=>data_format_ID_EX, 
	datamem_write_in=>datamem_write_ID_EX, 
	jump_flag_in=>jump_flag_ID_EX, 
	mux0_sel_in=>mux0_sel_ID_EX, 
	reg_file_write_in=>reg_file_write_ID_EX, 
	CSR_file_write_in=>CSR_file_write_ID_EX,
	reg_file_write_address_in=>reg_file_write_address_ID_EX, 
	CSR_file_write_address_in=>CSR_File_read_addr_ID_EX,
	ALU_output_in=>ALU_output, 
	register_file_output_1_in=> forward_mux_1_output, 
	ALU_branch_response_in=> ALU_branch_response, 
	instruction_address_in=> instruction_address_ID_EX, 
	data_format_out=> data_format_EX_MEM, 
	datamem_write_out=> datamem_write_EX_MEM, 
	jump_flag_out=> jump_flag_EX_MEM, 
	mux0_sel_out=> mux0_sel_EX_MEM, 
	reg_file_write_out=> reg_file_write_EX_MEM, 
	CSR_file_write_out=>CSR_file_write_EX_MEM,
	reg_file_write_address_out=> reg_file_write_address_EX_MEM, 
	CSR_file_write_address_out=>CSR_File_read_addr_EX_MEM,
	ALU_output_out=> ALU_output_EX_MEM, 
	register_file_output_1_out=> register_file_output_1_EX_MEM, 
	ALU_branch_response_out=> ALU_branch_response_EX_MEM, 
	instruction_address_out=> instruction_address_EX_MEM);

	FLUSH : entity riscv.flushing_unit port map(
	clear=>reset, 
	clock=>clock, 
	flushing_control=>flushing_control, 
	flushing_output=>flushing_unit_output);

	datamem_module_0 : entity riscv.datamem_interface port map(
	input_data=>register_file_output_1_EX_MEM, 
	byte_address=>ALU_output_EX_MEM, 
	data_format=>data_format_EX_MEM, 
	clock=>clock, 
	load=>datamem_write_EX_MEM, 
	output_data=>datamem_output);
	
    IF_ID_PLr: entity riscv.IF_ID_DIV(behavioral) port map( 
    clock=>clock,                                           
    clear=>program_counter_mux_sel,                         
    instruction_address_in=>PC_output,                      
    instruction_data_in=>progmem_output,                    
    instruction_address_out=>instruction_address_IF_ID,     
    instruction_data_out=>instruction
    );                     

	MEM_WB_PLR : entity riscv.MEM_WB_DIV port map(
	clock=>clock, 
	clear=>reset, 
	
	mux0_sel_in => mux0_sel_EX_MEM, 
	reg_file_write_in => reg_file_write_EX_MEM, 
	reg_file_write_address_in => reg_file_write_address_EX_MEM, 
	CSR_file_write_address_in=>CSR_File_read_addr_EX_MEM,
	ALU_output_in => ALU_output_EX_MEM, 
	datamem_output_in => datamem_output, 
	instruction_address_in => instruction_address_EX_MEM, 
	CSR_file_write_in => CSR_file_write_EX_MEM,
	CSR_file_write_data_in => register_file_output_1_EX_MEM,
	
	mux0_sel_out => mux0_sel_MEM_WB, 
	reg_file_write_out => reg_file_write_MEM_WB, 
	reg_file_write_address_out => reg_file_write_address_MEM_WB, 
	CSR_file_write_address_out=>CSR_File_write_addr_MEM_WB,
	ALU_output_out => ALU_output_MEM_WB, 
	datamem_output_out => datamem_output_MEM_WB, 
	instruction_address_out => instruction_address_MEM_WB,
	CSR_file_write_out => CSR_file_write_MEM_WB,
	CSR_file_write_data_out => CSR_File_write_data_MEM_WB);
    
    
    
    
    flushing_control<=(ALU_branch_response_EX_MEM or jump_flag_EX_MEM);
    mux_0_in_2<=std_logic_vector(unsigned(instruction_address_MEM_WB) + 4);
    pc_addr_0<=(std_logic_vector(unsigned(PC_output) + 4));
    program_counter_mux_sel<=(reset or flushing_unit_output);
	debug_instruction_address <= PC_output;
	debug_regfile_x31_output <= debug_regfile_x31_output_signal;
	debug_regfile_x1_output <= debug_regfile_x1_output_signal;
	debug_regfile_x2_output <= debug_regfile_x2_output_signal;
	debug_ALU_output <= ALU_output;
	debug_ALU_input_0 <= forward_mux_0_output;
	debug_ALU_input_1 <= mux_1_output;
	debug_forward_mux_0 <= forward_mux_0_control;
	debug_forward_mux_1 <= forward_mux_1_control;
	debug_reg_file_read_address_0_ID_EXE <= register_file_read_address_0_ID_EX;
	debug_reg_file_write_address_EX_MEM <= reg_file_write_address_EX_MEM;
	debug_mux0_sel_MEM_WB <= mux0_sel_MEM_WB;
	debug_reg_file_write_MEM_WB <= reg_file_write_MEM_WB;
	debug_reg_file_write_address_MEM_WB <= reg_file_write_address_MEM_WB;
	debug_ALU_output_MEM_WB <= ALU_output_MEM_WB;
	debug_ALU_output_EX_MEM <= ALU_output_EX_MEM;
	debug_register_file_output_0 <= register_file_output_0;
	debug_register_file_output_1 <= register_file_output_1;
	debug_register_file_output_0_ID_EX <= register_file_output_0_ID_EX;
	debug_register_file_output_1_ID_EX <= register_file_output_1_ID_EX;
	debug_instruction <= progmem_output;

end architecture structural;