//this code is implement and check how enum datatype is created and used across logic as named constants
//also the enum builtin methods
module enum_demo;
  typedef enum bit [1:0] {
    IDLE = 2'b00,
    READ = 2'b01,
    WRITE = 2'b10,
    DONE = 2'b11
  } state_t;

  state_t curr_state;

  initial begin
    curr_state = READ;
    $display("State = %s (%0d)", curr_state.name(), curr_state);

    curr_state = curr_state.next();      // built-in method
    $display("Next state = %s", curr_state.name());

    if (curr_state == WRITE)
      $display("Transitioned correctly to WRITE");
  end
endmodule
