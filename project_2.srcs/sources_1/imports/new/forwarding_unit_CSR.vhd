----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2020 01:27:12 AM
-- Design Name: 
-- Module Name: forwarding_unit_CSR - Behavioral
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

entity forwarding_unit_CSR is
	port (
		reg_file_read_address_0_ID_EXE : in std_logic_vector(11 downto 0);

		reg_file_write_EX_MEM : in std_logic;
		reg_file_write_address_EX_MEM : in std_logic_vector(11 downto 0);

		reg_file_write_MEM_WB : in std_logic;
		reg_file_write_address_MEM_WB : in std_logic_vector(11 downto 0);

		forward_mux_0_control : out std_logic_vector(1 downto 0)
	);
end forwarding_unit_CSR;

architecture structural of forwarding_unit_CSR is

	signal internal_mux_0_control : std_logic_vector(1 downto 0) := "00";
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of structural : architecture is "yes";

begin		  	   
	--forward_0 : process (reg_file_read_address_0_OUTE, reg_file_write_EX_MEM, reg_file_write_MEM_WB, reg_file_write_address_EX_MEM, reg_file_write_address_MEM_WB, mux_0_sel_EX_MEM, mux_0_sel_MEM_WB)
	--begin
	--	if (mux_0_sel_EX_MEM = "00") and (reg_file_write_EX_MEM = '1') and (reg_file_read_address_0_OUTE = reg_file_write_address_EX_MEM) and (reg_file_read_address_0_OUTE /= "00000") then
	--		internal_mux_0_control <= "001";
    --
	--	elsif (mux_0_sel_EX_MEM = "01") and (reg_file_write_EX_MEM = '1') and (reg_file_read_address_0_OUTE = reg_file_write_address_EX_MEM) and (reg_file_read_address_0_OUTE /= "00000") then
	--		internal_mux_0_control <= "010";
    --
	--	elsif (mux_0_sel_MEM_WB = "00") and (reg_file_write_MEM_WB = '1') and (reg_file_read_address_0_OUTE = reg_file_write_address_MEM_WB) and (reg_file_read_address_0_OUTE /= "00000") then
	--		internal_mux_0_control <= "011";
    --
	--	elsif (mux_0_sel_MEM_WB = "01") and (reg_file_write_MEM_WB = '1') and (reg_file_read_address_0_OUTE = reg_file_write_address_MEM_WB) and (reg_file_read_address_0_OUTE /= "00000") then
	--		internal_mux_0_control <= "100";
    --
	--	else
	--		internal_mux_0_control <= "000";
    --
	--	end if;
	--end process;



	--forward_1 : process (reg_file_read_address_1_OUTE, reg_file_write_EX_MEM, reg_file_write_MEM_WB, reg_file_write_address_EX_MEM, reg_file_write_address_MEM_WB, mux_0_sel_EX_MEM, mux_0_sel_MEM_WB)
	--begin
	--	if (mux_0_sel_EX_MEM = "00") and (reg_file_write_EX_MEM = '1') and (reg_file_read_address_1_OUTE = reg_file_write_address_EX_MEM) and (reg_file_read_address_1_OUTE /= "00000") then
	--		internal_mux_1_control <= "001";
    --
	--	elsif (mux_0_sel_EX_MEM = "01") and (reg_file_write_EX_MEM = '1') and (reg_file_read_address_1_OUTE = reg_file_write_address_EX_MEM) and (reg_file_read_address_1_OUTE /= "00000") then
	--		internal_mux_1_control <= "010";
    --
	--	elsif (mux_0_sel_MEM_WB = "00") and (reg_file_write_MEM_WB = '1') and (reg_file_read_address_1_OUTE = reg_file_write_address_MEM_WB) and (reg_file_read_address_1_OUTE /= "00000") then
	--		internal_mux_1_control <= "011";
    --
	--	elsif (mux_0_sel_MEM_WB = "01") and (reg_file_write_MEM_WB = '1') and (reg_file_read_address_1_OUTE = reg_file_write_address_MEM_WB) and (reg_file_read_address_1_OUTE /= "00000") then
	--		internal_mux_1_control <= "100";
    --
	--	else
	--		internal_mux_1_control <= "000";
    --
	--	end if;
	--end process;
	
	internal_mux_0_control<=
	"01" when (
	(reg_file_write_EX_MEM = '1') and 
	(reg_file_read_address_0_ID_EXE = reg_file_write_address_EX_MEM) and 
	(reg_file_read_address_0_ID_EXE /= "00000")
	) else
	"10" when (
	(reg_file_write_MEM_WB = '1') and 
	(reg_file_read_address_0_ID_EXE = reg_file_write_address_MEM_WB) and 
	(reg_file_read_address_0_ID_EXE /= "00000")
	) else
	"00" ;
	forward_mux_0_control <= internal_mux_0_control;

end architecture structural;