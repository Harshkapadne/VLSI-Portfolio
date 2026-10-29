# Day 14 — 4-bit Down-Counter

## Objective
Design and verify a 4-bit synchronous down-counter using Verilog HDL.

## Design Specifications
- Counter width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Counting direction: Downward
- Counter range: 15 to 0
- Underflow behavior: Wraps from `0000` to `1111`

## Project Files
- `down_counter_4bit.v` — RTL design
- `down_counter_4bit_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. First decrement after reset.
3. Second decrement.
4. Underflow from `0000` to `1111`.
5. Multiple decrements, with expected-value checks.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Simulation Result
All test cases passed. The simulation verified synchronous reset, decrementing, underflow, and the expected counting sequence.

## Key Learning
Learned to design and verify a synchronous down-counter using Verilog HDL, understand fixed-width arithmetic, and write a testbench with expected-value comparisons.