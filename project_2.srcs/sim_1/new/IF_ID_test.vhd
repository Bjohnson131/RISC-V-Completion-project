----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2021 07:48:50 PM
-- Design Name: 
-- Module Name: IF_ID_test - Behavioral
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
use ieee.numeric_std.all;
library riscv;
use riscv.all;

entity IF_ID_test is
--  Port ( );
end IF_ID_test;

architecture Behavioral of IF_ID_test is
    signal clock,reset: std_logic := '0';
	signal instruction_address_IF_ID : std_logic_vector(31 downto 0);
	signal instruction: std_logic_vector(31 downto 0);

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
	signal mux1_sel : types.MEMORY_MUX_SEL;
	signal CSR_File_read_addr_OUT : std_logic_vector(11 downto 0);
	signal CSR_File_read_data : std_logic_vector(31 downto 0);
	signal register_file_output_internal_0 : std_logic_vector(31 downto 0);
	signal register_file_output_internal_1 : std_logic_vector(31 downto 0);
	signal CSR_File_read_addr_internal : std_logic_vector(11 downto 0);
    --signal instruction_address_IF_ID,instruction : std_logic_vector(31 downto 0);
    signal decoded_cluster      : types.instruction_cluster;
    signal debug_decoded_opcode : types.opcode;
begin


 -------------------------
 -- Instruction Decode. --
 -------------------------
 controller : entity riscv.controller port map(
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
	mux1_sel=>mux1_sel,
	debug_decoded_cluster=>decoded_cluster,
	debug_decoded_opcode=>debug_decoded_opcode);

IF_STAGE: entity riscv.IF_STAGE(Fibbonacci_test) port map(
 clock => clock,
 reset => reset,
 
 --Output to ID
 instruction_address=>instruction_address_IF_ID,
 instruction=>instruction,
 
 --Input from Execution stage
 JTU_output=>x"00000000",	 
 --Input from Memory stage
 flushing_unit_output=>'0'
);


process 
variable Expected_Address : integer := 0;
variable Init_Address : integer := 16#00010000#;
begin 
  wait for 1ns;
  for I in 0 to 1000 loop
    clock <= '1';
    wait for 25ns;
    Expected_Address := (I*4)+Init_Address;
    assert instruction_address_IF_ID = std_logic_vector(to_unsigned(Expected_Address,32)) report 
    "Clock cycle " & integer'image(I) & 
    " was " & integer'image(to_integer (unsigned (instruction_address_IF_ID))) &
    ", expecting " & integer'image(Expected_Address) ;
    wait for 25ns;
    clock <= '0';
    wait for 50ns;  
  end loop;
end process;  

end Behavioral;
