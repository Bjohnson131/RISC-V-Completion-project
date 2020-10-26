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
use riscv.flushing_unit;
use riscv.MEM_WB_DIV;
use riscv.datamem_interface;

--Uncomment the following library declaration if instantiating
--any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_STAGE is
 Port (
  --SYSTEM SIGNALS
  clock,reset: in std_logic;
  
  --OUTPUTS
    program_counter_mux_sel : out std_logic;
 	mux0_sel_MEM_WB : out std_logic_vector(1 downto 0);
	reg_file_write_MEM_WB : out std_logic;
	reg_file_write_address_MEM_WB : out std_logic_vector(4 downto 0);
    CSR_File_write_addr_MEM_WB : out std_logic_vector(11 downto 0);
	ALU_output_MEM_WB : out std_logic_vector(31 downto 0);
	datamem_output_MEM_WB : out std_logic_vector(31 downto 0);
	instruction_address_MEM_WB : out std_logic_vector(31 downto 0);
	CSR_file_write_MEM_WB : out std_logic;
	CSR_File_write_data_MEM_WB : out std_logic_vector(31 downto 0);
	flushing_unit_output : out std_logic;
	datamem_output_MEM : out std_logic_vector(31 downto 0);
	
	
  --EXECUTE SIGNALS  
  	data_format_EX_MEM : in std_logic_vector(2 downto 0);
	datamem_write_EX_MEM : in std_logic;
	jump_flag_EX_MEM : in std_logic;

	mux0_sel_EX_MEM : in std_logic_vector(1 downto 0);
	reg_file_write_EX_MEM : in std_logic;
	reg_file_write_address_EX_MEM : in std_logic_vector(4 downto 0);
	ALU_branch_response_EX_MEM : in std_logic;
	ALU_output_EX_MEM : in std_logic_vector(31 downto 0);
	register_file_output_1_EX_MEM : in std_logic_vector(31 downto 0);
	instruction_address_EX_MEM : in std_logic_vector(31 downto 0);
	CSR_File_read_addr_EX_MEM : in std_logic_vector(11 downto 0);
	CSR_file_write_EX_MEM : in std_logic
  
   );
end MEM_STAGE;

architecture Behavioral of MEM_STAGE is
    signal datamem_output : std_logic_vector(31 downto 0);
	signal flushing_control : std_logic;
	signal flushing_unit_output_internal : std_logic;
begin

    datamem_output_MEM <= datamem_output;
    flushing_unit_output <= flushing_unit_output_internal;
    flushing_control<=(ALU_branch_response_EX_MEM or jump_flag_EX_MEM);
    program_counter_mux_sel<=(reset or flushing_unit_output_internal);

	FLUSH : entity riscv.flushing_unit port map(
	clear=>reset, 
	clock=>clock, 
	flushing_control=>flushing_control, 
	flushing_output=>flushing_unit_output_internal);

	datamem_module_0 : entity riscv.datamem_interface port map(
	input_data=>register_file_output_1_EX_MEM, 
	byte_address=>ALU_output_EX_MEM, 
	data_format=>data_format_EX_MEM, 
	clock=>clock, 
	load=>datamem_write_EX_MEM, 
	output_data=>datamem_output);
	
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
	
end Behavioral;
