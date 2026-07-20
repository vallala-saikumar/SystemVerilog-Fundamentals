# SystemVerilog Fundamentals

A structured collection of SystemVerilog concepts, from core language
fundamentals through complete verification environments — built for
DV interview prep and hands-on practice.

## Repo Structure

| # | Folder | Covers |
|---|---|---|
| 01 | `01_data_types` | 2-state/4-state, arrays, queues, associative arrays, structs, unions, enums, typedef/casting |
| 02 | `02_procedural_constructs` | always_comb/ff/latch, blocking vs non-blocking, fork-join, loops, jump statements, static vs automatic, argument passing |
| 03 | `03_oop` | Classes, inheritance, polymorphism, copy semantics, abstract classes, access specifiers, $cast, parameterized classes, extern methods |
| 04 | `04_interfaces_modports` | Interfaces, modports, clocking blocks, virtual interfaces |
| 05 | `05_randomization` | rand/randc, pre/post_randomize, rand_mode(), nested class randomization |
| 06 | `06_constraints` | Range/relational/set constraints, inline & soft constraints, dist, implication/if-else, foreach/solve.../unique, extern/static constraints |
| 07 | `07_functional_coverage` | Covergroups, implicit/explicit bins, transition/wildcard/array bins, cross coverage, illegal/ignore bins, coverage options |
| 08 | `08_assertions_sva` | Immediate & concurrent assertions, sequences/properties, implication & sequence/property operators, $rose/$fell/$past, disable iff, built-in methods |
| 09 | `09_mailboxes_semaphores_events` | Mailboxes, semaphores, events, trigger/wait semantics and race pitfalls |
| 10 | `10_sv_environment_practice_codes` | Complete mini verification environments applying the above concepts end-to-end |

## Folder 10 — Practice Environments

| Project | Description |
|---------|-------------|
| `01_encoder` | Self-checking testbench for a parameterized priority encoder — generator, driver, interface, monitors, and scoreboard |
| `02_full_subtractor`| Self-checking testbench for a full subtractor |


## How to use this repo
Each folder (01–09) contains standalone `.sv` files, each demonstrating
one concept with a runnable testbench and a `README.md` summarizing key
takeaways. Folder 10 contains complete, connected environments rather
than isolated concept files — a good next step once the fundamentals
are comfortable.

## Tools
Code has been compiled/run using Questa/ModelSim (`qverilog`). Any
SystemVerilog-compliant simulator (VCS, Xcelium) should work with
minimal or no changes.
