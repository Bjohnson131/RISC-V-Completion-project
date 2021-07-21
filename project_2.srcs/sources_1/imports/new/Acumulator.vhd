----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 04/25/2020 12:29:06 PM
-- Design Name:
-- Module Name: Acumulator - Behavioral
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Acumulator is
  port (clock  : in  std_logic;
        reset  : in  std_logic;
        number : out unsigned(63 downto 0));
end Acumulator;

architecture Behavioral of Acumulator is
  signal number_next : unsigned(63 downto 0);
  signal number_out  : unsigned(63 downto 0) := x"0000000000000000";
begin

  number_next <= number_out+1;

  -- SR ---
  -- not good practice to have additional signals in process sensitivity list
  -- in addition to clock.
  -- Either the process has clock and hence it is a synchronus process
  -- Or it has no clock and only other signals and is an asynchronus process.
  -- Not good practise to mix and match
  -- SR ---

--process (clock, number_next)
  process (clock)
  begin
    if(rising_edge(clock))then
      if(reset = '0') then
        number_out <= number_next;
      elsif(reset = '1') then
        number_out <= x"0000000000000000";
      end if;
    end if;
  end process;

  number <= number_out;

end Behavioral;
