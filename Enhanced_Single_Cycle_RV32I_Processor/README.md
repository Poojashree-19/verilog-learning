# 32-bit Single-Cycle RV32I Processor in SystemVerilog

## Overview

This project implements a **32-bit Single-Cycle RISC-V (RV32I) Processor** using **SystemVerilog**. The processor supports the core RV32I instruction set, including arithmetic, logical, memory access, branch, and immediate instructions.

In addition, the processor has been enhanced with:

- A **custom AVG instruction**
- **Architectural Performance Counters** to monitor processor execution statistics

The design was verified using a SystemVerilog testbench and waveform analysis in EDA Playground.

---

## Features

- 32-bit Single-Cycle RV32I Processor
- Modular RTL Design
- Program Counter (PC)
- Next PC Logic
- Instruction Memory
- Register File (32 × 32-bit Registers)
- Immediate Generator
- Main Control Unit
- ALU Control Unit
- 32-bit ALU
- Data Memory
- Branch Decision Logic
- Writeback Multiplexer
- Complete Datapath Integration
- Processor Top Module
- SystemVerilog Testbench
- Waveform Verification

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

### Memory Instructions

- LW
- SW

### Branch Instructions

- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

---

## Custom Instruction

### AVG (Average)

A custom instruction was added using a custom RISC-V opcode.

### Operation

```text
AVG rd, rs1, rs2

rd = (rs1 + rs2) / 2
```

Example:

```text
AVG x12, x10, x11
```

If

```text
x10 = 20
x11 = 10
```

Then

```text
x12 = 15
```

---

## Architectural Performance Counters

The processor includes built-in performance counters to monitor execution.

- Cycle Counter
- Instruction Counter
- Branch Counter
- Memory Operation Counter
- Custom AVG Instruction Counter

Example Output

```text
----------------------------------------
Simulation Finished
----------------------------------------
Cycle Count       = 23
Instruction Count = 23
Branch Count      = 1
Memory Count      = 2
AVG Count         = 1
```

---

## Project Structure

```text
RV32I-Single-Cycle-Processor/

├── rv32i_processor.sv
├── processor_top_tb.sv
├── README.md
├── LICENSE
└── screenshots/
    └── waveform.png
```

---

## Design Modules

- Program Counter
- Next PC Logic
- Instruction Memory
- Register File
- Immediate Generator
- Main Control Unit
- ALU Control Unit
- 32-bit ALU
- Data Memory
- Branch Decision Unit
- Writeback Multiplexer
- Performance Counters
- Datapath
- Processor Top

---

## Simulation

The processor was verified using a custom SystemVerilog testbench.

Simulation includes:

- Arithmetic Instructions
- Logical Instructions
- Memory Access
- Branch Execution
- Custom AVG Instruction
- Performance Counter Verification

---

## Waveform

Add your waveform screenshot here.

```markdown
![Waveform](screenshots/waveform.png)
```

---

## Tools Used

- SystemVerilog
- Icarus Verilog
- EDA Playground
- EPWave / GTKWave
- GitHub

---

## Skills Demonstrated

- RTL Design
- Digital Logic Design
- Computer Architecture
- RISC-V ISA
- Datapath Design
- Control Unit Design
- Custom Instruction Design
- Performance Monitoring
- SystemVerilog
- Functional Verification
- Testbench Development
- Waveform Analysis

---

## Future Enhancements

- Five-stage Pipelined RV32I Processor
- Hazard Detection Unit
- Data Forwarding Unit
- Branch Prediction
- CSR (Control and Status Registers)
- Interrupt and Exception Handling
- Instruction & Data Cache Support

---

## Author

**Poojashree DH**

Electrical and Electronics Engineering  
PES University

GitHub: https://github.com/Poojashree-19
