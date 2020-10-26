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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Acumulator is
  Port ( clock: in std_logic;
         reset: in std_logic;
         number: out unsigned(63 downto 0));
end Acumulator;

architecture Behavioral of Acumulator is
    signal number_next : unsigned(63 downto 0);
    signal number_out : unsigned(63 downto 0):=x"0000000000000000";
begin
    number_next<=number_out+1;
    number<=number_out;
    
process (clock, number_next)
begin
    if(rising_edge(clock))then
        if( reset = '0') then
            number_out <= number_next;
        elsif( reset = '1') then
            number_out <= x"0000000000000000";        
        end if;
    end if;
end process;

end Behavioral;
