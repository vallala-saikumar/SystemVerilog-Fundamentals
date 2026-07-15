// mailbox_put_get_demo.sv
// Basic mailbox put()/get() - FIFO order, producer then consumer

module mail;
  int x, a = 5;
  int y, b = 6;
  int z, c = 7;

  mailbox mbx = new();   // unbounded mailbox

  task drive();
    mbx.put(a);
    mbx.put(b);
    mbx.put(c);
  endtask

  task retrive();
    mbx.get(x);
    mbx.get(y);
    mbx.get(z);
    $display("x=%0d y=%0d z=%0d", x, y, z);
  endtask

  initial begin
    drive();
    retrive();   // runs after drive() fully completes - no blocking exercised
  end

  // Note: mailbox is FIFO - items come out in the same order put in.
  // Since drive/retrive run sequentially (not fork-join), get() never
  // actually blocks here.

endmodule
