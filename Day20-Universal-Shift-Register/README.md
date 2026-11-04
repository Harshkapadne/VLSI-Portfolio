# Day 20 — 4-bit Universal Shift Register

## Objective
Design and verify a 4-bit universal shift register using Verilog HDL.

## Design Specifications
- Register width: 4 bits
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Control input: 2-bit mode
- Output: 4-bit parallel output

## Operating Modes

| Mode | Operation |
|---|---|
| 00 | Hold |
| 01 | Shift right |
| 10 | Shift left |
| 11 | Parallel load |

Reset has the highest priority.

## Project Files
- `universal_shift_register_4bit.v` — RTL design
- `universal_shift_register_4bit_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Parallel load.
3. Hold operation.
4. Right shift with serial input 1.
5. Right shift with serial input 0.
6. Left shift with serial input 0.
7. Left shift with serial input 1.
8. Parallel load with another data value.
9. Mode-change retention.
10. Reset priority over parallel loading.

Both internal register values and external parallel outputs were verified.

## Fault Injection and Debugging

Three intentional design faults were introduced and detected:

1. Swapped left and right shift operations.
2. Swapped HOLD and PARALLEL LOAD mode operations.
3. Incorrect reset priority over parallel loading.

The testbench detected all three faults through expected-value comparisons.

After debugging, the original RTL design was restored and verified again.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Designing a universal shift register.
- Combining multiple operations using a Verilog case statement.
- Understanding mode decoding and control priority.
- Developing testbenches for sequential circuits.
- Performing fault injection.
- Debugging incorrect RTL behavior.
- Verifying designs using Icarus Verilog and GTKWave.

## Verification Result
All original verification tests passed after restoring the correct RTL design.
All three intentionally introduced faults were successfully detected by the testbench.