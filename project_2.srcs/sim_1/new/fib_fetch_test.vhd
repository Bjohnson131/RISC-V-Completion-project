----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2021 10:27:36 PM
-- Design Name: 
-- Module Name: fib_fetch_test - Behavioral
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

entity fib_fetch_test is
--  Port ( );
end fib_fetch_test;

architecture Behavioral of fib_fetch_test is
    signal clock,reset: std_logic := '0';
	signal instruction_address_IF_ID : std_logic_vector(31 downto 0);
	signal instruction: std_logic_vector(31 downto 0);
begin

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
