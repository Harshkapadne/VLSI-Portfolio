# VLSI Design and Verification Portfolio

Welcome to my VLSI learning portfolio. This repository documents my hands-on journey in digital design, Verilog RTL development, simulation, and verification.

## Learning Goals

- Build a strong foundation in digital logic and Boolean algebra.
- Design combinational and sequential circuits using Verilog.
- Write testbenches and verify RTL functionality.
- Debug designs using simulation waveforms.
- Develop skills relevant to RTL Design and Design Verification Engineering.

## Tools and Technologies

- **VS Code** — code editor
- **WSL Ubuntu** — development environment
- **Verilog HDL** — RTL design
- **Icarus Verilog** — compilation and simulation
- **GTKWave** — waveform analysis
- **Git and GitHub** — version control and portfolio management

## Projects and Practice

| Folder | Topic |
|---|---|
| `Day05-MUX` | 2:1 Multiplexer |
| `Day06-MUX4` | 4:1 Multiplexer |
| `Day07-Procedural-MUX` | Procedural 2:1 Multiplexer |
| `Day08-Case-MUX` | 4:1 Multiplexer using `case` |
| `Day09-Decoder` | 2-to-4 Decoder |

Each project contains Verilog source code and a testbench. Project-specific README files will document the design and simulation steps.

## Typical Simulation Workflow

Compile a design and testbench with Icarus Verilog:

```bash
iverilog -o design_sim design.v design_tb.v
vvp design_sim
```

For designs that generate a VCD waveform, open it with GTKWave:

```bash
gtkwave design.vcd
```

Replace the example filenames with the filenames used in each project.

## Progress

This portfolio is a work in progress. New exercises, debugging practice, verification concepts, and projects will be added as I progress through the learning roadmap.
