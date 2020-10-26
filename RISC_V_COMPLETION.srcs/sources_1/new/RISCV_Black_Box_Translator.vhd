----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2020 12:50:34 AM
-- Design Name: 
-- Module Name: RISCV_Black_Box_Translator - Behavioral
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
library RISCV;
use RISCV.all;
library riscvi;
use riscvi.all;
library riscy;
use riscy.all;

entity RISCV_Black_Box_Translator is
 Port ( 
 led: out std_logic_vector(7 downto 0);
 --sw: in std_logic_vector(7 downto 0);
 sysClk: in std_logic);
end RISCV_Black_Box_Translator;

architecture Behavioral of RISCV_Black_Box_Translator is

signal reset : std_logic :='0';
signal acumulator: unsigned(63 downto 0);
    signal debug_info: std_logic_vector(447 downto 0);
signal accreset: std_logic;

begin


mcu : entity riscv.MCU2(Behavioral) port map( 
clock=>sysClk, 
reset=>reset,
--instruction_in=>std_logic_vector(acumulator(31 downto 0)),
debug_immediate=>debug_info(447 downto 416),
debug_regfile_x1_output=>debug_info(415 downto 384),
debug_regfile_x2_output=>debug_info(383 downto 352),
debug_ALU_output=>debug_info(351 downto 320),
debug_ALU_input_0=>debug_info(319 downto 288),
debug_ALU_input_1=>debug_info(287 downto 256),
debug_ALU_output_MEM_WB=>debug_info(255 downto 224),
debug_ALU_output_EX_MEM=>debug_info(223 downto 192),
debug_register_file_output_0=>debug_info(191 downto 160),
debug_register_file_output_1=>debug_info(159 downto 128),
debug_register_file_output_0_id_ex=>debug_info(127 downto 96),
debug_register_file_output_1_id_ex=>debug_info(95 downto 64),
debug_instruction=>debug_info(63 downto 32),
debug_regfile_x31_output=>debug_info(31 downto 0));

accumulator1 : entity riscvi.Acumulator(Behavioral) port map( clock=>sysClk, reset=>accreset, number=>acumulator);
slider_mux : entity riscvi.Slider_mux(Behavioral) port map( toSlide=>debug_info, selector=>std_logic_vector(acumulator), output=>led );

accreset <= '1' when acumulator =x"00000000000001BF" else '0';

end Behavioral;
