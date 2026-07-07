// =====================================================================
// Description : Demonstrates jump/control-transfer statements -
//               break, continue, return, disable <label>, and
//               disable fork. break/continue behave like C/Java.
//               disable and disable fork are SystemVerilog-specific
//               and are commonly used to implement timeouts and clean
//               up concurrent processes.
// =====================================================================
module jump_statements;

  function automatic bit check_even(int val);
    if (val % 2 == 0) return 1;   // return exits function immediately
    return 0;
  endfunction

  // module-level signal instead of a ref argument
  bit ack_signal = 0;

  task automatic wait_for_ack();
    fork
      begin : ack_wait_block
        @(posedge ack_signal);
        $display("[%0t] ACK received", $time);
      end
      begin
        #100;
        disable ack_wait_block;   // terminate the waiting process on timeout
        $display("[%0t] Timeout - ACK not received, block disabled", $time);
      end
    join_any
    disable fork;   // cleans up any remaining background process from fork
  endtask

  initial begin
    // break: exits the loop entirely
    $display("-- break demo --");
    for (int i = 0; i < 5; i++) begin
      if (i == 3) break;
      $display("break: i=%0d", i);
    end

    // continue: skips rest of current iteration
    $display("-- continue demo --");
    for (int i = 0; i < 5; i++) begin
      if (i == 2) continue;
      $display("continue: i=%0d", i);
    end

    // return: demonstrated via check_even()
    $display("-- return demo --");
    $display("check_even(4) = %0b", check_even(4));
    $display("check_even(5) = %0b", check_even(5));

    // disable / disable fork: demonstrated via wait_for_ack timeout
    $display("-- disable / disable fork demo --");
    wait_for_ack();   

    $finish;
  end

endmodule


