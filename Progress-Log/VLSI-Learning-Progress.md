# VLSI Learning Progress Log

**Learning Track:** RTL Design and Verification  
**Primary Language:** Verilog HDL  
**Simulation Tools:** Icarus Verilog and GTKWave  
**Development Environment:** VS Code, WSL Ubuntu, Git  
**Progress Period:** Days 1–10

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

**## Day 11 — D Flip-Flop with Asynchronous Reset**

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

**## Day 12 — 4-bit Register with Synchronous Reset**

**=Practical work=**
- Designed a 4-bit register using Verilog HDL.
- Implemented an active-high synchronous reset.
- Used `always @(posedge clk)` to describe the register's behavior.
- Created a testbench to verify reset, data capture, and data retention.
- Simulated the design using Icarus Verilog.
- Inspected the output waveforms using GTKWave.
- Created README documentation for the project.

**Verification result:** All five test cases passed.

**Outcome:** Successfully designed and verified a 4-bit register with an active-high synchronous reset.

---

## Tools and Skills Practised

- **Verilog HDL:** Combinational logic, MUXes, decoders, procedural blocks, `if/else`, and `case`.
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

**Current milestone:** Completed foundational digital logic exercises and five introductory Verilog projects, with simulation, testbench development, debugging, and local Git version control.