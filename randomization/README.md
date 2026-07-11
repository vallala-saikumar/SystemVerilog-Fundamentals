# Randomization

Covers SystemVerilog's core randomization mechanics - generating random
values and controlling how randomize() behaves. Constraint syntax
(range, inside, dist, implication, etc.) is covered separately in the
constraints folder.

## Files

| # | File                                | Concept                                       |
|---|-------------------------------------|--------------------------------------------------|
| 1 | `randomization_basics.sv`           | `rand` vs `randc`                                  |
| 2 | `pre_post_randomize.sv`         	  | `pre_randomize()`, `post_randomize()`              |
| 3 | `randmode.sv`                       | `rand_mode()` - enabling/disabling randomization per variable |
| 4 | `std_randomize.sv`      			  | Checking `randomize()`'s return value, `std::randomize()` |
| 5 | `nested_class_randomization.sv`     | randomization of nested class properties in different ways |

## Key takeaways
- **rand vs randc**: `rand` can repeat values across calls; `randc`
  cycles through every possible value once before any value repeats.
- **pre_randomize/post_randomize** are automatic hooks called before and
  after every `randomize()` call - useful for logging or computing
  derived values from the freshly randomized data.
- **rand_mode()** disables randomization for a specific *variable*
  entirely - it retains its current value and is skipped during
  `randomize()`. This is different from `constraint_mode()`, which
  disables a *constraint block* instead (see the constraints folder).
- **Always check randomize()'s return value** in real testbench code -
  a return of 0 means randomization failed (usually due to conflicting
  constraints), and silently ignoring this can cause hard-to-trace bugs.
- **std::randomize()** randomizes plain variables that live outside any
  class.
