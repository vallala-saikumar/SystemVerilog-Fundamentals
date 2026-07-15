// semaphore_get_put_demo.sv
// Semaphore with 3 keys - shows get(n)/put(n) with multiple keys and blocking

module sem;
  semaphore s = new(3);   // pool starts with 3 keys

  task p1();
    s.get(2);              // takes 2 keys, 1 left in pool
    #5;
    $display("%0t first", $time);
    s.put(3);              // returns 3 keys (more than it took)
  endtask

  task p2();
    s.get(4);              // blocks - pool max is 3, can't get 4
    #3;
    $display("%0t second", $time);
    s.put(3);
  endtask

  task p3();
    s.try_get(4);          // non-blocking, likely fails silently
    #9;
    $display("%0t third", $time);
    s.get(4);              // blocks, same reason as p2
    $display("%0t fourth", $time);
    s.put(2);
  endtask

  initial begin
    fork
      p1();
      p2();
      p3();
    join
  end

  // Note: get(n) blocks until n keys are available at once.
  // try_get(n) is the non-blocking version, returns 0 if unavailable.
  // put(n) doesn't have to match the n originally taken.

endmodule
