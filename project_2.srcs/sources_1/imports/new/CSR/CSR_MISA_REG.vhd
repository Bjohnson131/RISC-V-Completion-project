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

entity CSR_MISA_REG is
  Port (

  --REGISTER SIGNALS
  clk : in std_logic;
  write_val : in std_logic_vector(31 downto 0);
  write_in : in std_logic;
  val_out : out std_logic_vector(31 downto 0);

  --CONTROL SIGNALS
  I_ISA_EN : out std_logic
  );
end CSR_MISA_REG;

architecture Behavioral of CSR_MISA_REG is
    signal value,value_next: std_logic_vector(31 downto 0) := "01000000000101000000000100000000";
    --                                                               ZYXWVUTSRQPONMLKJIHGFEDCBA
begin
    val_out <= value;

    -- SR ---
    -- for the sake of readability it's better practice to use decimal/hex
    -- values for constants than binary. Let the synthesis tool worry about converting
    -- to binary.
    -- SR ---

    value_next <=
    "01000000000101000000000100000000" when( write_in = '1' ) else
    value;

    I_ISA_EN <= value(8);

    process(clk)
    begin
        if(rising_edge(clk)) then
        value <= value_next;
        end if;
    end process;

end Behavioral;
