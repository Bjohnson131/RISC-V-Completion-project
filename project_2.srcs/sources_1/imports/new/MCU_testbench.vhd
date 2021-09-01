----------------------------------------------------------------------------------
-- Company:
-- Engineer: Stacey Rieck
--
-- Create Date: 04/25/2020 12:50:34 AM
-- Design Name:
-- Module Name: MCU_testbench
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
-- Stestbench for simulation testing both RISCV_Black_Box_Translator and microcontroller
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library riscv;
use riscv.all;

-- SR ---
-- Testbench entity empty
-- SR ---
entity MCU_testbench is
end MCU_testbench;

architecture Behavioral of MCU_testbench is

  signal sysClk : std_logic;
  signal led: std_logic_vector(7 downto 0);
  signal reset : std_logic;

begin

  reset <= '0';

  -- SR ---
  -- Only valid syntax for simulation
  -- This won't work for synthesis
  -- SR ---

  sysClk <=  '1' after 0.5 ns when sysClk = '0' else
             '0' after 0.5 ns when sysClk = '1';

  RISCV_Black_Box_Translator_i : entity riscv.RISCV_Black_Box_Translator(Behavioral) port map(
    sysClk=>sysClk,
    led=>led
    );

  microcontroller_i : entity riscv.microcontroller(structural) port map(
    clock=>sysClk,
    reset=>reset
    );



end Behavioral;
