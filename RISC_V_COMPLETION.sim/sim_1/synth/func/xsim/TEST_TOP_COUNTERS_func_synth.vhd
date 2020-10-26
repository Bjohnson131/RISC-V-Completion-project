-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Thu May 21 18:24:48 2020
-- Host        : DESKTOP-4OG9IDO running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Users/Brice/VIVADO/RISC_V_TEST/RISC_V_TEST.sim/sim_1/synth/func/xsim/TEST_TOP_COUNTERS_func_synth.vhd
-- Design      : TEST_TOP_COUNTERS
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \CSR_TIMER__28\ is
  port (
    clk : in STD_LOGIC;
    DATA_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    EN_WRITE_LOW : in STD_LOGIC;
    EN_WRITE_HIGH : in STD_LOGIC;
    EN_OUT_LOW : in STD_LOGIC;
    EN_OUT_HIGH : in STD_LOGIC;
    DATA_LOW_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    DATA_HIGH_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \CSR_TIMER__28\ : entity is "CSR_TIMER";
end \CSR_TIMER__28\;

architecture STRUCTURE of \CSR_TIMER__28\ is
  signal \<const0>\ : STD_LOGIC;
  signal \^data_low_out\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal clock_next0_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \clock_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \clock_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \clock_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \clock_reg[7]_i_1_n_2\ : STD_LOGIC;
  signal \clock_reg[7]_i_1_n_3\ : STD_LOGIC;
  signal \NLW_clock_reg[7]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_clock_reg[7]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
begin
  DATA_HIGH_OUT(31) <= \<const0>\;
  DATA_HIGH_OUT(30) <= \<const0>\;
  DATA_HIGH_OUT(29) <= \<const0>\;
  DATA_HIGH_OUT(28) <= \<const0>\;
  DATA_HIGH_OUT(27) <= \<const0>\;
  DATA_HIGH_OUT(26) <= \<const0>\;
  DATA_HIGH_OUT(25) <= \<const0>\;
  DATA_HIGH_OUT(24) <= \<const0>\;
  DATA_HIGH_OUT(23) <= \<const0>\;
  DATA_HIGH_OUT(22) <= \<const0>\;
  DATA_HIGH_OUT(21) <= \<const0>\;
  DATA_HIGH_OUT(20) <= \<const0>\;
  DATA_HIGH_OUT(19) <= \<const0>\;
  DATA_HIGH_OUT(18) <= \<const0>\;
  DATA_HIGH_OUT(17) <= \<const0>\;
  DATA_HIGH_OUT(16) <= \<const0>\;
  DATA_HIGH_OUT(15) <= \<const0>\;
  DATA_HIGH_OUT(14) <= \<const0>\;
  DATA_HIGH_OUT(13) <= \<const0>\;
  DATA_HIGH_OUT(12) <= \<const0>\;
  DATA_HIGH_OUT(11) <= \<const0>\;
  DATA_HIGH_OUT(10) <= \<const0>\;
  DATA_HIGH_OUT(9) <= \<const0>\;
  DATA_HIGH_OUT(8) <= \<const0>\;
  DATA_HIGH_OUT(7) <= \<const0>\;
  DATA_HIGH_OUT(6) <= \<const0>\;
  DATA_HIGH_OUT(5) <= \<const0>\;
  DATA_HIGH_OUT(4) <= \<const0>\;
  DATA_HIGH_OUT(3) <= \<const0>\;
  DATA_HIGH_OUT(2) <= \<const0>\;
  DATA_HIGH_OUT(1) <= \<const0>\;
  DATA_HIGH_OUT(0) <= \<const0>\;
  DATA_LOW_OUT(31) <= \<const0>\;
  DATA_LOW_OUT(30) <= \<const0>\;
  DATA_LOW_OUT(29) <= \<const0>\;
  DATA_LOW_OUT(28) <= \<const0>\;
  DATA_LOW_OUT(27) <= \<const0>\;
  DATA_LOW_OUT(26) <= \<const0>\;
  DATA_LOW_OUT(25) <= \<const0>\;
  DATA_LOW_OUT(24) <= \<const0>\;
  DATA_LOW_OUT(23) <= \<const0>\;
  DATA_LOW_OUT(22) <= \<const0>\;
  DATA_LOW_OUT(21) <= \<const0>\;
  DATA_LOW_OUT(20) <= \<const0>\;
  DATA_LOW_OUT(19) <= \<const0>\;
  DATA_LOW_OUT(18) <= \<const0>\;
  DATA_LOW_OUT(17) <= \<const0>\;
  DATA_LOW_OUT(16) <= \<const0>\;
  DATA_LOW_OUT(15) <= \<const0>\;
  DATA_LOW_OUT(14) <= \<const0>\;
  DATA_LOW_OUT(13) <= \<const0>\;
  DATA_LOW_OUT(12) <= \<const0>\;
  DATA_LOW_OUT(11) <= \<const0>\;
  DATA_LOW_OUT(10) <= \<const0>\;
  DATA_LOW_OUT(9) <= \<const0>\;
  DATA_LOW_OUT(8) <= \<const0>\;
  DATA_LOW_OUT(7 downto 0) <= \^data_low_out\(7 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\clock[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^data_low_out\(0),
      O => clock_next0_in(0)
    );
\clock_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => clock_next0_in(0),
      Q => \^data_low_out\(0),
      R => '0'
    );
\clock_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => clock_next0_in(1),
      Q => \^data_low_out\(1),
      R => '0'
    );
\clock_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => clock_next0_in(2),
      Q => \^data_low_out\(2),
      R => '0'
    );
\clock_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => clock_next0_in(3),
      Q => \^data_low_out\(3),
      R => '0'
    );
\clock_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => clock_next0_in(4),
      Q => \^data_low_out\(4),
      R => '0'
    );
\clock_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \clock_reg[4]_i_1_n_0\,
      CO(2) => \clock_reg[4]_i_1_n_1\,
      CO(1) => \clock_reg[4]_i_1_n_2\,
      CO(0) => \clock_reg[4]_i_1_n_3\,
      CYINIT => \^data_low_out\(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => clock_next0_in(4 downto 1),
      S(3 downto 0) => \^data_low_out\(4 downto 1)
    );
\clock_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => clock_next0_in(5),
      Q => \^data_low_out\(5),
      R => '0'
    );
\clock_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => clock_next0_in(6),
      Q => \^data_low_out\(6),
      R => '0'
    );
\clock_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => clock_next0_in(7),
      Q => \^data_low_out\(7),
      R => '0'
    );
\clock_reg[7]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \clock_reg[4]_i_1_n_0\,
      CO(3 downto 2) => \NLW_clock_reg[7]_i_1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \clock_reg[7]_i_1_n_2\,
      CO(0) => \clock_reg[7]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_clock_reg[7]_i_1_O_UNCONNECTED\(3),
      O(2 downto 0) => clock_next0_in(7 downto 5),
      S(3) => '0',
      S(2 downto 0) => \^data_low_out\(7 downto 5)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity SEL_CLK_DIV is
  port (
    clk : in STD_LOGIC;
    DIV_SEL : in STD_LOGIC_VECTOR ( 4 downto 0 );
    COUT : out STD_LOGIC
  );
end SEL_CLK_DIV;

architecture STRUCTURE of SEL_CLK_DIV is
  signal COUT_INST_0_i_10_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_11_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_12_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_1_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_2_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_3_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_4_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_5_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_6_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_7_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_8_n_0 : STD_LOGIC;
  signal COUT_INST_0_i_9_n_0 : STD_LOGIC;
  signal \count[0]_i_2_n_0\ : STD_LOGIC;
  signal \count_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \count_reg[0]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[0]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[0]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[0]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[0]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[0]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[0]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \count_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \count_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \count_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \count_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \count_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \count_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \count_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \count_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \count_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \count_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \count_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \count_reg_n_0_[0]\ : STD_LOGIC;
  signal data1 : STD_LOGIC;
  signal data10 : STD_LOGIC;
  signal data11 : STD_LOGIC;
  signal data12 : STD_LOGIC;
  signal data13 : STD_LOGIC;
  signal data14 : STD_LOGIC;
  signal data15 : STD_LOGIC;
  signal data16 : STD_LOGIC;
  signal data17 : STD_LOGIC;
  signal data18 : STD_LOGIC;
  signal data19 : STD_LOGIC;
  signal data2 : STD_LOGIC;
  signal data20 : STD_LOGIC;
  signal data21 : STD_LOGIC;
  signal data22 : STD_LOGIC;
  signal data23 : STD_LOGIC;
  signal data24 : STD_LOGIC;
  signal data25 : STD_LOGIC;
  signal data26 : STD_LOGIC;
  signal data27 : STD_LOGIC;
  signal data28 : STD_LOGIC;
  signal data29 : STD_LOGIC;
  signal data3 : STD_LOGIC;
  signal data30 : STD_LOGIC;
  signal data31 : STD_LOGIC;
  signal data4 : STD_LOGIC;
  signal data5 : STD_LOGIC;
  signal data6 : STD_LOGIC;
  signal data7 : STD_LOGIC;
  signal data8 : STD_LOGIC;
  signal data9 : STD_LOGIC;
  signal \NLW_count_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
begin
COUT_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => COUT_INST_0_i_1_n_0,
      I1 => COUT_INST_0_i_2_n_0,
      I2 => DIV_SEL(4),
      I3 => COUT_INST_0_i_3_n_0,
      I4 => DIV_SEL(3),
      I5 => COUT_INST_0_i_4_n_0,
      O => COUT
    );
COUT_INST_0_i_1: unisim.vcomponents.MUXF7
     port map (
      I0 => COUT_INST_0_i_5_n_0,
      I1 => COUT_INST_0_i_6_n_0,
      O => COUT_INST_0_i_1_n_0,
      S => DIV_SEL(2)
    );
COUT_INST_0_i_10: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data15,
      I1 => data14,
      I2 => DIV_SEL(1),
      I3 => data13,
      I4 => DIV_SEL(0),
      I5 => data12,
      O => COUT_INST_0_i_10_n_0
    );
COUT_INST_0_i_11: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data3,
      I1 => data2,
      I2 => DIV_SEL(1),
      I3 => data1,
      I4 => DIV_SEL(0),
      I5 => \count_reg_n_0_[0]\,
      O => COUT_INST_0_i_11_n_0
    );
COUT_INST_0_i_12: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data7,
      I1 => data6,
      I2 => DIV_SEL(1),
      I3 => data5,
      I4 => DIV_SEL(0),
      I5 => data4,
      O => COUT_INST_0_i_12_n_0
    );
COUT_INST_0_i_2: unisim.vcomponents.MUXF7
     port map (
      I0 => COUT_INST_0_i_7_n_0,
      I1 => COUT_INST_0_i_8_n_0,
      O => COUT_INST_0_i_2_n_0,
      S => DIV_SEL(2)
    );
COUT_INST_0_i_3: unisim.vcomponents.MUXF7
     port map (
      I0 => COUT_INST_0_i_9_n_0,
      I1 => COUT_INST_0_i_10_n_0,
      O => COUT_INST_0_i_3_n_0,
      S => DIV_SEL(2)
    );
COUT_INST_0_i_4: unisim.vcomponents.MUXF7
     port map (
      I0 => COUT_INST_0_i_11_n_0,
      I1 => COUT_INST_0_i_12_n_0,
      O => COUT_INST_0_i_4_n_0,
      S => DIV_SEL(2)
    );
COUT_INST_0_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data27,
      I1 => data26,
      I2 => DIV_SEL(1),
      I3 => data25,
      I4 => DIV_SEL(0),
      I5 => data24,
      O => COUT_INST_0_i_5_n_0
    );
COUT_INST_0_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data31,
      I1 => data30,
      I2 => DIV_SEL(1),
      I3 => data29,
      I4 => DIV_SEL(0),
      I5 => data28,
      O => COUT_INST_0_i_6_n_0
    );
COUT_INST_0_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data19,
      I1 => data18,
      I2 => DIV_SEL(1),
      I3 => data17,
      I4 => DIV_SEL(0),
      I5 => data16,
      O => COUT_INST_0_i_7_n_0
    );
COUT_INST_0_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data23,
      I1 => data22,
      I2 => DIV_SEL(1),
      I3 => data21,
      I4 => DIV_SEL(0),
      I5 => data20,
      O => COUT_INST_0_i_8_n_0
    );
COUT_INST_0_i_9: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data11,
      I1 => data10,
      I2 => DIV_SEL(1),
      I3 => data9,
      I4 => DIV_SEL(0),
      I5 => data8,
      O => COUT_INST_0_i_9_n_0
    );
\count[0]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \count_reg_n_0_[0]\,
      O => \count[0]_i_2_n_0\
    );
\count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[0]_i_1_n_7\,
      Q => \count_reg_n_0_[0]\,
      R => '0'
    );
\count_reg[0]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \count_reg[0]_i_1_n_0\,
      CO(2) => \count_reg[0]_i_1_n_1\,
      CO(1) => \count_reg[0]_i_1_n_2\,
      CO(0) => \count_reg[0]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \count_reg[0]_i_1_n_4\,
      O(2) => \count_reg[0]_i_1_n_5\,
      O(1) => \count_reg[0]_i_1_n_6\,
      O(0) => \count_reg[0]_i_1_n_7\,
      S(3) => data3,
      S(2) => data2,
      S(1) => data1,
      S(0) => \count[0]_i_2_n_0\
    );
\count_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[8]_i_1_n_5\,
      Q => data10,
      R => '0'
    );
\count_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[8]_i_1_n_4\,
      Q => data11,
      R => '0'
    );
\count_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[12]_i_1_n_7\,
      Q => data12,
      R => '0'
    );
\count_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \count_reg[8]_i_1_n_0\,
      CO(3) => \count_reg[12]_i_1_n_0\,
      CO(2) => \count_reg[12]_i_1_n_1\,
      CO(1) => \count_reg[12]_i_1_n_2\,
      CO(0) => \count_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \count_reg[12]_i_1_n_4\,
      O(2) => \count_reg[12]_i_1_n_5\,
      O(1) => \count_reg[12]_i_1_n_6\,
      O(0) => \count_reg[12]_i_1_n_7\,
      S(3) => data15,
      S(2) => data14,
      S(1) => data13,
      S(0) => data12
    );
\count_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[12]_i_1_n_6\,
      Q => data13,
      R => '0'
    );
\count_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[12]_i_1_n_5\,
      Q => data14,
      R => '0'
    );
\count_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[12]_i_1_n_4\,
      Q => data15,
      R => '0'
    );
\count_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[16]_i_1_n_7\,
      Q => data16,
      R => '0'
    );
\count_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \count_reg[12]_i_1_n_0\,
      CO(3) => \count_reg[16]_i_1_n_0\,
      CO(2) => \count_reg[16]_i_1_n_1\,
      CO(1) => \count_reg[16]_i_1_n_2\,
      CO(0) => \count_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \count_reg[16]_i_1_n_4\,
      O(2) => \count_reg[16]_i_1_n_5\,
      O(1) => \count_reg[16]_i_1_n_6\,
      O(0) => \count_reg[16]_i_1_n_7\,
      S(3) => data19,
      S(2) => data18,
      S(1) => data17,
      S(0) => data16
    );
\count_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[16]_i_1_n_6\,
      Q => data17,
      R => '0'
    );
\count_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[16]_i_1_n_5\,
      Q => data18,
      R => '0'
    );
\count_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[16]_i_1_n_4\,
      Q => data19,
      R => '0'
    );
\count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[0]_i_1_n_6\,
      Q => data1,
      R => '0'
    );
\count_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[20]_i_1_n_7\,
      Q => data20,
      R => '0'
    );
\count_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \count_reg[16]_i_1_n_0\,
      CO(3) => \count_reg[20]_i_1_n_0\,
      CO(2) => \count_reg[20]_i_1_n_1\,
      CO(1) => \count_reg[20]_i_1_n_2\,
      CO(0) => \count_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \count_reg[20]_i_1_n_4\,
      O(2) => \count_reg[20]_i_1_n_5\,
      O(1) => \count_reg[20]_i_1_n_6\,
      O(0) => \count_reg[20]_i_1_n_7\,
      S(3) => data23,
      S(2) => data22,
      S(1) => data21,
      S(0) => data20
    );
\count_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[20]_i_1_n_6\,
      Q => data21,
      R => '0'
    );
\count_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[20]_i_1_n_5\,
      Q => data22,
      R => '0'
    );
\count_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[20]_i_1_n_4\,
      Q => data23,
      R => '0'
    );
\count_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[24]_i_1_n_7\,
      Q => data24,
      R => '0'
    );
\count_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \count_reg[20]_i_1_n_0\,
      CO(3) => \count_reg[24]_i_1_n_0\,
      CO(2) => \count_reg[24]_i_1_n_1\,
      CO(1) => \count_reg[24]_i_1_n_2\,
      CO(0) => \count_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \count_reg[24]_i_1_n_4\,
      O(2) => \count_reg[24]_i_1_n_5\,
      O(1) => \count_reg[24]_i_1_n_6\,
      O(0) => \count_reg[24]_i_1_n_7\,
      S(3) => data27,
      S(2) => data26,
      S(1) => data25,
      S(0) => data24
    );
\count_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[24]_i_1_n_6\,
      Q => data25,
      R => '0'
    );
\count_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[24]_i_1_n_5\,
      Q => data26,
      R => '0'
    );
\count_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[24]_i_1_n_4\,
      Q => data27,
      R => '0'
    );
\count_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[28]_i_1_n_7\,
      Q => data28,
      R => '0'
    );
\count_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \count_reg[24]_i_1_n_0\,
      CO(3) => \NLW_count_reg[28]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \count_reg[28]_i_1_n_1\,
      CO(1) => \count_reg[28]_i_1_n_2\,
      CO(0) => \count_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \count_reg[28]_i_1_n_4\,
      O(2) => \count_reg[28]_i_1_n_5\,
      O(1) => \count_reg[28]_i_1_n_6\,
      O(0) => \count_reg[28]_i_1_n_7\,
      S(3) => data31,
      S(2) => data30,
      S(1) => data29,
      S(0) => data28
    );
\count_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[28]_i_1_n_6\,
      Q => data29,
      R => '0'
    );
\count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[0]_i_1_n_5\,
      Q => data2,
      R => '0'
    );
\count_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[28]_i_1_n_5\,
      Q => data30,
      R => '0'
    );
\count_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[28]_i_1_n_4\,
      Q => data31,
      R => '0'
    );
\count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[0]_i_1_n_4\,
      Q => data3,
      R => '0'
    );
\count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[4]_i_1_n_7\,
      Q => data4,
      R => '0'
    );
\count_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \count_reg[0]_i_1_n_0\,
      CO(3) => \count_reg[4]_i_1_n_0\,
      CO(2) => \count_reg[4]_i_1_n_1\,
      CO(1) => \count_reg[4]_i_1_n_2\,
      CO(0) => \count_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \count_reg[4]_i_1_n_4\,
      O(2) => \count_reg[4]_i_1_n_5\,
      O(1) => \count_reg[4]_i_1_n_6\,
      O(0) => \count_reg[4]_i_1_n_7\,
      S(3) => data7,
      S(2) => data6,
      S(1) => data5,
      S(0) => data4
    );
\count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[4]_i_1_n_6\,
      Q => data5,
      R => '0'
    );
\count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[4]_i_1_n_5\,
      Q => data6,
      R => '0'
    );
\count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[4]_i_1_n_4\,
      Q => data7,
      R => '0'
    );
\count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[8]_i_1_n_7\,
      Q => data8,
      R => '0'
    );
\count_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \count_reg[4]_i_1_n_0\,
      CO(3) => \count_reg[8]_i_1_n_0\,
      CO(2) => \count_reg[8]_i_1_n_1\,
      CO(1) => \count_reg[8]_i_1_n_2\,
      CO(0) => \count_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \count_reg[8]_i_1_n_4\,
      O(2) => \count_reg[8]_i_1_n_5\,
      O(1) => \count_reg[8]_i_1_n_6\,
      O(0) => \count_reg[8]_i_1_n_7\,
      S(3) => data11,
      S(2) => data10,
      S(1) => data9,
      S(0) => data8
    );
\count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => \count_reg[8]_i_1_n_6\,
      Q => data9,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity CSR_TIMER_ARRAY is
  port (
    sel_low_READ : in STD_LOGIC_VECTOR ( 4 downto 0 );
    sel_high_READ : in STD_LOGIC_VECTOR ( 4 downto 0 );
    sel_low_WRITE : in STD_LOGIC_VECTOR ( 4 downto 0 );
    sel_high_WRITE : in STD_LOGIC_VECTOR ( 4 downto 0 );
    EN_WRITE_LOW : in STD_LOGIC;
    EN_WRITE_HIGH : in STD_LOGIC;
    clk : in STD_LOGIC;
    D_OUT_LOW : out STD_LOGIC_VECTOR ( 31 downto 0 );
    D_OUT_HIGH : out STD_LOGIC_VECTOR ( 31 downto 0 );
    D_IN : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end CSR_TIMER_ARRAY;

architecture STRUCTURE of CSR_TIMER_ARRAY is
  signal \<const0>\ : STD_LOGIC;
  signal \^d_out_low\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_timer_27_DATA_HIGH_OUT_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_timer_27_DATA_LOW_OUT_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 8 );
begin
  D_OUT_HIGH(31) <= \<const0>\;
  D_OUT_HIGH(30) <= \<const0>\;
  D_OUT_HIGH(29) <= \<const0>\;
  D_OUT_HIGH(28) <= \<const0>\;
  D_OUT_HIGH(27) <= \<const0>\;
  D_OUT_HIGH(26) <= \<const0>\;
  D_OUT_HIGH(25) <= \<const0>\;
  D_OUT_HIGH(24) <= \<const0>\;
  D_OUT_HIGH(23) <= \<const0>\;
  D_OUT_HIGH(22) <= \<const0>\;
  D_OUT_HIGH(21) <= \<const0>\;
  D_OUT_HIGH(20) <= \<const0>\;
  D_OUT_HIGH(19) <= \<const0>\;
  D_OUT_HIGH(18) <= \<const0>\;
  D_OUT_HIGH(17) <= \<const0>\;
  D_OUT_HIGH(16) <= \<const0>\;
  D_OUT_HIGH(15) <= \<const0>\;
  D_OUT_HIGH(14) <= \<const0>\;
  D_OUT_HIGH(13) <= \<const0>\;
  D_OUT_HIGH(12) <= \<const0>\;
  D_OUT_HIGH(11) <= \<const0>\;
  D_OUT_HIGH(10) <= \<const0>\;
  D_OUT_HIGH(9) <= \<const0>\;
  D_OUT_HIGH(8) <= \<const0>\;
  D_OUT_HIGH(7) <= \<const0>\;
  D_OUT_HIGH(6) <= \<const0>\;
  D_OUT_HIGH(5) <= \<const0>\;
  D_OUT_HIGH(4) <= \<const0>\;
  D_OUT_HIGH(3) <= \<const0>\;
  D_OUT_HIGH(2) <= \<const0>\;
  D_OUT_HIGH(1) <= \<const0>\;
  D_OUT_HIGH(0) <= \<const0>\;
  D_OUT_LOW(31) <= \<const0>\;
  D_OUT_LOW(30) <= \<const0>\;
  D_OUT_LOW(29) <= \<const0>\;
  D_OUT_LOW(28) <= \<const0>\;
  D_OUT_LOW(27) <= \<const0>\;
  D_OUT_LOW(26) <= \<const0>\;
  D_OUT_LOW(25) <= \<const0>\;
  D_OUT_LOW(24) <= \<const0>\;
  D_OUT_LOW(23) <= \<const0>\;
  D_OUT_LOW(22) <= \<const0>\;
  D_OUT_LOW(21) <= \<const0>\;
  D_OUT_LOW(20) <= \<const0>\;
  D_OUT_LOW(19) <= \<const0>\;
  D_OUT_LOW(18) <= \<const0>\;
  D_OUT_LOW(17) <= \<const0>\;
  D_OUT_LOW(16) <= \<const0>\;
  D_OUT_LOW(15) <= \<const0>\;
  D_OUT_LOW(14) <= \<const0>\;
  D_OUT_LOW(13) <= \<const0>\;
  D_OUT_LOW(12) <= \<const0>\;
  D_OUT_LOW(11) <= \<const0>\;
  D_OUT_LOW(10) <= \<const0>\;
  D_OUT_LOW(9) <= \<const0>\;
  D_OUT_LOW(8) <= \<const0>\;
  D_OUT_LOW(7 downto 0) <= \^d_out_low\(7 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
timer_27: entity work.\CSR_TIMER__28\
     port map (
      DATA_HIGH_OUT(31 downto 0) => NLW_timer_27_DATA_HIGH_OUT_UNCONNECTED(31 downto 0),
      DATA_IN(31 downto 0) => B"00000000000000000000000000000000",
      DATA_LOW_OUT(31 downto 8) => NLW_timer_27_DATA_LOW_OUT_UNCONNECTED(31 downto 8),
      DATA_LOW_OUT(7 downto 0) => \^d_out_low\(7 downto 0),
      EN_OUT_HIGH => '1',
      EN_OUT_LOW => '1',
      EN_WRITE_HIGH => '0',
      EN_WRITE_LOW => '0',
      clk => clk
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity CSR_hpmcounter is
  port (
    READ_ADDR_IN : in STD_LOGIC_VECTOR ( 11 downto 0 );
    WRITE_ADDR_IN : in STD_LOGIC_VECTOR ( 11 downto 0 );
    clk : in STD_LOGIC;
    WRITE : in STD_LOGIC;
    D_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    D_IN : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end CSR_hpmcounter;

architecture STRUCTURE of CSR_hpmcounter is
  signal \<const0>\ : STD_LOGIC;
  signal \^d_out\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_Timers_D_OUT_HIGH_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_Timers_D_OUT_LOW_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 8 );
begin
  D_OUT(31) <= \<const0>\;
  D_OUT(30) <= \<const0>\;
  D_OUT(29) <= \<const0>\;
  D_OUT(28) <= \<const0>\;
  D_OUT(27) <= \<const0>\;
  D_OUT(26) <= \<const0>\;
  D_OUT(25) <= \<const0>\;
  D_OUT(24) <= \<const0>\;
  D_OUT(23) <= \<const0>\;
  D_OUT(22) <= \<const0>\;
  D_OUT(21) <= \<const0>\;
  D_OUT(20) <= \<const0>\;
  D_OUT(19) <= \<const0>\;
  D_OUT(18) <= \<const0>\;
  D_OUT(17) <= \<const0>\;
  D_OUT(16) <= \<const0>\;
  D_OUT(15) <= \<const0>\;
  D_OUT(14) <= \<const0>\;
  D_OUT(13) <= \<const0>\;
  D_OUT(12) <= \<const0>\;
  D_OUT(11) <= \<const0>\;
  D_OUT(10) <= \<const0>\;
  D_OUT(9) <= \<const0>\;
  D_OUT(8) <= \<const0>\;
  D_OUT(7 downto 0) <= \^d_out\(7 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
Timers: entity work.CSR_TIMER_ARRAY
     port map (
      D_IN(31 downto 0) => B"00000000000000000000000000000000",
      D_OUT_HIGH(31 downto 0) => NLW_Timers_D_OUT_HIGH_UNCONNECTED(31 downto 0),
      D_OUT_LOW(31 downto 8) => NLW_Timers_D_OUT_LOW_UNCONNECTED(31 downto 8),
      D_OUT_LOW(7 downto 0) => \^d_out\(7 downto 0),
      EN_WRITE_HIGH => '0',
      EN_WRITE_LOW => '0',
      clk => clk,
      sel_high_READ(4 downto 0) => B"11011",
      sel_high_WRITE(4 downto 0) => B"00000",
      sel_low_READ(4 downto 0) => B"11011",
      sel_low_WRITE(4 downto 0) => B"00000"
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity TEST_TOP_COUNTERS is
  port (
    led : out STD_LOGIC_VECTOR ( 7 downto 0 );
    sw : in STD_LOGIC_VECTOR ( 7 downto 0 );
    btn_c : in STD_LOGIC;
    btn_t : in STD_LOGIC;
    btn_b : in STD_LOGIC;
    btn_r : in STD_LOGIC;
    btn_l : in STD_LOGIC;
    sysClk : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of TEST_TOP_COUNTERS : entity is true;
end TEST_TOP_COUNTERS;

architecture STRUCTURE of TEST_TOP_COUNTERS is
  signal counting_clock : STD_LOGIC;
  signal led_OBUF : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sw_IBUF : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal sysClk_IBUF : STD_LOGIC;
  signal sysClk_IBUF_BUFG : STD_LOGIC;
  signal NLW_HPMs_D_OUT_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 8 );
begin
HPMs: entity work.CSR_hpmcounter
     port map (
      D_IN(31 downto 0) => B"00000000000000000000000000000000",
      D_OUT(31 downto 8) => NLW_HPMs_D_OUT_UNCONNECTED(31 downto 8),
      D_OUT(7 downto 0) => led_OBUF(7 downto 0),
      READ_ADDR_IN(11 downto 0) => B"110000011011",
      WRITE => '0',
      WRITE_ADDR_IN(11 downto 0) => B"000000000000",
      clk => counting_clock
    );
SEL_CLK_DIV: entity work.SEL_CLK_DIV
     port map (
      COUT => counting_clock,
      DIV_SEL(4 downto 0) => sw_IBUF(4 downto 0),
      clk => sysClk_IBUF_BUFG
    );
\led_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => led_OBUF(0),
      O => led(0)
    );
\led_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => led_OBUF(1),
      O => led(1)
    );
\led_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => led_OBUF(2),
      O => led(2)
    );
\led_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => led_OBUF(3),
      O => led(3)
    );
\led_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => led_OBUF(4),
      O => led(4)
    );
\led_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => led_OBUF(5),
      O => led(5)
    );
\led_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => led_OBUF(6),
      O => led(6)
    );
\led_OBUF[7]_inst\: unisim.vcomponents.OBUF
     port map (
      I => led_OBUF(7),
      O => led(7)
    );
\sw_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sw(0),
      O => sw_IBUF(0)
    );
\sw_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sw(1),
      O => sw_IBUF(1)
    );
\sw_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sw(2),
      O => sw_IBUF(2)
    );
\sw_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sw(3),
      O => sw_IBUF(3)
    );
\sw_IBUF[4]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sw(4),
      O => sw_IBUF(4)
    );
sysClk_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => sysClk_IBUF,
      O => sysClk_IBUF_BUFG
    );
sysClk_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => sysClk,
      O => sysClk_IBUF
    );
end STRUCTURE;
