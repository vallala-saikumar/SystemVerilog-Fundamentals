// system_functions
// Demonstrates commonly used sampled-value system functions in
// assertions: $rose, $fell, $stable, $past.

module system_functions (
  input logic clk,
  input logic signal_a
);

  // $rose - true when signal transitions from 0 to 1 on this clock edge
  property rose_check;
    @(posedge clk) $rose(signal_a) |-> ##1 1;   // just demonstrating detection, always true after
  endproperty

  // $fell - true when signal transitions from 1 to 0 on this clock edge
  property fell_check;
    @(posedge clk) $fell(signal_a) |-> ##1 1;
  endproperty

  // $stable - true when signal did NOT change value since the last clock edge
  property stable_check;
    @(posedge clk) $stable(signal_a) |-> ##1 1;
  endproperty

  always @(posedge clk) begin
    if ($rose(signal_a))
      $display("[%0t] $rose detected: signal_a went 0 -> 1", $time);
    if ($fell(signal_a))
      $display("[%0t] $fell detected: signal_a went 1 -> 0", $time);
    if ($stable(signal_a))
      $display("[%0t] $stable detected: signal_a unchanged", $time);
    // $past(signal_a) returns the value of signal_a from the PREVIOUS clock edge
    $display("[%0t] current=%0b previous(via $past)=%0b", $time, signal_a, $past(signal_a));
  end

endmodule

module tb_system_functions;
  logic clk = 0, signal_a = 0;
  always #5 clk = ~clk;

  system_functions dut (.clk(clk), .signal_a(signal_a));

  initial begin
    @(posedge clk); signal_a = 1;   // triggers $rose
    @(posedge clk);                 // stable
    @(posedge clk); signal_a = 0;   // triggers $fell
    @(posedge clk);                 // stable
    #20 $finish;
  end
endmodule
