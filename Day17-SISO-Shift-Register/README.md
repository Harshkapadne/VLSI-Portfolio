# Day 17 — 4-bit SISO Shift Register

## Objective
Design and verify a 4-bit Serial-In Serial-Out (SISO) right-shift register using Verilog HDL.

## Design Specifications
- Register width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Input: 1-bit serial input
- Output: 1-bit serial output
- Shift direction: Right shift
- Serial input enters through the MSB.
- Serial output is taken from the LSB.

## Project Files
- `siso_shift_register_4bit.v` — RTL design
- `siso_shift_register_4bit_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. First serial input bit.
3. Second serial input bit.
4. Third serial input bit.
5. Fourth serial input bit.
6. Fifth serial input bit.
7. Sixth serial input bit.
8. Seventh serial input bit.
9. Eighth serial input bit.
10. Output retention between clock edges.

The testbench checks both the internal 4-bit shift register and the external serial output.

## Expected Data Sequence

Serial input:
`1 → 0 → 1 → 1 → 0 → 0 → 0 → 0`

Serial output:
`0 → 0 → 0 → 1 → 0 → 1 → 1 → 0`

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding Serial-In Serial-Out shift registers.
- Implementing right shifting using Verilog concatenation.
- Understanding serial data propagation through flip-flops.
- Understanding four-clock-cycle data latency.
- Verifying internal and external signals using a testbench.
- Inspecting sequential behavior using GTKWave.

## Simulation Result
All verification tests passed. The simulation confirmed synchronous reset, correct serial data transmission, data ordering, and output retention between clock edges.