# Pipelined 8-bit ALU with Full Flag Unit and Hazard Awareness

## Project Overview

This project implements a 2-stage pipelined 8-bit Arithmetic Logic Unit (ALU) using SystemVerilog.
The design supports arithmetic and logical operations, generates status flags, stores flags in a dedicated flag register, 
and includes basic hazard handling through stall and flush mechanisms.

The project was verified using SystemVerilog testbenches and waveform analysis in EDA Playground.

---

## Features

### Supported Operations

| Opcode | Operation |
| ------ | --------- |
| 000    | ADD       |
| 001    | SUB       |
| 010    | AND       |
| 011    | OR        |
| 100    | XOR       |

### Status Flags

* Zero Flag (Z)
* Carry Flag (C)
* Overflow Flag (V)
* Negative Flag (N)
* Parity Flag (P)

### Pipeline Features

* 2-stage pipelined architecture
* Pipeline register between input and execution stages
* Registered ALU result output
* Dedicated flag register
* Stall support
* Flush support

---

## Architecture

```text
Input Operands
      │
      ▼
Pipeline Register
      │
      ▼
ALU + Flag Generation
      │
      ▼
Result Register
      │
      ▼
Flag Register
      │
      ▼
Outputs
```

---

## RTL Modules

* `alu_8bit.sv`
* `Pipeline_reg.sv`
* `flags_register.sv`
* `pipelined_alu_top.sv`

---

## Verification

The design was verified using SystemVerilog testbenches.

### Test Cases

* ADD operation
* SUB operation
* AND operation
* Zero flag generation
* Carry flag generation
* Overflow flag generation
* Stall operation
* Flush operation

Waveforms were analyzed to verify:

* Correct pipeline behavior
* Correct ALU outputs
* Proper flag generation
* Stall functionality
* Flush functionality
* Result and flag alignment

---

## Waveform

The waveform demonstrates:

* Input capture through the pipeline register
* ALU execution
* Registered result output
* Flag register operation
* Stall behavior
* Flush behavior

> Add your waveform image here:
>
> `pipelined_alu_top.png`

---

## Tools Used

* SystemVerilog
* EDA Playground
* EPWave

---

## Learning Outcomes

Through this project, I learned:

* Combinational logic design
* Sequential logic design
* ALU implementation
* Status flag generation
* Pipeline register design
* Hazard handling using stall and flush
* Module integration
* Testbench development
* Waveform-based verification

---

## Author

**Poojashree DH**
Electrical Engineering
PES University
