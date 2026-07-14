// concurrent_assertions_basics
// Concurrent assertions check conditions ACROSS TIME, sampled on clock
// edges - unlike immediate assertions, they can span multiple cycles
// and keep checking continuously throughout simulation, not just once
// at a specific line of procedural code.

module concurrent_assertions (
  input logic clk,
  input logic req,
  input logic ack
);

  // basic concurrent assertion - checks that whenever req is high,
  // ack must be high on the SAME clock edge
  property req_ack_same_cycle;
    @(posedge clk) req |-> ack;
  endproperty

  assert property (req_ack_same_cycle)
  else
    $error("[%0t] req asserted without matching ack", $time);

endmodule

module tb_concurrent_assertions;
  logic clk = 0, req = 0, ack = 0;
  always #5 clk = ~clk;

  concurrent_assertions dut (.clk(clk), .req(req), .ack(ack));

  initial begin
    @(posedge clk); req = 1; ack = 1;   // correct case
    @(posedge clk); req = 0; ack = 0;
    @(posedge clk); req = 1; ack = 0;   // this should trigger the assertion failure
    @(posedge clk); req = 0;
    #20 $finish;
  end
endmodule
