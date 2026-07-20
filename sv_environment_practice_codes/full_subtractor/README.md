# Full Subtractor Verification Environment

A complete SystemVerilog testbench environment for a full subtractor —
a practice project applying core verification concepts (interfaces,
classes, randomization, self-checking scoreboards) into one connected
environment.

## Overview

**DUT:** `fs_dut.sv` — a full subtractor taking two input bits and a
borrow-in, producing a difference output and borrow-out.

**Verification approach:** a self-checking, class-based environment —
randomized stimulus generation, a driver to apply it, independent
input/output monitors, and a scoreboard that checks actual DUT
behavior against expected results.

`fs_environment` instantiates and connects all of the above.
`fs_test` configures and starts the environment.
`fs_top` is the simulation entry point — instantiates the DUT, the
interface, and launches the test.

## Files

| File                | Role                                                          |
|---------------------|------------------------------------------------------------------|
| `fs_top.sv`         | Top module — instantiates DUT + interface, starts the test        |
| `fs_test.sv`        | Configures the environment and starts stimulus                    |
| `fs_environment.sv` | Builds and connects generator, driver, monitors, scoreboard        |
| `fs_generator.sv`   | Generates and randomizes transactions                             |
| `fs_driver.sv`      | Drives transactions onto the DUT through the interface             |
| `fs_interface.sv`   | Bundles DUT signals; clocking block for synchronized drive/sample  |
| `fs_dut.sv`         | The full subtractor design under test                             |
| `fs_ip_monitor.sv`  | Passively monitors DUT input signals                              |
| `fs_op_monitor.sv`  | Passively monitors DUT output signals                             |
| `fs_scoreboard.sv`  | Compares actual DUT output against expected difference/borrow      |
| `fs_transaction.sv` | Randomized transaction class carrying input/output fields          |
| `fs_pb.sv`          | Shared parameters/typedefs used across the environment              |

## Key verification focus
- Correct difference and borrow-out logic verified across all input
  combinations via randomized stimulus
- Self-checking via scoreboard comparison against a reference model
  (expected difference/borrow computed independently of the DUT)

## Concepts applied from this repo
| Concept 								   | Where it's used |
|------------------------------------------|------------------------------------------|
| Interfaces & clocking blocks (`04`)	   | `fs_interface.sv` |
| OOP / class structure (`03`) 			   | Transaction, generator, driver, scoreboard classes |
| Randomization & constraints (`05`, `06`) | `fs_transaction.sv`, `fs_generator.sv` |
| Mailboxes/events (`09`) 				   | Communication between generator, driver, and monitors |
