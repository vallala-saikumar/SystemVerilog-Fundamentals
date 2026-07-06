//this code is implemented to know the difference between 2-state and 4-state datatypes 

module data_types_demo;
  // 4-state: can hold X (unknown) and Z (high-impedance)
  logic [7:0] four_state_var;
  // 2-state: only 0/1, more memory-efficient, used heavily in TB/randomization
  bit   [7:0] two_state_var;

  initial begin
    // Uninitialized logic defaults to X, bit defaults to 0
    $display("logic default = %b", four_state_var);
    $display("bit   default = %b", two_state_var);

    four_state_var = 8'bx;
    $display("logic holding X = %b", four_state_var);

    // two_state_var can never show X - assigning x truncates to 0
    two_state_var = 8'bx;
    $display("bit truncates X to = %b", two_state_var);
  end
endmodule
