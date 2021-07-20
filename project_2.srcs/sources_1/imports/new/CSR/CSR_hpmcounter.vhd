----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2020 03:04:18 PM
-- Design Name: 
-- Module Name: CSR_hpmcounter - Behavioral
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
library riscv;
use riscv.CSR_TIMER_ARRAY;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity CSR_hpmcounter is
    Port ( READ_ADDR_IN, WRITE_ADDR_IN : in STD_LOGIC_VECTOR (11 downto 0);
           clk,WRITE : in STD_LOGIC;
           D_OUT : out STD_LOGIC_VECTOR (31 downto 0);
           D_IN : in STD_LOGIC_VECTOR (31 downto 0));
end CSR_hpmcounter;

architecture Behavioral of CSR_hpmcounter is
 signal sel_low_read, sel_high_read,sel_low_write, sel_high_write : std_logic_vector(4 downto 0) := "00000";
 signal prev_addr,prev_addr_next : std_logic_vector(11 downto 0) := "000000000000";
 signal write_low, write_high, match_low_read, match_high_read, match_low_write, match_high_write: std_logic := '0';
 signal match_freeze_val: std_logic := '0';
 signal OUT_LOW, OUT_HIGH: std_logic_vector(31 downto 0) := x"00000000";
 signal freeze_val,freeze_val_next: std_logic_vector(31 downto 0) := x"00000000";
begin

D_OUT <= 
freeze_val when (match_freeze_val = '1') else
OUT_LOW when match_low_read = '1' else
OUT_HIGH when match_high_read = '1' else
x"00000000";

--When the address matches either the high of the low component (corresponding)
match_freeze_val <= 
'1' when ((prev_addr xor "000010000000") = READ_ADDR_IN) else '0';

freeze_val_next <= OUT_LOW when( match_low_read = '1' ) else OUT_HIGH;

process(clk)
begin
    if(rising_edge(clk)) then
        prev_addr_next <= READ_ADDR_IN;
        prev_addr <= prev_addr_next;
        freeze_val <= freeze_val_next;
    end if;
end process;



with READ_ADDR_IN(11 downto 5) select
match_low_read <= 
'1' when "1100000",
'0' when others;

with READ_ADDR_IN(11 downto 5) select
match_high_read <= 
'1' when "1100100",
'0' when others;

with WRITE_ADDR_IN(11 downto 5) select
match_low_write <= 
'1' when "1100000",
'0' when others;

with WRITE_ADDR_IN(11 downto 5) select
match_high_write <= 
'1' when "1100100",
'0' when others;

write_low <= match_low_write AND WRITE;
write_high <= match_high_write AND WRITE;

sel_low_read <= READ_ADDR_IN(4 downto 0);
sel_high_read <= READ_ADDR_IN(4 downto 0);

sel_low_write <= write_ADDR_IN(4 downto 0);
sel_high_write <= write_ADDR_IN(4 downto 0);

Timers: entity riscv.CSR_TIMER_ARRAY(Behavioral) port map(
sel_low_read => sel_low_read,
sel_high_read => sel_high_read,
sel_low_write => sel_low_write,
sel_high_write => sel_high_write,
EN_WRITE_LOW => write_low,
EN_WRITE_HIGH => write_high,
clk => clk, 
D_OUT_LOW => OUT_LOW,
D_OUT_HIGH => OUT_HIGH,
D_IN => D_IN
);

end Behavioral;
