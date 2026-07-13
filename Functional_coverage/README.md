# Functional Coverage

Covers SystemVerilog's functional coverage constructs - measuring which
values, sequences, and combinations of values have actually been
exercised during simulation, used to judge verification completeness.

## Files

| # | File                             | Concept                                                              |
|---|----------------------------------|---------------------------------------------------------------------------|
| 1 | `coverage_basics.sv`             | Covergroup, coverpoint, implicit (clocked) vs explicit (`sample()`) sampling |
| 2 | `transition_bins.sv`             | All transition bin forms - sequence, set, consecutive/range/goto/non-consecutive repeat |
| 3 | `illegal_ignore_bins.sv`         | `illegal_bins` vs `ignore_bins`                                             |
| 4 | `cross_coverage_binsof.sv`       | Cross coverage restricted using `binsof()`                                  |
| 5 | `coverage_constructs.sv`         | Cross coverage using `binsof().intersect{}`                                 |
| 6 | `coverage_options.sv`            | `option.name`, `option.comment`, `option.per_instance`, `option.auto_bin_max`, `option.at_least`, `option.goal` |

## Key takeaways
- **Covergroups** can sample implicitly on a clocking event
  (`covergroup cg @(posedge clk);`) or explicitly via `cg.sample()`
  called manually wherever needed in the code.
- **Transition bins** track sequences of values across samples, not
  just single values - covering everything from a simple `a=>b`
  transition to repeat counts (`[*n]`, `[*m:n]`), goto-style repeats
  (`[->n]`), and non-consecutive repeats (`[=n]`). Essential for FSM
  and protocol sequence coverage.
- **illegal_bins** raise a runtime error if that value is ever sampled
  (values that should never legally occur). **ignore_bins** silently
  exclude values from coverage calculation with no error.
- **binsof()** lets a cross coverage bin selectively include or exclude
  combinations based on which bin a coverpoint hit, rather than
  covering every possible combination equally.
- **binsof().intersect{}** further restricts a cross bin to only count
  combinations where the referenced coverpoint's value also falls
  within a specific range - useful for narrowing down exactly which
  cross combinations matter.
- **Coverage options** tune how coverage is measured and reported:
  `option.name` and `option.comment` are descriptive only,
  `option.per_instance` controls whether coverage is merged or tracked
  separately per object, `option.auto_bin_max` caps automatically
  generated bins, `option.at_least` sets the minimum hit count for a
  bin to count as covered, and `option.goal` sets a custom completion
  target percentage.
