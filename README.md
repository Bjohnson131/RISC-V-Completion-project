# RISC-V-Completion-project

## The Big To-Do List

### Refactoring:
---
#### CSRs:
##### CSR/CSR_hpmcounter.vhd
 - [ ] Triage
 - [ ] Implementation
 - [ ] Change Naming to Capital
 ---
##### CSR/CSR_MARCHID_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MCAUSE_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MCOUNTEREN_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MEDELEG_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MEPC_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MHARTID_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MIDELEG_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MIE_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MIMPID_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MIP_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MISA_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MSCRATCH_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MSTATUS_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MTVAL_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MTVEC_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_MVENDORID_REG.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_Regfile.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_TIMER.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
##### CSR/CSR_TIMER_ARRAY.vhd
 - [ ] Triage
 - [ ] Implementation
 ---
#### Top Level Modules
 - [ ] Triage  
 
Current files: 
Acumulator.vhd  
adder.vhd  
ALU.vhd  
controller.vhd  
datamem.vhd  
datamem_interface.vhd  
datapath.vhd  
debounce.vhd  
DEMUX_32_1.vhd  
flushing_unit.vhd  
forwarding_unit.vhd  
forwarding_unit_CSR.vhd  
INTERRUPT_CONTROL_UNIT.vhd  
jump_target_unit.vhd  
MCU2.vhd  
MCU_testbench.vhd  
microcontroller.vhd  
progmem_interface.vhd  
program_counter.vhd  
register_file.vhd  
RISCV_Black_Box_Translator.vhd  
SEL_CLK_DIV.vhd  
Slider_mux.vhd  
TEST_TOP_COUNTERS.vhd  

#### Muxes
---
 - [x] Triage
 - [ ] Use generics instead of lots of files.
 - [ ] Genericise a Nx1 mux
 - [ ] Genericise a NxN mux  

Current files: 
Mux/mux_2_1.vhd
Mux/mux_32_1.vhd
Mux/mux_32_32.vhd
Mux/mux_3_1.vhd
Mux/mux_4_1.vhd
Mux/mux_5_1.vhd

#### Registers
---
 - [x] Triage
 - [ ] Use generics instead of lots of files.
 - [ ] Genericise an n-bit mux
 - [ ] Genericise an n-bit mux on any type of change    
 
Current files: 
Register/reg12b.vhd
Register/reg1b.vhd
Register/reg2b.vhd
Register/reg32b.vhd
Register/reg32b_falling_edge.vhd
Register/reg3b.vhd
Register/reg4b.vhd
Register/reg5b.vhd
#### Staging
---
 - [ ] Triage
 - [ ] Turn instructions into data types
 - [ ] Put instructions into a new library
 - [ ] Define basic operations of instructions.  
 
Current files: 
Stage/EX_MEM_DIV.vhd
Stage/EX_STAGE.vhd
Stage/ID_EX_DIV.vhd
Stage/ID_STAGE.vhd
Stage/IF_ID_DIV.vhd
Stage/IF_STAGE.vhd
Stage/MEM_STAGE.vhd
Stage/MEM_WB_DIV.vhd
Stage/WB_STAGE.vhd