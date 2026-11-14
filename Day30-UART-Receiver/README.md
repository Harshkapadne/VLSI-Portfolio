# Day 30 — UART Receiver using FSM and Shift Register

## Objective
To design and verify an 8-bit UART receiver using a Finite State Machine (FSM), shift register, and bit counter. The receiver captures serial data in LSB-first order and reconstructs the original 8-bit parallel data.

## Design Specifications

| Parameter | Description |
|---|---|
| Communication | UART |
| Frame Format | 8-N-1 |
| Start Bit | Logic 0 |
| Data Bits | 8 bits |
| Data Order | LSB first |
| Parity | None |
| Stop Bit | Logic 1 |
| FSM Type | Moore FSM |
| Number of States | 4 |
| Reset | Synchronous, active HIGH |
| Baud Timing | External baud_tick input |

## FSM States

| State | Encoding | Function |
|---|---|---|
| IDLE | 00 | Wait for the start bit |
| START | 01 | Validate the start bit |
| DATA | 10 | Receive eight serial data bits |
| STOP | 11 | Validate the stop bit |

## Architecture

The UART receiver consists of the following functional blocks:

1. **Sequential State Logic:** Updates the current FSM state on the positive clock edge and handles synchronous reset.
2. **Combinational Next-State Logic:** Determines the next state based on the current state, RX input, baud_tick, and bit counter.
3. **Shift Register and Bit Counter:** Captures eight serial data bits and reconstructs the original parallel byte.
4. **Receiver Output Logic:** Generates rx_valid after a valid frame and framing_error when the stop bit is invalid.
5. **Busy Output:** Indicates whether the receiver is processing a frame.

## Shift Register Operation

The receiver uses the following operation to capture incoming bits:

`shift_reg <= {rx, shift_reg[7:1]};`

Since UART transmits data LSB first, this shifting arrangement reconstructs the original byte after eight sampling operations.

Example:

- Transmitted byte: `8'hA5`
- Received bit order: `1, 0, 1, 0, 0, 1, 0, 1`
- Final shift register: `8'hA5`

## Receiver Outputs

| Output | Function |
|---|---|
| rx_data | Stores the most recently received valid byte |
| rx_valid | One-clock-cycle pulse indicating successful reception |
| framing_error | One-clock-cycle pulse indicating an invalid stop bit |
| busy | HIGH while the receiver is outside IDLE |

An invalid stop bit does not update rx_data.

## Project Files

| File | Description |
|---|---|
| uart_receiver.v | UART receiver RTL implementation |
| uart_receiver_tb.v | Verification testbench |
| uart_receiver.vcd | Simulation waveform |

## Verification Test Cases

| Test | Scenario | Expected Result |
|---|---|---|
| 1 | Reset operation | Receiver returns to IDLE and clears registers |
| 2 | Idle condition | Receiver remains in IDLE |
| 3 | Receive 8'hA5 | Correct byte received |
| 4 | Receive 8'h3C | Correct byte received |
| 5 | Receive 8'h00 | Correct byte received |
| 6 | Receive 8'hFF | Correct byte received |
| 7 | False start detection | Receiver rejects the invalid start bit |
| 8 | Invalid stop bit | Framing error is detected |
| 9 | Reset during DATA reception | Receiver resets and clears internal registers |

## Verification Result

**ALL TESTS PASSED!**

All nine test scenarios passed successfully. The testbench checked the FSM state, next-state behavior through the design, shift register, bit counter, received data, valid pulse, framing error, and busy output.

The simulation waveform was inspected using GTKWave.

## Tools Used

- Verilog HDL
- Visual Studio Code
- Icarus Verilog
- GTKWave
- Git and GitHub

## Key Learning Outcomes

- Understood UART receiver operation and 8-N-1 frame structure.
- Implemented a four-state Moore FSM.
- Learned how to reconstruct parallel data from serial input using a shift register.
- Implemented LSB-first data reception.
- Understood false-start detection.
- Implemented valid-data and framing-error indicators.
- Verified reset behavior during an active reception.
- Practiced comprehensive RTL verification using a self-checking testbench.

## Conclusion

Successfully designed and simulated an 8-bit UART receiver using an FSM and shift register. The design correctly receives serial data, reconstructs the original byte, detects invalid frames, and handles reset conditions.