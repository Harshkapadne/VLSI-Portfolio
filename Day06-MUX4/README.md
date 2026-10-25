# Day 6 — 4:1 Multiplexer

## Objective

Design and verify a 4:1 multiplexer using Verilog HDL and a conditional operator.

## Design

A 4:1 multiplexer selects one of four data inputs using two select lines.

Inputs:
- `d0`, `d1`, `d2`, `d3` — four data inputs
- `s1`, `s0` — select signals

Output:
- `y` — selected data output

### Selection Table

| `s1` | `s0` | Selected Input |
|---|---|---|
| 0 | 0 | `d0` |
| 0 | 1 | `d1` |
| 1 | 0 | `d2` |
| 1 | 1 | `d3` |

The output follows the data input selected by `{s1, s0}`.

## Files

- `mux4.v` — Verilog RTL implementation.
- `mux4_tb.v` — testbench for exhaustive input checking.

## Simulation

Compile and run from this directory:

    iverilog -o mux4_sim mux4.v mux4_tb.v
    vvp mux4_sim

## Verification

The testbench checks all 64 combinations of four data inputs and two select signals.

Expected result: all 64 test cases pass.

## Waveform Analysis

The testbench generates `mux4.vcd`. Open it using GTKWave:

    gtkwave mux4.vcd

Inspect the data inputs, select lines, and output. Confirm that `y` matches the selected data input for every select combination.

## Concepts Practised

- 4:1 multiplexer design
- Two-bit selection logic
- Verilog conditional operator
- Exhaustive testbench verification
- VCD waveform generation and analysis
