// assertion_builtin_methods
// Demonstrates built-in methods used for assertion control and
// checking: $assertoff, $asserton, $assertkill, and action blocks
// with pass/fail counters.

module assertion_builtin_methods (
  input logic clk,
  input logic req,
  input logic gnt
);

  int pass_count = 0;
  int fail_count = 0;

  property req_gnt_check;
    @(posedge clk) req |-> gnt;
  endproperty

  // action blocks - separate pass and fail handling, useful for
  // tracking statistics rather than just printing an error
  assert property (req_gnt_check)
    pass_count++;
  else
    fail_count++;

  // $assertoff / $asserton / $assertkill are system tasks that control
  // assertion checking globally or on a specific instance at runtime -
  // useful for disabling checks during known invalid periods (e.g. reset)
  initial begin
    #12 $assertoff;         // temporarily disable all assertions
    #10 $asserton;          // re-enable them
    // $assertkill;         // would permanently kill in-progress assertion attempts
  end

  final begin
    $display("Total: pass_count=%0d fail_count=%0d", pass_count, fail_count);
  end

endmodule
