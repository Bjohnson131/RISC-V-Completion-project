----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2020 06:08:14 PM
-- Design Name: 
-- Module Name: CSR_TIMER_ARRAY - Behavioral
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
use riscv.CSR_TIMER;
use riscv.MUX_32_32;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CSR_TIMER_ARRAY is
    Port ( sel_low_READ,sel_high_READ,sel_low_WRITE,sel_high_WRITE : in STD_LOGIC_VECTOR (4 downto 0);
           EN_WRITE_LOW,EN_WRITE_HIGH : in STD_LOGIC;
           clk : in STD_LOGIC;
           D_OUT_LOW, D_OUT_HIGH : out STD_LOGIC_VECTOR (31 downto 0);
           D_IN : in STD_LOGIC_VECTOR (31 downto 0));
end CSR_TIMER_ARRAY;

architecture Behavioral of CSR_TIMER_ARRAY is
    signal clk_0,ENA_OUT_LOW_0,ENA_OUT_HIGH_0,ENA_WRT_LOW_0,ENA_WRT_HIGH_0: std_logic  := '0';
    signal Dout_LOW_0,Dout_HIGH_0 : std_logic_vector(31 downto 0);

    signal clk_1,ENA_OUT_LOW_1,ENA_OUT_HIGH_1,ENA_WRT_LOW_1,ENA_WRT_HIGH_1: std_logic  := '0';
    signal Dout_LOW_1,Dout_HIGH_1 : std_logic_vector(31 downto 0);

    signal clk_2,ENA_OUT_LOW_2,ENA_OUT_HIGH_2,ENA_WRT_LOW_2,ENA_WRT_HIGH_2: std_logic  := '0';
    signal Dout_LOW_2,Dout_HIGH_2 : std_logic_vector(31 downto 0);

    signal clk_3,ENA_OUT_LOW_3,ENA_OUT_HIGH_3,ENA_WRT_LOW_3,ENA_WRT_HIGH_3: std_logic  := '0';
    signal Dout_LOW_3,Dout_HIGH_3 : std_logic_vector(31 downto 0);

    signal clk_4,ENA_OUT_LOW_4,ENA_OUT_HIGH_4,ENA_WRT_LOW_4,ENA_WRT_HIGH_4: std_logic  := '0';
    signal Dout_LOW_4,Dout_HIGH_4 : std_logic_vector(31 downto 0);

    signal clk_5,ENA_OUT_LOW_5,ENA_OUT_HIGH_5,ENA_WRT_LOW_5,ENA_WRT_HIGH_5: std_logic  := '0';
    signal Dout_LOW_5,Dout_HIGH_5 : std_logic_vector(31 downto 0);

    signal clk_6,ENA_OUT_LOW_6,ENA_OUT_HIGH_6,ENA_WRT_LOW_6,ENA_WRT_HIGH_6: std_logic  := '0';
    signal Dout_LOW_6,Dout_HIGH_6 : std_logic_vector(31 downto 0);

    signal clk_7,ENA_OUT_LOW_7,ENA_OUT_HIGH_7,ENA_WRT_LOW_7,ENA_WRT_HIGH_7: std_logic  := '0';
    signal Dout_LOW_7,Dout_HIGH_7 : std_logic_vector(31 downto 0);

    signal clk_8,ENA_OUT_LOW_8,ENA_OUT_HIGH_8,ENA_WRT_LOW_8,ENA_WRT_HIGH_8: std_logic  := '0';
    signal Dout_LOW_8,Dout_HIGH_8 : std_logic_vector(31 downto 0);

    signal clk_9,ENA_OUT_LOW_9,ENA_OUT_HIGH_9,ENA_WRT_LOW_9,ENA_WRT_HIGH_9: std_logic  := '0';
    signal Dout_LOW_9,Dout_HIGH_9 : std_logic_vector(31 downto 0);

    signal clk_10,ENA_OUT_LOW_10,ENA_OUT_HIGH_10,ENA_WRT_LOW_10,ENA_WRT_HIGH_10: std_logic  := '0';
    signal Dout_LOW_10,Dout_HIGH_10 : std_logic_vector(31 downto 0);

    signal clk_11,ENA_OUT_LOW_11,ENA_OUT_HIGH_11,ENA_WRT_LOW_11,ENA_WRT_HIGH_11: std_logic  := '0';
    signal Dout_LOW_11,Dout_HIGH_11 : std_logic_vector(31 downto 0);

    signal clk_12,ENA_OUT_LOW_12,ENA_OUT_HIGH_12,ENA_WRT_LOW_12,ENA_WRT_HIGH_12: std_logic  := '0';
    signal Dout_LOW_12,Dout_HIGH_12 : std_logic_vector(31 downto 0);

    signal clk_13,ENA_OUT_LOW_13,ENA_OUT_HIGH_13,ENA_WRT_LOW_13,ENA_WRT_HIGH_13: std_logic  := '0';
    signal Dout_LOW_13,Dout_HIGH_13 : std_logic_vector(31 downto 0);

    signal clk_14,ENA_OUT_LOW_14,ENA_OUT_HIGH_14,ENA_WRT_LOW_14,ENA_WRT_HIGH_14: std_logic  := '0';
    signal Dout_LOW_14,Dout_HIGH_14 : std_logic_vector(31 downto 0);

    signal clk_15,ENA_OUT_LOW_15,ENA_OUT_HIGH_15,ENA_WRT_LOW_15,ENA_WRT_HIGH_15: std_logic  := '0';
    signal Dout_LOW_15,Dout_HIGH_15 : std_logic_vector(31 downto 0);

    signal clk_16,ENA_OUT_LOW_16,ENA_OUT_HIGH_16,ENA_WRT_LOW_16,ENA_WRT_HIGH_16: std_logic  := '0';
    signal Dout_LOW_16,Dout_HIGH_16 : std_logic_vector(31 downto 0);

    signal clk_17,ENA_OUT_LOW_17,ENA_OUT_HIGH_17,ENA_WRT_LOW_17,ENA_WRT_HIGH_17: std_logic  := '0';
    signal Dout_LOW_17,Dout_HIGH_17 : std_logic_vector(31 downto 0);

    signal clk_18,ENA_OUT_LOW_18,ENA_OUT_HIGH_18,ENA_WRT_LOW_18,ENA_WRT_HIGH_18: std_logic  := '0';
    signal Dout_LOW_18,Dout_HIGH_18 : std_logic_vector(31 downto 0);

    signal clk_19,ENA_OUT_LOW_19,ENA_OUT_HIGH_19,ENA_WRT_LOW_19,ENA_WRT_HIGH_19: std_logic  := '0';
    signal Dout_LOW_19,Dout_HIGH_19 : std_logic_vector(31 downto 0);

    signal clk_20,ENA_OUT_LOW_20,ENA_OUT_HIGH_20,ENA_WRT_LOW_20,ENA_WRT_HIGH_20: std_logic  := '0';
    signal Dout_LOW_20,Dout_HIGH_20 : std_logic_vector(31 downto 0);

    signal clk_21,ENA_OUT_LOW_21,ENA_OUT_HIGH_21,ENA_WRT_LOW_21,ENA_WRT_HIGH_21: std_logic  := '0';
    signal Dout_LOW_21,Dout_HIGH_21 : std_logic_vector(31 downto 0);

    signal clk_22,ENA_OUT_LOW_22,ENA_OUT_HIGH_22,ENA_WRT_LOW_22,ENA_WRT_HIGH_22: std_logic  := '0';
    signal Dout_LOW_22,Dout_HIGH_22 : std_logic_vector(31 downto 0);

    signal clk_23,ENA_OUT_LOW_23,ENA_OUT_HIGH_23,ENA_WRT_LOW_23,ENA_WRT_HIGH_23: std_logic  := '0';
    signal Dout_LOW_23,Dout_HIGH_23 : std_logic_vector(31 downto 0);

    signal clk_24,ENA_OUT_LOW_24,ENA_OUT_HIGH_24,ENA_WRT_LOW_24,ENA_WRT_HIGH_24: std_logic  := '0';
    signal Dout_LOW_24,Dout_HIGH_24 : std_logic_vector(31 downto 0);

    signal clk_25,ENA_OUT_LOW_25,ENA_OUT_HIGH_25,ENA_WRT_LOW_25,ENA_WRT_HIGH_25: std_logic  := '0';
    signal Dout_LOW_25,Dout_HIGH_25 : std_logic_vector(31 downto 0);

    signal clk_26,ENA_OUT_LOW_26,ENA_OUT_HIGH_26,ENA_WRT_LOW_26,ENA_WRT_HIGH_26: std_logic  := '0';
    signal Dout_LOW_26,Dout_HIGH_26 : std_logic_vector(31 downto 0);

    signal clk_27,ENA_OUT_LOW_27,ENA_OUT_HIGH_27,ENA_WRT_LOW_27,ENA_WRT_HIGH_27: std_logic  := '0';
    signal Dout_LOW_27,Dout_HIGH_27 : std_logic_vector(31 downto 0);

    signal clk_28,ENA_OUT_LOW_28,ENA_OUT_HIGH_28,ENA_WRT_LOW_28,ENA_WRT_HIGH_28: std_logic  := '0';
    signal Dout_LOW_28,Dout_HIGH_28 : std_logic_vector(31 downto 0);

    signal clk_29,ENA_OUT_LOW_29,ENA_OUT_HIGH_29,ENA_WRT_LOW_29,ENA_WRT_HIGH_29: std_logic  := '0';
    signal Dout_LOW_29,Dout_HIGH_29 : std_logic_vector(31 downto 0);

    signal clk_30,ENA_OUT_LOW_30,ENA_OUT_HIGH_30,ENA_WRT_LOW_30,ENA_WRT_HIGH_30: std_logic  := '0';
    signal Dout_LOW_30,Dout_HIGH_30 : std_logic_vector(31 downto 0);

    signal clk_31,ENA_OUT_LOW_31,ENA_OUT_HIGH_31,ENA_WRT_LOW_31,ENA_WRT_HIGH_31: std_logic  := '0';
    signal Dout_LOW_31,Dout_HIGH_31 : std_logic_vector(31 downto 0);

    signal out_low,out_high : std_logic_vector(31 downto 0);

begin

D_OUT_LOW <= out_low;
D_OUT_HIGH<= out_high;

-- SR ---
-- Why duplicate the clock signal so many times?
-- What's the goal here?
-- SR ---

clk_0 <= clk;
clk_1 <= clk;
clk_2 <= clk;
clk_3 <= clk;
clk_4 <= clk;
clk_5 <= clk;
clk_6 <= clk;
clk_7 <= clk;
clk_8 <= clk;
clk_9 <= clk;
clk_10 <= clk;
clk_11 <= clk;
clk_12 <= clk;
clk_13 <= clk;
clk_14 <= clk;
clk_15 <= clk;
clk_16 <= clk;
clk_17 <= clk;
clk_18 <= clk;
clk_19 <= clk;
clk_20 <= clk;
clk_21 <= clk;
clk_22 <= clk;
clk_23 <= clk;
clk_24 <= clk;
clk_25 <= clk;
clk_26 <= clk;
clk_27 <= clk;
clk_28 <= clk;
clk_29 <= clk;
clk_30 <= clk;
clk_31 <= clk;

DEMUX_LOW: entity riscv.DEMUX_32_1(Behavioral) port map(
sel => sel_low_WRITE,
input => EN_WRITE_LOW,
output_0 => ENA_WRT_LOW_0,
output_1 => ENA_WRT_LOW_1,
output_2 => ENA_WRT_LOW_2,
output_3 => ENA_WRT_LOW_3,
output_4 => ENA_WRT_LOW_4,
output_5 => ENA_WRT_LOW_5,
output_6 => ENA_WRT_LOW_6,
output_7 => ENA_WRT_LOW_7,
output_8 => ENA_WRT_LOW_8,
output_9 => ENA_WRT_LOW_9,
output_10 => ENA_WRT_LOW_10,
output_11 => ENA_WRT_LOW_11,
output_12 => ENA_WRT_LOW_12,
output_13 => ENA_WRT_LOW_13,
output_14 => ENA_WRT_LOW_14,
output_15 => ENA_WRT_LOW_15,
output_16 => ENA_WRT_LOW_16,
output_17 => ENA_WRT_LOW_17,
output_18 => ENA_WRT_LOW_18,
output_19 => ENA_WRT_LOW_19,
output_20 => ENA_WRT_LOW_20,
output_21 => ENA_WRT_LOW_21,
output_22 => ENA_WRT_LOW_22,
output_23 => ENA_WRT_LOW_23,
output_24 => ENA_WRT_LOW_24,
output_25 => ENA_WRT_LOW_25,
output_26 => ENA_WRT_LOW_26,
output_27 => ENA_WRT_LOW_27,
output_28 => ENA_WRT_LOW_28,
output_29 => ENA_WRT_LOW_29,
output_30 => ENA_WRT_LOW_30,
output_31 => ENA_WRT_LOW_31
);

DEMUX_HIGH: entity riscv.DEMUX_32_1(Behavioral) port map(
sel => sel_high_WRITE,
input => EN_WRITE_HIGH,
output_0 => ENA_WRT_HIGH_0,
output_1 => ENA_WRT_HIGH_1,
output_2 => ENA_WRT_HIGH_2,
output_3 => ENA_WRT_HIGH_3,
output_4 => ENA_WRT_HIGH_4,
output_5 => ENA_WRT_HIGH_5,
output_6 => ENA_WRT_HIGH_6,
output_7 => ENA_WRT_HIGH_7,
output_8 => ENA_WRT_HIGH_8,
output_9 => ENA_WRT_HIGH_9,
output_10 => ENA_WRT_HIGH_10,
output_11 => ENA_WRT_HIGH_11,
output_12 => ENA_WRT_HIGH_12,
output_13 => ENA_WRT_HIGH_13,
output_14 => ENA_WRT_HIGH_14,
output_15 => ENA_WRT_HIGH_15,
output_16 => ENA_WRT_HIGH_16,
output_17 => ENA_WRT_HIGH_17,
output_18 => ENA_WRT_HIGH_18,
output_19 => ENA_WRT_HIGH_19,
output_20 => ENA_WRT_HIGH_20,
output_21 => ENA_WRT_HIGH_21,
output_22 => ENA_WRT_HIGH_22,
output_23 => ENA_WRT_HIGH_23,
output_24 => ENA_WRT_HIGH_24,
output_25 => ENA_WRT_HIGH_25,
output_26 => ENA_WRT_HIGH_26,
output_27 => ENA_WRT_HIGH_27,
output_28 => ENA_WRT_HIGH_28,
output_29 => ENA_WRT_HIGH_29,
output_30 => ENA_WRT_HIGH_30,
output_31 => ENA_WRT_HIGH_31
);

mux_LOW: entity riscv.MUX_32_32(Behavioral) port map(
sel => sel_low_READ,
output_0 => out_low,
input_0 => Dout_LOW_0,
input_1 => Dout_LOW_1,
input_2 => Dout_LOW_2,
input_3 => Dout_LOW_3,
input_4 => Dout_LOW_4,
input_5 => Dout_LOW_5,
input_6 => Dout_LOW_6,
input_7 => Dout_LOW_7,
input_8 => Dout_LOW_8,
input_9 => Dout_LOW_9,
input_10 => Dout_LOW_10,
input_11 => Dout_LOW_11,
input_12 => Dout_LOW_12,
input_13 => Dout_LOW_13,
input_14 => Dout_LOW_14,
input_15 => Dout_LOW_15,
input_16 => Dout_LOW_16,
input_17 => Dout_LOW_17,
input_18 => Dout_LOW_18,
input_19 => Dout_LOW_19,
input_20 => Dout_LOW_20,
input_21 => Dout_LOW_21,
input_22 => Dout_LOW_22,
input_23 => Dout_LOW_23,
input_24 => Dout_LOW_24,
input_25 => Dout_LOW_25,
input_26 => Dout_LOW_26,
input_27 => Dout_LOW_27,
input_28 => Dout_LOW_28,
input_29 => Dout_LOW_29,
input_30 => Dout_LOW_30,
input_31 => Dout_LOW_31
);


mux_HIGH: entity riscv.MUX_32_32(Behavioral) port map(
sel => sel_high_READ,
output_0 => out_high,
input_0 => Dout_HIGH_0,
input_1 => Dout_HIGH_1,
input_2 => Dout_HIGH_2,
input_3 => Dout_HIGH_3,
input_4 => Dout_HIGH_4,
input_5 => Dout_HIGH_5,
input_6 => Dout_HIGH_6,
input_7 => Dout_HIGH_7,
input_8 => Dout_HIGH_8,
input_9 => Dout_HIGH_9,
input_10 => Dout_HIGH_10,
input_11 => Dout_HIGH_11,
input_12 => Dout_HIGH_12,
input_13 => Dout_HIGH_13,
input_14 => Dout_HIGH_14,
input_15 => Dout_HIGH_15,
input_16 => Dout_HIGH_16,
input_17 => Dout_HIGH_17,
input_18 => Dout_HIGH_18,
input_19 => Dout_HIGH_19,
input_20 => Dout_HIGH_20,
input_21 => Dout_HIGH_21,
input_22 => Dout_HIGH_22,
input_23 => Dout_HIGH_23,
input_24 => Dout_HIGH_24,
input_25 => Dout_HIGH_25,
input_26 => Dout_HIGH_26,
input_27 => Dout_HIGH_27,
input_28 => Dout_HIGH_28,
input_29 => Dout_HIGH_29,
input_30 => Dout_HIGH_30,
input_31 => Dout_HIGH_31
);

timer_0: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_0,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_0,
EN_WRITE_HIGH => ENA_WRT_HIGH_0,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_0,
DATA_HIGH_OUT => Dout_HIGH_0
);

timer_1: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_1,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_1,
EN_WRITE_HIGH => ENA_WRT_HIGH_1,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_1,
DATA_HIGH_OUT => Dout_HIGH_1
);

timer_2: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_2,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_2,
EN_WRITE_HIGH => ENA_WRT_HIGH_2,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_2,
DATA_HIGH_OUT => Dout_HIGH_2
);

timer_3: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_3,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_3,
EN_WRITE_HIGH => ENA_WRT_HIGH_3,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_3,
DATA_HIGH_OUT => Dout_HIGH_3
);

timer_4: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_4,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_4,
EN_WRITE_HIGH => ENA_WRT_HIGH_4,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_4,
DATA_HIGH_OUT => Dout_HIGH_4
);

timer_5: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_5,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_5,
EN_WRITE_HIGH => ENA_WRT_HIGH_5,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_5,
DATA_HIGH_OUT => Dout_HIGH_5
);

timer_6: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_6,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_6,
EN_WRITE_HIGH => ENA_WRT_HIGH_6,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_6,
DATA_HIGH_OUT => Dout_HIGH_6
);

timer_7: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_7,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_7,
EN_WRITE_HIGH => ENA_WRT_HIGH_7,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_7,
DATA_HIGH_OUT => Dout_HIGH_7
);

timer_8: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_8,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_8,
EN_WRITE_HIGH => ENA_WRT_HIGH_8,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_8,
DATA_HIGH_OUT => Dout_HIGH_8
);

timer_9: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_9,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_9,
EN_WRITE_HIGH => ENA_WRT_HIGH_9,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_9,
DATA_HIGH_OUT => Dout_HIGH_9
);

timer_10: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_10,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_10,
EN_WRITE_HIGH => ENA_WRT_HIGH_10,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_10,
DATA_HIGH_OUT => Dout_HIGH_10
);

timer_11: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_11,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_11,
EN_WRITE_HIGH => ENA_WRT_HIGH_11,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_11,
DATA_HIGH_OUT => Dout_HIGH_11
);

timer_12: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_12,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_12,
EN_WRITE_HIGH => ENA_WRT_HIGH_12,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_12,
DATA_HIGH_OUT => Dout_HIGH_12
);

timer_13: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_13,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_13,
EN_WRITE_HIGH => ENA_WRT_HIGH_13,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_13,
DATA_HIGH_OUT => Dout_HIGH_13
);

timer_14: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_14,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_14,
EN_WRITE_HIGH => ENA_WRT_HIGH_14,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_14,
DATA_HIGH_OUT => Dout_HIGH_14
);

timer_15: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_15,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_15,
EN_WRITE_HIGH => ENA_WRT_HIGH_15,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_15,
DATA_HIGH_OUT => Dout_HIGH_15
);

timer_16: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_16,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_16,
EN_WRITE_HIGH => ENA_WRT_HIGH_16,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_16,
DATA_HIGH_OUT => Dout_HIGH_16
);

timer_17: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_17,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_17,
EN_WRITE_HIGH => ENA_WRT_HIGH_17,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_17,
DATA_HIGH_OUT => Dout_HIGH_17
);

timer_18: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_18,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_18,
EN_WRITE_HIGH => ENA_WRT_HIGH_18,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_18,
DATA_HIGH_OUT => Dout_HIGH_18
);

timer_19: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_19,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_19,
EN_WRITE_HIGH => ENA_WRT_HIGH_19,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_19,
DATA_HIGH_OUT => Dout_HIGH_19
);

timer_20: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_20,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_20,
EN_WRITE_HIGH => ENA_WRT_HIGH_20,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_20,
DATA_HIGH_OUT => Dout_HIGH_20
);

timer_21: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_21,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_21,
EN_WRITE_HIGH => ENA_WRT_HIGH_21,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_21,
DATA_HIGH_OUT => Dout_HIGH_21
);

timer_22: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_22,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_22,
EN_WRITE_HIGH => ENA_WRT_HIGH_22,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_22,
DATA_HIGH_OUT => Dout_HIGH_22
);

timer_23: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_23,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_23,
EN_WRITE_HIGH => ENA_WRT_HIGH_23,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_23,
DATA_HIGH_OUT => Dout_HIGH_23
);

timer_24: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_24,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_24,
EN_WRITE_HIGH => ENA_WRT_HIGH_24,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_24,
DATA_HIGH_OUT => Dout_HIGH_24
);

timer_25: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_25,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_25,
EN_WRITE_HIGH => ENA_WRT_HIGH_25,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_25,
DATA_HIGH_OUT => Dout_HIGH_25
);

timer_26: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_26,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_26,
EN_WRITE_HIGH => ENA_WRT_HIGH_26,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_26,
DATA_HIGH_OUT => Dout_HIGH_26
);

timer_27: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_27,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_27,
EN_WRITE_HIGH => ENA_WRT_HIGH_27,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_27,
DATA_HIGH_OUT => Dout_HIGH_27
);

timer_28: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_28,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_28,
EN_WRITE_HIGH => ENA_WRT_HIGH_28,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_28,
DATA_HIGH_OUT => Dout_HIGH_28
);

timer_29: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_29,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_29,
EN_WRITE_HIGH => ENA_WRT_HIGH_29,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_29,
DATA_HIGH_OUT => Dout_HIGH_29
);

timer_30: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_30,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_30,
EN_WRITE_HIGH => ENA_WRT_HIGH_30,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_30,
DATA_HIGH_OUT => Dout_HIGH_30
);

timer_31: entity riscv.CSR_TIMER(Behavioral) port map(
clk => clk_31,
DATA_IN => D_IN,
EN_WRITE_LOW => ENA_WRT_LOW_31,
EN_WRITE_HIGH => ENA_WRT_HIGH_31,
EN_OUT_LOW => '1',
EN_OUT_HIGH => '1',
DATA_LOW_OUT => Dout_LOW_31,
DATA_HIGH_OUT => Dout_HIGH_31
);

end Behavioral;
