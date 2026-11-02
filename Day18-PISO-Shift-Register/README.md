# Day 18 — 4-bit PISO Shift Register

## Objective
Design and verify a 4-bit Parallel-In Serial-Out (PISO) right-shift register using Verilog HDL.

## Design Specifications
- Register width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Parallel input: 4 bits
- Serial output: 1 bit
- Shift direction: Right shift
- Serial transmission order: LSB first
- Load control: Active-high
- Reset has higher priority than parallel loading.

## Project Files
- `piso_shift_register_4bit.v` — RTL design
- `piso_shift_register_4bit_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Parallel loading of `1011`.
3. First right shift.
4. Second right shift.
5. Third right shift.
6. Fourth right shift.
7. Parallel loading of `1100`.
8. First right shift after loading `1100`.
9. Verification of no immediate loading when load is inactive.
10. Verification of reset priority over parallel loading.

Both the internal 4-bit shift register and external serial output are checked.

## Expected Serial Transmission

Parallel data: `1011`

Serial output (LSB first): `1 → 1 → 0 → 1`

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding Parallel-In Serial-Out architecture.
- Implementing parallel loading using Verilog HDL.
- Implementing right shifting using concatenation.
- Understanding control-signal priority.
- Verifying synchronous loading and shifting.
- Testing reset priority over parallel loading.
- Inspecting internal and external signals using GTKWave.

## Simulation Result
All verification tests passed. The simulation verified parallel loading, serial transmission, right shifting, load control, and reset priority.