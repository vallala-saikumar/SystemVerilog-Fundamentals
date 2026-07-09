// clocking_blocksv
interface sync_if(input logic clk);
  logic [7:0] data;
  logic       valid;

  // clocking block synchronizes signal sampling/driving to clock edges -
  // prevents race conditions between testbench and DUT changing signals
  // at the exact same simulation time
  clocking cb @(posedge clk);
    output data;          // testbench DRIVES data through this clocking block
    input  #1step valid;  // testbench SAMPLES valid safely through this clocking block
  endclocking

  modport tb(clocking cb);   // testbench accesses signals ONLY through cb
endinterface

module driver_tb(sync_if.tb bus);
  initial begin
    @(bus.cb);              // wait for the clocking block's clock event
    bus.cb.data <= 8'hCC;   // drive through clocking block, not the raw signal
  end
endmodule

module dut_side(sync_if bus);
  // DUT-side logic asserts 'valid' directly on the raw signal
  initial begin
    #7 bus.valid = 1;
  end
endmodule

module clocking_block;
  logic clk = 0;
  always #5 clk = ~clk;

  sync_if bus(clk);
  driver_tb d(bus.tb);
  dut_side  dut(bus);

  always @(posedge clk) begin
    if (bus.cb.valid)   // sampled safely through the clocking block
      $display("[%0t] observed via clocking block: data=%0h valid=%0b", $time, bus.data, bus.cb.valid);
  end

  initial begin
    #50 $finish;
  end
endmodule
