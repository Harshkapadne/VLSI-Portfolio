# Day 22 — Divide-by-10 Frequency Divider

## Objective
Design and verify a divide-by-10 frequency divider using Verilog HDL.

## Design Specifications
- Input clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Counter width: 3 bits
- Counter sequence: 0 to 4
- Terminal count: 4
- Output: Registered clock signal
- Frequency division factor: 10
- Output duty cycle: 50%

## Working Principle
The internal counter increments on every rising edge of the input clock.

When the counter reaches decimal 4:
- The counter resets to zero.
- The output clock toggles.

The output toggles after every five input clock cycles. Therefore, one complete output clock cycle requires ten input clock cycles.

## Frequency Calculation

f_out = f_in / 10

For a 50 MHz input clock:

f_out = 50 MHz / 10 = 5 MHz

## Project Files
- `clock_divider_by10.v` — RTL design
- `clock_divider_by10_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Terminal count detection.
3. First output transition.
4. Second output transition.
5. Third output transition.
6. Value retention between clock edges.
7. Reset during operation.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding frequency and time period.
- Designing counter-based frequency dividers.
- Calculating frequency division ratios.
- Understanding output toggling.
- Calculating duty cycle.
- Implementing terminal-count detection.
- Verifying clock waveforms using GTKWave.

## Simulation Result
All verification tests passed. The output clock toggles after every five rising edges of the input clock, producing a divide-by-10 output with a 50% duty cycle.