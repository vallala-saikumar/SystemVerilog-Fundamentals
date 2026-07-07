// =====================================================================
// Description : Demonstrates the three modern always variants -
//               always_comb (combinational), always_ff (sequential),
//               and always_latch (intentional latch). These replace
//               the generic legacy "always" block and let simulators/
//               linters catch unintended latch inference or misuse.
// =====================================================================
module always_demo (
  input  logic clk, rst_n, en,
  input  logic [3:0] a, b,
  output logic [3:0] sum_comb,
  output logic [3:0] sum_ff,
  output logic [3:0] latch_out
);

  // always_comb: auto-sensitivity list, flags missing inputs / unintended latches
  always_comb begin
    sum_comb = a + b;
  end

  // always_ff: sequential only, tool flags combinational-style misuse
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      sum_ff <= 4'b0;
    else
      sum_ff <= a + b;
  end

  // always_latch: intentional latch - rare, usually a bug if unintended
  always_latch begin
    if (en)
      latch_out = a;
  end

endmodule

// ---------------------------------------------------------------------
// Simple testbench to exercise the module and terminate cleanly
// ---------------------------------------------------------------------
module tb_always_demo;
  logic clk = 0, rst_n = 0, en = 0;
  logic [3:0] a = 4'd3, b = 4'd5;
  logic [3:0] sum_comb, sum_ff, latch_out;

  always_demo dut (.*);

  always #5 clk = ~clk;

  initial begin
    rst_n = 0;
    #10 rst_n = 1;
    en = 1;
    #10 a = 4'd7;
    #20 $display("sum_comb=%0d sum_ff=%0d latch_out=%0d", sum_comb, sum_ff, latch_out);
    #10 $finish;   // always terminate the simulation explicitly
  end
endmodule
