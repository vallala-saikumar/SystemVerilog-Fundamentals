// disable_iff_and_directives
// Demonstrates disable iff (to suppress assertion checking during
// reset or another condition), and cover property / expect.

module disable_iff_ex (
  input logic clk,
  input logic rst_n,
  input logic req,
  input logic gnt
);

  // disable iff - the assertion is NOT checked whenever the condition
  // is true (commonly used to ignore checks during reset)
  property req_gnt_with_reset;
    @(posedge clk) disable iff (!rst_n)
      req |-> gnt;
  endproperty

  assert property (req_gnt_with_reset)
  else $error("[%0t] req without gnt (outside reset)", $time);

  // cover property - doesn't check pass/fail, just records how many
  // times this behavior pattern actually occurred, useful for coverage
  // rather than correctness checking
  cover property (@(posedge clk) req ##1 gnt);

endmodule

module tb_disable_iff;
  logic clk = 0, rst_n = 0, req = 0, gnt = 0;
  always #5 clk = ~clk;

  disable_iff_ex dut (.clk(clk), .rst_n(rst_n), .req(req), .gnt(gnt));

  initial begin
    req = 1; gnt = 0;   // would normally fail, but reset is active so it's ignored
    #10 rst_n = 1;      // reset released, assertion now active
    @(posedge clk); req = 1; gnt = 1;
    @(posedge clk); req = 0; gnt = 0;
    #20 $finish;
  end
endmodule
