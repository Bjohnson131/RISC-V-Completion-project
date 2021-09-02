----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/23/2020 04:55:15 PM
-- Design Name: 
-- Module Name: MCU2 - Behavioral
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
use riscv.IF_STAGE;
use riscv.ID_STAGE;
use riscv.EX_STAGE;
use riscv.MEM_STAGE;
use riscv.WB_STAGE;	 
use riscv.INTERRUPT_CONTROL_UNIT;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MCU2 is
  Port ( 
  clock,reset : in std_logic;
  
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
end MCU2;

architecture Behavioral of MCU2 is

 --MEM -> IF SIGNALS
 signal flushing_unit_output : std_logic;

 --EX -> IF SIGNALS
 signal JTU_output : std_logic_vector(31 downto 0);

 --IF -> ID SIGNALS
 signal instruction_address_IF_ID,instruction : std_logic_vector(31 downto 0);
 
 --WB -> ID SIGNALS
 signal mux_0_output : std_logic_vector(31 downto 0);
 
 --ID -> EX SIGNALS
 signal register_file_output_0: std_logic_vector(31 downto 0);
 signal register_file_output_1: std_logic_vector(31 downto 0);
 signal CSR_File_read_addr : std_logic_vector(11 downto 0);
 signal ALU_operation_out : std_logic_vector(3 downto 0);
 signal ALU_branch_out : std_logic;
 signal ALU_branch_control_out : std_logic_vector(2 downto 0);
 signal mux1_sel_out : std_logic_vector(1 downto 0);
 signal JTU_mux_sel_out : std_logic;
 signal data_format_out : std_logic_vector(2 downto 0);
 signal datamem_write_out : std_logic;
 signal jump_flag_out : std_logic;
 signal mux0_sel_out : std_logic_vector(1 downto 0);
 signal reg_file_write_out : std_logic;
 signal csr_file_write_out : std_logic;
 signal reg_file_write_address_out : std_logic_vector(4 downto 0);
 signal register_file_read_address_0_out : std_logic_vector(4 downto 0);
 signal register_file_read_address_1_out : std_logic_vector(4 downto 0);
 signal CSR_file_read_address_0_out : std_logic_vector(11 downto 0);
 signal register_file_output_0_out : std_logic_vector(31 downto 0);
 signal register_file_output_1_out : std_logic_vector(31 downto 0);
 signal immediate_out : std_logic_vector(31 downto 0);
 signal instruction_address_out : std_logic_vector(31 downto 0); 
 signal CSR_file_output_1_out : std_logic_vector(31 downto 0);
 
 --EX -> MEM SIGNAL 
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
 
 --ED -> ID SIGNAL
 signal CSR_File_read_addr_EX_MEM : std_logic_vector(11 downto 0);
 signal CSR_file_write_EX_MEM : std_logic;
 --signal ALU_output_EX_MEM : std_logic_vector(31 downto 0);
 
 
 --MEM -> WB SIG
 signal program_counter_mux_sel : std_logic;
 signal mux0_sel_MEM_WB : std_logic_vector(1 downto 0);
 signal ALU_output_MEM_WB : std_logic_vector(31 downto 0);
 signal instruction_address_MEM_WB : std_logic_vector(31 downto 0);
 --MEM -> EX battery
 signal datamem_output_MEM : std_logic_vector(31 downto 0);
 --MEM -> WB, MEM -> ID SIG
 --signal CSR_File_write_addr_MEM_WB : std_logic_vector(11 downto 0);
 --signal CSR_file_write_MEM_WB : std_logic;
 --signal CSR_File_write_data_MEM_WB : std_logic_vector(31 downto 0);
 signal reg_file_write_MEM_WB : std_logic;
 signal reg_file_write_address_MEM_WB : std_logic_vector(4 downto 0);
 --MEM ->WB, MEM -> EX SIG
 signal datamem_output_MEM_WB : std_logic_vector(31 downto 0);
 
begin

--DEBUG SIGNALS

debug_pc_output  <= instruction_address_IF_ID ;
debug_regfile_write  <= reg_file_write_out  ;
debug_mux0_sel  <= mux0_sel_out  ;
debug_immediate  <= immediate_out  ;
debug_ALU_operation  <= ALU_operation_out  ;
debug_reg_file_read_address_0_ID_EXE  <= register_file_read_address_0_out  ;
debug_reg_file_write_address_EX_MEM  <= reg_file_write_address_EX_MEM  ;
debug_mux0_sel_MEM_WB  <= mux0_sel_MEM_WB  ;
debug_reg_file_write_MEM_WB  <= reg_file_write_MEM_WB  ;
debug_reg_file_write_address_MEM_WB  <= reg_file_write_address_MEM_WB  ;
debug_ALU_output_MEM_WB  <= ALU_output_MEM_WB  ;
debug_ALU_output_EX_MEM  <= ALU_output_EX_MEM  ;
debug_register_file_output_0  <= register_file_output_0  ;
debug_register_file_output_1  <= register_file_output_1  ;
debug_register_file_output_0_ID_EX  <= register_file_output_0_out  ;
debug_register_file_output_1_ID_EX  <= register_file_output_1_out  ;
debug_instruction  <= instruction  ;

--INTERRUPT LOGIC

--ICU : entity riscvi.INTERRUPT_CONTROL_UNIT(behavioral) port map();


--STAGING		   
 -----------------------
 -- Intruction Fetch. --
 -----------------------
 IF_stg : entity riscv.IF_STAGE(Behavioral) port map(
 clock => clock,
 reset => reset,
 
 --Output to ID
 instruction_address=>instruction_address_IF_ID,
 instruction=>instruction,
 
 --Input from Execution stage
 JTU_output=>JTU_output,	 
 --Input from Memory stage
 flushing_unit_output=>flushing_unit_output
 );
 
 -------------------------
 -- Instruction Decode. --
 -------------------------
 ID_stg : entity riscv.ID_STAGE(Behavioral) port map(
 clock => clock,
 reset => reset,

 --  Input from Instruction Fetch.
 instruction_address_IF_ID=>         instruction_address_IF_ID,
 instruction=>                       instruction,
 
 --WB SIGNALS
 mux_0_output                           =>                     mux_0_output, 
 reg_file_write_MEM_WB                  =>            reg_file_write_MEM_WB,
 reg_file_write_address_MEM_WB          =>    reg_file_write_address_MEM_WB,
 CSR_file_write_MEM_WB                  =>            CSR_file_write_EX_MEM,
 CSR_File_write_data_MEM_WB             =>                ALU_output_EX_MEM,
 CSR_File_write_addr                    =>        CSR_File_read_addr_EX_MEM,
 
 ALU_operation_out                      =>                ALU_operation_out,
 ALU_branch_out                         =>                   ALU_branch_out,
 ALU_branch_control_out                 =>           ALU_branch_control_out,
 mux1_sel_out                           =>                     mux1_sel_out,
 JTU_mux_sel_out                        =>                  JTU_mux_sel_out,
 data_format_out                        =>                  data_format_out,
 datamem_write_out                      =>                datamem_write_out,
 jump_flag_out                          =>                    jump_flag_out,
 mux0_sel_out                           =>                     mux0_sel_out,
 reg_file_write_out                     =>               reg_file_write_out,
 csr_file_write_out                     =>               csr_file_write_out,
 reg_file_write_address_out             =>       reg_file_write_address_out,
 register_file_read_address_0_out       => register_file_read_address_0_out,
 register_file_read_address_1_out       => register_file_read_address_1_out,
 CSR_file_read_address_0_out            =>      CSR_file_read_address_0_out,
 register_file_output_0_out             =>       register_file_output_0_out,
 register_file_output_1_out             =>       register_file_output_1_out,
 immediate_out                          =>                    immediate_out,
 instruction_address_out                =>         instruction_address_out ,
 CSR_file_output_1_out                  =>           CSR_file_output_1_out ,
 
 --Degug signals sent to the top - level stuff.
 debug_reg_file_read_address_0          =>    debug_reg_file_read_address_0,
 debug_reg_file_read_address_1          =>    debug_reg_file_read_address_1,
 debug_regfile_x1_output                =>         debug_regfile_x1_output ,
 debug_regfile_x2_output                =>         debug_regfile_x2_output ,
 debug_regfile_x31_output               =>         debug_regfile_x31_output
 
 );
 
 EX_stg : entity riscv.EX_STAGE(Behavioral) port map(
 clock => clock,
 reset => reset,
 
	ALU_operation_ID_EX                 => ALU_operation_out,     
	ALU_branch_ID_EX                    => ALU_branch_out,  
	ALU_branch_control_ID_EX            => ALU_branch_control_out,          
	mux1_sel_ID_EX                      => mux1_sel_out ,
	JTU_mux_sel_ID_EX                   => JTU_mux_sel_out ,   
	data_format_ID_EX                   => data_format_out ,   
	datamem_write_ID_EX                 => datamem_write_out ,     
	jump_flag_ID_EX                     => jump_flag_out , 
	mux0_sel_ID_EX                      => mux0_sel_out ,
	reg_file_write_ID_EX                => reg_file_write_out ,      
	reg_file_write_address_ID_EX        => reg_file_write_address_out ,              
	register_file_read_address_0_ID_EX  => register_file_read_address_0_out ,                    
	register_file_read_address_1_ID_EX  => register_file_read_address_1_out,                    
	register_file_output_0_ID_EX        => register_file_output_0_out ,              
	register_file_output_1_ID_EX        => register_file_output_1_out ,              
	immediate_ID_EX                     => immediate_out  , 
	CSR_File_read_addr_ID_EX            => CSR_file_read_address_0_out,          
	CSR_File_read_data_ID_EX            => CSR_file_output_1_out ,          
	CSR_file_write_ID_EX                => csr_file_write_out  ,      
	instruction_address_ID_EX           => instruction_address_out ,  
 
   	data_format_EX_MEM                  => data_format_EX_MEM ,
	datamem_write_EX_MEM                => datamem_write_EX_MEM ,
	jump_flag_EX_MEM                    => jump_flag_EX_MEM ,
	mux0_sel_EX_MEM                     => mux0_sel_EX_MEM ,
	reg_file_write_EX_MEM               => reg_file_write_EX_MEM ,
	reg_file_write_address_EX_MEM       => reg_file_write_address_EX_MEM ,
	ALU_branch_response_EX_MEM          => ALU_branch_response_EX_MEM ,
	ALU_output_EX_MEM                   => ALU_output_EX_MEM ,
	register_file_output_1_EX_MEM       => register_file_output_1_EX_MEM ,
	instruction_address_EX_MEM          => instruction_address_EX_MEM ,
	CSR_File_read_addr_EX_MEM           => CSR_File_read_addr_EX_MEM ,
	CSR_file_write_EX_MEM               => CSR_file_write_EX_MEM ,
	
	--WB SIGNALS
    --CSR_file_write_MEM_WB               => CSR_file_write_MEM_WB,
    --CSR_File_write_addr_MEM_WB          => CSR_File_write_addr_MEM_WB,
    --CSR_File_write_data_MEM_WB          => CSR_File_write_data_MEM_WB,
	reg_file_write_MEM_WB               => reg_file_write_MEM_WB,
    mux0_sel_MEM_WB                     => mux0_sel_MEM_WB,
    reg_file_write_address_MEM_WB       => reg_file_write_address_MEM_WB,
    ALU_output_MEM_WB                   => ALU_output_MEM_WB,
    datamem_output_MEM_WB               => datamem_output_MEM_WB,
	
    JTU_output                          => JTU_output,
    
    datamem_output_MEM                  => datamem_output_MEM,
    
    --DEBUG SIGNALS
    forward_mux_0_control_debug         => debug_forward_mux_0,
    forward_mux_1_control_debug         => debug_forward_mux_1,
    ALU_output_debug                    => debug_ALU_output,
    ALU_input_0                         => debug_ALU_input_0,
    ALU_input_1                         => debug_ALU_input_1
 
 );
 
 MEM_stg : entity riscv.MEM_STAGE(Behavioral) port map(
 clock => clock,
 reset => reset,
 
program_counter_mux_sel                       =>  program_counter_mux_sel,
mux0_sel_MEM_WB                               =>  mux0_sel_MEM_WB,
reg_file_write_MEM_WB                         =>  reg_file_write_MEM_WB,
reg_file_write_address_MEM_WB                 =>  reg_file_write_address_MEM_WB,
--CSR_File_write_addr_MEM_WB                    =>  CSR_File_write_addr_MEM_WB,
--CSR_file_write_MEM_WB                         =>  CSR_file_write_MEM_WB,
--CSR_File_write_data_MEM_WB                    =>  CSR_File_write_data_MEM_WB,
ALU_output_MEM_WB                             =>  ALU_output_MEM_WB,
datamem_output_MEM_WB                         =>  datamem_output_MEM_WB,
instruction_address_MEM_WB                    =>  instruction_address_MEM_WB,
datamem_output_MEM                            =>  datamem_output_MEM,
 
	data_format_EX_MEM                  =>data_format_EX_MEM,
	datamem_write_EX_MEM                =>datamem_write_EX_MEM,
	jump_flag_EX_MEM                    =>jump_flag_EX_MEM,
	mux0_sel_EX_MEM                     =>mux0_sel_EX_MEM,
	reg_file_write_EX_MEM               =>reg_file_write_EX_MEM,
	reg_file_write_address_EX_MEM       =>reg_file_write_address_EX_MEM,
	ALU_branch_response_EX_MEM          =>ALU_branch_response_EX_MEM,
	ALU_output_EX_MEM                   =>ALU_output_EX_MEM,
	register_file_output_1_EX_MEM       =>register_file_output_1_EX_MEM,
	instruction_address_EX_MEM          =>instruction_address_EX_MEM ,
	CSR_File_read_addr_EX_MEM           =>CSR_File_read_addr_EX_MEM,  
	CSR_file_write_EX_MEM               =>CSR_file_write_EX_MEM,
	flushing_unit_output                => flushing_unit_output
 );
 
 WB_stg : entity riscv.WB_STAGE(Behavioral) port map(
 clock => clock,
 reset => reset,
    mux_0_output                           => mux_0_output,
 	mux0_sel_MEM_WB                        => mux0_sel_MEM_WB,
	ALU_output_MEM_WB                      => ALU_output_MEM_WB,
	datamem_output_MEM_WB                  => datamem_output_MEM_WB,
	instruction_address_MEM_WB             => instruction_address_MEM_WB
 );

end Behavioral;
