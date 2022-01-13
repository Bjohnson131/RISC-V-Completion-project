----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2021 10:02:16 PM
-- Design Name: 
-- Module Name: Progmem_fibonacci - Behavioral
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
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
library riscv;
use riscv.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Progmem_fibonacci is
	port (
		clock : in std_logic;
		byte_address : in std_logic_vector(31 downto 0);
		output_data : out std_logic_vector(31 downto 0)
	);
end Progmem_fibonacci;

architecture Behavioral of Progmem_fibonacci is
	signal data_next : std_logic_vector(31 downto 0) := X"00000000";
begin		
    
    process(clock)
    begin
    if (rising_edge(clock)) then
        output_data <= data_next;
    end if;
    end process;

    with byte_address select
    data_next <=
    0x"00000317" when x"00010000",
    0x"00830067" when x"00010004",
    0x"00000293" when x"00010008",
    0x"00100313" when x"0001000c",
    0x"00400513" when x"00010010",
    0x"00000597" when x"00010014",
    0x"07c58593" when x"00010018",
    0x"00000073" when x"0001001c",
    0x"00500513" when x"00010020",
    0x"00000073" when x"00010024",
    0x"00050e13" when x"00010028",
    0x"00b00513" when x"0001002c",
    0x"00a00593" when x"00010030",
    0x"00000073" when x"00010034",
    0x"00400513" when x"00010038",
    0x"00000597" when x"0001003c",
    0x"06c58593" when x"00010040",
    0x"00000073" when x"00010044",
    0x"00100513" when x"00010048",
    0x"000e0593" when x"0001004c",
    0x"00000073" when x"00010050",
    0x"000e0c63" when x"00010054",
    0x"005303b3" when x"00010058",
    0x"00030293" when x"0001005c",
    0x"00038313" when x"00010060",
    0x"fffe0e13" when x"00010064",
    0x"fedff06f" when x"00010068",
    0x"00400513" when x"0001006c",
    0x"00000597" when x"00010070",
    0x"03d58593" when x"00010074",
    0x"00000073" when x"00010078",
    0x"00100513" when x"0001007c",
    0x"00028593" when x"00010080",
    0x"00000073" when x"00010084",
    0x"00a00513" when x"00010088",
    0x"00000073" when x"0001008c",
    x"00000000" when others; 
    
end Behavioral;
