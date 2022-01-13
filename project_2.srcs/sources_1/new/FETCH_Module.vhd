----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2021 09:23:53 PM
-- Design Name: 
-- Module Name: FETCH_Module - Behavioral
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
use riscv.progmem_interface;
use riscv.program_counter;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FETCH_Module is
  Port ( 
  --INPUT
  
  --EX SIGNALS
  -- TODO-3: Change this to custom 'address' type.
  JTU_output: in Std_logic_vector(31 downto 0);  
  --MEM SIGNALS
  flushing_unit_output: in std_logic;  
  --SYSTEM SIGNALS
  clock,reset: in std_logic;  
  instruction: in std_logic_vector(31 downto 0);
  --OUTPUT
  -- TODO-2: Change this to custom 'address' type.
  instruction_address_out: out std_logic_vector(31 downto 0);
  instruction_out: out std_logic_vector (31 downto 0);
  pc_addr_0: out std_logic_vector(31 downto 0)
    );
end FETCH_Module;

architecture Behavioral of FETCH_Module is
    signal program_counter_mux_sel: std_logic;
    signal PC_output: Std_logic_vector(31 downto 0) := x"00010000";
	signal PC_next_address: std_logic_vector(31 downto 0) := x"00010000";
begin

    program_counter_mux_sel<=(reset or flushing_unit_output);
    PC_next_address<=(std_logic_vector(unsigned(PC_output) + 4));
    pc_addr_0 <= PC_output;
    
-- Program counter:
-- clear: resets the counter to address 0
-- clock: advances the program counter
-- mux_sel: chooses betweem address in 1 or 0
-- address_in_x: The choices between the addresses to use
-- address_out: The current address to fetch.
program_counter_0 : entity riscv.program_counter port map(
clear=>reset, 
clock=>clock, 
mux_sel=>program_counter_mux_sel, 
address_in_0=>PC_next_address, 
address_in_1=>JTU_output, 			
address_out=>PC_output);


-- Instruction Fetch / Instruction Decode Divider.
-- Takes in the PC, and the instruction.
-- Is basically a big register.
IF_ID_PLR: entity riscv.IF_ID_DIV(behavioral) port map( 
    clock=>clock,                                           
    clear=>program_counter_mux_sel,                         
    instruction_address_in=>PC_output,                      
    instruction_data_in=>instruction,                    
    instruction_address_out=>instruction_address_out,     
    instruction_data_out=>instruction_out
    );

end Behavioral;
