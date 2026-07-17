# 32-bit Single-Cycle RV32I Processor

## Overview

This project implements a 32-bit Single-Cycle RISC-V (RV32I) processor in SystemVerilog.

The processor executes one instruction per clock cycle and supports arithmetic, logical, memory access, branch instructions, a custom AVG instruction, and architectural performance counters.

---

## Features

- Program Counter (PC)
- Next PC Logic
- Instruction Memory
- Register File (32 × 32-bit)
- Immediate Generator
- Main Control Unit
- ALU Control Unit
- 32-bit ALU
- Data Memory
- Branch Decision Logic
- Writeback Multiplexer
- Datapath Integration
- Processor Top Module
- Testbench
- Custom AVG Instruction
- Architectural Performance Counters

---

## Supported Instructions

### R-Type

- ADD
- SUB
- AND
- OR
- XOR
- SLL
- SRL
- SRA
- SLT
- SLTU

### I-Type

- ADDI
- ANDI
- ORI
- XORI
- SLLI
- SRLI
- SRAI
- SLTI

### Memory

- LW
- SW

### Branch

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

### Custom

AVG rd, rs1, rs2

```
rd = (rs1 + rs2) / 2
```

---

## Performance Counters

- Cycle Counter
- Instruction Counter
- Branch Counter
- Memory Counter
- AVG Instruction Counter

---

## Tools Used

- SystemVerilog
- Icarus Verilog
- GTKWave / EPWave
- EDA Playground

---

## Project Structure

```
program_counter
next_pc_logic
instruction_memory
register_file
immediate_generator
main_control_unit
alu_control
alu_32bit
data_memory
branch_decision
writeback_mux
performance_counters
datapath
processor_top
processor_top_tb
```

---

## Sample Output

```
Cycle Count       = 23
Instruction Count = 23
Branch Count      = 1
Memory Count      = 2
AVG Count         = 1
```

---

## Future Improvements

- Five-stage pipelined processor
- Hazard detection
- Forwarding unit
- Branch prediction
- CSR support
- Interrupt handling
