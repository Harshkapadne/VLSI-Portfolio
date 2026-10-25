# Day 9 — 2-to-4 Decoder

## Objective

Implement and verify a 2-to-4 decoder using Verilog and a combinational `case` statement.

## Design

The decoder accepts two input bits, `a1` and `a0`, and produces a four-bit output vector `y`. For each valid binary input, exactly one output bit is HIGH.

| Inputs `{a1, a0}` | Expected output `y[3:0]` |
|---|---|
| `00` | `0001` |
| `01` | `0010` |
| `10` | `0100` |
| `11` | `1000` |

## Files

- `decoder2to4.v` — decoder RTL implementation.
- `decoder2to4_tb.v` — testbench that checks all four input combinations.

## Simulation

Compile and run from this directory:

```bash
iverilog -o decoder2to4_sim decoder2to4.v decoder2to4_tb.v
vvp decoder2to4_sim
```

Expected result:

```text
PASS: All 4 decoder combinations passed.
```

## Waveform Analysis

The testbench generates `decoder2to4.vcd`. Open it with GTKWave:

```bash
gtkwave decoder2to4.vcd
```

Inspect `a1`, `a0`, and `y` to confirm that the selected output bit matches each input combination.

## Concepts Practised

- Combinational logic
- Verilog `case` and `default`
- Four-bit output vectors
- Testbench loops and expected-value checking
- Simulation and waveform analysis
