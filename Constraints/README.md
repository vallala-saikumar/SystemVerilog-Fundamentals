# Constraints in system verilog

Covers SystemVerilog's constraint syntax used to shape the random space
during randomization. This is a companion to the randomization folder,
which covers randomize() mechanics itself (rand/randc, rand_mode(),
pre/post_randomize).

## Files

| # | File                                       | Concept                                                    		   |
|---|--------------------------------------------|---------------------------------------------------------------------|
| 1 | `inside_constraint.sv`                     | Range, relational, set membership (`inside`)                        |
| 2 | `constraint_mode.sv`         				 | Inline constraints (`randomize() with {}`), `constraint_mode()`     |
| 3 | `soft_inline_constraints.sv`               | `soft` constraints as overridable defaults                          |
| 4 | `dist_weighted_constraints.sv`             | Weighted distribution (`dist`, `:=`, `:/`)                          |
| 5 | `conditional_constraints.sv`     			 | Implication (`->`), if-else conditional constraints                 |
| 6 | `foreach_solve_unique_constraints.sv`      | `foreach`, `solve...before`, `unique`                               |
| 7 | `extern_constraint.sv`                     | Extern constraint declaration/definition split                      |
| 8 | `function_inside_constraint.sv`            | Calling a function inside a constraint expression                   |
| 9 | `static_constraint.sv`                     | `static` constraint shared across all class instances               |

## Key takeaways
- **Basic constraints**: range and relational constraints narrow the
  random space directly; `inside` restricts to a specific set/range.
- **Inline constraints** (`randomize() with {...}`) apply only for one
  call. **constraint_mode()** enables/disables an entire constraint
  block at runtime - useful for generating illegal/corner-case stimulus.
- **Soft constraints** act as defaults and are silently overridden by
  any conflicting hard or inline constraint.
- **dist** assigns relative weights to values or ranges (`:=` per value,
  `:/` split across a range) to bias how often each value occurs.
- **Implication (`->`) and if-else** apply a constraint only under a
  condition - useful for correlating one variable's legal range to
  another variable's value.
- **foreach** applies a constraint to every element of an array.
  **solve...before** controls randomization order when one variable's
  value should influence another's constrained range. **unique**
  ensures all values in a set/array are distinct.
- **extern constraint** separates the constraint's declaration (inside
  the class) from its definition (outside, via `ClassName::constraint_name`),
  keeping large classes readable - same idea as extern methods.
- **Functions inside constraints** let a bound or condition be computed
  dynamically rather than hardcoded - the function must be free of side
  effects like calling `randomize()`.
- **Static constraints** are shared across every instance of the class,
  just like a static class member. Disabling a static constraint through
  any one object's handle disables it for all objects of that class -
  a common source of confusion if not understood clearly.
