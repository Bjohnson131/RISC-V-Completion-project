----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2020 04:09:13 PM
-- Design Name: 
-- Module Name: ID_STAGE - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library riscv;
use riscv.ALU;
use riscv.EX_MEM_DIV;

--Uncomment the following library declaration if instantiating
--any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EX_STAGE is
 Port (
  --SYSTEM SIGNALS
  clock,reset: in std_logic;
  
  --OUTPUTS
  	data_format_EX_MEM : out std_logic_vector(2 downto 0);
	datamem_write_EX_MEM : out std_logic;
	jump_flag_EX_MEM : out std_logic;

	mux0_sel_EX_MEM : out std_logic_vector(1 downto 0);
	reg_file_write_EX_MEM : out std_logic;
	reg_file_write_address_EX_MEM : out std_logic_vector(4 downto 0);
	ALU_branch_response_EX_MEM : out std_logic;
	ALU_output_EX_MEM : out std_logic_vector(31 downto 0);
	register_file_output_1_EX_MEM : out std_logic_vector(31 downto 0);
	instruction_address_EX_MEM : out std_logic_vector(31 downto 0);
	CSR_File_read_addr_EX_MEM : out std_logic_vector(11 downto 0);
	CSR_file_write_EX_MEM : out std_logic;
	JTU_output : out std_logic_vector(31 downto 0);
  
  --DECODE SIGNALS
	ALU_operation_ID_EX : in std_logic_vector(3 downto 0);
	ALU_branch_ID_EX : in std_logic;
	ALU_branch_control_ID_EX : in std_logic_vector(2 downto 0);
	mux1_sel_ID_EX : in std_logic_vector(1 downto 0);
	JTU_mux_sel_ID_EX : in std_logic;

	data_format_ID_EX : in std_logic_vector(2 downto 0);
	datamem_write_ID_EX : in std_logic;
	jump_flag_ID_EX : in std_logic;

	mux0_sel_ID_EX : in std_logic_vector(1 downto 0);
	reg_file_write_ID_EX : in std_logic;
	reg_file_write_address_ID_EX : in std_logic_vector(4 downto 0);

	register_file_read_address_0_ID_EX : in std_logic_vector (4 downto 0);
	register_file_read_address_1_ID_EX : in std_logic_vector (4 downto 0);
	register_file_output_0_ID_EX : in std_logic_vector(31 downto 0);
	register_file_output_1_ID_EX : in std_logic_vector(31 downto 0);
	immediate_ID_EX : in std_logic_vector(31 downto 0);
	CSR_File_read_addr_ID_EX : in std_logic_vector(11 downto 0);
	CSR_File_read_data_ID_EX : in std_logic_vector(31 downto 0);
	CSR_file_write_ID_EX : in std_logic;
	instruction_address_ID_EX : in std_logic_vector(31 downto 0);
	
  
  --FETCH SIGNALS
  
  --MEM SIGNALS
  datamem_output_MEM : in std_logic_vector(31 downto 0);
  
  --WB SIGNALS
  reg_file_write_MEM_WB : in std_logic;
  --CSR_file_write_MEM_WB : in std_logic;
  --CSR_File_write_addr_MEM_WB : in std_logic_vector(11 downto 0);
  --CSR_File_write_data_MEM_WB : in std_logic_vector(31 downto 0);
  mux0_sel_MEM_WB : in std_logic_vector(1 downto 0);
  reg_file_write_address_MEM_WB : in std_logic_vector(4 downto 0);
  ALU_output_MEM_WB : in std_logic_vector(31 downto 0);
  datamem_output_MEM_WB : in std_logic_vector(31 downto 0);
  
  
  --DEBUG SIGNALS
  forward_mux_0_control_debug : out std_logic_vector(2 downto 0);
  forward_mux_1_control_debug : out std_logic_vector(2 downto 0);
  ALU_output_debug : out std_logic_vector(31 downto 0);
  ALU_input_0 : out std_logic_vector(31 downto 0);
  ALU_input_1 : out std_logic_vector(31 downto 0)
  
   );
end EX_STAGE;

architecture Behavioral of EX_STAGE is

	--signal data_format_INTERNAL : std_logic_vector(2 downto 0);
	--signal datamem_write_INTERNAL : std_logic;
	--signal jump_flag_INTERNAL : std_logic;

	signal mux0_sel_INTERNAL : std_logic_vector(1 downto 0);
	signal reg_file_write_INTERNAL : std_logic;
	signal reg_file_write_address_INTERNAL : std_logic_vector(4 downto 0);
	signal ALU_output_INTERNAL : std_logic_vector(31 downto 0);
	signal register_file_output_1_INTERNAL : std_logic_vector(31 downto 0);
	signal CSR_File_read_addr_INTERNAL : std_logic_vector(11 downto 0);
	signal CSR_file_write_INTERNAL : std_logic;    

	signal mux_1_output : std_logic_vector(31 downto 0);
	signal forward_mux_0_output : std_logic_vector(31 downto 0);
	signal forward_mux_1_output : std_logic_vector(31 downto 0);
	signal forward_mux_0_control : std_logic_vector(2 downto 0);
	signal forward_mux_1_control : std_logic_vector(2 downto 0);
	signal forward_mux_2_control : std_logic_vector(1 downto 0);
	signal CSR_File_read_data_mux1 : std_logic_vector(31 downto 0);
	signal ALU_branch_response : std_logic;
	
	signal ALU_output : std_logic_vector(31 downto 0);
	
	

begin

forward_mux_0_control_debug <= forward_mux_0_control;
forward_mux_1_control_debug <= forward_mux_1_control;
ALU_input_0 <= mux_1_output;
ALU_input_1 <= forward_mux_0_output;
ALU_output_debug <= ALU_output;
mux0_sel_EX_MEM <= mux0_sel_INTERNAL;
reg_file_write_EX_MEM <= reg_file_write_INTERNAL;
reg_file_write_address_EX_MEM <= reg_file_write_address_INTERNAL;
ALU_output_EX_MEM <= ALU_output_INTERNAL;
register_file_output_1_EX_MEM <= register_file_output_1_INTERNAL;
CSR_File_read_addr_EX_MEM <= CSR_File_read_addr_INTERNAL;
CSR_file_write_EX_MEM <= CSR_file_write_INTERNAL;

    JTU_0 : entity riscv.jump_target_unit port map(
    JTU_mux_sel_ID_EX, 
    instruction_address_ID_EX, 
    register_file_output_0_ID_EX, 
    immediate_ID_EX, 
    JTU_output);

    
	FU_REG : entity riscv.forwarding_unit port map(
	reg_file_read_address_0_ID_EXE=>register_file_read_address_0_ID_EX, 
	reg_file_read_address_1_ID_EXE=>register_file_read_address_1_ID_EX, 
	reg_file_write_EX_MEM=>reg_file_write_INTERNAL, --CHANGE--
	reg_file_write_address_EX_MEM=>reg_file_write_address_INTERNAL,  --CHANGE--
	mux_0_sel_EX_MEM=>mux0_sel_INTERNAL,  --CHANGE--
	reg_file_write_MEM_WB=>reg_file_write_MEM_WB,  --CHANGE--
	reg_file_write_address_MEM_WB=>reg_file_write_address_MEM_WB,  --CHANGE--
	mux_0_sel_MEM_WB=>mux0_sel_MEM_WB,  --CHANGE--
	forward_mux_0_control=>forward_mux_0_control, 
	forward_mux_1_control=>forward_mux_1_control);

	FU_CSR : entity riscv.forwarding_unit_CSR port map(
	reg_file_read_address_0_ID_EXE=>CSR_File_read_addr_ID_EX, 
	reg_file_write_EX_MEM=>CSR_file_write_INTERNAL, 
	reg_file_write_address_EX_MEM=>CSR_File_read_addr_INTERNAL, 
	reg_file_write_MEM_WB=>'0', 
	reg_file_write_address_MEM_WB=>"000000000000", 
	forward_mux_0_control=>forward_mux_2_control);
	
	forward_mux_1 : entity riscv.mux_5_1 port map(
	forward_mux_1_control, 
	register_file_output_1_ID_EX, 
	ALU_output_INTERNAL, 
	datamem_output_MEM, 
	ALU_output_MEM_WB, 
	datamem_output_MEM_WB, 
	forward_mux_1_output);

	FU_CSR_MUX_0: entity riscv.mux_3_1 port map(
	selection=>forward_mux_2_control,
	input_0=>CSR_File_read_data_ID_EX,
	input_1=>register_file_output_1_INTERNAL,
	input_2=>x"00000000",
	output_0=>CSR_File_read_data_mux1);
	
	forward_mux_0 : entity riscv.mux_5_1 port map(
	forward_mux_0_control, 
	register_file_output_0_ID_EX, 
	ALU_output_INTERNAL, 
	datamem_output_MEM, 
	ALU_output_MEM_WB, 
	datamem_output_MEM_WB, 
	forward_mux_0_output);

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
	mux0_sel_out=> mux0_sel_INTERNAL, 
	reg_file_write_out=> reg_file_write_EX_MEM, 
	CSR_file_write_out=>CSR_file_write_INTERNAL,
	reg_file_write_address_out=> reg_file_write_address_INTERNAL, 
	CSR_file_write_address_out=>CSR_File_read_addr_INTERNAL,
	ALU_output_out=> ALU_output_INTERNAL, 
	register_file_output_1_out=> register_file_output_1_INTERNAL, 
	ALU_branch_response_out=> ALU_branch_response_EX_MEM, 
	instruction_address_out=> instruction_address_EX_MEM);
	
end Behavioral;
