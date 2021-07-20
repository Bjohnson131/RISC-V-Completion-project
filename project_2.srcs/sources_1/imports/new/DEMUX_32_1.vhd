----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2020 03:07:08 PM
-- Design Name: 
-- Module Name: DEMUX_32_1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DEMUX_32_1 is
    Port ( sel : in STD_LOGIC_VECTOR (4 downto 0);
           input : in STD_LOGIC;
           output_0 : out STD_LOGIC;
           output_1 : out STD_LOGIC;
           output_2 : out STD_LOGIC;
           output_3 : out STD_LOGIC;
           output_4 : out STD_LOGIC;
           output_5 : out STD_LOGIC;
           output_6 : out STD_LOGIC;
           output_7 : out STD_LOGIC;
           output_8 : out STD_LOGIC;
           output_9 : out STD_LOGIC;
           output_10 : out STD_LOGIC;
           output_11 : out STD_LOGIC;
           output_12 : out STD_LOGIC;
           output_13 : out STD_LOGIC;
           output_14 : out STD_LOGIC;
           output_15 : out STD_LOGIC;
           output_16 : out STD_LOGIC;
           output_17 : out STD_LOGIC;
           output_18 : out STD_LOGIC;
           output_19 : out STD_LOGIC;
           output_20 : out STD_LOGIC;
           output_21 : out STD_LOGIC;
           output_22 : out STD_LOGIC;
           output_23 : out STD_LOGIC;
           output_24 : out STD_LOGIC;
           output_25 : out STD_LOGIC;
           output_26 : out STD_LOGIC;
           output_27 : out STD_LOGIC;
           output_28 : out STD_LOGIC;
           output_29 : out STD_LOGIC;
           output_30 : out STD_LOGIC;
           output_31 : out STD_LOGIC
);
end DEMUX_32_1;

architecture Behavioral of DEMUX_32_1 is

begin
output_0 <= input when ( sel = "00000" ) else '0'; 
output_1 <= input when ( sel = "00001" ) else '0'; 
output_2 <= input when ( sel = "00010" ) else '0'; 
output_3 <= input when ( sel = "00011" ) else '0'; 
output_4 <= input when ( sel = "00100" ) else '0'; 
output_5 <= input when ( sel = "00101" ) else '0'; 
output_6 <= input when ( sel = "00110" ) else '0'; 
output_7 <= input when ( sel = "00111" ) else '0'; 
output_8 <= input when ( sel = "01000" ) else '0'; 
output_9 <= input when ( sel = "01001" ) else '0'; 
output_10 <= input when ( sel = "01010" ) else '0'; 
output_11 <= input when ( sel = "01011" ) else '0'; 
output_12 <= input when ( sel = "01100" ) else '0'; 
output_13 <= input when ( sel = "01101" ) else '0'; 
output_14 <= input when ( sel = "01110" ) else '0'; 
output_15 <= input when ( sel = "01111" ) else '0'; 
output_16 <= input when ( sel = "10000" ) else '0'; 
output_17 <= input when ( sel = "10001" ) else '0'; 
output_18 <= input when ( sel = "10010" ) else '0'; 
output_19 <= input when ( sel = "10011" ) else '0'; 
output_20 <= input when ( sel = "10100" ) else '0'; 
output_21 <= input when ( sel = "10101" ) else '0'; 
output_22 <= input when ( sel = "10110" ) else '0'; 
output_23 <= input when ( sel = "10111" ) else '0'; 
output_24 <= input when ( sel = "11000" ) else '0'; 
output_25 <= input when ( sel = "11001" ) else '0'; 
output_26 <= input when ( sel = "11010" ) else '0'; 
output_27 <= input when ( sel = "11011" ) else '0'; 
output_28 <= input when ( sel = "11100" ) else '0'; 
output_29 <= input when ( sel = "11101" ) else '0'; 
output_30 <= input when ( sel = "11110" ) else '0'; 
output_31 <= input when ( sel = "11111" ) else '0'; 

end Behavioral;
