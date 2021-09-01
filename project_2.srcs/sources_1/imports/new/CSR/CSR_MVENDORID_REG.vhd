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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CSR_MVENDORID_REG is
  Port (

  val_out : out std_logic_vector(31 downto 0)

  );
end CSR_MVENDORID_REG;

architecture Behavioral of CSR_MVENDORID_REG is
begin

    val_out <= X"F33D5EED";

end Behavioral;
