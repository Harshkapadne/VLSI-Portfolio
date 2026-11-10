# Day 26 — Serial Sequence Detector using Mealy FSM

## Objective
Design and verify a serial sequence detector for the binary pattern `1011` using a Mealy Finite State Machine (FSM) in Verilog HDL. The design supports overlapping sequence detection.

## Design Specifications
- FSM type: Mealy FSM
- Target sequence: `1011`
- Number of states: 4
- State encoding: 2-bit binary encoding
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Input: 1-bit serial input (`serial_in`)
- Output: 1-bit detection signal (`detected`)
- Detection mode: Overlapping sequence detection

## State Representation

| State | Encoding | Description |
|---|---|---|
| S0 | `2'b00` | No matching bits |
| S1 | `2'b01` | First bit `1` received |
| S2 | `2'b10` | Partial sequence `10` received |
| S3 | `2'b11` | Partial sequence `101` received |

## State Transition Conditions

| Current State | serial_in | Next State | detected |
|---|---|---|---|
| S0 | 0 | S0 | 0 |
| S0 | 1 | S1 | 0 |
| S1 | 0 | S2 | 0 |
| S1 | 1 | S1 | 0 |
| S2 | 0 | S0 | 0 |
| S2 | 1 | S3 | 0 |
| S3 | 0 | S2 | 0 |
| S3 | 1 | S1 | 1 |

## Project Files
- `sequence_detector_1011.v` — RTL design
- `sequence_detector_1011_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Detection of the sequence `1011`.
3. Verification using input sequence `0000`.
4. Verification using input sequence `1010`.
5. Overlapping sequence detection using input `1011011`.
6. Reset during partial sequence detection.
7. Verification of internal FSM state transitions.
8. Verification of the Mealy detection output before and after positive clock edges.
9. Verification that the detection output returns LOW after a successful detection.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding Mealy FSM architecture.
- Difference between Moore and Mealy FSMs.
- Designing serial sequence detectors.
- Implementing binary state encoding.
- Understanding current-state and next-state logic.
- Implementing combinational output logic.
- Understanding overlapping sequence detection.
- Using blocking assignments in combinational logic.
- Using nonblocking assignments in sequential logic.
- Verifying Mealy outputs between clock edges.
- Implementing synchronous reset.
- Developing testbenches with state and output verification.

## Simulation Result
The design was simulated using Icarus Verilog and the waveform was inspected using GTKWave. Verification covered synchronous reset, successful sequence detection, non-detection cases, overlapping sequence detection, and reset during partial sequence detection.

