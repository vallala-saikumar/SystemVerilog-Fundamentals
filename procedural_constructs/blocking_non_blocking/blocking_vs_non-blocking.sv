// =====================================================================
// Description : Shows the difference between blocking (=) and
//               non-blocking (<=) assignments, and why using blocking
//               assignments inside sequential (always_ff) logic causes
//               incorrect shift-register behavior.
// =====================================================================
module blocking_nonblocking_demo (
  input  logic clk,
  input  logic [3:0] d,
  output logic [3:0] q1, q2,       // wrong style using blocking
  output logic [3:0] q1_nb, q2_nb  // correct style using non-blocking
);

  // WRONG for sequential logic - blocking assignment
  always_ff @(posedge clk) begin
    q1 = d;
    q2 = q1;   // gets q1's NEW value in same time step - not a real shift reg
  end

  // CORRECT for sequential logic - non-blocking assignment
  always_ff @(posedge clk) begin
    q1_nb <= d;
    q2_nb <= q1_nb;   // gets q1_nb's OLD value - correct 2-stage shift register
  end

  // RULE OF THUMB:
  // - Combinational (always_comb) -> blocking (=)
  // - Sequential (always_ff)      -> non-blocking (<=)
  // - Never mix assignment types to the same signal
  // - Never mix blocking/non-blocking to different signals in the same block

endmodule

// ---------------------------------------------------------------------
// Testbench
// ---------------------------------------------------------------------
module tb_blocking_nonblocking;
  logic clk = 0;
  logic [3:0] d = 0;
  logic [3:0] q1, q2, q1_nb, q2_nb;

  blocking_nonblocking_demo dut (.*);
  always #5 clk = ~clk;

  initial begin
    for (int i = 1; i <= 4; i++) begin
      @(posedge clk);
      d = i;
      #1 $display("[%0t] d=%0d | blocking: q1=%0d q2=%0d | nonblocking: q1_nb=%0d q2_nb=%0d",
                   $time, d, q1, q2, q1_nb, q2_nb);
    end
    $finish;
  end
endmodule
