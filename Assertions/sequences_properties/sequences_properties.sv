// sequences_properties
// Sequences describe a pattern of signal behavior over time.
// Properties wrap sequences with implication/behavioral intent, and
// are what actually gets checked by an assert/cover statement.

module sequences_properties (
  input logic clk,
  input logic start,
  input logic busy,
  input logic done
);

  // sequence - just describes a temporal pattern, doesn't check anything by itself
  sequence start_to_busy_seq;
    start ##1 busy;   // 'start' followed by 'busy' exactly 1 clock later
  endsequence

  sequence busy_to_done_seq;
    busy ##[1:5] done;   // 'busy' followed by 'done' anywhere within 1 to 5 cycles
  endsequence

  // property - uses the sequence with an implication to define pass/fail intent
  property start_implies_busy_next;
    @(posedge clk) start_to_busy_seq;
  endproperty

  property busy_implies_done_within_5;
    @(posedge clk) busy |-> busy_to_done_seq;
  endproperty

  assert property (start_implies_busy_next)
  else $error("[%0t] start was not followed by busy on the next cycle", $time);

  assert property (busy_implies_done_within_5)
  else $error("[%0t] busy did not lead to done within 5 cycles", $time);

endmodule

module tb_sequences_properties;
  logic clk = 0, start = 0, busy = 0, done = 0;
  always #5 clk = ~clk;

  sequences_properties dut (.clk(clk), .start(start), .busy(busy), .done(done));

  initial begin
    @(posedge clk); start = 1;
    @(posedge clk); start = 0; busy = 1;
    @(posedge clk); busy = 0;
    @(posedge clk); done = 1;
    @(posedge clk); done = 0;
    #30 $finish;
  end
endmodule
