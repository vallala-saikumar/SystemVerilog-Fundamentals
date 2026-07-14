// property_operators
// Demonstrates property-level operators: not, and, or, if-else, until,
// eventually, s_always.

module property_operators (
  input logic clk,
  input logic req,
  input logic gnt,
  input logic err
);

  // not - property should NEVER be true (asserts absence of a condition)
  property no_error_ever;
    @(posedge clk) not (err);
  endproperty

  // and (property-level) - both properties must hold
  property req_and_no_err;
    @(posedge clk) (req |-> gnt) and (not err);
  endproperty

  // if-else at property level - different checks based on a condition
  property conditional_check;
    @(posedge clk) if (req) gnt else !gnt;
  endproperty

  // until - left property must hold UNTIL the right one becomes true
  property req_until_gnt;
    @(posedge clk) req until gnt;
  endproperty

  // s_eventually - condition must become true at SOME point in the future (strong)
  property eventually_granted;
    @(posedge clk) req |-> s_eventually gnt;
  endproperty

  // s_always - condition must hold true on every cycle, strongly (bounded)
  property always_no_err;
    @(posedge clk) s_always [1:10] !err;
  endproperty

  assert property (no_error_ever)
  else $error("[%0t] err signal asserted, should never happen", $time);

  assert property (eventually_granted)
  else $error("[%0t] req was never eventually followed by gnt", $time);

endmodule
