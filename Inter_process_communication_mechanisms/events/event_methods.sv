// event_methods_and_persistence
// Demonstrates event built-in methods (triggered()) and the difference
// between a regular event trigger (non-persistent) and ->> (persistent,
// scheduled) trigger.

module event_methods;

  event ev;

  initial begin
    fork
      // waits using triggered() method instead of @(ev) - useful when
      // you need to check status without blocking indefinitely
      begin
        #5;
        if (ev.triggered())
          $display("[%0t] ev already triggered (unexpected here)", $time);
        else
          $display("[%0t] ev not yet triggered, as expected", $time);
      end

      begin
        #10;
        -> ev;   // standard blocking trigger - happens immediately at this line
        $display("[%0t] ev triggered normally", $time);
      end

      begin
        #12;
        if (ev.triggered())
          $display("[%0t] ev.triggered() now returns true after the trigger", $time);
      end
    join

    // ->> is a NON-BLOCKING/persistent trigger - schedules the trigger
    // to happen in the SAME time step but after all blocking assignments,
    // avoiding certain race conditions compared to a plain ->
    ->> ev;
    $display("[%0t] used ->> (scheduled/persistent trigger)", $time);

    #5 $finish;
  end
endmodule
