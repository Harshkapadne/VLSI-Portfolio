# Day 23 — 4-bit Register with Clock Enable

## Objective
Design and verify a 4-bit synchronous register with an active-high clock-enable input using Verilog HDL.

## Design Specifications
- Register width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Enable: Active-high clock enable
- Input: 4-bit data input (`d`)
- Output: 4-bit register output (`q`)

## Operating Conditions

| Reset | Enable | Operation |
|---|---|---|
| 1 | X | Reset register to `0000` |
| 0 | 1 | Load input data into register |
| 0 | 0 | Hold previous register value |

Reset has priority over enable.

## Project Files
- `clock_enable_register_4bit.v` — RTL design
- `clock_enable_register_4bit_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Load data with enable active.
3. Hold data with enable inactive.
4. Change input data while enable is inactive.
5. Reactivate enable and load new data.
6. Verify reset priority over enable.
7. Verify value retention between clock edges.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding clock-enable functionality.
- Difference between clock enable and clock gating.
- Implementing synchronous reset and enable logic.
- Understanding register data retention.
- Verifying sequential behavior using testbenches.
- Understanding the role of clock gating in low-power VLSI design.
- Introduction to glitch-free clock gating using integrated clock-gating cells.

## Simulation Result
All verification tests passed. The simulation verified synchronous reset, data loading, hold behavior, reset priority, and clock-edge-dependent register updates.