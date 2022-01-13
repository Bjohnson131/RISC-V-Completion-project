----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2021 10:52:30 PM
-- Design Name: 
-- Module Name: ID_TEST - Behavioral
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
library riscv;
use riscv.all;
use riscv.types.all;	

entity ID_TEST is
--  Port ();
end ID_TEST;

architecture Behavioral of ID_TEST is
    signal clock,reset: std_logic := '0';
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
    signal instruction : std_logic_vector(31 downto 0);
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


process 
begin 
  clock <= '1';
  wait for 50ns;
  clock <= '0';
  --  auipc x6, 0 
  instruction <= x"00000317";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.AUIPC_OP report "00000317 not AUIPC_OP";
  assert decoded_cluster      = types.AUIPC    report "00000317 not AUIPC";
  assert mux1_sel = types.NOP                  report "00000317 not NOP mux sel";
  wait for 50ns;
  clock <= '0';
  instruction <= x"00830067";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.JALR_OP report "00830067 not JALR";
  assert decoded_cluster      = types.JALR    report "00830067 not JALR";
  assert mux1_sel = types.NOP                 report "00830067 not NOP mux sel";
  wait for 50ns;
  clock <= '0';
  instruction <= x"00000293";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.ADDI   report "00000293 not ADDI";
  assert decoded_cluster      = types.OP_IMM report "00000293 not OP_IMM";
  assert immediate = x"00000000"             report "00000293 immediate not 0x00000000";
  assert mux1_sel = types.SINGLE_OP          report "00000293 not SINGLE_OP mux sel";
  wait for 50ns;
  clock <= '0';
  instruction <= x"00100313";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.ADDI   report "00100313 not ADDI";
  assert decoded_cluster      = types.OP_IMM report "00100313 not OP_IMM";
  assert immediate = x"00000001"             report "00100313 immediate not 0x00000001";
  assert mux1_sel = types.SINGLE_OP          report "00100313 not SINGLE_OP mux sel";
  wait for 50ns;
  clock <= '0';
  instruction <= x"00400513";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.ADDI   report "00400513 not ADDI";
  assert decoded_cluster      = types.OP_IMM report "00400513 not OP_IMM";
  assert immediate = x"00000004"             report "00400513 immediate not 0x00000004";
  assert mux1_sel = types.SINGLE_OP          report "00400513 not SINGLE_OP mux sel";
  wait for 50ns;
  clock <= '0';
  instruction <= x"00000597";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.AUIPC_OP report "00000597 not AUIPC_OP";
  assert decoded_cluster      = types.AUIPC    report "00000597 not AUIPC";
  assert mux1_sel = types.NOP                  report "00000597 not NOP mux sel";
  wait for 50ns;
  clock <= '0';
  instruction <= x"07c58593";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.ADDI   report "07c58593 not ADDI";
  assert decoded_cluster      = types.OP_IMM report "07c58593 not OP_IMM";
  assert immediate = x"0000007c"             report "07c58593 immediate not 0x0000007c";
  assert mux1_sel = types.SINGLE_OP          report "07c58593 not SINGLE_OP mux sel";
  wait for 50ns;
  clock <= '0';
  instruction <= x"00000073";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.INVALID report "00000073 not INVALID";
  assert decoded_cluster      = types.INVALID report "00000073 not INVALID";
  assert mux1_sel = types.NOP                 report "00000073 not NOP mux sel";
  -- assert debug_decoded_opcode = types.ECALL report "00000073 not ECALL";
  -- unimplemented.
  wait for 50ns;
  clock <= '0';
  instruction <= x"00500513";
  wait for 50ns;
  
  clock <= '1';
  assert debug_decoded_opcode = types.ADDI   report "00500513 not ADDI";
  assert decoded_cluster      = types.OP_IMM report "00500513 not OP_IMM";
  assert immediate = x"00000005"             report "00500513 immediate not 0x00000005";
  assert mux1_sel = types.SINGLE_OP          report "00500513 not SINGLE_OP mux sel";
  wait for 50ns;
  clock <= '0';
  wait for 50ns;
  
end process;

end Behavioral;
