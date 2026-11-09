# Day 25 — Traffic Light Controller using FSM

## Objective
Design and verify a traffic light controller for a two-road intersection using a Moore Finite State Machine (FSM) in Verilog HDL.

## Design Specifications
- FSM type: Moore FSM
- Number of states: 4
- State encoding: 2-bit binary encoding
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Timer input: 1-bit input (`timer_done`)
- Controlled roads: North-South (NS) and East-West (EW)
- Outputs: Six traffic-light control signals

## State Representation

| State | Encoding | NS Signal | EW Signal |
|---|---|---|---|
| NS_GREEN | `2'b00` | Green | Red |
| NS_YELLOW | `2'b01` | Yellow | Red |
| EW_GREEN | `2'b10` | Red | Green |
| EW_YELLOW | `2'b11` | Red | Yellow |

## State Transition Conditions

| Current State | timer_done | Next State |
|---|---|---|
| NS_GREEN | 0 | NS_GREEN |
| NS_GREEN | 1 | NS_YELLOW |
| NS_YELLOW | 0 | NS_YELLOW |
| NS_YELLOW | 1 | EW_GREEN |
| EW_GREEN | 0 | EW_GREEN |
| EW_GREEN | 1 | EW_YELLOW |
| EW_YELLOW | 0 | EW_YELLOW |
| EW_YELLOW | 1 | NS_GREEN |

The controller remains in the current state while `timer_done` is LOW and advances to the next state when `timer_done` becomes HIGH at a positive clock edge.

## Project Files
- `traffic_light_fsm.v` — RTL design
- `traffic_light_fsm_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Verify NS_GREEN when the timer is not completed.
3. Transition from NS_GREEN to NS_YELLOW.
4. Verify NS_YELLOW when the timer is not completed.
5. Transition from NS_YELLOW to EW_GREEN.
6. Verify EW_GREEN when the timer is not completed.
7. Transition from EW_GREEN to EW_YELLOW.
8. Verify EW_YELLOW when the timer is not completed.
9. Transition from EW_YELLOW back to NS_GREEN.
10. Verify reset during the EW_GREEN state.
11. Verify internal FSM states and external traffic-light outputs.
12. Verify reset priority over the normal state transition.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding Moore FSM implementation.
- Designing a multi-state traffic light controller.
- Binary state encoding.
- Sequential state-register implementation.
- Combinational next-state logic.
- Moore output decoding.
- Implementing synchronous reset.
- Understanding timer-based state transitions.
- Verifying traffic-light signal combinations.
- Checking reset priority over normal FSM transitions.
- Debugging FSM behavior using simulation waveforms.

## Simulation Result
All testbench checks passed in simulation using Icarus Verilog. The simulation verified all four FSM states, timer-controlled state transitions, traffic-light output combinations, and synchronous reset behavior. Waveforms were inspected using GTKWave.