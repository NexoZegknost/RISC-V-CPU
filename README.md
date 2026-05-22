# RISC-V CPU Design

![GitHub stars](https://img.shields.io/github/stars/NexoZegknost/RISC-V-CPU?style=for-the-badge&logo=github) ![GitHub forks](https://img.shields.io/github/forks/NexoZegknost/RISC-V-CPU?style=for-the-badge&logo=github) ![GitHub issues](https://img.shields.io/github/issues/NexoZegknost/RISC-V-CPU?style=for-the-badge&logo=github) ![License](https://img.shields.io/badge/license-LICENSE-green?style=for-the-badge)

## 📑 Table of Contents

- [Description](#description)
- [Quick Start](#quick-start)
- [Screenshots](#screenshots)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## 📝 Description

### 1. Technical Specifications
The system is a basic RISC processor with the following core parameters:
*   **Architecture:** 3-bit Opcode (supporting 8 instructions) and 5-bit Operand (addressing 32 memory locations).
*   **Data Width:** 32-bit.
*   **Operation:** Synchronous logic driven by `clk` and active-high `rst`.
*   **Control Unit:** Finite State Machine (FSM) consisting of 8 sequential states (from `INST_ADDR` to `STORE`).

### 2. Functional Blocks
The design follows a modular hierarchy:
*   **Program Counter (PC):** Manages instruction addresses; supports increments and jumps (JMP).
*   **ALU (Arithmetic Logic Unit):** Executes 8 arithmetic/logic operations and manages the `is_zero` flag for conditional branching.
*   **Controller (FSM):** The "brain" of the CPU, coordinating 9 control signals across 8 cycles.
*   **Memory:** Integrated storage for instructions and data, utilizing a bidirectional data bus.
*   **IR & Accumulator (AC):** Registers for temporary storage of instructions and calculation results.
*   **Address Mux:** Selects between PC or IR addresses for memory access based on the execution phase.

### 3. Instruction Set:
| Opcode | Mnemonic | Description |
| :---: | :---: | :--- |
| `000` | **HLT** | Halt execution and stop the program. |
| `001` | **SKZ** | Skip the next instruction if the Zero flag = 1. |
| `010` | **ADD** | Add memory content to the Accumulator. |
| `011` | **AND** | Perform bitwise AND operation. |
| `100` | **XOR** | Perform bitwise XOR operation. |
| `101` | **LDA** | Load data from memory into the Accumulator. |
| `110` | **STO** | Store Accumulator data into memory. |
| `111` | **JMP** | Unconditional jump to the target address. |

### 4. Control Unit: Finite State Machine (FSM)
The Controller coordinates the timing of the CPU through an 8-state cyclic FSM. Each state corresponds to a specific phase of the Instruction Cycle:

| State | Name | Functional Description |
| :---: | :--- | :--- |
| `S0` | **INST_ADDR** | Send the address from Program Counter (PC) to the Memory. |
| `S1` | **INST_FETCH** | Fetch the instruction data from Memory via the data bus. |
| `S2` | **INST_LOAD** | Load the fetched data into the Instruction Register (IR). |
| `S3` | **IDLE/DECODE** | Decode the Opcode and increment the Program Counter (PC+1). |
| `S4` | **OP_ADDR** | Send the operand address (from IR) to the Memory. |
| `S5` | **OP_FETCH** | Fetch the data operand required for the instruction. |
| `S6` | **ALU_OP** | Execute Arithmetic/Logic operation (ADD, AND, XOR, etc.). |
| `S7` | **STORE** | Write the result back to Memory (for STO) or update the Accumulator. |

> **Note:** The FSM ensures that control signals such as `load_ir`, `inc_pc`, and `mem_write` are asserted only at the precise clock edges required for data stability.
## ⚡ Quick Start

```bash

# Clone the repository
git clone https://github.com/NexoZegknost/RISC-V-CPU/tree/main?tab=readme-ov-file.git

# (See Development Setup below)
```

## 📸 Overview

 [Coming soon ...]

## 📁 Project Structure

```
.
├── LICENSE
├── RISC CPU.srcs
│   ├── sim_1
│   │   └── new
│   │       ├── ALU_TB.v
│   │       ├── Addr_MUX_TB.v
│   │       ├── Ctrl_TB.v
│   │       ├── MEM_TB.v
│   │       ├── PC_tb.v
│   │       ├── Program_Counter_TB.v
│   │       ├── Register_TB.v
│   │       ├── TOP_TB.v
│   └── sources_1
│       └── new
│           ├── ALU.v
│           ├── Address_Mux.v
│           ├── Controller.v
│           ├── IR.v
│           ├── PC.v
│           ├── TOP.v
│           ├── design.v
│           └── memory.v
└── RISC CPU.xpr
```

## 👥 Development Team
**Ho Chi Minh City University of Technology (HCMUT)**  
**Faculty of Computer Science and Engineering**

| Member | ID |
| :--- | :---:  |
| **Nguyễn Huỳnh Hữu Đức** |  |
| **Phạm Việt Cường** |  | 
| **Nguyễn Chí Quốc Cường** |  |


## 📜 License

This project is licensed under the LICENSE

*This architecture is inspired by RISC principles for academic research. RISC-V is a trademark of RISC-V International. This project is an independent implementation.*

---
*Note: The comprehensive technical report was authored in LaTeX, including detailed block diagrams and timing analysis.*
