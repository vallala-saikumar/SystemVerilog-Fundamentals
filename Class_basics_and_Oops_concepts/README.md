# Object-Oriented Programming (OOP)

Covers SystemVerilog's class-based OOP features - the foundation for
reusable, extensible testbench components.

## Files

| # | File                                    	| Concept                                     	 |
|---|-------------------------------------------|------------------------------------------------|
| 1 | `01_class_basics.sv`                      | Class, constructor (`new`), members, methods   |
| 2 | `02_inheritance.sv`                       | `extends`, constructor chaining                |
| 3 | `03_polymorphism_virtual.sv`              | Virtual vs non-virtual methods                 |
| 4 | `04_deep_vs_shallow_copy.sv`              | Shallow copy vs deep copy                      |
| 5 | `05_abstract_class_virtual_methods.sv`    | Virtual class, pure virtual methods            |
| 6 | `06_access_specifiers.sv`                 | `local`, `protected`, public members           |
| 7 | `07_this_super_keyword.sv`                | `this`, `super` explicit usage                 |
| 8 | `08_dollar_cast_downcasting.sv`           | `$cast`, upcasting vs downcasting              |
| 9 | `09_parameterized_class.sv`               | `class #(type T, int PARAM)`                   |
| 10| `10_extern_methods.sv`                    | `extern` method declarations                   |

## Key takeaways
- **Classes** bundle data and behavior - the basic unit for transactions, drivers, monitors, scoreboards.
- **Inheritance** builds specialized classes on a common base; always chain constructors with `super.new()`.
- **Polymorphism** requires `virtual` methods - a non-virtual method called via a base handle runs the base's version, not the derived one.
- **Shallow copy** (`new obj`) only copies top-level handles; nested objects stay shared. **Deep copy** recreates nested objects independently.
- **Abstract classes** with `pure virtual` methods force every derived class to implement a required method.
- **Access specifiers**: `local` = this class only, `protected` = this class + derived classes, unmarked = public.
- **this/super**: `this` resolves member vs argument name clashes; `super` calls the parent's constructor/method explicitly.
- **$cast** is required for downcasting (base → derived handle) and can fail at runtime - always check its return value. Same mechanism UVM's factory uses internally.
- **Parameterized classes** let one class definition work across types/sizes - the pattern UVM sequences/drivers are built on.
- **Extern methods** separate declaration from implementation, keeping large classes readable.
