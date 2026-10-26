# Day 11 — D Flip-Flop with Asynchronous Reset

## Objective
Design and verify a positive-edge-triggered D flip-flop with an active-low asynchronous reset.

## Design Features
- Captures input data on the rising edge of the clock.
- Clears the output when reset is asserted.
- Holds the stored value between active clock edges.

## Tools
- Verilog HDL
- Icarus Verilog
- GTKWave

## Verification
The testbench checks asynchronous reset, data capture, hold behavior, and reset during operation.

## Files
- `dff_async_reset.v` — RTL design
- `dff_async_reset_tb.v` — Testbench

Simulation executables and VCD waveforms are generated locally and excluded from Git.
