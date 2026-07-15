// mailbox_basics
// Demonstrates a bounded mailbox used for inter-process communication -
// commonly used to pass transactions between a generator/sequencer and
// a driver in a testbench.

module mailbox_basics;

  mailbox #(int) mbx = new(3);   // bounded mailbox, max capacity 3 items

  // producer process - puts items into the mailbox
  task automatic producer();
    for (int i = 1; i <= 5; i++) begin
      mbx.put(i);   // blocks if mailbox is full (bounded to 3 here)
      $display("[%0t] producer put %0d (mailbox size now %0d)", $time, i, mbx.num());
      #5;
    end
  endtask

  // consumer process - takes items out of the mailbox
  task automatic consumer();
    int val;
    forever begin
      mbx.get(val);   // blocks if mailbox is empty
      $display("[%0t] consumer got %0d", $time, val);
      #8;   // consumer slower than producer, will cause backpressure
    end
  endtask

  initial begin
    fork
      producer();
      consumer();
    join_any

    #50 $finish;
  end
endmodule
