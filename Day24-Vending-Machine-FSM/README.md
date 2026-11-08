# Day 24 — Vending Machine FSM (Moore FSM)

## Objective
Design and verify a vending machine using a Moore Finite State Machine (FSM) in Verilog HDL. The machine accepts two ₹5 coins and dispenses an item costing ₹10.

## Design Specifications
- FSM type: Moore FSM
- Number of states: 3
- State encoding: 2-bit binary encoding
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Coin input: 1-bit input (`coin`)
- Output: 1-bit dispense signal (`dispense`)
- Item cost: ₹10
- Accepted coin: ₹5

## State Representation

| State | Encoding | Description |
|---|---|---|
| IDLE | `2'b00` | Waiting for the first coin |
| HAVE_5 | `2'b01` | First ₹5 coin received |
| DISPENSE | `2'b10` | ₹10 received; dispense item |

## State Transition Conditions

| Current State | Coin Input | Next State |
|---|---|---|
| IDLE | 0 | IDLE |
| IDLE | 1 | HAVE_5 |
| HAVE_5 | 0 | HAVE_5 |
| HAVE_5 | 1 | DISPENSE |
| DISPENSE | 0 or 1 | IDLE |

## Project Files
- `vending_machine_fsm.v` — RTL design
- `vending_machine_fsm_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. No coin insertion.
3. First coin insertion and transition to HAVE_5.
4. Waiting for the second coin.
5. Second coin insertion and transition to DISPENSE.
6. Automatic return to IDLE after dispensing.
7. Verification of another vending transaction.
8. Completion of a second transaction.
9. Reset during the HAVE_5 state.
10. Reset during the DISPENSE state.
11. Verification of internal FSM states.
12. Verification of the external dispense output.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding Finite State Machines.
- Difference between Moore and Mealy FSMs.
- Understanding state encoding and state transitions.
- Separation of sequential and combinational logic.
- Implementing current-state and next-state logic.
- Using blocking assignments (`=`) in combinational logic.
- Using nonblocking assignments (`<=`) in sequential logic.
- Avoiding unintended latch inference through default assignments.
- Implementing synchronous reset in an FSM.
- Verifying FSM behavior using testbenches.

## Simulation Result
The FSM was simulated using Icarus Verilog and its waveforms were inspected using GTKWave. Verification covered normal vending transactions, automatic state transitions, dispense output behavior, and synchronous reset under different FSM states.