----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2020 02:56:18 PM
-- Design Name: 
-- Module Name: TEST_TOP_COUNTERS - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TEST_TOP_COUNTERS is
 Port ( 
 
 led: out std_logic_vector(7 downto 0);
 sw: in std_logic_vector(7 downto 0);
 btn_c: in std_logic;
 btn_t: in std_logic;
 btn_b: in std_logic;
 btn_r: in std_logic;
 btn_l: in std_logic;
 sysClk: in std_logic);
end TEST_TOP_COUNTERS;

architecture Behavioral of TEST_TOP_COUNTERS is
 signal btn_c_out,btn_t_out,btn_b_out,btn_l_out,btn_r_out : std_logic;
 signal counting_clock : std_logic;
 signal data_output : std_logic_vector(31 downto 0);
begin

--led(0) <= btn_c_out;
--led(1) <= btn_t_out;
--led(2) <= btn_b_out;
--led(3) <= btn_l_out;
--led(4) <= btn_r_out;

Dbce_c : entity riscv.DeBounce(behav) port map(
Clock => sysClk,
Reset => '0',
button_in => btn_c,
pulse_out => btn_c_out
); 

Dbce_t : entity riscv.DeBounce(behav) port map(
Clock => sysClk,
Reset => '0',
button_in => btn_t,
pulse_out => btn_t_out
); 

Dbce_b : entity riscv.DeBounce(behav) port map(
Clock => sysClk,
Reset => '0',
button_in => btn_b,
pulse_out => btn_b_out
); 

Dbce_l : entity riscv.DeBounce(behav) port map(
Clock => sysClk,
Reset => '0',
button_in => btn_l,
pulse_out => btn_l_out
); 

Dbce_r : entity riscv.DeBounce(behav) port map(
Clock => sysClk,
Reset => '0',
button_in => btn_r,
pulse_out => btn_r_out
); 

SEL_CLK_DIV: entity riscv.SEL_CLK_DIV(Behavioral) port map(
clk => sysClk,
DIV_SEL => sw(4 downto 0),
COUT => counting_clock
);

HPMs: entity riscv.CSR_hpmcounter(Behavioral) port map(
clk => counting_clock,
READ_ADDR_IN => "110000011011",
WRITE_ADDR_IN => "000000000000",
WRITE => '0',
D_IN => x"00000000",
D_OUT => data_output
);

led <= data_output(7 downto 0);

end Behavioral;
