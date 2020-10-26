----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2020 04:09:13 PM
-- Design Name: 
-- Module Name: ID_STAGE - Behavioral
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
library riscv;
use riscv.mux_3_1;

--Uncomment the following library declaration if instantiating
--any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WB_STAGE is
 Port (
  --SYSTEM SIGNALS
  clock,reset: in std_logic;
  
  --OUTPUTS
  mux_0_output : out std_logic_vector(31 downto 0);
  
  --MEM SIGNALS
  mux0_sel_MEM_WB : in std_logic_vector(1 downto 0);
  ALU_output_MEM_WB : in std_logic_vector(31 downto 0);
  datamem_output_MEM_WB : in std_logic_vector(31 downto 0);
  instruction_address_MEM_WB : in std_logic_vector(31 downto 0)
  
   );
end WB_STAGE;

architecture Behavioral of WB_STAGE is
 signal  mux_0_in_2 : std_logic_vector(31 downto 0);
begin

    mux_0_in_2<=std_logic_vector(unsigned(instruction_address_MEM_WB) + 4);

mux_0 : entity riscv.mux_3_1 port map(
	selection=>mux0_sel_MEM_WB, 
	input_0=>ALU_output_MEM_WB, 
	input_1=>datamem_output_MEM_WB, 
	input_2=>mux_0_in_2, 
	output_0=>mux_0_output);

end Behavioral;
