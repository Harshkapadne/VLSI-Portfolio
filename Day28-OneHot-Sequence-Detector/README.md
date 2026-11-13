# Day 28 — Serial Sequence Detector using One-Hot FSM

## Objective
Design and verify a serial sequence detector for the binary pattern `1011` using a Moore Finite State Machine (FSM) with One-Hot state encoding. The design supports overlapping sequence detection.

## Design Specifications
- FSM type: Moore FSM
- State encoding: One-Hot encoding
- Target sequence: `1011`
- Number of states: 5
- Number of state flip-flops: 5
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Input: 1-bit serial input (`serial_in`)
- Output: 1-bit detection signal (`detected`)
- Detection mode: Overlapping sequence detection

## State Representation

| State | One-Hot Encoding | Description | detected |
|---|---|---|---|
| S0 | `5'b00001` | No matching bits | 0 |
| S1 | `5'b00010` | First bit `1` received | 0 |
| S2 | `5'b00100` | Partial sequence `10` received | 0 |
| S3 | `5'b01000` | Partial sequence `101` received | 0 |
| S4 | `5'b10000` | Complete sequence `1011` detected | 1 |

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

## Binary vs One-Hot Encoding

| Parameter | Binary Encoding | One-Hot Encoding |
|---|---|---|
| Number of states | 5 | 5 |
| Flip-flops required | 3 | 5 |
| State representation | 3-bit binary | 5-bit One-Hot |
| State decoding | Requires binary decoding | Direct state-bit representation |

One-Hot encoding uses more flip-flops but can simplify state decoding and combinational logic.

## Project Files
- `sequence_detector_1011_onehot.v` — RTL design
- `sequence_detector_1011_onehot_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Detection of sequence `1011`.
3. Verification using input sequence `0000`.
4. Verification using input sequence `1010`.
5. Overlapping sequence detection using input `1011011`.
6. Reset during partial sequence detection.
7. Verification of internal One-Hot state transitions.
8. Verification of next-state One-Hot encoding.
9. Verification of Moore output before and after positive clock edges.
10. Verification of detection count for normal and overlapping sequences.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding One-Hot FSM architecture.
- Difference between binary and One-Hot state encoding.
- Understanding the hardware representation of FSM states.
- Implementing a five-state sequence detector.
- Understanding current-state and next-state logic.
- Implementing Moore output logic.
- Understanding overlapping sequence detection.
- Verifying One-Hot state validity.
- Implementing synchronous reset.
- Developing reusable testbench tasks.
- Understanding the trade-off between flip-flop count and state decoding complexity.

## Simulation Result
The design was simulated using Icarus Verilog and the waveforms were inspected using GTKWave. Verification covered synchronous reset, successful sequence detection, non-detection cases, overlapping sequence detection, reset during partial sequence detection, and One-Hot state validity.