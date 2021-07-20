----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2021 12:11:29 AM
-- Design Name: 
-- Module Name: RISCV_DATA - 
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

package RISCV_DATA is
    type opcode is (INVALID, LUI, AUIPC, JAL, JALR, BEQ, BNE, BLT, BGE, BLTU, BGEU, LB, LH, LW, LBU, LHU, SB, SH, SW, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, ADD, SUB, inst_SLL, SLT, SLTU, inst_XOR, inst_SRL, inst_SRA, inst_OR, inst_AND, FENCE, FENCEI, EXALL, EBREAK, CSRRW, CSRRS, CSRRC, CSRRSI, CSRRCI, CSRRWI);
    type instruction_cluster is (INVALID, LOAD, STORE, MADD, BRANCH, LOAD_FP, STORE_FP, MSUB, JALR, NMSUB, MISC_MEM, AMO, NMADD, JAL, OP_IMM, OP, OP_FP, SYSTEM, AUIPC, LUI, OP_IMM_32, OP_32);
    type operational_state is (NORMAL, SUPERVISOR, HYPERVISOR, MACHINE);
    type word is array  (0 to 31) of bit;
    type instruction is record
        trgt: std_logic_vector(11 downto 0);
        srce: std_logic_vector(11 downto 0);
        dest: std_logic_vector(11 downto 0);
        op: opcode;
        cluster: instruction_cluster;
        data: word;
    end record; 
    --type word is std_logic_vector(31 downto 0);
    
    function toInst(data: word) return instruction;
    function wordTC(myWord: std_logic_vector(31 downto 0)) return word;
    function opcodeTC(myWord: word) return opcode;
    function instclustTC(myWord: word) return instruction_cluster;    
end;