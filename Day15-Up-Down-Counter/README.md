# Day 15 — 4-bit Up/Down Counter

## Objective
Design and verify a configurable 4-bit synchronous up/down counter using Verilog HDL.

## Design Specifications
- Counter width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Direction control: `up_down`
- `up_down = 1`: Increment
- `up_down = 0`: Decrement
- Overflow: `1111` to `0000`
- Underflow: `0000` to `1111`

## Project Files
- `up_down_counter_4bit.v` — RTL design
- `up_down_counter_4bit_tb.v` — Testbench

## Verification
The testbench verifies:
1. Synchronous reset.
2. First upward count.
3. Second upward count.
4. Direction switching to downward.
5. Continued downward counting.
6. Underflow.
7. Direction switching back to upward.
8. Holding the counter value between rising clock edges (additional test).

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
Learned to design a configurable sequential circuit, implement synchronous direction control, and verify upward and downward counting using a Verilog testbench.