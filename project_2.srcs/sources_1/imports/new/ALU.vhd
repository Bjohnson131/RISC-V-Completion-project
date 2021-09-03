library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port (
		input_0, input_1 	: in std_logic_vector(31 downto 0);
		operation 				: in std_logic_vector(3 downto 0);
		branch 						: in std_logic;
		branch_control 		: in std_logic_vector(2 downto 0);
		branch_response 	: out std_logic;
		output 						: out std_logic_vector(31 downto 0) :=  x"00000000"
	);
end entity ALU;

architecture Behavioral of ALU is
	constant zeros : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";
	signal result_temp : std_logic_vector(32 downto 0) := "000000000000000000000000000000000";
begin

		-- TODO-11: invert logic such that we don't have to use branch=0 on every line
		-- DONE-11: This is a theoretical solution, but we need a testbed.
    output <= 
    X"00000000"																																			when (branch = '1') else
    result_temp(31 downto 0)                                                        when (operation = "0000" OR operation = "1000")else
    std_logic_vector(shift_left(unsigned(input_0), to_integer(unsigned(input_1))))  when (operation = "0001")else
    std_logic_vector(shift_right(unsigned(input_0), to_integer(unsigned(input_1)))) when (operation = "0101")else
    std_logic_vector(shift_right(signed(input_0), to_integer(unsigned(input_1))))   when (operation = "1101")else
    X"00000001"                                                                     when ((operation = "0011" OR operation = "0010") and result_temp(32) = '1')else
    X"00000000"                                                                     when ((operation = "0011" OR operation = "0010") and result_temp(32) = '0')else
    input_0 xor input_1                                                             when (operation = "0100")else
    input_0 or input_1                                                              when (operation = "0110")else
    input_0 and input_1                                                             when (operation = "0111")else
    input_0 nand input_1                                                            when (operation = "1001")else
    input_1                                                                         when (operation = "1011")else
    result_temp(31 downto 0);

    -- TODO-14: find out why we're duplicating the last bit for these signed operations..
    -- Do we need to extend the sign bit? Are we modifying the default behavior?
    result_temp <=
    std_logic_vector(signed(input_0(31) & input_0) + signed(input_1(31) & input_1)) when (branch = '0' and operation = "0000")else
    std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1)) when (branch = '0' and operation = "1000")else
    std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1)) when (branch = '0' and operation = "0010")else
    std_logic_vector(unsigned('0' & input_0) - unsigned('0' & input_1))             when (branch = '0' and operation = "0011")else
    zeros				                                             												when (branch = '0') else
    std_logic_vector(signed(input_0(31) & input_0) - signed(input_1(31) & input_1)) when (branch = '1' and (branch_control = "000" or branch_control = "001" or branch_control = "100" or branch_control = "101"))else
    std_logic_vector(unsigned('0' & input_0) - unsigned('0' & input_1)) 						when (branch = '1' and (branch_control = "110" or branch_control = "111"))else
    zeros;

    branch_response <=
    '1' when (
    (	branch_control 	= "000" and      result_temp = zeros) 														or
    (	branch_control 	= "001" and not (result_temp = zeros)) 														or
    ((branch_control 	= "100" or branch_control = "110") and (result_temp(32) = '1')) 	or
    ((branch_control 	= "101" or branch_control = "111") and (result_temp(32) = '0'))) 	else '0';

end architecture Behavioral;