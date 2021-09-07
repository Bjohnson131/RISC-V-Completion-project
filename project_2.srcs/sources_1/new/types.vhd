----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Brice Johnson
-- 
-- Create Date: 09/06/2021 05:50:03 PM
-- Design Name: 
-- Module Name:  - 
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

package types is
    type operational_states is (
       NORMAL,     -- Normal, or 'user' mode
       SUPERVISOR, -- One Execution level above NORMAL
       HYPERVISOR, -- One level above Supervisor
       MACHINE);   -- "Kernel" level access, highest access level
       
    type instruction_cluster is (INVALID, LOAD, STORE, MADD, BRANCH, LOAD_FP, STORE_FP, MSUB, JALR, NMSUB, MISC_MEM, AMO, NMADD, JAL, OP_IMM, OP, OP_FP, SYSTEM, AUIPC, LUI, OP_IMM_32, OP_32);
    type opcode is (INVALID, LUI, AUIPC, JAL, JALR, BEQ, BNE, BLT, BGE, BLTU, BGEU, LB, LH, LW, LBU, LHU, SB, SH, SW, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, ADD, SUB, inst_SLL, SLT, SLTU, inst_XOR, inst_SRL, inst_SRA, inst_OR, inst_AND, FENCE, FENCEI, EXALL, EBREAK, CSRRW, CSRRS, CSRRC, CSRRSI, CSRRCI, CSRRWI);
    type ALU_OP is (OP1, OP2); -- TODO-21: find and name all of the ALU OPs.
     
    type INSTR is array (31 downto 0) of std_logic;
    
    function CLUSTER(L : INSTR) return instruction_cluster;
    function OP(L : INSTR) return opcode;
end;

package body types is

    -- CLUSTER takes in an instruction and outputs the corresponding instruction cluster
    function CLUSTER(L :in INSTR)
       return instruction_cluster is 
       variable cluster: instruction_cluster;
       begin
       with L select?
       cluster :=
       LOAD    when "------------------0------00000--",
       LOAD    when "-----------------010-----00000--",
       STORE   when "-----------------00------01000--",
       STORE   when "-----------------010-----01000--",
       BRANCH  when "-----------------00------11000--",
       BRANCH  when "-----------------1-------11000--",
       JALR    when "-------------------------11001--",
       JAL     when "-------------------------11011--",
       OP_IMM  when "-------------------------00100--",
       OP      when "-------------------------01100--",
       AUIPC   when "-------------------------00101--",
       LUI     when "-------------------------01101--",
       SYSTEM  when "-------------------------11100--",
       INVALID when others;
       return cluster;
     end CLUSTER; 
     
    -- OP takes in an instruction and outputs the corresponding instruction cluster
    function OP(L :in INSTR)
       return opcode is 
       variable op: opcode;
       begin
        with L select?
        op :=
       LB         when "-----------------000-----00000--",
       LH         when "-----------------001-----00000--",
       LW         when "-----------------010-----00000--",
       LBU        when "-----------------100-----00000--",
       LHU        when "-----------------101-----00000--",
       SB         when "-----------------000-----01000--",
       SH         when "-----------------001-----01000--",
       SW         when "-----------------010-----01000--",
       BEQ        when "-----------------000-----11000--",
       BNE        when "-----------------001-----11000--",
       BLT        when "-----------------100-----11000--",
       BGE        when "-----------------101-----11000--",
       BLTU       when "-----------------110-----11000--",
       BGEU       when "-----------------111-----11000--",
       JALR       when "-------------------------11001--",
       JAL        when "-------------------------11011--",
       Addi       when "-----------------000-----00100--",
       SLLI       when "-----------------001-----00100--",
       SLTI       when "-----------------010-----00100--",
       SLTIU      when "-----------------011-----00100--",
       XORI       when "-----------------100-----00100--",
       ORI        when "-----------------110-----00100--",
       ANDI       when "-----------------111-----00100--",
       SRLI       when "-0---------------101-----00100--",
       SRAI       when "-1---------------101-----00100--",
       ADD        when "-0---------------000-----01100--",
       SUB        when "-1---------------000-----01100--",
       inst_SLL   when "-----------------001-----01100--",
       SLT        when "-----------------010-----01100--",
       SLTU       when "-----------------011-----01100--",
       inst_XOR   when "-----------------100-----01100--",
       inst_SRL   when "-0---------------101-----01100--",
       inst_SRA   when "-1---------------101-----01100--",
       inst_OR    when "-----------------110-----01100--",
       inst_AND   when "-----------------111-----01100--",
       AUIPC      when "-------------------------00101--",
       LUI        when "-------------------------01101--",
       CSRRS      when "-----------------010-----11100--", -- NEEDS IMPLEMENTATION--
       CSRRW      when "-----------------001-----11100--", -- NEEDS IMPLEMENTATION--
       CSRRC      when "-----------------011-----11100--", -- NEEDS IMPLEMENTATION--
       CSRRSI     when "-----------------110-----11100--", -- NEEDS IMPLEMENTATION--
       CSRRWI     when "-----------------101-----11100--", -- NEEDS IMPLEMENTATION--
       CSRRCI     when "-----------------111-----11100--", -- NEEDS IMPLEMENTATION--
       INVALID when others;
       return op;
     end OP; 
end ;
