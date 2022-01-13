----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Brice Johnson
-- 
-- Create Date: 09/06/2021 05:50:03 PM
-- Design Name: 
-- Module Name:  - 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: VHDL 2008
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

package types is
    type operational_states is (
       NORMAL,     -- Normal, or 'user' mode
       SUPERVISOR, -- One Execution level above NORMAL
       HYPERVISOR, -- One level above Supervisor
       MACHINE);   -- "Kernel" level access, highest access level
    
    type MEMORY_MUX_SEL is (ATOMIC_SWAP, SINGLE_OP, NOP);
    type instruction_cluster is (INVALID, LOAD, STORE, MADD, BRANCH, LOAD_FP, STORE_FP, MSUB, JALR, NMSUB, MISC_MEM, AMO, NMADD, JAL, OP_IMM, OP_NIMM, OP_FP, SYSTEM, AUIPC, LUI, OP_IMM_32, OP_32);
    type opcode is (INVALID, LUI, AUIPC_OP, JAL, JALR_OP, BEQ, BNE, BLT, BGE, BLTU, BGEU, LB, LH, LW, LBU, LHU, SB, SH, SW, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, ADD, SUB, inst_SLL, SLT, SLTU, inst_XOR, inst_SRL, inst_SRA, inst_OR, inst_AND, FENCE, FENCEI, EXALL, EBREAK, CSRRW, CSRRS, CSRRC, CSRRSI, CSRRCI, CSRRWI);
    type ALU_OP is (OP1, OP2); -- TODO-21: find and name all of the ALU OPs.
     
    subtype INSTR is std_logic_vector(31 downto 0); 
    subtype REGADDR is std_logic_vector(4 downto 0);
    type REGSIG is record
        reg : REGADDR;
        en : std_logic;
    end record;    
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
       OP_NIMM when "-------------------------01100--",
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
       JALR_OP    when "-------------------------11001--",
       JAL        when "-------------------------11011--",
       ADDI       when "-----------------000-----00100--",
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
       AUIPC_OP   when "-------------------------00101--",
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

-------------------------------------------------------
--   ____  _____   _____ ____  _____  ______  _____  --
--  / __ \|  __ \ / ____/ __ \|  __ \|  ____|/ ____| --
-- | |  | | |__) | |   | |  | | |  | | |__  | (___   --
-- | |  | |  ___/| |   | |  | | |  | |  __|  \___ \  --
-- | |__| | |    | |___| |__| | |__| | |____ ____) | --
--  \____/|_|     \_____\____/|_____/|______|_____/  --
-------------------------------------------------------
-- pages referenced are from https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf
-- OpCode -- Pg# -- Notes
-------------------
--INVALID -- n/a -- No associated instruction. Will raise exceptions (eventually)
--  LUI   -- 14  -- Load Upper Immediate is used to build 32-bit constants and uses the U-type format. LUI places the U-immediate value in the top 20 bits of the destination register rd, filling in the lowest 12 bits with zeros
-- AUIPC  -- 14  -- Add Upper Immediate to pc is used to build pc-relative addresses and uses the U-type format. AUIPC forms a 32-bit offset from the 20-bit U-immediate, filling in the lowest 12 bits with zeros, adds this offset to the pc, then places the result in register rd    
--  JAL   -- 15  -- The Jump And Link instruction uses the J-type format, where the J-immediate encodes a signed offset in multiples of 2 bytes
--  JALR  -- 16  -- Jump And Link Register uses the I-type encoding The target address is obtained by adding the 12-bit signed I-immediate to the register rs1, then setting the least-significant bit of the result to zero. The address of the instruction following the jump (pc+4) is written to register rd.
-------------------
--  BEQ   -- 17  -- BEQ and BNE take the branch if registers rs1 and rs2 are equal or unequal respectively
--  BNE   -- 17  --  
--  BLT   -- 17  -- BLT and BLTU take the branch if rs1 is less than rs2, using signed and unsigned comparison respectively  
--  BLTU  -- 17  --
--  BGE   -- 17  -- BGE and BGEU take the branch if rs1 is greater than or equal to rs2, using signed and unsigned comparison respectively
--  BGEU  -- 17  --   
-------------------
--  LW    -- 19  -- The Load Word instruction loads a 32-bit value from memory into rd 
--  LH    -- 19  -- Load Half loads a 16-bit value from memory, then sign-extends to 32-bits before storing in rd 
--  LHU   -- 19  -- Load Half Upper loads a 16-bit value from memory but then zero extends to 32-bits before storing in rd
--  LB    -- 19  -- LB and LBU are defined analogously for 8-bit values.
--  LBU   -- 19  --  
--  SW    -- 19  -- Store Word
--  SH    -- 19  -- Store Half (From low bits)
--  SB    -- 19  -- Store Byte (From low bits.)
-------------------
--  ADDI  -- 13  -- ADDI adds the sign-extended 12-bit immediate to register rs1. Arithmetic overflow is ignored and the result is simply the low XLEN bits of the result.    
--  ADD   -- 15  -- ADD and SUB perform addition and subtraction respectively. Overflows are ignored and the low
--  SUB   -- 15  -- XLEN bits of results are written to the destination
--  SLT   -- 15  -- SLT and SLTU perform signed and unsigned compares respectively, writing 1 to rd if rs1 < rs2, 0 otherwise. 
--  SLTU  -- 15  -- Note, SLTU rd, x0, rs2 sets rd to 1 if rs2 is not equal to zero, otherwise sets rd to zero  
-------------------
--  SLTI  -- 13  -- Set Less Than Immediate places the value 1 in register rd if register rs1 is less than the sign extended immediate when both are treated as signed numbers, else 0 is written to rd.    
-- SLTIU  -- 14  -- Set Less Than Immediate Upper is similar but compares the values as unsigned numbers (i.e., the immediate is first sign-extended to XLEN bits then treated as an unsigned number)
-------------------
--  ANDI  -- 14  -- ANDI, ORI, XORI are logical operations that perform bitwise AND, OR, and XOR on register rs1
--  ORI   -- 14  -- and the sign-extended 12-bit immediate and place the result in rd. Note, XORI rd, rs1, -1 performs 
--  XORI  -- 14  -- a bitwise logical inversion of register rs1 (assembler pseudo-instruction NOT rd, rs).            
--inst_AND-- 14  --     
--inst_OR -- 14  --
--inst_XOR-- 14  --
-------------------
--  SLLI  -- 14  -- Shifts by a constant are encoded as a specialization of the I-type format. The operand to be shifted
--  SRLI  -- 14  -- is in rs1, and the shift amount is encoded in the lower 5 bits of the I-immediate field. The right
--  SRAI  -- 14  -- shift type is encoded in a high bit of the I-immediate. SLLI is a logical left shift (zeros are shifted  
--inst_SLL-- 14  --         
--inst_SRL-- 14  --        
--inst_SRA-- 14  --    
-------------------     
--  FENCE -- 20  --  The FENCE instruction is used to order device I/O and memory accesses as viewed by other RISCV harts and external devices or coprocessors.
-- FENCEI -- 20  --   
--  EXALL -- 24  -- The ECALL instruction is used to make a request to the supporting execution environment, which is usually an operating system. The ABI for the system will define how parameters for the environment request are passed, but usually these will be in defined locations in the integer register file.
-- EBREAK -- 24  -- The EBREAK instruction is used by debuggers to cause control to be transferred back to a debugging environment.   
-------------------
-- CSRRW  -- 22  -- The CSRRW (Atomic Read/Write CSR) instruction atomically swaps values in the CSRs and integer registers.    
-- CSRRS  -- 22  -- The CSRRS (Atomic Read and Set Bits in CSR) instruction reads the value of the CSR, zeroextends the value to XLEN bits, and writes it to integer register rd.    
-- CSRRC  -- 22  -- The CSRRC (Atomic Read and Clear Bits in CSR) instruction reads the value of the CSR, zeroextends the value to XLEN bits, and writes it to integer register rd.   
-- CSRRSI -- 22  -- The CSRRWI, CSRRSI, and CSRRCI variants are similar to CSRRW, CSRRS, and CSRRC respectively, except they update the CSR using.    
-- CSRRCI -- 22  -- an XLEN-bit value obtained by zero-extending a 5-bit unsigned immediate (uimm[4:0]) field encoded in the rs1 field instead of.  
-- CSRRWI -- 22  -- a value from an integer.  