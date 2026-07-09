// interface with modports

interface bus_if(input logic clk);
  logic [7:0] addr;
  logic [7:0] data;
  logic       we;

  // modport restricts signal DIRECTION from a particular module's point of view
  modport master(output addr, output data, output we, input clk);
  modport slave(input addr, input data, input we, input clk);
endinterface

module master_drv(bus_if.master bus);   // connects using the 'master' view only
  initial begin
    @(posedge bus.clk);
    bus.addr = 8'h20;
    bus.data = 8'h55;
    bus.we   = 1;
    // Trying to READ bus.addr as an input here would be flagged, since
    // 'master' modport declares these signals as outputs
  end
endmodule

module slave_recv(bus_if.slave bus);   // connects using the 'slave' view only
  always @(posedge bus.clk) begin
    if (bus.we)
      $display("[%0t] slave received addr=%0h data=%0h", $time, bus.addr, bus.data);
  end
endmodule

module modports;
  logic clk = 0;
  always #5 clk = ~clk;

  bus_if bus(clk);

  master_drv m(bus.master);   // same interface, different modport per module
  slave_recv s(bus.slave);

  initial begin
    #50 $finish;
  end
endmodule
