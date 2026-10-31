# Day 16 — 4-bit Serial-In Parallel-Out Shift Register (SIPO)

## Objective
Design and verify a 4-bit right-shift Serial-In Parallel-Out (SIPO) register using Verilog HDL.

## Design Specifications
- Register width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Input: 1-bit serial input
- Output: 4-bit parallel output
- Shift direction: Right shift
- New serial data enters through the MSB.

## Project Files
- `shift_register_4bit.v` — RTL design
- `shift_register_4bit_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. First shift.
3. Second shift.
4. Value retention between clock edges.
5. Third shift.
6. Fourth shift.
7. Fifth shift.

## Expected Data Sequence
`0000 → 1000 → 0100 → 1010 → 1101 → 0110`

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding Serial-In Parallel-Out shift registers.
- Implementing right-shift operations using Verilog concatenation.
- Understanding synchronous data shifting.
- Writing testbenches with expected-value comparisons.
- Verifying sequential behavior through waveform analysis.

## Simulation Result
All verification tests passed. The simulation verified synchronous reset, right shifting, and data retention between clock edges.