#  Procedural Constructs

This section covers SystemVerilog procedural blocks, control flow, concurrency,
and task/function behavior used in RTL design and verification testbenches.

## Files

| # | File						| Concept 									 | Importance |

| 1 | `always_comb_ff_latch.sv` | `always_comb`, `always_ff`, `always_latch` | Recommended procedural blocks for modeling combinational, sequential, and latch logic. |

| 2 | `blocking_nonblocking.sv` | `=` vs `<=` 								 | Correct assignment semantics for combinational and sequential logic. |

| 3 | `fork_blocks.sv`		    | `join`, `join_any`, `join_none`			 | Parallel process execution and synchronization. |

| 4 | `unique_if_case.sv` 		| `if`, `case`, `unique if`, `unique case` 	 | Conditional logic and runtime checking. |

| 5 | `sv_loops.sv` 			| Loops and `generate` 						 | Procedural iteration and compile-time hardware generation. |

| 6 | `jump_statements.sv` 		| `break`, `continue`, `disable`, `disable fork` | Loop control and process management. |

| 7 | `static_vs_automatic_function.sv` | Static vs Automatic Functions 	 | Function storage lifetime and re-entrancy. |

| 8 | `static_vs_automatic_task.sv` | Static vs Automatic Tasks 			 | Safe concurrent task execution using automatic storage. |

## Key Takeaways

- Use `always_comb`, `always_ff`, and `always_latch` to clearly express design intent.
- Use blocking (`=`) assignments for combinational logic and non-blocking (`<=`) assignments for sequential logic.
- Understand `fork...join` variants for concurrent process execution.
- Use `unique if` and `unique case` to detect overlapping or missing conditions.
- Distinguish procedural loops from `generate`, which creates hardware during elaboration.
- Prefer automatic tasks and functions for recursive or concurrent execution.
