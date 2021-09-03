----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2020 04:09:13 PM
-- Design Name: 
-- Module Name: jump_target_unit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   Takes in all addresses to select from, a mux sel signal,
--   and an immediate to add to the mux output, and outputs the
--   address that the processor should jump to if any.
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
library riscv;
use riscv.all;

entity jump_target_unit is
	port (
		mux_sel : in std_logic;
		current_instruction_address : in std_logic_vector(31 downto 0);
		regfile_address : in std_logic_vector(31 downto 0);
		immediate : in std_logic_vector(31 downto 0);
		target_address : out std_logic_vector(31 downto 0)
	);
end jump_target_unit;

architecture behavioral of jump_target_unit is
	signal mux_output : std_logic_vector (31 downto 0) := X"00000000";
begin
	internal_mux : entity riscv.mux_2_1 port map(
		selection=>mux_sel, 
		input_0  =>current_instruction_address, 
		input_1  =>regfile_address, 
		output_0 =>mux_output);

	internal_adder : entity riscv.adder port map(
		input_0 =>mux_output, 
		input_1 =>immediate, 
		output_0=>target_address);
end behavioral;