// =====================================================================
// Description : Demonstrates all three fork-join variants available in
//               SystemVerilog - join (wait for all), join_any (wait for
//               at least one), and join_none (don't wait at all).
// =====================================================================
module fork_join_demo;

  initial begin
    // ---- join: waits for ALL branches to complete ----
    $display("[%0t] Start fork...join", $time);
    fork
      #10 $display("[%0t] join: Branch 1 done", $time);
      #20 $display("[%0t] join: Branch 2 done", $time);
    join
    $display("[%0t] fork...join finished (after slowest branch)", $time);

    // ---- join_any: waits for AT LEAST ONE branch ----
    $display("[%0t] Start fork...join_any", $time);
    fork
      #10 $display("[%0t] join_any: Branch A done", $time);
      #20 $display("[%0t] join_any: Branch B done", $time);
    join_any
    $display("[%0t] fork...join_any continues after first branch completes", $time);
    #15; // let remaining branch finish before moving on, just for clean display

    // ---- join_none: doesn't wait, spawns and moves on immediately ----
    $display("[%0t] Start fork...join_none", $time);
    fork
      #10 $display("[%0t] join_none: Branch X done", $time);
      #20 $display("[%0t] join_none: Branch Y done", $time);
    join_none
    $display("[%0t] fork...join_none continues immediately, branches run in background", $time);

    #30 $finish;
  end

  // join       -> parent waits for ALL child processes
  // join_any   -> parent waits for AT LEAST ONE child process
  // join_none  -> parent doesn't wait, spawns and moves on

endmodule
