# Day 7 — Procedural 2:1 Multiplexer

## Objective

Implement a 2:1 multiplexer using a procedural `always @(*)` block and an `if/else` statement.

## Design

The circuit has two data inputs, one select signal, and one output.

When `s = 0`, the output follows `d0`.
When `s = 1`, the output follows `d1`.

The `always @(*)` block executes when an input used in the combinational logic changes. The `if/else` statement describes the selection behavior.

## Files

- `mux2_proc.v` — procedural MUX RTL implementation.
- `mux2_proc_tb.v` — testbench for checking the circuit.

## Simulation

Compile and run from this directory:

    iverilog -o mux2_proc_sim mux2_proc.v mux2_proc_tb.v
    vvp mux2_proc_sim

## Verification

The testbench checks all 8 combinations of the two data inputs and the select signal.

Expected result: all 8 test cases pass.

## Waveform Analysis

If the testbench generates `mux2_proc.vcd`, open it using GTKWave:

    gtkwave mux2_proc.vcd

Inspect the inputs and output to verify the selection behavior.

## Concepts Practised

- Procedural combinational RTL
- `always @(*)`
- `if/else` statements
- Procedural assignments and `reg`
- Avoiding unintended latch inference
- Testbench verification and waveform debugging
