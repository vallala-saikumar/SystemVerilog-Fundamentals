#  Interfaces and Modports

Covers SystemVerilog interfaces - how they bundle related signals,
restrict signal direction per module, synchronize signal timing, and
connect into class-based testbench code.

## Files

| # | File                           | Concept                                |
|---|--------------------------------|-------------------------------------------|
| 1 | `01_interface_basics.sv`       | Interface declaration, signal bundling     |
| 2 | `02_modports.sv`               | Modports - restricting signal direction    |
| 3 | `03_clocking_blocks.sv`        | Clocking blocks - synchronized drive/sample |
| 4 | `04_virtual_interface.sv`      | Virtual interfaces - connecting classes to real HW interfaces |

## Key takeaways
- **Interfaces** group related signals into a single handle, avoiding
  long port lists when connecting multiple modules together.
- **Modports** restrict how a connected module can use an interface's
  signals (input/output), preventing accidental misuse - e.g. a slave
  module shouldn't be able to drive address lines.
- **Clocking blocks** synchronize signal driving and sampling to clock
  edges, avoiding race conditions between testbench and DUT. A signal
  can only be declared once per clocking block (either `input`,
  `output`, or `inout` - never both `input` and `output` separately).
- **Virtual interfaces** let class-based code (drivers, monitors, etc.)
  reference a real interface instance through a handle, since classes
  can't instantiate interfaces directly. This is the exact mechanism
  UVM components use to connect to physical DUT signals.
