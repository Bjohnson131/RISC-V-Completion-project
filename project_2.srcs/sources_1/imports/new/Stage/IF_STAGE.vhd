----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Brice Johnson
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
use riscv.progmem_interface;
use riscv.Progmem_fibonacci;
use riscv.program_counter;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_STAGE is
  Port (
  --INPUT
  
  --EX SIGNALS
  -- TODO-3: Change this to custom 'address' type.
  JTU_output : in Std_logic_vector(31 downto 0);
  
  --MEM SIGNALS
  flushing_unit_output : in std_logic;
  
  --SYSTEM SIGNALS
  clock,reset: in std_logic;
  
  --OUTPUT
  -- TODO-2: Change this to custom 'address' type.
  instruction_address: out std_logic_vector(31 downto 0);
  -- TODO-1: Change this to custom 'instruction' type.
  instruction: out std_logic_vector(31 downto 0)
  );
end IF_STAGE;


architecture Production of IF_STAGE is
	signal progmem_output : std_logic_vector(31 downto 0);
	signal pc_addr_0: std_logic_vector(31 downto 0);
begin

FETCH : entity riscv.FETCH_Module port map(
  JTU_output               => JTU_output,
  flushing_unit_output     => flushing_unit_output,
  clock                    => clock,
  reset                    => reset,
  instruction              => progmem_output,
  
  instruction_address_out  => instruction_address,
  instruction_out          => instruction,
  pc_addr_0                => pc_addr_0
);
-- Progmem interface
-- takes in the address, and outputs the instruction fetched.
progmem_module_0 : entity riscv.progmem_interface port map(
clock=>clock, 
byte_address=>pc_addr_0, 
output_data=>progmem_output);

end Production;




architecture Fibbonacci_test of IF_STAGE is
	signal progmem_output : std_logic_vector(31 downto 0);
	signal pc_addr_0 : std_logic_vector(31 downto 0);
begin

FETCH : entity riscv.FETCH_Module port map(
  JTU_output               => JTU_output,
  flushing_unit_output     => flushing_unit_output,
  clock                    => clock,
  reset                    => reset,
  instruction              => progmem_output,
  
  instruction_address_out  => instruction_address,
  instruction_out          => instruction,
  pc_addr_0                => pc_addr_0
);
-- Progmem interface
-- takes in the address, and outputs the instruction fetched.
progmem_module_0 : entity riscv.Progmem_fibonacci(Behavioral) port map(
clock=>clock, 
byte_address=>pc_addr_0, 
output_data=>progmem_output);
end Fibbonacci_test;
