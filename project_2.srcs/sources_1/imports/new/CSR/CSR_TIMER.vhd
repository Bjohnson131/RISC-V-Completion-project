----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 05:31:13 PM
-- Design Name: 
-- Module Name: CSR_TIMER - Behavioral
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

entity CSR_TIMER is
    Port ( clk : in STD_LOGIC;
           DATA_IN : in STD_LOGIC_VECTOR (31 downto 0);
           EN_WRITE_LOW : in STD_LOGIC;
           EN_WRITE_HIGH : in STD_LOGIC;
           EN_OUT_LOW : in STD_LOGIC;
           EN_OUT_HIGH : in STD_LOGIC;
           DATA_LOW_OUT : out STD_LOGIC_VECTOR (31 downto 0);
           DATA_HIGH_OUT : out STD_LOGIC_VECTOR (31 downto 0));
end CSR_TIMER;

architecture Behavioral of CSR_TIMER is
    signal clock,clock_next : unsigned(63 downto 0) := x"0000000000000000";
begin
    clock_next <=
    clock(63 downto 32) & unsigned(DATA_IN) when (EN_WRITE_LOW = '1' and EN_WRITE_HIGH = '0') else
    unsigned(DATA_IN) & clock(31 downto 0)  when (EN_WRITE_LOW = '0' and EN_WRITE_HIGH = '1') else
    clock+1;

    DATA_LOW_OUT <=
    std_logic_vector(clock(31 downto 0)) when ( EN_OUT_LOW = '1' ) else
    x"00000000";

    DATA_HIGH_OUT <=
    std_logic_vector(clock(63 downto 32)) when ( EN_OUT_HIGH = '1' ) else
    x"00000000";

    process(clk)
    begin
        if(rising_edge(clk)) then
            clock<=clock_next;
        end if;
    end process;

end Behavioral;
