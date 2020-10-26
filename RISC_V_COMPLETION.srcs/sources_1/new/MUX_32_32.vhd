----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2020 02:44:06 PM
-- Design Name: 
-- Module Name: MUX_32_32 - Behavioral
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

entity MUX_32_32 is
  Port (
  sel : in std_logic_vector(4 downto 0);
  output_0 : out std_logic_vector(31 downto 0);
  input_0 : in std_logic_vector(31 downto 0);
  input_1 : in std_logic_vector(31 downto 0);
  input_2 : in std_logic_vector(31 downto 0);
  input_3 : in std_logic_vector(31 downto 0);
  input_4 : in std_logic_vector(31 downto 0);
  input_5 : in std_logic_vector(31 downto 0);
  input_6 : in std_logic_vector(31 downto 0);
  input_7 : in std_logic_vector(31 downto 0);
  input_8 : in std_logic_vector(31 downto 0);
  input_9 : in std_logic_vector(31 downto 0);
  input_10 : in std_logic_vector(31 downto 0);
  input_11 : in std_logic_vector(31 downto 0);
  input_12 : in std_logic_vector(31 downto 0);
  input_13 : in std_logic_vector(31 downto 0);
  input_14 : in std_logic_vector(31 downto 0);
  input_15 : in std_logic_vector(31 downto 0);
  input_16 : in std_logic_vector(31 downto 0);
  input_17 : in std_logic_vector(31 downto 0);
  input_18 : in std_logic_vector(31 downto 0);
  input_19 : in std_logic_vector(31 downto 0);
  input_20 : in std_logic_vector(31 downto 0);
  input_21 : in std_logic_vector(31 downto 0);
  input_22 : in std_logic_vector(31 downto 0);
  input_23 : in std_logic_vector(31 downto 0);
  input_24 : in std_logic_vector(31 downto 0);
  input_25 : in std_logic_vector(31 downto 0);
  input_26 : in std_logic_vector(31 downto 0);
  input_27 : in std_logic_vector(31 downto 0);
  input_28 : in std_logic_vector(31 downto 0);
  input_29 : in std_logic_vector(31 downto 0);
  input_30 : in std_logic_vector(31 downto 0);
  input_31 : in std_logic_vector(31 downto 0)
   );
end MUX_32_32;

architecture Behavioral of MUX_32_32 is

begin

output_0 <=
input_0 when (sel = "00000") else 
input_1 when (sel = "00001") else 
input_2 when (sel = "00010") else 
input_3 when (sel = "00011") else 
input_4 when (sel = "00100") else 
input_5 when (sel = "00101") else 
input_6 when (sel = "00110") else 
input_7 when (sel = "00111") else 
input_8 when (sel = "01000") else 
input_9 when (sel = "01001") else 
input_10 when (sel = "01010") else 
input_11 when (sel = "01011") else 
input_12 when (sel = "01100") else 
input_13 when (sel = "01101") else 
input_14 when (sel = "01110") else 
input_15 when (sel = "01111") else 
input_16 when (sel = "10000") else 
input_17 when (sel = "10001") else 
input_18 when (sel = "10010") else 
input_19 when (sel = "10011") else 
input_20 when (sel = "10100") else 
input_21 when (sel = "10101") else 
input_22 when (sel = "10110") else 
input_23 when (sel = "10111") else 
input_24 when (sel = "11000") else 
input_25 when (sel = "11001") else 
input_26 when (sel = "11010") else 
input_27 when (sel = "11011") else 
input_28 when (sel = "11100") else 
input_29 when (sel = "11101") else 
input_30 when (sel = "11110") else 
input_31 when (sel = "11111") else
x"00000000";

end Behavioral;
