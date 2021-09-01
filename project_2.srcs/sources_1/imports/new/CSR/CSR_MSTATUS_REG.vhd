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

entity CSR_MSTATUS_REG is
  Port (

  --REGISTER SIGNALS
  clk : in std_logic;
  write_val : in std_logic_vector(31 downto 0);
  write_in : in std_logic;
  val_out : out std_logic_vector(31 downto 0);

  --INTERRUPT SIGNALS
  USER_INTERRUPT_CAUGHT: in std_logic;
  SYSTEM_INTERRUPT_CAUGHT: in std_logic;
  MACHINE_INTERRUPT_CAUGHT: in std_logic;
  USER_INTERRUPT_RUNNING : in std_logic;
  SYSTEM_INTERRUPT_RUNNING : in std_logic;
  MACHINE_INTERRUPT_RUNNING : in std_logic;
  USER_INTERRUPT_ENABLE: out std_logic;
  SYSTEM_INTERRUPT_ENABLE: out std_logic;
  MACHINE_INTERRUPT_ENABLE: out std_logic;

  --CONTROL SIGNALS
  CURRENT_PRIVELEGE_LEVEL: in std_logic_vector(1 downto 0)

  );
end CSR_MSTATUS_REG;

architecture Behavioral of CSR_MSTATUS_REG is
    signal value,value_next,value_parted: std_logic_vector(31 downto 0) := X"00000000";
    signal INTERRUPT_CAUGHT,INTERRUPT_RUNNING: std_logic;

begin

    val_out <= value;
    USER_INTERRUPT_ENABLE <= value(0);
    SYSTEM_INTERRUPT_ENABLE <= value(1);
    MACHINE_INTERRUPT_ENABLE <= value(3);
    INTERRUPT_CAUGHT <= USER_INTERRUPT_CAUGHT or SYSTEM_INTERRUPT_CAUGHT or MACHINE_INTERRUPT_CAUGHT;
    INTERRUPT_RUNNING <= USER_INTERRUPT_RUNNING or SYSTEM_INTERRUPT_RUNNING or MACHINE_INTERRUPT_RUNNING;

    value_next <=
    write_val          when( write_in = '1' ) else
    value_parted       when( INTERRUPT_CAUGHT = '1') else
    value;

    value_parted(0) <= '0'             when(USER_INTERRUPT_CAUGHT = '1' and INTERRUPT_RUNNING = '1') else value(0);
    value_parted(4) <= value(0)        when(USER_INTERRUPT_CAUGHT = '1' and INTERRUPT_RUNNING = '1') else value(4);
    value_parted(1) <= '0'             when(SYSTEM_INTERRUPT_CAUGHT = '1' and INTERRUPT_RUNNING = '1') else value(1);
    value_parted(5) <= value(1)        when(SYSTEM_INTERRUPT_CAUGHT = '1' and INTERRUPT_RUNNING = '1') else value(5);
    value_parted(3) <= '0'             when(MACHINE_INTERRUPT_RUNNING = '1' and INTERRUPT_RUNNING = '1') else value(3);
    value_parted(7) <= value(3)        when(MACHINE_INTERRUPT_RUNNING = '1' and INTERRUPT_RUNNING = '1') else value(7);
    value_parted(8) <= '1'             when(SYSTEM_INTERRUPT_CAUGHT = '1' and SYSTEM_INTERRUPT_RUNNING = '1') else
                       '0'             when(SYSTEM_INTERRUPT_CAUGHT = '1' and USER_INTERRUPT_RUNNING = '1') else value(8);
    value_parted(12 downto 11) <= "00" when(MACHINE_INTERRUPT_CAUGHT = '1' and USER_INTERRUPT_RUNNING = '1') else
                                  "01" when(MACHINE_INTERRUPT_CAUGHT = '1' and SYSTEM_INTERRUPT_RUNNING = '1') else
                                  "10" when(MACHINE_INTERRUPT_CAUGHT = '1' and MACHINE_INTERRUPT_RUNNING = '1') else value(12 downto 11);


    process(clk)
    begin
        if(rising_edge(clk)) then
        value <= value_next;
        end if;
    end process;

end Behavioral;
