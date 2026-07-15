// mailbox_try_methods
// Demonstrates non-blocking mailbox methods: try_put, try_get, try_peek.
// These return immediately with a status instead of blocking.

module mailbox_try_methods;

  mailbox #(int) mbx = new(2);   // bounded mailbox, capacity 2

  initial begin
    int status;
    int val;

    // try_put - returns 1 on success, 0 if mailbox is full (non-blocking)
    status = mbx.try_put(10);
    $display("try_put(10) status=%0d (expected 1, success)", status);

    status = mbx.try_put(20);
    $display("try_put(20) status=%0d (expected 1, success, mailbox now full)", status);

    status = mbx.try_put(30);
    $display("try_put(30) status=%0d (expected 0, mailbox full)", status);

    // try_peek - looks at the next item WITHOUT removing it
    status = mbx.try_peek(val);
    $display("try_peek() status=%0d val=%0d (expected 1 and 10, item still in mailbox)", status, val);

    // try_get - removes and returns the next item, non-blocking
    status = mbx.try_get(val);
    $display("try_get() status=%0d val=%0d (expected 1 and 10)", status, val);

    status = mbx.try_get(val);
    $display("try_get() status=%0d val=%0d (expected 1 and 20)", status, val);

    status = mbx.try_get(val);
    $display("try_get() status=%0d (expected 0, mailbox now empty)", status);

    $finish;
  end
endmodule
