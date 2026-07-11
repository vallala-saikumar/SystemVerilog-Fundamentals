// randomize_return_check and randomization of variables which are not declared with rand/randc 
//and variables which are not part of class

class check_pkt;
  rand bit [7:0] addr;
endclass

module randomize_return_check;
   check_pkt pkt = new();
  
  int plain_var;

  initial begin
    int status;

    // randomize() returns 1 on success, 0 on failure - always check it
    // in real testbench code instead of silently ignoring with void'()
    status = pkt.randomize();
    if (status)
      $display("randomize succeeded, addr=%0d", pkt.addr);
    else
      $display("randomize FAILED");

    // std::randomize() - global scope randomization function, useful for
    // randomizing plain variables that aren't part of a class
   

    status = std::randomize(plain_var) with { plain_var inside {[1:5]}; };
    if (status)
      $display("std::randomize succeeded, plain_var=%0d", plain_var);
    else
      $display("std::randomize FAILED");

   
  end

endmodule
