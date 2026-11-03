# Day 19 — 4-bit Bidirectional Shift Register

## Objective
Design and verify a 4-bit bidirectional shift register using Verilog HDL.

## Design Specifications
- Register width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Direction control: `direction`
- `direction = 1`: Right shift
- `direction = 0`: Left shift
- Serial input: 1 bit
- Parallel output: 4 bits
- Reset has priority over shifting.

## Shift Operations

### Right Shift
- New serial input enters the MSB.
- Existing bits move towards the LSB.
- Old LSB is discarded.
- Verilog: `{serial_in, shift_reg[3:1]}`

### Left Shift
- New serial input enters the LSB.
- Existing bits move towards the MSB.
- Old MSB is discarded.
- Verilog: `{shift_reg[2:0], serial_in}`

## Project Files
- `bidirectional_shift_register_4bit.v` — RTL design
- `bidirectional_shift_register_4bit_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. First right shift.
3. Second right shift.
4. Third right shift.
5. First left shift.
6. Second left shift.
7. Switch to right shift.
8. Switch to left shift.
9. Direction change retention.
10. Serial input change retention.

Both the internal shift register and external parallel output are checked.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding bidirectional shift registers.
- Implementing left-shift and right-shift operations.
- Implementing direction-control logic.
- Understanding synchronous sequential operations.
- Verifying direction switching.
- Testing input retention between clock edges.
- Inspecting internal and external signals using GTKWave.

## Simulation Result
All verification tests passed. The simulation verified synchronous reset, both shifting directions, direction switching, and input retention between clock edges.