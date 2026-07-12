// foreach_solve_unique_constraints
class array_pkt;
  rand bit [3:0] mode;
  rand bit [7:0] addr;
  rand bit [3:0] arr[4];

  constraint foreach_c {
    foreach (arr[i])
      arr[i] inside {[0:9]};
  }

  constraint unique_c {
    unique {arr};
  }

  constraint solve_order_c {
    solve mode before addr;
    mode inside {0, 1};
    if (mode == 0)
      addr inside {[0:15]};
    else
      addr inside {[16:31]};
  }
endclass

module foreach_solve_unique;
  initial begin
    array_pkt pkt = new();

    $display("-- foreach + unique constraint on array --");
    void'(pkt.randomize());
    $display("arr = %p (all elements expected 0-9 and unique)", pkt.arr);

    $display("-- solve...before ordering (mode solved first) --");
    repeat (4) begin
      void'(pkt.randomize());
      $display("mode=%0d addr=%0d", pkt.mode, pkt.addr);
    end

    $finish;
  end
endmodule
