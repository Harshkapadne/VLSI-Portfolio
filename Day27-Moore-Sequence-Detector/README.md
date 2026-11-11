# Day 27 — Serial Sequence Detector using Moore FSM

## Objective
Design and verify a serial sequence detector for the binary pattern `1011` using a Moore Finite State Machine (FSM) in Verilog HDL. The design supports overlapping sequence detection.

## Design Specifications
- FSM type: Moore FSM
- Target sequence: `1011`
- Number of states: 5
- State encoding: 3-bit binary encoding
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Input: 1-bit serial input (`serial_in`)
- Output: 1-bit detection signal (`detected`)
- Detection mode: Overlapping sequence detection

## State Representation

| State | Encoding | Description | detected |
|---|---|---|---|
| S0 | `3'b000` | No matching bits | 0 |
| S1 | `3'b001` | First bit `1` received | 0 |
| S2 | `3'b010` | Partial sequence `10` received | 0 |
| S3 | `3'b011` | Partial sequence `101` received | 0 |
| S4 | `3'b100` | Complete sequence `1011` detected | 1 |

## State Transition Conditions

| Current State | serial_in | Next State |
|---|---|---|
| S0 | 0 | S0 |
| S0 | 1 | S1 |
| S1 | 0 | S2 |
| S1 | 1 | S1 |
| S2 | 0 | S0 |
| S2 | 1 | S3 |
| S3 | 0 | S2 |
| S3 | 1 | S4 |
| S4 | 0 | S2 |
| S4 | 1 | S1 |

## Project Files
- `sequence_detector_1011_moore.v` — RTL design
- `sequence_detector_1011_moore_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Detection of the sequence `1011`.
3. Verification using input sequence `0000`.
4. Verification using input sequence `1010`.
5. Overlapping sequence detection using input sequence `1011011`.
6. Reset during partial sequence detection.
7. Verification of internal FSM state transitions.
8. Verification of Moore output before and after positive clock edges.
9. Verification that the detection output remains HIGH in the detection state and returns LOW after leaving that state.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding Moore FSM architecture.
- Difference between Moore and Mealy FSMs.
- Designing serial sequence detectors.
- Implementing binary state encoding.
- Understanding current-state and next-state logic.
- Implementing Moore output decoding.
- Understanding overlapping sequence detection.
- Using blocking assignments in combinational logic.
- Using nonblocking assignments in sequential logic.
- Understanding clock-edge-dependent output behavior.
- Implementing synchronous reset.
- Developing reusable testbench tasks for verification.

## Simulation Result
The design was simulated using Icarus Verilog and the waveforms were inspected using GTKWave. Verification covered synchronous reset, successful sequence detection, non-detection cases, overlapping sequence detection, and reset during partial sequence detection.