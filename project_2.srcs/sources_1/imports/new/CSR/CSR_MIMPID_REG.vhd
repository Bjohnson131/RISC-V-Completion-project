----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2020 02:01:48 PM
-- Design Name: 
-- Module Name: CSR_MISA_REG - Behavioral
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
								

entity CSR_MIMPID_REG is
  Port ( 
  
  val_out : out std_logic_vector(31 downto 0)  
  
  );
end CSR_MIMPID_REG;

architecture Behavioral of CSR_MARCHID_REG is
begin	
    val_out <= X"00000002";					 
end Behavioral;
