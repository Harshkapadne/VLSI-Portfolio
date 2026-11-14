# VLSI Learning Progress Log

**Learning Track:** RTL Design and Verification  
**Primary Language:** Verilog HDL  
**Simulation Tools:** Icarus Verilog and GTKWave  
**Development Environment:** VS Code, WSL Ubuntu, Git  
**Progress Period:** Day 1 onward

---

## Day 1 — Introduction to VLSI

**Topics learned**
- Introduction to VLSI design.
- Differences between ASIC and FPGA.
- Overview of the RTL design and verification workflow.
- Role of RTL design and verification engineers.

**Outcome:** Understood the basic VLSI workflow and career direction.

## Day 2 — Digital Logic Fundamentals

**Topics learned**
- Binary number system.
- Basic logic gates.
- Boolean algebra.
- De Morgan's theorems.

**Outcome:** Established a foundation for digital circuit design.

## Day 3 — Combinational Logic

**Topics learned**
- Multiplexers.
- Encoders and decoders.
- Half adders and full adders.
- Combinational circuit behavior.

**Outcome:** Learned how digital circuits process inputs to generate outputs.

## Day 4 — Sequential Logic and Digital Systems

**Topics learned**
- Adders and ALU fundamentals.
- Combinational versus sequential circuits.
- Latches and flip-flops.
- Clocks and registers.

**Outcome:** Developed an introductory understanding of sequential logic and digital system components.

## Day 5 — First Verilog MUX Project

**Practical work**
- Set up and used Icarus Verilog.
- Created a 2:1 multiplexer using Verilog.
- Developed a testbench.
- Simulated the design and checked all eight input combinations.
- Used Git to record the project.

**Tools:** Icarus Verilog, VS Code, Git.

**Outcome:** Completed the first Verilog simulation project.

## Day 6 — 4:1 Multiplexer

**Practical work**
- Implemented a 4:1 multiplexer.
- Used select lines to choose between four data inputs.
- Tested all 64 combinations of the data and select inputs.
- Generated a VCD waveform for inspection.

**Tools:** Icarus Verilog, GTKWave, Git.

**Outcome:** Practised larger combinational designs and exhaustive testbench checking.

## Day 7 — Procedural MUX Using `always @(*)`

**Topics and practical work**
- Implemented a 2:1 MUX using procedural Verilog.
- Used `always @(*)` and `if/else`.
- Simulated all eight input combinations.
- Inspected waveform behavior.

**Outcome:** Learned an alternative way to describe combinational logic in Verilog.

## Day 8 — Case-Based 4:1 MUX

**Topics and practical work**
- Implemented a 4:1 MUX using `case`.
- Used a `default` branch.
- Tested all 64 input combinations.
- Practised Verilog syntax and testbench concepts.

**Outcome:** Improved understanding of procedural combinational logic and selection statements.

## Day 9 — 2-to-4 Decoder

**Practical work**
- Implemented a 2-to-4 decoder.
- Used `case` to map two input bits to four output lines.
- Created a testbench for all four input combinations.
- Generated simulation and waveform files.

**Verification result:** All four decoder input combinations passed.

**Outcome:** Completed and verified a decoder design.

## Day 10 — Verification, Debugging and Portfolio Organization

**Practical work**
- Reviewed earlier MUX and decoder projects.
- Investigated a MUX output-mapping error.
- Improved the decoder testbench with individual PASS/FAIL messages.
- Added a test-case summary and failure counter.
- Intentionally introduced a decoder fault and confirmed that the testbench detected it.
- Created a unified portfolio repository.
- Organized project source files, testbenches, and README documentation.
- Generated local simulation and waveform files for Days 5–9.
- Configured Git to ignore generated simulation artifacts.

**Outcome:** Practised fault detection, testbench improvement, debugging, and source-control organization.

## Day 11 — D Flip-Flop with Asynchronous Reset

**Practical work**
- Designed a D flip-flop using Verilog HDL.
- Implemented an active-low asynchronous reset.
- Used `always @(posedge clk or negedge rst_n)` for sequential logic.
- Created a testbench to verify the flip-flop's operation.
- Simulated the design using Icarus Verilog.
- Inspected the output waveforms using GTKWave.
- Created README documentation for the project.

**Verification result:** All five test cases passed.

**Outcome:** Successfully designed and verified a D flip-flop with an active-low asynchronous reset.

## Day 12 — 4-bit Register with Synchronous Reset

**Practical work**
- Designed a 4-bit register using Verilog HDL.
- Implemented an active-high synchronous reset.
- Used `always @(posedge clk)` to describe the register's behavior.
- Created a testbench to verify reset, data capture, and data retention.
- Simulated the design using Icarus Verilog.
- Inspected the output waveforms using GTKWave.
- Created README documentation for the project.

**Verification result:** All five test cases passed.

**Outcome:** Successfully designed and verified a 4-bit register with an active-high synchronous reset.

## Day 13 — 4-bit Up-Counter

**Practical work**

- Designed a 4-bit synchronous up-counter using Verilog HDL.
- Implemented an active-high synchronous reset.
- Verified counter incrementing on positive clock edges using `@(posedge clk)`.
- Tested value retention between clock edges.
- Verified overflow from `1111` to `0000`.
- Tested reset operation during counting.
- Simulated the design using Icarus Verilog.
- Inspected clock, reset, and counter waveforms using GTKWave.
- Created README documentation for the project.

**Verification result:** All five test cases passed.

**Outcome:** Successfully designed and verified a 4-bit synchronous up-counter with an active-high synchronous reset.

## Day 14 — 4-bit Down-Counter

**Practical Work**
- Designed a 4-bit synchronous down-counter using Verilog HDL.
- Implemented an active-high synchronous reset.
- Verified decrementing on positive clock edges.
- Tested the transition from `0000` to `1111`.
- Verified multiple decrements using expected-value comparisons.
- Simulated the design using Icarus Verilog.
- Generated a VCD waveform for GTKWave inspection.
- Created project documentation in README.md.

**Verification Result:** All test cases passed in simulation.

**Outcome:** Successfully designed and verified a 4-bit synchronous down-counter.

## Day 15 — 4-bit Up/Down Counter

**Practical Work**
- Designed a configurable 4-bit up/down counter using Verilog HDL.
- Implemented active-high synchronous reset.
- Implemented direction selection using `up_down`.
- Verified upward and downward counting.
- Tested overflow and underflow.
- Verified direction switching.
- Tested that changing direction does not immediately change the counter output.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** To be updated after successful simulation.

**Outcome:** Designed and verified a configurable 4-bit synchronous up/down counter.

## Day 16 — 4-bit SIPO Shift Register

**Practical Work**
- Studied the four types of shift registers: SISO, SIPO, PISO, and PIPO.
- Designed a 4-bit Serial-In Parallel-Out shift register using Verilog HDL.
- Implemented an active-high synchronous reset.
- Implemented right shifting using concatenation.
- Verified serial data entering through the MSB.
- Tested multiple consecutive shift operations.
- Verified that changing the serial input does not immediately change the output.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All test cases passed in simulation.

**Outcome:** Successfully designed and verified a 4-bit synchronous SIPO shift register.

## Day 17 — 4-bit SISO Shift Register

**Practical Work**
- Studied Serial-In Serial-Out shift-register architecture.
- Designed a 4-bit SISO right-shift register using Verilog HDL.
- Implemented active-high synchronous reset.
- Used an internal 4-bit register for data storage.
- Connected the serial output to the LSB.
- Verified serial data propagation through four flip-flops.
- Tested the four-clock-cycle data delay.
- Verified that changing serial input does not immediately change the register.
- Checked both internal register values and external serial output.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All test cases passed in simulation.

**Outcome:** Successfully designed and verified a 4-bit synchronous SISO shift register.

## Day 18 — 4-bit PISO Shift Register

**Practical Work**
- Studied Parallel-In Serial-Out shift-register architecture.
- Designed a 4-bit PISO right-shift register using Verilog HDL.
- Implemented active-high synchronous reset.
- Implemented parallel loading of four bits simultaneously.
- Implemented serial transmission using right shifting.
- Connected the serial output to the LSB.
- Verified LSB-first serial data transmission.
- Tested loading and shifting operations.
- Verified no immediate loading when load is inactive.
- Tested reset priority over parallel loading.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All test cases passed in simulation.

**Outcome:** Successfully designed and verified a 4-bit synchronous PISO shift register.

## Day 19 — 4-bit Bidirectional Shift Register

**Practical Work**
- Designed a 4-bit bidirectional shift register using Verilog HDL.
- Implemented active-high synchronous reset.
- Implemented right shifting using concatenation.
- Implemented left shifting using concatenation.
- Added direction control to select the shifting operation.
- Verified serial input entering through both MSB and LSB.
- Tested switching between right-shift and left-shift operations.
- Verified that changing direction does not immediately change the register.
- Verified that changing serial input does not immediately change the register.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All ten verification scenarios passed in simulation.

**Outcome:** Successfully designed and verified a 4-bit synchronous bidirectional shift register.

## Day 20 — Universal Shift Register, Revision and Debugging

**Practical Work**
- Revised counters and shift registers covered during Days 13–19.
- Designed a 4-bit universal shift register using Verilog HDL.
- Implemented HOLD, right shift, left shift, and parallel-load operations.
- Used a 2-bit mode signal for operation selection.
- Implemented active-high synchronous reset.
- Developed a verification testbench for all four operating modes.
- Verified mode-change retention and reset priority.
- Performed fault injection and debugging.

**Fault Injection Results**
- Bug 1: Swapped left and right operations — detected.
- Bug 2: Swapped HOLD and PARALLEL LOAD — detected.
- Bug 3: Incorrect reset priority — detected.
- Identified the failing tests and understood the causes.
- Restored the correct RTL and performed final simulation.

**Tools Used**
- Icarus Verilog
- GTKWave
- VS Code
- Git and GitHub

**Verification Result:** Original verification tests passed after restoring the correct RTL. All three injected faults were detected.

**Outcome:** Successfully designed and verified a universal shift register and practiced systematic RTL fault injection and debugging.

## Day 21 — Mod-10 Synchronous Counter

**Practical Work**
- Studied synchronous and asynchronous counters.
- Learned the concept of Mod-N counters.
- Calculated flip-flop requirements using the logarithmic formula.
- Designed a 4-bit Mod-10 synchronous counter using Verilog HDL.
- Implemented active-high synchronous reset.
- Implemented terminal-count detection at decimal 9.
- Verified counting from 0 to 9.
- Tested rollover from `1001` to `0000`.
- Verified reset during counting.
- Tested value retention between clock edges.
- Performed fault injection by changing the terminal count from 9 to 8.
- Identified premature rollover through simulation failures.
- Restored the correct RTL design.
- Simulated using Icarus Verilog and inspected GTKWave waveforms.

**Verification Result:** Original testbench passed after restoring the correct terminal-count condition. The intentional terminal-count fault was detected.

**Outcome:** Successfully designed and verified a 4-bit Mod-10 synchronous counter and practiced systematic debugging.

## Day 22 — Divide-by-10 Frequency Divider

**Practical Work**
- Studied clock frequency and time period.
- Understood frequency division using counters.
- Designed a divide-by-10 frequency divider using Verilog HDL.
- Implemented a 3-bit internal counter.
- Implemented terminal-count detection at decimal 4.
- Generated output clock transitions after every five input clock cycles.
- Verified output frequency and 50% duty cycle.
- Tested synchronous reset.
- Verified output clock toggling.
- Tested value retention between clock edges.
- Verified reset during operation.
- Simulated using Icarus Verilog.
- Inspected clock waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All testbench checks passed in simulation.

**Outcome:** Successfully designed and verified a divide-by-10 synchronous clock divider.

## Day 23 — 4-bit Register with Clock Enable

**Practical Work**
- Studied clock-enable functionality.
- Understood the difference between clock enable and clock gating.
- Studied the role of clock gating in dynamic power reduction.
- Learned about glitch-free clock gating and integrated clock-gating cells.
- Designed a 4-bit synchronous register with clock enable using Verilog HDL.
- Implemented active-high synchronous reset.
- Implemented conditional data loading using the enable signal.
- Verified data retention when enable is inactive.
- Tested changing input data while enable is inactive.
- Verified reset priority over enable.
- Tested register behavior between clock edges.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All testbench checks passed in simulation.

**Outcome:** Successfully designed and verified a 4-bit register with clock enable and understood fundamental clock-gating concepts.

## Day 24 — Vending Machine FSM (Moore FSM)

**Practical Work**
- Studied the fundamentals of Finite State Machines (FSMs).
- Understood the difference between Moore and Mealy FSMs.
- Studied current-state and next-state logic.
- Learned binary state encoding and state representation.
- Designed a vending machine FSM using Verilog HDL.
- Implemented three states: IDLE, HAVE_5, and DISPENSE.
- Designed the vending machine to accept two ₹5 coins for a ₹10 item.
- Implemented sequential state-transition logic using a positive-edge-triggered clock.
- Implemented combinational next-state logic using `always @(*)`.
- Implemented Moore output logic for the dispense signal.
- Implemented active-high synchronous reset.
- Verified normal vending-machine transactions.
- Tested automatic return to IDLE after dispensing.
- Verified reset during the HAVE_5 state.
- Verified reset during the DISPENSE state.
- Verified internal FSM states and external output using a testbench.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** Testbench verification completed for normal transactions, state transitions, output behavior, and reset conditions.

**Outcome:** Successfully designed and verified a Moore FSM-based vending machine and understood the fundamentals of FSM design, state transitions, and sequential and combinational logic separation.

## Day 25 — Traffic Light Controller using FSM

**Practical Work**
- Studied the implementation of a traffic light controller using FSM.
- Designed a Moore FSM for a two-road intersection (North-South and East-West).
- Implemented four states: NS_GREEN, NS_YELLOW, EW_GREEN, and EW_YELLOW.
- Implemented 2-bit binary state encoding.
- Designed sequential state-transition logic using a positive-edge-triggered clock.
- Implemented combinational next-state logic using `always @(*)`.
- Implemented Moore output logic for six traffic-light control signals.
- Used `timer_done` as the state-transition control input.
- Implemented active-high synchronous reset.
- Verified state retention when `timer_done` is inactive.
- Verified transitions between all four FSM states.
- Tested transition from EW_YELLOW back to NS_GREEN.
- Verified reset during the EW_GREEN state.
- Verified reset priority over normal state transitions.
- Verified internal FSM states and external traffic-light outputs.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All testbench checks passed in simulation.

**Outcome:** Successfully designed and verified a four-state Moore FSM-based traffic light controller and understood timer-controlled state transitions, output decoding, and synchronous reset behavior.

## Day 26 — Serial Sequence Detector using Mealy FSM

**Practical Work**
- Studied the fundamentals of Mealy FSM architecture.
- Understood the difference between Moore and Mealy FSMs.
- Designed a serial sequence detector for the binary pattern `1011`.
- Implemented four FSM states: S0, S1, S2, and S3.
- Implemented 2-bit binary state encoding.
- Designed sequential state-transition logic using a positive-edge-triggered clock.
- Implemented combinational next-state logic using `always @(*)`.
- Implemented Mealy output logic using the current state and serial input.
- Implemented active-high synchronous reset.
- Verified detection of the sequence `1011`.
- Tested non-detection using input sequences `0000` and `1010`.
- Implemented and verified overlapping sequence detection using `1011011`.
- Tested reset during partial sequence detection.
- Verified internal FSM states and external detection output.
- Studied Mealy output behavior between positive clock edges.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All testbench checks passed in simulation.

**Outcome:** Successfully designed and verified a Mealy FSM-based serial sequence detector for the pattern `1011`, understood overlapping sequence detection, and learned the timing differences between Mealy and Moore FSM outputs.

## Day 27 — Serial Sequence Detector using Moore FSM

**Practical Work**
- Studied the implementation of a serial sequence detector using Moore FSM.
- Compared Moore and Mealy FSM architectures.
- Designed a serial sequence detector for the binary pattern `1011`.
- Implemented five FSM states: S0, S1, S2, S3, and S4.
- Implemented 3-bit binary state encoding.
- Designed sequential state-transition logic using a positive-edge-triggered clock.
- Implemented combinational next-state logic using `always @(*)`.
- Implemented Moore output logic based only on the current state.
- Implemented active-high synchronous reset.
- Verified detection of the sequence `1011`.
- Tested non-detection using input sequences `0000` and `1010`.
- Implemented overlapping sequence detection using `1011011`.
- Tested reset during partial sequence detection.
- Verified internal FSM state transitions and external detection output.
- Compared Mealy and Moore output timing.
- Developed reusable testbench tasks for state and output verification.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** All testbench checks passed in simulation.

**Outcome:** Successfully designed and verified a five-state Moore FSM-based serial sequence detector for the pattern `1011`, understood overlapping sequence detection, and learned the differences between Moore and Mealy FSM architectures and their output timing.

## Day 28 — Serial Sequence Detector using One-Hot FSM

**Practical Work**
- Studied One-Hot state encoding in Finite State Machines.
- Compared binary and One-Hot state encoding techniques.
- Designed a serial sequence detector for the binary pattern `1011` using One-Hot encoding.
- Implemented five FSM states: S0, S1, S2, S3, and S4.
- Implemented five-bit One-Hot state representation.
- Designed sequential state-transition logic using a positive-edge-triggered clock.
- Implemented combinational next-state logic using `always @(*)`.
- Implemented Moore output logic based only on the current state.
- Implemented active-high synchronous reset.
- Verified all ten state transitions.
- Verified successful detection of the sequence `1011`.
- Tested non-detection using input sequences `0000` and `1010`.
- Verified overlapping sequence detection using `1011011`.
- Tested reset during partial sequence detection.
- Implemented One-Hot state validity checking in the testbench.
- Verified both current-state and next-state One-Hot encoding.
- Used reusable Verilog tasks for state, output, and reset verification.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** Testbench verification completed for sequence detection, overlapping detection, reset behavior, and One-Hot state validity.

**Outcome:** Successfully designed and verified a five-state Moore FSM-based serial sequence detector using One-Hot encoding and understood the differences between binary and One-Hot state representation, including their flip-flop requirements and state-decoding trade-offs.

## Day 29 — UART Transmitter using FSM and Shift Register

**Practical Work**
- Studied UART asynchronous serial communication.
- Understood the UART 8-N-1 frame format.
- Designed an 8-bit UART transmitter using Verilog HDL.
- Implemented four FSM states: IDLE, START, DATA, and STOP.
- Implemented 2-bit binary state encoding.
- Designed sequential state-transition logic using a positive-edge-triggered clock.
- Implemented combinational next-state logic using `always @(*)`.
- Designed an 8-bit shift register for parallel-to-serial data conversion.
- Implemented LSB-first serial data transmission.
- Designed a 3-bit bit counter to track eight data bits.
- Used an external `baud_tick` input for bit-period timing.
- Implemented start-bit and stop-bit transmission.
- Implemented the `tx` serial output.
- Implemented the `busy` transmission status output.
- Implemented a one-system-clock-cycle `tx_done` completion pulse.
- Verified transmission of different 8-bit data values.
- Tested behavior when a new start request occurs during an active transmission.
- Tested synchronous reset during active transmission.
- Simulated using Icarus Verilog.
- Inspected waveforms using GTKWave.
- Created project documentation.

**Verification Result:** UART frame transmission, LSB-first shifting, bit counter progression, status signals, and reset behavior were exercised in simulation and inspected using GTKWave.

**Outcome:** Successfully designed and verified an FSM-controlled UART transmitter and understood the integration of an FSM, shift register, and bit counter for parallel-to-serial communication.

## Day 30 — UART Receiver using FSM and Shift Register

**Practical Work**

- Designed a four-state Moore FSM with IDLE, START, DATA, and STOP states.
- Implemented start-bit validation and false-start detection.
- Designed an 8-bit shift register to receive serial data in LSB-first order.
- Implemented a bit counter to track the eight received data bits.
- Implemented `rx_valid` to indicate successful reception.
- Implemented `framing_error` to detect an invalid stop bit.
- Implemented the `busy` output to indicate active reception.
- Created a self-checking testbench with nine verification scenarios.
- Inspected simulation waveforms using GTKWave.

**Verification Result:** All nine test scenarios passed successfully, covering reset, idle operation, reception of `8'hA5`, `8'h3C`, `8'h00`, and `8'hFF`, false-start detection, framing-error detection, and reset during DATA reception.

**Outcome:** Successfully designed and verified an 8-bit UART receiver using an FSM and shift register. Understood serial-to-parallel conversion, LSB-first reception, start-bit validation, and framing-error detection.

---

## Tools and Skills Practised

- **Verilog HDL:** Combinational logic, MUXes, decoders, procedural blocks, flip-flops, registers, `if/else`, and `case`.
- **Verification:** Testbenches, input combinations, expected outputs, PASS/FAIL reporting, and error counters.
- **Simulation:** Icarus Verilog.
- **Waveform analysis:** GTKWave and VCD files.
- **Version control:** Git, commits, `.gitignore`, and repository organization.
- **Development environment:** VS Code and WSL Ubuntu.

## Next Learning Goals

- Strengthen Verilog syntax and combinational design.
- Learn counters, registers, and sequential logic.
- Practise blocking and non-blocking assignments.
- Build more comprehensive self-checking testbenches.
- Learn finite-state machines.
- Progress to SystemVerilog and verification fundamentals.

---

**Current milestone:** Progressing through RTL Design and Verification fundamentals, with hands-on experience in combinational logic, Verilog HDL, sequential circuits, testbench development, simulation, waveform analysis, debugging, and Git/GitHub portfolio management.