# Day 8 — 4:1 Multiplexer Using `case`

## Objective

Design and verify a 4:1 multiplexer using a Verilog `case` statement inside a combinational procedural block.

## Design

A 4:1 multiplexer routes one of four data inputs to the output according to the two select bits.

### Selection Table

| Select `{s1, s0}` | Output |
|---|---|
| `00` | `d0` |
| `01` | `d1` |
| `10` | `d2` |
| `11` | `d3` |

The `case` statement makes each selection condition explicit. A `default` assignment provides a defined output for any unmatched or unknown selection condition in simulation.

## Files

- `mux4_case.v` — MUX RTL using a `case` statement.
- `mux4_case_tb.v` — testbench that checks all input combinations.

## Simulation

Compile and run from this directory:

    iverilog -o mux4_case_sim mux4_case.v mux4_case_tb.v
    vvp mux4_case_sim

## Verification

The testbench checks all 64 combinations of the four data inputs and two select signals.

Expected result: all 64 test cases pass.

## Waveform Analysis

If the testbench generates `mux4_case.vcd`, open it using GTKWave:

    gtkwave mux4_case.vcd

Inspect `s1`, `s0`, the data inputs, and `y` to confirm that the correct input reaches the output.

## Concepts Practised

- Verilog `case`, `endcase`, and `default`
- Procedural combinational logic
- Select-line decoding
- Exhaustive testbench verification
- Simulation and waveform analysis
