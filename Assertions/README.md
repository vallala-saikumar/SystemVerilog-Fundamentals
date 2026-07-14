#  Assertions (SVA)

Covers SystemVerilog Assertions - formally specifying expected design
behavior so the simulator continuously checks it, catching protocol
violations that directed checks might miss.

## Files

| # | File                                      | Concept                                                          |
|---|-------------------------------------------|------------------------------------------------------------------------|
| 1 | `immediate_assertions.sv`                 | Immediate assertions - zero-delay, procedural checks                     |
| 2 | `concurrent_assertions_basics.sv`         | Concurrent assertions, clocked checking                                  |
| 3 | `sequences_properties.sv`                 | `sequence`, `property`, `##` delay operators                             |
| 4 | `system_functions_rose_fell.sv`           | `$rose`, `$fell`, `$stable`, `$past`                                      |
| 5 | `implication_operators.sv`                | `|->` (overlapped) vs `|=>` (non-overlapped)                              |
| 6 | `sequence_operators.sv`                   | `##n`, `##[m:n]`, `and`, `or`, `intersect`, `throughout`, `within`, `first_match` |
| 7 | `property_operators.sv`                   | `not`, `and`, `or`, if-else, `until`, `s_eventually`, `s_always`           |
| 8 | `assertion_builtin_methods.sv`            | Pass/fail action blocks, `$assertoff`/`$asserton`/`$assertkill`           |
| 9 | `disable_iff_ex.sv`          				| `disable iff`, `cover property`                                           |

## Key takeaways
- **Immediate assertions** check a condition once, at the point they
  execute procedurally - no clock/time awareness.
- **Concurrent assertions** are checked continuously on clock edges and
  can span multiple cycles.
- **|-> (overlapped)** requires the consequent true in the SAME cycle;
  **|=> (non-overlapped)** requires it true the NEXT cycle - a very
  common interview distinction.
- **Sequence operators**: `##n`/`##[m:n]` express delay, `and`/`or`
  combine sequences with different completion rules, `intersect`
  requires simultaneous completion, `throughout` holds a condition
  across another sequence's duration, `within` nests one sequence
  inside another's window, and `first_match` takes only the earliest
  possible match when a range creates multiple candidates.
- **Property operators**: `not` asserts a condition never occurs,
  `until`/`s_eventually`/`s_always` express ordering and persistence
  requirements over time.
- **Action blocks** on assert property let you run custom code on pass
  or fail (e.g. counters) instead of just printing an error.
  **$assertoff/$asserton/$assertkill** control assertion checking at
  runtime - useful for suppressing checks during known invalid windows.
- **disable iff** is the standard way to suppress an assertion during
  reset or another don't-care condition, rather than manually gating
  every property. **cover property** records how often a behavior
  pattern occurs, for coverage purposes rather than pass/fail checking.
