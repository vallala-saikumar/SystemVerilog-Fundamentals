// event_basics
// Demonstrates basic event usage for synchronizing between processes -
// one process triggers an event, another waits for it.

module event_basics;

  event data_ready;

  task automatic producer();
    #10;
    $display("[%0t] producer preparing data...", $time);
    #5;
    -> data_ready;   // trigger the event
    $display("[%0t] producer triggered data_ready", $time);
  endtask

  task automatic consumer();
    $display("[%0t] consumer waiting for data_ready...", $time);
    @(data_ready);   // blocks until the event is triggered
    $display("[%0t] consumer detected data_ready, proceeding", $time);
  endtask

  initial begin
    fork
      producer();
      consumer();
    join

    $finish;
  end
endmodule
