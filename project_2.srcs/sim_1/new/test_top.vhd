----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2021 07:40:28 PM
-- Design Name: 
-- Module Name: test_top - Behavioral
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
use work.all;

entity test_top is
--  Port ( );
end test_top;

architecture Behavioral of test_top is

begin

-- Tests for the Instruction Fetch (IF) portion
fib_test_IF: entity work.fib_fetch_test(Behavioral);

-- Tests for the Instruction Decode(ID) Acumulator
test_id: entity work.ID_TEST(Behavioral);


end Behavioral;
