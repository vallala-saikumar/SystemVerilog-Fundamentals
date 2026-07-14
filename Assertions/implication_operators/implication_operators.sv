// implication_operators
// Demonstrates the two implication operators used in properties:
// |-> (overlapped) and |=> (non-overlapped).

module implication_operators (
  input logic clk,
  input logic req,
  input logic gnt
);

  // OVERLAPPED implication (|->): if antecedent (req) is true, the
  // consequent (gnt) must be true on the SAME clock cycle
  property overlapped_impl;
    @(posedge clk) req |-> gnt;
  endproperty

  // NON-OVERLAPPED implication (|=>): if antecedent (req) is true, the
  // consequent (gnt) must be true on the NEXT clock cycle (1 cycle later)
  property non_overlapped_impl;
    @(posedge clk) req |=> gnt;
  endproperty

  assert property (overlapped_impl)
  else $error("[%0t] overlapped: req without gnt in same cycle", $time);

  assert property (non_overlapped_impl)
  else $error("[%0t] non_overlapped: req without gnt in next cycle", $time);

endmodule

module tb_implication_operators;
  logic clk = 0, req = 0, gnt = 0;
  always #5 clk = ~clk;

  implication_operators dut (.clk(clk), .req(req), .gnt(gnt));

  initial begin
    @(posedge clk); req = 1; gnt = 1;   // satisfies overlapped
    @(posedge clk); req = 0; gnt = 0;
    @(posedge clk); req = 1; gnt = 0;   // will need gnt=1 NEXT cycle for non_overlapped
    @(posedge clk); gnt = 1; req = 0;
    #20 $finish;
  end
endmodule
