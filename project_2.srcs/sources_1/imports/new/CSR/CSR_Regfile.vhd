----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2020 01:45:09 AM
-- Design Name: 
-- Module Name: CSR_Regfile - Behavioral
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
use riscv.all;			   
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CSR_Regfile is
	port (
	
	    --REG SIGNALS
		write_data : in std_logic_vector(31 downto 0);
		write_address : in std_logic_vector(11 downto 0);
		write_state : in std_logic_vector(1 downto 0);
		read_address_0 : in std_logic_vector(11 downto 0);
		read_state : in std_logic_vector(1 downto 0);
		write_control, clock, clear : in std_logic;
		output_data_0 : out std_logic_vector(31 downto 0);
		
		--Write_address_1,Write_address_2,Write_address_3 : in std_logic_vector(11 downto 0);
		--Write_val_1,Write_val_2,Write_val_3 : in std_logic_vector(31 downto 0);
		
		--CONTROL SIGNALS
        I_ISA_EN : out std_logic
		
	);
end entity CSR_Regfile;

architecture Behavioral of CSR_Regfile is
    --HPM_SIG
    signal HPM_OUT : std_logic_vector(31 downto 0);
    signal read_address_uns : unsigned(11 downto 0);
    signal write_address_HPM : std_logic_vector(11 downto 0);
    
    --MISA_SIG
    signal MISA_WRITE : std_logic;
    signal MISA_OUT : std_logic_vector(31 downto 0);
    
    --MVENDORID SIG
    signal MVENDORID_OUT : std_logic_vector(31 downto 0);
    
    --MARCHID SIG
    signal MARCHID_OUT : std_logic_vector(31 downto 0);
    
    --MIMPID SIG
    signal MIMPID_OUT : std_logic_vector(31 downto 0);
    
    
begin
read_address_uns <= unsigned(read_address_0);

output_data_0 <= 
HPM_OUT when((read_address_uns <= x"C1F" and read_address_uns >= x"C00") or (read_address_uns <= x"C9F" and read_address_uns >= x"C80"))else
MISA_OUT when(read_address_0 = x"301" and read_state = "1-") else
MVENDORID_OUT when(read_address_0 = x"F11" and read_state = "1-") else
MARCHID_OUT when(read_address_0 = x"F12" and read_state = "1-") else
MIMPID_OUT when(read_address_0 = x"F13" and read_state = "1-") else
x"00000000";


--Hardware Performance Monitoring 

write_address_HPM <=
write_address when (write_state = "01" or write_state = "10" or write_state = "11")else
x"FFF";

HPMs: entity riscv.CSR_hpmcounter(Behavioral) port map(
clk => clock,
READ_ADDR_IN => read_address_0,
WRITE_ADDR_IN => write_address_HPM,
WRITE => write_control,
D_IN => write_data,
D_OUT => HPM_OUT
);

MISA_WRITE <=
'1' when ( write_address = x"301" and write_control = '1' and write_state = "1-")else
'0';

-- MISA Reg
MISA: entity riscv.CSR_MISA_REG(Behavioral) port map(
  --REGISTER SIGNALS
  clk => clock,
  write_val => write_data,
  write_in => MISA_WRITE,
  val_out => MISA_OUT,
  --CONTROL SIGNALS
  I_ISA_EN => I_ISA_EN
);


MVENDORID:  entity riscv.CSR_MVENDORID_REG(Behavioral) port map(
  --REGISTER SIGNALS
  val_out => MVENDORID_OUT
);

MARCHID:  entity riscv.CSR_MARCHID_REG(Behavioral) port map(
  --REGISTER SIGNALS
  val_out => MARCHID_OUT
);

MIMPID:  entity riscv.CSR_MARCHID_REG(Behavioral) port map(
  --REGISTER SIGNALS
  val_out => MIMPID_OUT
);


end architecture Behavioral;
