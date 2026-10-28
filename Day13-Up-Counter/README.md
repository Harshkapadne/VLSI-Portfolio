# Day 13 — 4-bit Up-Counter

## Objective
Design and verify a 4-bit synchronous up-counter using Verilog HDL.

## Design Specifications
- **Counter width:** 4 bits
- **Clock:** Positive-edge triggered
- **Reset:** Active-high synchronous reset
- **Counting sequence:** `0000` to `1111`
- **Overflow:** Wraps from `1111` to `0000`

## Files
- `up_counter_4bit.v` — RTL design
- `up_counter_4bit_tb.v` — Testbench

## Verification
The testbench verifies:
1. Synchronous reset.
2. Counter increment.
3. Value retention between clock edges.
4. Counter overflow.
5. Reset during counting.

## Tools Used
- Icarus Verilog — compilation and simulation
- GTKWave — waveform inspection
- VS Code — code editing
- Git and GitHub — version control

## Result
All five test cases passed. The waveform confirmed that the counter increments on rising clock edges, resets synchronously, and wraps from `1111` to `0000`.

## Key Learning
Understood how to design and verify a synchronous counter using Verilog HDL, clock-edge-triggered behavior, reset logic, and testbench-based verification.