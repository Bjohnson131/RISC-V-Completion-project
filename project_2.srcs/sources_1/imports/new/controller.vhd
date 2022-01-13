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
        instruction : in types.INSTR;

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
        mux1_sel : out types.MEMORY_MUX_SEL;

        debug_decoded_cluster : out types.instruction_cluster;
        debug_decoded_opcode : out types.opcode
    );
end entity controller;

architecture Behavioral of controller is
    -- The operating state of the machine. This will
    -- likely be moved to a different types package in the future.

    signal current_state, next_state : types.operational_states := types.NORMAL;
    signal decoded_cluster           : types.instruction_cluster;
    signal decoded_opcode            : types.opcode;
    signal mux1_sel_system           : types.MEMORY_MUX_SEL;
    signal ALU_OP_SYSTEM             : std_logic_vector(3 downto 0) := "0000";
    --signal next_decoded_cluster : types.instruction_cluster;
    signal immediate_substitute : std_logic_vector (31 downto 0);
    signal ALU_substitute : std_logic_vector(3 downto 0);

begin

    decoded_opcode  <= types.OP(instruction);
    decoded_cluster <= types.CLUSTER(instruction);
    debug_decoded_cluster <= decoded_cluster;
    debug_decoded_opcode <= decoded_opcode;

    with current_state select
 current_state_out <=
        "00" when types.NORMAL,
        "01" when types.SUPERVISOR,
        "10" when types.HYPERVISOR,
        "11" when types.MACHINE;

    -- TODO-19:  Change this to an enum
    with decoded_opcode select
 ALU_OP_SYSTEM <=
        "1001" when types.CSRRC,
        "0110" when types.CSRRS,
        "1011" when types.CSRRW,
        "1001" when types.CSRRCI, --TODO-16: IMPLEMENT--
        "0110" when types.CSRRSI, --TODO-17: IMPLEMENT--
        "1011" when types.CSRRWI, --TODO-18: IMPLEMENT--
        "0000" when others;

    --/-----------------------------\
    --|       Read Address 0        |
    --\-----------------------------/     
    with decoded_cluster select
 reg_file_read_address_0 <=
        instruction(19 downto 15) when types.SYSTEM,
        instruction(19 downto 15) when types.OP_IMM,
        instruction(19 downto 15) when types.OP_NIMM,
        instruction(19 downto 15) when types.LOAD,
        instruction(19 downto 15) when types.STORE,
        instruction(19 downto 15) when types.BRANCH,
        instruction(19 downto 15) when types.JALR,
        "00000"                       when others;

    --/-----------------------------\
    --|       Read Address 1        |
    --\-----------------------------/    
    with decoded_cluster select
 reg_file_read_address_1 <=
        instruction(11 downto 7)  when types.SYSTEM,
        instruction(24 downto 20) when types.OP_IMM,
        instruction(24 downto 20) when types.OP_NIMM,
        instruction(24 downto 20) when types.LOAD,
        instruction(24 downto 20) when types.STORE,
        instruction(24 downto 20) when types.BRANCH,
        "00000"                   when others;



    --/--------------------------------------------\
    --| Special stuff for system instructions only |
    --\--------------------------------------------/  
    with decoded_cluster select
 csr_file_read_address_0 <=
        instruction(31 downto 20) when types.SYSTEM,
        "000000000000"            when others;

    -- TODO-20: figure out a better way to implement CSR signals.
    with decoded_cluster select
 CSR_file_write <=
        '1' when types.SYSTEM,
        '0' when others;

    --/-----------------------------\
    --|        Reg write bit        |
    --\-----------------------------/  
    with decoded_cluster select
 reg_file_write <=
        '0' when types.INVALID,
        '0' when types.STORE,
        '0' when types.BRANCH,
        '1' when types.LOAD,
        '1' when types.JALR,
        '1' when types.JAL,
        '1' when types.OP_IMM,
        '1' when types.OP_NIMM,
        '1' when types.AUIPC,
        '1' when types.LUI,
        '0' when others;


    --/-----------------------------\
    --|       Reg write addr        |
    --\-----------------------------/  
    with decoded_cluster select
 reg_file_write_address<=
        instruction(11 downto 7) when types.LOAD,
        instruction(11 downto 7) when types.JALR,
        instruction(11 downto 7) when types.JAL,
        instruction(11 downto 7) when types.OP_IMM,
        instruction(11 downto 7) when types.OP_NIMM,
        instruction(11 downto 7) when types.AUIPC,
        instruction(11 downto 7) when types.LUI,
        instruction(11 downto 7) when types.SYSTEM,
        "00000"                  when others;

    with decoded_cluster select
 immediate <=
        x"00000000"                                                                                                                                                when types.INVALID,
        std_logic_vector("00000000000000000000" & instruction(31 downto 25) & instruction(11 downto 7))                                                            when types.LOAD,
        std_logic_vector("00000000000000000000" & instruction(31 downto 20))                                                                                       when types.STORE,
        std_logic_vector("00000000000000000" & instruction(31) & instruction(7) & instruction(30 downto 25) & instruction(11 downto 6) & '0')                      when types.BRANCH,
        std_logic_vector(shift_right(signed(instruction(31 downto 20) & "00000000000000000000"), 20))                                                              when types.JALR,
        std_logic_vector(shift_right(signed(instruction(31) & instruction(19 downto 12) & instruction(20) & instruction(30 downto 21) & '0' & "00000000000"), 11)) when types.JAL,
        immediate_substitute                                                                                                                                       when types.OP_IMM,
        x"00000000"                                                                                                                                                when types.OP_NIMM,
        std_logic_vector(instruction(31 downto 12) & "000000000000")                                                                                               when types.AUIPC,
        std_logic_vector(instruction(31 downto 12) & "000000000000")                                                                                               when types.LUI,
        std_logic_vector("000000000000000000000000000" & instruction(19 downto 15))                                                                                when types.SYSTEM,
        x"00000000"                                                                                                                                                when others;


    --/----------------------------\
    --| A micro opcode for the ALU |
    --\----------------------------/  
    with decoded_cluster select
 ALU_operation <=
        ALU_substitute                                                when types.OP_IMM,
        std_logic_vector(instruction(30) & instruction(14 downto 12)) when types.OP_NIMM,
        ALU_OP_SYSTEM                                                 when types.SYSTEM,
        "0000"                                                        when others;

    --/--------------------------------------\
    --|Tells the ALU whether or not to branch|
    --\--------------------------------------/  
    with decoded_cluster select
 ALU_branch <=
        '1' when types.BRANCH,
        '0' when others;

    with decoded_cluster select
 ALU_branch_control<=
        std_logic_vector(instruction(14 downto 12)) when types.BRANCH,
        "000"                                       when others;

    --/-------------\
    --|Jumping logic|
    --\-------------/  

    with decoded_cluster select
 JTU_mux_sel <=
        '1' when types.JALR,
        '0' when others;

    with decoded_cluster select
 jump_flag<=
        '1' when types.JALR,
        '1' when types.JAL,
        '0' when others;

    with decoded_cluster select
 mux0_sel <=
        "01" when types.LOAD,
        "10" when types.JALR,
        "10" when types.JAL,
        "00" when others;

    with decoded_cluster select
 data_format <=
        std_logic_vector(instruction(14 downto 12)) when types.LOAD,
        std_logic_vector(instruction(14 downto 12)) when types.STORE,
        "000"                                       when others;

    with decoded_cluster select
 datamem_write <=
        '1' when types.STORE,
        '0' when others;

    with decoded_opcode select
 mux1_sel_system<=
        types.ATOMIC_SWAP when types.CSRRW,
        types.ATOMIC_SWAP when types.CSRRC,
        types.ATOMIC_SWAP when types.CSRRS,
        types.SINGLE_OP   when types.CSRRWI,
        types.SINGLE_OP   when types.CSRRCI,
        types.SINGLE_OP   when types.CSRRSI,
        types.NOP         when others;

    with decoded_cluster select
 mux1_sel<=
        types.SINGLE_OP when types.LOAD,
        types.SINGLE_OP when types.STORE,
        types.SINGLE_OP when types.OP_IMM,
        types.SINGLE_OP when types.LUI,
        mux1_sel_system when types.SYSTEM,
        types.NOP                when others;

    with decoded_opcode select
 immediate_substitute <=
        std_logic_vector(shift_right(signed(instruction(31 downto 20) & "00000000000000000000"), 20))    when types.ADDI,
        std_logic_vector(shift_right(signed(instruction(31 downto 20) & "00000000000000000000"), 20))    when types.SLTI,
        std_logic_vector(shift_right(signed(instruction(31 downto 20) & "00000000000000000000"), 20))    when types.SLTIU,
        std_logic_vector("00000000000000000000" & instruction(31 downto 20))                             when types.XORI,
        std_logic_vector("00000000000000000000" & instruction(31 downto 20))                             when types.ANDI,
        std_logic_vector("00000000000000000000" & instruction(31 downto 20))                             when types.ORI,
        std_logic_vector("000000000000000000000000000" & instruction(24 downto 20))                      when others;

    with decoded_opcode select
 ALU_substitute <=
        std_logic_vector('0' & instruction(14 downto 12)) when types.ADDI,
        std_logic_vector('0' & instruction(14 downto 12)) when types.SLTI,
        std_logic_vector('0' & instruction(14 downto 12)) when types.SLTIU,
        std_logic_vector('0' & instruction(14 downto 12)) when types.XORI,
        std_logic_vector('0' & instruction(14 downto 12)) when types.ANDI,
        std_logic_vector('0' & instruction(14 downto 12)) when types.ORI,
        std_logic_vector('0' & instruction(14 downto 12)) when types.SLLI,
        std_logic_vector(instruction(30) & instruction(14 downto 12)) when others;

    --reg_file_read_address_0 <= reg_file_read_address_0;
    --reg_file_read_address_1 <= reg_file_read_address_1;
    --reg_file_write          <= reg_file_write;
    --reg_file_write_address  <= reg_file_write_address;
    --ALU_operation           <= ALU_operation;
    --ALU_branch              <= ALU_branch;
    --ALU_branch_control      <= ALU_branch_control;
    --JTU_mux_sel             <= JTU_mux_sel;
    --data_format             <= data_format;
    --datamem_write           <= datamem_write;
    --jump_flag               <= jump_flag;
    --mux0_sel                <= mux0_sel;

end architecture Behavioral;