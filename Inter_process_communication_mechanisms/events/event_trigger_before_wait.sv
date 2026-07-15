// trigger_before_wait
// Demonstrates what happens when the trigger executes BEFORE the wait
// statement runs, for all 4 combinations - showing which combos
// deadlock and which recover.

module trigger_before_wait;

  event ev1, ev2, ev3, ev4;

  // ------------------------------------------------------------------
  // 1) -> triggered FIRST, @(event) waits AFTER - DEADLOCKS
  //    The trigger already happened and is gone; @ has nothing to catch.
  // ------------------------------------------------------------------
  task automatic combo1_trigger_first();
    -> ev1;   // trigger happens immediately, right now
    $display("[%0t] combo1: triggered ev1 BEFORE anyone waits", $time);

    fork
      begin
        $display("[%0t] combo1: now waiting on @(ev1) - this will HANG forever", $time);
        @(ev1);   // too late - this event already fired and is gone
        $display("[%0t] combo1: this line will NEVER print", $time);
      end
    join_none   // join_none so this demo doesn't hang the whole simulation
  endtask

  // ------------------------------------------------------------------
  // 2) ->> triggered FIRST (still resolves within same/this time step),
  //    @(event) waits AFTER that time step has passed - DEADLOCKS too
  // ------------------------------------------------------------------
  task automatic combo2_trigger_first();
    ->> ev2;
    $display("[%0t] combo2: issued ->> ev2 BEFORE anyone waits", $time);
    #1;   // let time advance past the time step where ->> resolved

    fork
      begin
        $display("[%0t] combo2: now waiting on @(ev2) - this will HANG forever too", $time);
        @(ev2);
        $display("[%0t] combo2: this line will NEVER print", $time);
      end
    join_none
  endtask

  // ------------------------------------------------------------------
  // 3) -> triggered FIRST, wait(triggered()) checked in the SAME time
  //    step - WORKS, because triggered() stays true for that time step
  // ------------------------------------------------------------------
  task automatic combo3_trigger_first();
    -> ev3;
    $display("[%0t] combo3: triggered ev3 BEFORE checking wait()", $time);

    // checked in the SAME time step (no # delay in between)
    wait (ev3.triggered());
    $display("[%0t] combo3: wait(ev3.triggered()) still caught it - SAME time step", $time);
  endtask

  // ------------------------------------------------------------------
  // 4) ->> triggered FIRST, wait(triggered()) checked in the SAME time
  //    step - WORKS for the same reason as combo3
  // ------------------------------------------------------------------
  task automatic combo4_trigger_first();
    ->> ev4;
    $display("[%0t] combo4: issued ->> ev4 BEFORE checking wait()", $time);

    wait (ev4.triggered());   // still same time step - ->> resolves before this check completes
    $display("[%0t] combo4: wait(ev4.triggered()) still caught it - SAME time step", $time);
  endtask

  initial begin
    $display("===== combo1: -> then @(event) - EXPECT DEADLOCK (won't print done) =====");
    combo1_trigger_first();
    #2;

    $display("===== combo2: ->> then @(event) after time passes - EXPECT DEADLOCK =====");
    combo2_trigger_first();
    #2;

    $display("===== combo3: -> then wait(triggered()) same time step - EXPECT SUCCESS =====");
    combo3_trigger_first();

    $display("===== combo4: ->> then wait(triggered()) same time step - EXPECT SUCCESS =====");
    combo4_trigger_first();

    #10 $display("[%0t] Reached end - combo1/combo2 waiters are permanently stuck (harmless here since join_none)", $time);
    $finish;
  end



endmodule
