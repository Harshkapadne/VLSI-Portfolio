# Day 21 — 4-bit Mod-10 Synchronous Counter

## Objective
Design and verify a 4-bit Mod-10 synchronous up-counter using Verilog HDL.

## Design Specifications
- Counter width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Counting sequence: Decimal 0 to 9
- Terminal count: Decimal 9 (`1001`)
- Rollover: `1001` to `0000`
- Number of states: 10
- Number of flip-flops required: 4

## Project Files
- `mod10_counter.v` — RTL design
- `mod10_counter_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. First increment.
3. Multiple increments.
4. Terminal-count detection.
5. Mod-10 rollover.
6. Counting after rollover.
7. Reset during counting.
8. Value retention between clock edges.

## Fault Injection
An intentional terminal-count fault was introduced by changing the comparison from `4'd9` to `4'd8`.

The testbench detected the premature rollover through three failed checks:
- Terminal-count verification.
- Rollover verification.
- Counting after rollover.

The correct terminal-count condition was subsequently restored.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Difference between synchronous and asynchronous counters.
- Understanding Mod-N counters.
- Calculating flip-flop requirements using ceiling(log2(N)).
- Implementing terminal-count detection.
- Understanding rollover behavior.
- Developing testbenches and performing fault injection.

## Simulation Result
All original verification tests passed after restoring the correct terminal-count condition. The injected terminal-count fault was successfully detected.