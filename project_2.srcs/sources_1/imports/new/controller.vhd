library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
library riscv;
use riscv.all;

entity controller is
    port (
        clock : in std_logic;
        reset : in std_logic;
        instruction : in std_logic_vector(31 downto 0);

        reg_file_read_address_0 : out std_logic_vector(4 downto 0);
        reg_file_read_address_1 : out std_logic_vector(4 downto 0);
        csr_file_read_address_0 : out std_logic_vector(11 downto 0);

        CSR_file_write : out std_logic;
        reg_file_write : out std_logic;
        reg_file_write_address : out std_logic_vector(4 downto 0);

        immediate : out std_logic_vector(31 downto 0);

        ALU_operation : out std_logic_vector(3 downto 0);
        ALU_branch : out std_logic;
        ALU_branch_control : out std_logic_vector(2 downto 0);

        JTU_mux_sel : out std_logic;
        current_state_out : out std_logic_vector(1 downto 0);

        data_format : out std_logic_vector(2 downto 0);
        datamem_write : out std_logic;
        jump_flag : out std_logic;
        mux0_sel : out std_logic_vector(1 downto 0);
        mux1_sel : out std_logic_vector(1 downto 0)
    );

    type word is array (31 downto 0) of std_logic;
end entity controller;

architecture Behavioral of controller is
       -- The operating state of the machine. This will
       -- likely be moved to a different types package in the future.
    type operational_states is (
       NORMAL,     -- Normal, or 'user' mode
       SUPERVISOR, -- One Execution level above NORMAL
       HYPERVISOR, -- One level above Supervisor
       MACHINE);   -- "Kernel" level access, highest access level

    type instruction_cluster is (
       INVALID, 
       LOAD, 
       STORE, 
       MADD, 
       BRANCH, 
       LOAD_FP, 
       STORE_FP, 
       MSUB, 
       JALR, 
       NMSUB, 
       MISC_MEM, 
       AMO, 
       NMADD, 
       JAL, 
       OP_IMM, 
       OP, 
       OP_FP, 
       SYSTEM, 
       AUIPC, 
       LUI, 
       OP_IMM_32, 
       OP_32);
    signal current_state, next_state : operational_states := NORMAL;
    signal decoded_cluster : instruction_cluster;

    type opcode is (INVALID, LUI, AUIPC, JAL, JALR, BEQ, BNE, BLT, BGE, BLTU, BGEU, LB, LH, LW, LBU, LHU, SB, SH, SW, ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, ADD, SUB, inst_SLL, SLT, SLTU, inst_XOR, inst_SRL, inst_SRA, inst_OR, inst_AND, FENCE, FENCEI, EXALL, EBREAK, CSRRW, CSRRS, CSRRC, CSRRSI, CSRRCI, CSRRWI);
    signal decoded_opcode : opcode;

    signal fetched_instruction : std_logic_vector (31 downto 0) := x"00000000";
    signal internal_immediate : std_logic_vector (31 downto 0) := x"00000000";
    signal internal_reg_file_read_address_0 : std_logic_vector(4 downto 0) := "00000";
    signal internal_reg_file_read_address_1 : std_logic_vector(4 downto 0) := "00000";
    signal internal_reg_file_write : std_logic := '0';
    --signal internal_CSR_file_write : std_logic := '0';
    signal internal_reg_file_write_address : std_logic_vector(4 downto 0) := "00000";
    signal internal_PC_operation : std_logic_vector(2 downto 0) := "000";
    signal internal_ALU_operation : std_logic_vector(3 downto 0) := "0000";
    signal internal_ALU_branch : std_logic := '0';
    signal internal_ALU_branch_control : std_logic_vector(2 downto 0) := "000";
    signal internal_JTU_mux_sel : std_logic;
    signal internal_data_format : std_logic_vector(2 downto 0) := "000";
    signal internal_datamem_write : std_logic := '0';
    signal internal_jump_flag : std_logic := '0';
    signal internal_mux0_sel : std_logic_vector(1 downto 0) := "00";
    signal internal_mux1_sel : std_logic_vector(1 downto 0) := "00";
    signal internal_ALU_OP_SYSTEM : std_logic_vector(3 downto 0) := "0000";
    signal internal_mux1_sel_system : std_logic_vector(1 downto 0) := "00";

    signal next_decoded_cluster : instruction_cluster;
    signal next_decoded_opcode : opcode;
    signal immediate_substitute : std_logic_vector (31 downto 0);
    signal ALU_substitute : std_logic_vector(3 downto 0);


begin

-- Commented 8/31/21
-- What the hell does this do?
--    process (clock, reset)
--    begin
--        if (reset = '1') then
--            current_state <= normal;
--        elsif rising_edge(clock) then
--            current_state <= next_state;			
--            decoded_cluster <= next_decoded_cluster;
--            decoded_opcode <= next_decoded_opcode;
--            fetched_instruction <= instruction;
--        end if;
--    end process;

decoded_cluster <= next_decoded_cluster;
decoded_opcode <= next_decoded_opcode;
fetched_instruction <= instruction;

--/-----------------------------\
--| OPCODE INSTRUCTION DECODING |
--\-----------------------------/
with fetched_instruction select?
next_decoded_opcode <=
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

--/-----------------------------\
--|      CLUSTER DECODING       |
--\-----------------------------/  
with fetched_instruction select?
next_decoded_cluster <=
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

with current_state select
current_state_out <=
       "00" when NORMAL,
       "01" when SUPERVISOR,
       "10" when HYPERVISOR,
       "11" when MACHINE;

-- TODO-19:  Change this to an enum
internal_ALU_OP_SYSTEM <=
       "1001" when(next_decoded_opcode = CSRRC)else
       "0110" when(next_decoded_opcode = CSRRS)else
       "1011" when(next_decoded_opcode = CSRRW)else
       "1001" when(next_decoded_opcode = CSRRCI)else--TODO-16: IMPLEMENT--
       "0110" when(next_decoded_opcode = CSRRSI)else--TODO-17: IMPLEMENT--
       "1011" when(next_decoded_opcode = CSRRWI)else--TODO-18: IMPLEMENT--
       "0000";

--/-----------------------------\
--|       Read Address 0        |
--\-----------------------------/     
with decoded_cluster select
internal_reg_file_read_address_0 <=
        "00000"                           when INVALID,
        fetched_instruction(19 downto 15) when LOAD,
        fetched_instruction(19 downto 15) when STORE,
        fetched_instruction(19 downto 15) when BRANCH,
        fetched_instruction(19 downto 15) when JALR,
        "00000"                           when JAL,
        fetched_instruction(19 downto 15) when OP_IMM,
        fetched_instruction(19 downto 15) when OP,
        "00000"                           when AUIPC,
        "00000"                           when LUI,
        fetched_instruction(19 downto 15) when SYSTEM,
        "00000" 				when others;

--/-----------------------------\
--|       Read Address 1        |
--\-----------------------------/    
with decoded_cluster select
internal_reg_file_read_address_1 <=
        "00000"                           when INVALID,
        fetched_instruction(24 downto 20) when LOAD,
        fetched_instruction(24 downto 20) when STORE,
        fetched_instruction(24 downto 20) when BRANCH,
        "00000"                           when JALR,
        "00000"                           when JAL,
        fetched_instruction(24 downto 20) when OP_IMM,
        fetched_instruction(24 downto 20) when OP,
        "00000"                           when AUIPC,
        "00000"                           when LUI,
        fetched_instruction(11 downto 7)  when SYSTEM,
        "00000"                           when others;



--/--------------------------------------------\
--| Special stuff for system instructions only |
--\--------------------------------------------/  
with decoded_cluster select
csr_file_read_address_0 <=
        fetched_instruction(31 downto 20) when SYSTEM,
        "000000000000"                    when others;

-- TODO-20: figure out a better way to implement CSR signals.
with decoded_cluster select
CSR_file_write <=
       '1' when SYSTEM,
       '0' when others;

--/-----------------------------\
--|        Reg write bit        |
--\-----------------------------/  
with decoded_cluster select
internal_reg_file_write <=
       '0' when INVALID,
       '1' when LOAD,
       '0' when STORE,
       '0' when BRANCH,
       '1' when JALR,
       '1' when JAL,
       '1' when OP_IMM,
       '1' when OP,
       '1' when AUIPC,
       '1' when LUI,
       '0' when others;


--/-----------------------------\
--|       Reg write addr        |
--\-----------------------------/  
with decoded_cluster select
internal_reg_file_write_address<=
       "00000"                          when INVALID,
       fetched_instruction(11 downto 7) when LOAD,
       "00000"                          when STORE,
       "00000"                          when BRANCH,
       fetched_instruction(11 downto 7) when JALR,
       fetched_instruction(11 downto 7) when JAL,
       fetched_instruction(11 downto 7) when OP_IMM,
       fetched_instruction(11 downto 7) when OP,
       fetched_instruction(11 downto 7) when AUIPC,
       fetched_instruction(11 downto 7) when LUI,
       fetched_instruction(11 downto 7) when SYSTEM,
       "00000"                          when others;

with decoded_cluster select
internal_immediate <=
       x"00000000"                                                                                                                                                                                when INVALID,
       std_logic_vector("00000000000000000000" & fetched_instruction(31 downto 25) & fetched_instruction(11 downto 7))                                                                            when LOAD,
       std_logic_vector("00000000000000000000" & fetched_instruction(31 downto 20))                                                                                                               when STORE,
       std_logic_vector("00000000000000000" & fetched_instruction(31) & fetched_instruction(7) & fetched_instruction(30 downto 25) & fetched_instruction(11 downto 6) & '0')                      when BRANCH,
       std_logic_vector(shift_right(signed(fetched_instruction(31 downto 20) & "00000000000000000000"), 20))                                                                                      when JALR,
       std_logic_vector(shift_right(signed(fetched_instruction(31) & fetched_instruction(19 downto 12) & fetched_instruction(20) & fetched_instruction(30 downto 21) & '0' & "00000000000"), 11)) when JAL,
       immediate_substitute                                                                                                                                                                       when OP_IMM,
       x"00000000"                                                                                                                                                                                when OP,
       std_logic_vector(fetched_instruction(31 downto 12) & "000000000000")                                                                                                                       when AUIPC,
       std_logic_vector(fetched_instruction(31 downto 12) & "000000000000")                                                                                                                       when LUI,
       std_logic_vector("000000000000000000000000000" & fetched_instruction(19 downto 15))                                                                                                        when SYSTEM,
       x"00000000"                                                                                                                                                                                when others;


--/----------------------------\
--| A micro opcode for the ALU |
--\----------------------------/  
with decoded_cluster select
internal_ALU_operation <=
       ALU_substitute                                                                when OP_IMM,
       std_logic_vector(fetched_instruction(30) & fetched_instruction(14 downto 12)) when OP,
       internal_ALU_OP_SYSTEM                                                        when SYSTEM,
       "0000"                                                                        when others;

--/--------------------------------------\
--|Tells the ALU whether or not to branch|
--\--------------------------------------/  
with decoded_cluster select
internal_ALU_branch <=
       '1' when BRANCH,
       '0' when others;

with decoded_cluster select
internal_ALU_branch_control<=
       std_logic_vector(fetched_instruction(14 downto 12)) when BRANCH,
       "000"                                               when others;

--/-------------\
--|Jumping logic|
--\-------------/  

with decoded_cluster select
internal_JTU_mux_sel <=
       '1' when JALR,
       '0' when others;

with decoded_cluster select
internal_jump_flag<=
       '1' when JALR,
       '1' when JAL,
       '0' when others;

with decoded_cluster select
internal_mux0_sel <=
       "01" when LOAD,
       "10" when JALR,
       "10" when JAL,
       "00" when others;

with decoded_cluster select
internal_data_format <=
       std_logic_vector(fetched_instruction(14 downto 12)) when LOAD,
       std_logic_vector(fetched_instruction(14 downto 12)) when STORE,
       "000"                                               when others;

with decoded_cluster select
internal_datamem_write <=
       '1' when STORE,
       '0' when others;

with decoded_opcode select
internal_mux1_sel_system<=
       "10" when CSRRW,
       "10" when CSRRC,
       "10" when CSRRS,
       "01" when CSRRWI,
       "01" when CSRRCI,
       "01" when CSRRSI,
       "00" when others;

with decoded_cluster select
internal_mux1_sel<=
       "01" when LOAD,
       "01" when STORE,
       "01" when OP_IMM,
       "01" when LUI,
       internal_mux1_sel_system when SYSTEM,
       "00" when others;

with decoded_opcode select
immediate_substitute <=
       std_logic_vector(shift_right(signed(fetched_instruction(31 downto 20) & "00000000000000000000"), 20)) when ADDI,
       std_logic_vector(shift_right(signed(fetched_instruction(31 downto 20) & "00000000000000000000"), 20)) when SLTI,
       std_logic_vector(shift_right(signed(fetched_instruction(31 downto 20) & "00000000000000000000"), 20)) when SLTIU,
       std_logic_vector("00000000000000000000" & fetched_instruction(31 downto 20)) when XORI,
       std_logic_vector("00000000000000000000" & fetched_instruction(31 downto 20)) when ANDI,
       std_logic_vector("00000000000000000000" & fetched_instruction(31 downto 20)) when ORI,
       std_logic_vector("000000000000000000000000000" & fetched_instruction(24 downto 20)) when others;

with decoded_opcode select
ALU_substitute <=
       std_logic_vector('0' & fetched_instruction(14 downto 12)) when ADDI,
       std_logic_vector('0' & fetched_instruction(14 downto 12)) when SLTI,
       std_logic_vector('0' & fetched_instruction(14 downto 12)) when SLTIU,
       std_logic_vector('0' & fetched_instruction(14 downto 12)) when XORI,
       std_logic_vector('0' & fetched_instruction(14 downto 12)) when ANDI,
       std_logic_vector('0' & fetched_instruction(14 downto 12)) when ORI,
       std_logic_vector('0' & fetched_instruction(14 downto 12)) when SLLI,
       std_logic_vector(fetched_instruction(30) & fetched_instruction(14 downto 12)) when others;

    reg_file_read_address_0 <= internal_reg_file_read_address_0;
    reg_file_read_address_1 <= internal_reg_file_read_address_1;
    reg_file_write          <= internal_reg_file_write;
    reg_file_write_address  <= internal_reg_file_write_address;
    immediate               <= internal_immediate;
    ALU_operation           <= internal_ALU_operation;
    ALU_branch              <= internal_ALU_branch;
    ALU_branch_control      <= internal_ALU_branch_control;
    JTU_mux_sel             <= internal_JTU_mux_sel;
    data_format             <= internal_data_format;
    datamem_write           <= internal_datamem_write;
    jump_flag               <= internal_jump_flag;
    mux0_sel                <= internal_mux0_sel;
    mux1_sel                <= internal_mux1_sel;

end architecture Behavioral;