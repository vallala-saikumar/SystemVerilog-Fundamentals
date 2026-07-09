// interface_basics
interface simple_bus_if(input logic clk);
  logic [7:0] addr;
  logic [7:0] data;
  logic       we;
  logic       valid;
  // interface bundles related signals into ONE handle, avoiding long
  // port lists when connecting modules together
endinterface

module producer(simple_bus_if bus);
  initial begin
    @(posedge bus.clk);
    bus.addr  = 8'h10;
    bus.data  = 8'hAA;
    bus.we    = 1;
    bus.valid = 1;   // signals accessed via the interface handle, not individual ports
  end
endmodule

module consumer(simple_bus_if bus);
  always @(posedge bus.clk) begin
    if (bus.valid)
      $display("[%0t] consumer sees addr=%0h data=%0h we=%0b", $time, bus.addr, bus.data, bus.we);
  end
endmodule

module interface_basics;
  logic clk = 0;
  always #5 clk = ~clk;

  simple_bus_if bus(clk);   // single interface instance shared by both modules

  producer p(bus);   // only ONE port connection needed instead of 4 separate signals
  consumer c(bus);

  initial begin
    #50 $finish;
  end
endmodule
