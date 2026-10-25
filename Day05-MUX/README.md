# Day 5 — 2:1 Multiplexer

## Objective

Design and verify a 2:1 multiplexer using Verilog HDL.

## Design

A 2:1 multiplexer selects one of two data inputs based on a select signal.

Inputs:
- `d0` — first data input
- `d1` — second data input
- `s` — select signal

Output:
- `y` — selected data output

### Truth Table

| Select `s` | Input `d0` | Input `d1` | Output `y` |
|---|---|---|---|
| 0 | 0 | X | 0 |
| 0 | 1 | X | 1 |
| 1 | X | 0 | 0 |
| 1 | X | 1 | 1 |

Here, `X` means the input value does not affect the output for that select condition.

The Boolean expression is:

`y = (~s & d0) | (s & d1)`

## Files

- `mux.v` — Verilog RTL implementation.
- `mux_tb.v` — testbench used to verify the design.

## Simulation

Compile and run from this directory:

    iverilog -o mux_sim mux.v mux_tb.v
    vvp mux_sim

## Verification

The testbench checks all 8 possible combinations of `d0`, `d1`, and `s`.

Expected result: all 8 test cases pass.

## Waveform Analysis

If the testbench generates `mux.vcd`, open it using GTKWave:

    gtkwave mux.vcd

Inspect `d0`, `d1`, `s`, and `y` to confirm that the output follows the selected input.

## Concepts Practised

- Multiplexer operation
- Boolean expressions
- Verilog module and port declarations
- Testbench development
- Simulation and waveform analysis

