# Parameterized Encoder Verification Environment

A complete SystemVerilog testbench environment for a parameterized
priority encoder — a practice project applying the fundamentals covered
in this repo (interfaces, classes, randomization, coverage, mailboxes/
events) into one working end-to-end environment.

## Overview

**DUT:** `en_dut.sv` — a parameterized encoder that converts a
priority/one-hot input into its corresponding binary encoded output.
Being parameterized, the same design can be instantiated for different
input widths without modification.

**Verification approach:** a self-checking, non-UVM class-based
environment — randomized stimulus generation, a driver to apply it,
independent input/output monitors, and a scoreboard that checks actual
DUT behavior against expected results.

(compares expected vs actual output)
`en_environment` instantiates and connects all of the above.
`en_test` configures and starts the environment.
`en_top` is the simulation entry point — instantiates the DUT, the
interface, and launches the test.

## Files

| File                | Role                                                          |
|---------------------|----------------------------------------------------------------|
| `en_top.sv`         | Top module — instantiates DUT + interface, starts the test       |
| `en_test.sv`        | Configures the environment and starts stimulus                   |
| `en_environment.sv` | Builds and connects generator, driver, monitors, scoreboard       |
| `en_generator.sv`   | Generates and randomizes transactions                            |
| `en_driver.sv`      | Drives transactions onto the DUT through the interface           |
| `en_interface.sv`   | Bundles DUT signals; clocking block for synchronized drive/sample |
| `en_dut.sv`         | The parameterized encoder design under test                      |
| `en_ip_monitor.sv`  | Passively monitors DUT input signals                             |
| `en_op_monitor.sv`  | Passively monitors DUT output signals                            |
| `en_scoreboard.sv`  | Compares actual DUT output against expected encoding             |
| `en_transaction.sv` | Randomized transaction class carrying input/output fields        |
| `en_pb.sv`          | Shared parameters/typedefs used across the environment            |

## Key verification focus
- Correct encoding behavior verified across randomized input patterns
- Parameterized width support — the environment scales with the DUT's
  configured width rather than being hardcoded to one size
- Self-checking via scoreboard comparison against a reference model

## Concepts applied from this repo
| Concept 								   | Where it's used |
|------------------------------------------|----------------------------------------------------|
| Interfaces & clocking blocks (`04`)	   | `en_interface.sv` |
| OOP / class structure (`03`) 		  	   | Transaction, generator, driver, scoreboard classes |
| Randomization & constraints (`05`, `06`) | `en_transaction.sv`, `en_generator.sv`				 |
| Mailboxes/events (`09`) 				   | Communication between generator, driver, and monitors |
