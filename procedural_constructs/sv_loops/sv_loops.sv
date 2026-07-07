// =====================================================================
// Description : Demonstrates all six SystemVerilog loop constructs -
//               for, while, do-while, foreach, repeat, and forever -
//               plus a generate block for structural hardware
//               replication at elaboration time. Loops in an initial
//               block are testbench control flow; generate is used
//               for replicating RTL structures.
// =====================================================================
module sv_loops;

  int arr[4] = '{10, 20, 30, 40};

  initial begin
    //  for loop
    $display("-- for loop --");
    for (int i = 0; i < 4; i++)
      $display("for: i=%0d", i);

    //  while loop
    $display("-- while loop --");
    begin
      int j = 0;
      while (j < 3) begin
        $display("while: j=%0d", j);
        j++;
      end
    end

    //  do-while loop
    $display("-- do-while loop --");
    begin
      int k = 0;
      do begin
        $display("do-while: k=%0d", k);
        k++;
      end while (k < 2);
    end

    //  foreach loop - no manual bounds needed, works on arrays/queues
    $display("-- foreach loop --");
    foreach (arr[idx])
      $display("foreach: arr[%0d]=%0d", idx, arr[idx]);

    //  repeat loop - executes a fixed number of times, no index variable
    $display("-- repeat loop --");
    begin
      int count = 0;
      repeat (3) begin
        $display("repeat: iteration=%0d", count);
        count++;
      end
    end

    //  forever loop - runs indefinitely, must be broken out of manually
    $display("-- forever loop --");
    begin
      int m = 0;
      forever begin
        $display("forever: m=%0d", m);
        m++;
        if (m == 3) break;   // without break/disable this would run forever
      end
    end

    $finish;
  end

  // Structural generate block - NOT a testbench loop, used for replicating
  // hardware structures at compile/elaboration time
  genvar g;
  logic [3:0] gen_out [4];
  generate
    for (g = 0; g < 4; g++) begin : gen_block  //synthesizable loop
      assign gen_out[g] = g * 2;
    end
  endgenerate

endmodule
