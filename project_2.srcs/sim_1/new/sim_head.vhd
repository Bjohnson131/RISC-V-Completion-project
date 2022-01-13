----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2021 09:58:12 PM
-- Design Name: 
-- Module Name: sim_head - Behavioral
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

entity sim_head is
 Port ( 
 led: out std_logic_vector(7 downto 0);
 sysClk: out std_logic);
end sim_head;

architecture Behavioral of sim_head is
signal clock: std_logic := '0';
begin

rvbb: entity riscv.RISCV_Black_Box_Translator(Behavioral) port map(
sysClk => clock,
led => led
);

sysClk <= clock;

process 
begin 
  clock <= '1';
  wait for 50ns;
  clock <= '0';
  wait for 50ns;
end process;

end Behavioral;
