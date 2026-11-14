# Day 29 — UART Transmitter using FSM and Shift Register

## Objective
Design and verify an 8-bit UART transmitter using Verilog HDL. The transmitter accepts parallel data and converts it into serial data using an FSM-controlled shift register.

## Design Specifications
- Communication protocol: UART
- Frame format: 8-N-1
- Data width: 8 bits
- FSM states: 4
- State encoding: 2-bit binary encoding
- Clock: Positive-edge triggered
- Reset: Active-high synchronous reset
- Transmission order: Least Significant Bit (LSB) first
- Baud timing: External baud_tick input
- Input: 8-bit parallel data (`data_in`)
- Control input: Transmission start (`start`)
- Serial output: `tx`
- Status output: `busy`
- Completion output: `tx_done`

## UART Frame Format

| Field | Description | Logic Level |
|---|---|---|
| Idle | No transmission | 1 |
| Start bit | Beginning of transmission | 0 |
| Data bits | Eight bits, LSB first | 0 or 1 |
| Stop bit | End of transmission | 1 |

8-N-1 represents 8 data bits, no parity bit, and 1 stop bit.

## FSM State Representation

| State | Encoding | Description |
|---|---|---|
| IDLE | `2'b00` | Waiting for transmission request |
| START | `2'b01` | Transmitting start bit |
| DATA | `2'b10` | Transmitting eight data bits |
| STOP | `2'b11` | Transmitting stop bit |

## State Transition Conditions

| Current State | Condition | Next State |
|---|---|---|
| IDLE | start = 0 | IDLE |
| IDLE | start = 1 | START |
| START | baud_tick = 0 | START |
| START | baud_tick = 1 | DATA |
| DATA | baud_tick = 0 | DATA |
| DATA | baud_tick = 1 and bit_count less than 7 | DATA |
| DATA | baud_tick = 1 and bit_count equals 7 | STOP |
| STOP | baud_tick = 0 | STOP |
| STOP | baud_tick = 1 | IDLE |

## Datapath Components

- **8-bit Shift Register:** Loads parallel input data and shifts it right to transmit one bit at a time.
- **3-bit Bit Counter:** Tracks the eight transmitted data bits, from 0 to 7.
- **FSM Controller:** Controls the transmission sequence through IDLE, START, DATA, and STOP states.
- **Baud Tick:** Provides the timing pulse for advancing transmission by one bit period.

## Output Signals

| Output | Function |
|---|---|
| `tx` | Serial transmission output |
| `busy` | Indicates that transmission is active |
| `tx_done` | One-system-clock-cycle pulse indicating transmission completion |

## Project Files
- `uart_transmitter.v` — RTL design
- `uart_transmitter_tb.v` — Verification testbench

## Verification Tests
1. Synchronous reset.
2. Idle transmitter operation.
3. Transmission of the data byte `8'hA5`.
4. Verification of LSB-first data transmission.
5. Verification of the start and stop bits.
6. Verification of bit counter progression from 0 to 7.
7. Verification of shift register operation.
8. Verification of `busy` throughout transmission.
9. Verification of the one-clock-cycle `tx_done` pulse.
10. Transmission of a second data byte `8'h3C`.
11. Verification that a new start request is ignored while the transmitter is busy.
12. Reset during an active transmission.

## Tools Used
- VS Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning
- Understanding UART asynchronous serial communication.
- Understanding the UART 8-N-1 frame format.
- Designing an FSM-controlled UART transmitter.
- Integrating an FSM with a datapath.
- Implementing parallel data loading.
- Implementing LSB-first serial transmission.
- Understanding shift-register operation.
- Using a bit counter to track transmitted data.
- Understanding baud tick-based transmission timing.
- Implementing busy and transmission-completion status signals.
- Verifying sequential and datapath behavior using testbenches.

## Simulation Result
The UART transmitter was simulated using Icarus Verilog and its waveforms were inspected using GTKWave. Verification covered UART frame transmission, LSB-first data shifting, bit counter operation, transmission status, completion signaling, busy-state behavior, and reset during transmission.