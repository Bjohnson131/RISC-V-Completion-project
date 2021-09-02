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
use riscv.controller;			   		   

entity ID_STAGE is
 Port (
  --SYSTEM SIGNALS
  clock,reset: in std_logic;
  
  --OUTPUTS

  -- TODO-7: Put this CSR stuff into its own module
  --register_file_output_0: out std_logic_vector(31 downto 0);
  --register_file_output_1: out std_logic_vector(31 downto 0);
  --CSR_File_read_addr : out std_logic_vector(11 downto 0);
  CSR_file_read_address_0_out : out std_logic_vector(11 downto 0); 
  CSR_file_output_1_out : out std_logic_vector(31 downto 0);
  csr_file_write_out : out std_logic;

  -- TODO-8: Put this regfile stuff into its own module
  reg_file_write_out : out std_logic;
  reg_file_write_address_out : out std_logic_vector(4 downto 0);
  register_file_read_address_0_out : out std_logic_vector(4 downto 0);
  register_file_read_address_1_out : out std_logic_vector(4 downto 0);
  register_file_output_0_out : out std_logic_vector(31 downto 0);
  register_file_output_1_out : out std_logic_vector(31 downto 0);

  -- TODO-5: Change this to custom 'ALU operation' type.
  ALU_operation_out : out std_logic_vector(3 downto 0);
  ALU_branch_out : out std_logic;
  ALU_branch_control_out : out std_logic_vector(2 downto 0);

  -- TODO-6: WTF ARE THESE?!?
  mux1_sel_out : out std_logic_vector(1 downto 0);
  mux0_sel_out : out std_logic_vector(1 downto 0);

  JTU_mux_sel_out : out std_logic;
  data_format_out : out std_logic_vector(2 downto 0);
  datamem_write_out : out std_logic;
  jump_flag_out : out std_logic;

  immediate_out : out std_logic_vector(31 downto 0);
  instruction_address_out : out std_logic_vector(31 downto 0);
  
  
  --FETCH SIGNALS
  instruction_address_IF_ID: in std_logic_vector(31 downto 0);
  instruction: in std_logic_vector(31 downto 0);
  
  --WB SIGNALS

  -- TODO-4: Change this to its own module
  mux_0_output : in std_logic_vector(31 downto 0);
  reg_file_write_address_MEM_WB : in std_logic_vector(4 downto 0);
  CSR_File_write_data_MEM_WB : in std_logic_vector(31 downto 0);
  CSR_File_write_addr : in std_logic_vector(11 downto 0);
  CSR_file_write_MEM_WB : in std_logic;
  reg_file_write_MEM_WB : in std_logic;
  
  --DEBUG SIGNALS
  debug_reg_file_read_address_0 : out std_logic_vector(4 downto 0);
  debug_reg_file_read_address_1 : out std_logic_vector(4 downto 0);
  debug_regfile_x31_output : out std_logic_vector(31 downto 0);
  debug_regfile_x1_output : out std_logic_vector(31 downto 0);
  debug_regfile_x2_output : out std_logic_vector(31 downto 0)
  );
end ID_STAGE;

architecture Behavioral of ID_STAGE is
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
	
	
	signal CSR_File_read_addr_OUT : std_logic_vector(11 downto 0);
	signal CSR_File_read_data : std_logic_vector(31 downto 0);

	signal register_file_output_internal_0 : std_logic_vector(31 downto 0);
	signal register_file_output_internal_1 : std_logic_vector(31 downto 0);
	signal CSR_File_read_addr_internal : std_logic_vector(11 downto 0);

begin

    --register_file_output_1_out <= register_file_output_internal_1;
    --register_file_output_0_out <= register_file_output_internal_0;
    CSR_file_read_address_0_out <= CSR_File_read_addr_internal;
    debug_reg_file_read_address_0 <= reg_file_read_address_0;
    debug_reg_file_read_address_1 <= reg_file_read_address_1;

	controller_0 : entity riscv.controller port map(
	--INS
	clock=>clock, 
	reset=>reset, 
	instruction=>instruction, 
	--OUTS
	reg_file_read_address_0=>reg_file_read_address_0, 
	reg_file_read_address_1=>reg_file_read_address_1, 
	csr_file_read_address_0=>CSR_File_read_addr_internal,
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
	
	register_file_0 : entity riscv.register_file port map(
	write_data=>mux_0_output, 
	write_address=>reg_file_write_address_MEM_WB, 
	read_address_0=>reg_file_read_address_0, 
	read_address_1=>reg_file_read_address_1, 
	write_control=>reg_file_write_MEM_WB, 
	clock=>clock, 
	clear=>reset, 
	output_data_0=>register_file_output_internal_0, 
	output_data_1=>register_file_output_internal_1,--, 
	debug_x31_output=>debug_regfile_x31_output, 
	debug_x1_output=>debug_regfile_x1_output, 
	debug_x2_output=>debug_regfile_x2_output
	);	
	
	CSR : entity riscv.CSR_Regfile port map(
	clock=> clock,
	clear=>reset,	
	write_data => CSR_File_write_data_MEM_WB,
	write_address => CSR_File_write_addr,
	write_state => "11",
	read_state => "11",
	read_address_0 => CSR_File_read_addr_internal,
	output_data_0=>CSR_File_read_data,
	write_control=>CSR_file_write_MEM_WB	
	);

OUT_PLR : entity riscv.ID_EX_DIV port map(
	 --System Things--
	 clock=>clock,
	 clear=>'0', 
	 
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
	 CSR_file_read_address_0_in => CSR_File_read_addr_internal,
	 
	 -- DATA [MUXED]--
	 register_file_output_0_in=>register_file_output_internal_0, 
	 register_file_output_1_in=>register_file_output_internal_1, 
	 immediate_in=>immediate, 
	 instruction_address_in=>instruction_address_IF_ID, 
	 CSR_file_output_1_in=>CSR_File_read_data,
	 
	 --Outs--	 
	 ALU_operation_out=>ALU_operation_OUT, 
	 ALU_branch_out=>ALU_branch_OUT, 
	 ALU_branch_control_out=>ALU_branch_control_OUT, 
	 mux1_sel_out=>mux1_sel_OUT, 
	 JTU_mux_sel_out=>JTU_mux_sel_OUT, 	 
	 data_format_out=>data_format_OUT, 
	 datamem_write_out=>datamem_write_OUT, 
	 jump_flag_out=>jump_flag_OUT, 	 
	 mux0_sel_out=>mux0_sel_OUT, 
	 reg_file_write_out=>reg_file_write_OUT, 
	 CSR_file_write_out=>CSR_file_write_OUT,
	 reg_file_write_address_out=>reg_file_write_address_OUT, 	 
	 register_file_read_address_0_out=>register_file_read_address_0_OUT, 
	 register_file_read_address_1_out=>register_file_read_address_1_OUT, 
	 CSR_file_read_address_0_out=>CSR_File_read_addr_OUT,	 
	 register_file_output_0_out=>register_file_output_0_OUT, 
	 register_file_output_1_out=>register_file_output_1_OUT, 
	 immediate_out=>immediate_OUT, 
	 instruction_address_out=>instruction_address_OUT,
	 CSR_file_output_1_out =>CSR_file_output_1_out		 	 
	 );
end Behavioral;
