----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2020 10:53:54 PM
-- Design Name: 
-- Module Name: INTERRUPT_CONTROL_UNIT - Behavioral
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

entity INTERRUPT_CONTROL_UNIT is
  Port ( 
  clock: in std_logic;
  
  --sources
  CURRENT_PRIVELEGE_LEVEL: in std_logic_vector(1 downto 0);
  USER_INTERRUPT_ENABLE: out std_logic;
  SYSTEM_INTERRUPT_ENABLE: out std_logic;
  MACHINE_INTERRUPT_ENABLE: out std_logic;
  
  --CONTROLS
   USER_INTERRUPT_CAUGHT: out std_logic;
   SYSTEM_INTERRUPT_CAUGHT: out std_logic;
   MACHINE_INTERRUPT_CAUGHT: out std_logic
  );
end INTERRUPT_CONTROL_UNIT;

architecture Behavioral of INTERRUPT_CONTROL_UNIT is

begin


end Behavioral;
