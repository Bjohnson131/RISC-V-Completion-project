----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 06:13:14 PM
-- Design Name: 
-- Module Name: SEL_CLK_DIV - Behavioral
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

entity SEL_CLK_DIV is
    Port ( clk : in STD_LOGIC;
           DIV_SEL : in STD_LOGIC_VECTOR (4 downto 0);
           COUT : out STD_LOGIC);
end SEL_CLK_DIV;

architecture Behavioral of SEL_CLK_DIV is
    signal count,count_next : unsigned(31 downto 0) := x"00000000";
begin
    
    process (clk)
    begin
    if(rising_edge(clk)) then
     count <= count_next;
    end if;
    end process;
    
count_next<=count+1;

cout <= 
count(0) when ( DIV_SEL = "00000" ) else
count(1) when ( DIV_SEL = "00001" ) else
count(2) when ( DIV_SEL = "00010" ) else
count(3) when ( DIV_SEL = "00011" ) else
count(4) when ( DIV_SEL = "00100" ) else
count(5) when ( DIV_SEL = "00101" ) else
count(6) when ( DIV_SEL = "00110" ) else
count(7) when ( DIV_SEL = "00111" ) else
count(8) when ( DIV_SEL = "01000" ) else
count(9) when ( DIV_SEL = "01001" ) else
count(10) when ( DIV_SEL = "01010" ) else
count(11) when ( DIV_SEL = "01011" ) else
count(12) when ( DIV_SEL = "01100" ) else
count(13) when ( DIV_SEL = "01101" ) else
count(14) when ( DIV_SEL = "01110" ) else
count(15) when ( DIV_SEL = "01111" ) else 
count(16) when ( DIV_SEL = "10000" ) else
count(17) when ( DIV_SEL = "10001" ) else
count(18) when ( DIV_SEL = "10010" ) else
count(19) when ( DIV_SEL = "10011" ) else
count(20) when ( DIV_SEL = "10100" ) else
count(21) when ( DIV_SEL = "10101" ) else
count(22) when ( DIV_SEL = "10110" ) else
count(23) when ( DIV_SEL = "10111" ) else
count(24) when ( DIV_SEL = "11000" ) else
count(25) when ( DIV_SEL = "11001" ) else
count(26) when ( DIV_SEL = "11010" ) else
count(27) when ( DIV_SEL = "11011" ) else
count(28) when ( DIV_SEL = "11100" ) else
count(29) when ( DIV_SEL = "11101" ) else
count(30) when ( DIV_SEL = "11110" ) else
count(31) when ( DIV_SEL = "11111" ) else '0';

end Behavioral;
