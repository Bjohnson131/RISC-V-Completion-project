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
library riscv;
use riscv.progmem_interface;
use riscv.program_counter;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_STAGE is
  Port (
  --SYSTEM SIGNALS
  clock,reset: in std_logic;
  
  --OUTPUT
  instruction_address_IF_ID: out std_logic_vector(31 downto 0);
  instruction: out std_logic_vector(31 downto 0);
  
  --EX SIGNALS
  JTU_output : in Std_logic_vector(31 downto 0);
  
  --MEM SIGNALS
  flushing_unit_output : in std_logic
   );
end IF_STAGE;

architecture Behavioral of IF_STAGE is
    signal program_counter_mux_sel : std_logic;
    signal PC_output,pc_addr_0 : Std_logic_vector(31 downto 0) := x"00000000";
	signal PC_next_address,progmem_output : std_logic_vector(31 downto 0); --use this when it does
begin

    program_counter_mux_sel<=(reset or flushing_unit_output);
    pc_addr_0<=(std_logic_vector(unsigned(PC_output) + 4));

program_counter_0 : entity riscv.program_counter port map(
clear=>reset, 
clock=>clock, 
mux_sel=>program_counter_mux_sel, 
address_in_0=>pc_addr_0, 
address_in_1=>JTU_output, 
next_address=>PC_next_address, 
address_out=>PC_output);

progmem_module_0 : entity riscv.progmem_interface port map(
clock=>clock, 
byte_address=>PC_next_address, 
output_data=>progmem_output);

IF_ID_PLr: entity riscv.IF_ID_DIV(behavioral) port map( 
    clock=>clock,                                           
    clear=>program_counter_mux_sel,                         
    instruction_address_in=>PC_output,                      
    instruction_data_in=>progmem_output,                    
    instruction_address_out=>instruction_address_IF_ID,     
    instruction_data_out=>instruction
    );

end Behavioral;
