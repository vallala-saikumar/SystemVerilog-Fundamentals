// immediate_assertions
// Immediate assertions check a condition AT THE POINT they execute in
// procedural code (like an if-statement), evaluated using simulation
// time zero-delay semantics - no notion of clock edges or time windows.

module immediate_assertions;
  logic [3:0] a, b;
  logic [3:0] sum;

  initial begin
    a = 4'd5;
    b = 4'd3;
    sum = a + b;

    // basic immediate assertion - checks condition right now, in this
    // procedural block, like a runtime check
    assert (sum == 8)
      $display("PASS: sum is correct (%0d)", sum);
    else
      $error("FAIL: sum mismatch, got %0d expected 8", sum);

    // immediate assertion with only a fail action (no pass message needed)
    a = 4'd10;
    b = 4'd10;
    sum = a + b;   // will overflow 4-bit range on purpose
    assert (sum < 16)
    else
      $warning("sum overflowed 4-bit range: %0d", sum);

    $finish;
  end
endmodule
