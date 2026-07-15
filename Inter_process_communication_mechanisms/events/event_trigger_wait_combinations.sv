// event_trigger_wait_combinations
// Demonstrates all 4 combinations of waiting for an event (@ vs wait)
// combined with triggering an event (-> vs ->>):
//   1) @(event)      with ->   (blocking wait, blocking/immediate trigger)
//   2) @(event)      with ->>  (blocking wait, scheduled/persistent trigger)
//   3) wait(ev.triggered()) with ->   (polling wait, immediate trigger)
//   4) wait(ev.triggered()) with ->>  (polling wait, scheduled trigger)

module event_trigger_wait_combinations;

  event ev1, ev2, ev3, ev4;

  // ------------------------------------------------------------------
  // 1) @(event) + -> (standard combination)
  //    @(ev1) blocks until ev1 is triggered. -> triggers it immediately,
  //    in THIS procedural statement, before moving to the next line.
  // ------------------------------------------------------------------
  task automatic combo1();
    fork
      begin
        $display("[%0t] combo1: waiter using @(ev1) is now waiting...", $time);
        @(ev1);
        $display("[%0t] combo1: waiter detected ev1 via @(ev1)", $time);
      end
      begin
        #10;
        -> ev1;   // immediate trigger - takes effect right here
        $display("[%0t] combo1: triggered ev1 using ->", $time);
      end
    join
  endtask

  // ------------------------------------------------------------------
  // 2) @(event) + ->> (scheduled/persistent trigger)
  //    @(ev2) still blocks until triggered. ->> schedules the trigger
  //    to occur in the SAME time step but AFTER all blocking
  //    assignments/statements in the current time step have executed -
  //    useful to avoid races where the waiter might miss a plain ->
  //    if ordering between processes isn't guaranteed.
  // ------------------------------------------------------------------
  task automatic combo2();
    fork
      begin
        $display("[%0t] combo2: waiter using @(ev2) is now waiting...", $time);
        @(ev2);
        $display("[%0t] combo2: waiter detected ev2 via @(ev2) (after ->> scheduled trigger)", $time);
      end
      begin
        #10;
        ->> ev2;   // scheduled trigger - happens later in the same time step
        $display("[%0t] combo2: issued ->> ev2 (scheduled, not necessarily seen instantly)", $time);
      end
    join
  endtask

  // ------------------------------------------------------------------
  // 3) wait(ev.triggered()) + -> (polling instead of blocking @)
  //    wait() continuously polls the triggered() status instead of
  //    directly blocking on the event - functionally similar result
  //    but a different waiting mechanism, useful when combined with
  //    other conditions in the same wait() expression.
  // ------------------------------------------------------------------
  task automatic combo3();
    fork
      begin
        $display("[%0t] combo3: waiter using wait(ev3.triggered()) is now waiting...", $time);
        wait (ev3.triggered());
        $display("[%0t] combo3: waiter detected ev3 via wait(triggered())", $time);
      end
      begin
        #10;
        -> ev3;
        $display("[%0t] combo3: triggered ev3 using ->", $time);
      end
    join
  endtask

  // ------------------------------------------------------------------
  // 4) wait(ev.triggered()) + ->> (polling wait, scheduled trigger)
  //    Combines polling-based waiting with a scheduled trigger -
  //    triggered() only reflects true once the ->> trigger actually
  //    takes effect later in the same time step.
  // ------------------------------------------------------------------
  task automatic combo4();
    fork
      begin
        $display("[%0t] combo4: waiter using wait(ev4.triggered()) is now waiting...", $time);
        wait (ev4.triggered());
        $display("[%0t] combo4: waiter detected ev4 via wait(triggered()) (after ->> scheduled trigger)", $time);
      end
      begin
        #10;
        ->> ev4;
        $display("[%0t] combo4: issued ->> ev4 (scheduled)", $time);
      end
    join
  endtask

  initial begin
    $display("===== combo1: @(event) + -> =====");
    combo1();
    #5;

    $display("===== combo2: @(event) + ->> =====");
    combo2();
    #5;

    $display("===== combo3: wait(triggered()) + -> =====");
    combo3();
    #5;

    $display("===== combo4: wait(triggered()) + ->> =====");
    combo4();
    #5;

    $finish;
  end

endmodule
