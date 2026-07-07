// =====================================================================
// Description : Demonstrates the difference between static and
//               automatic tasks. A static task's local variables are
//               shared across all concurrent invocations - if the same
//               task is called from multiple parallel processes
//               (e.g. via fork), their local variables can corrupt each
//               other. An automatic task gets its own copy of locals
//               per invocation, making it safe for concurrent calls.
// =====================================================================
module static_vs_automatic_task;

  // STATIC task - local variable 'val' is SHARED across concurrent calls
  task static static_delay_print(int id, int delay_ns);
    int val;                  // static storage - shared across all calls
    val = id;
    #(delay_ns);
    $display("[%0t] STATIC task: expected id=%0d but printed val=%0d", $time, id, val);
  endtask

  // AUTOMATIC task - local variable 'val' is unique PER call
  task automatic automatic_delay_print(int id, int delay_ns);
    int val;                  // automatic storage - unique per call
    val = id;
    #(delay_ns);
    $display("[%0t] AUTOMATIC task: expected id=%0d and printed val=%0d", $time, id, val);
  endtask

  initial begin
    $display("-- Calling static task concurrently (values may corrupt) --");
    fork
      static_delay_print(1, 10);
      static_delay_print(2, 5);   // finishes first, may overwrite shared 'val'
    join

    #20;

    $display("-- Calling automatic task concurrently (values stay correct) --");
    fork
      automatic_delay_print(1, 10);
      automatic_delay_print(2, 5);
    join

    $finish;
  end

 
endmodule
