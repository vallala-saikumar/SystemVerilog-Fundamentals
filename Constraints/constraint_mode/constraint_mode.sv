// inline_and_constraint_mode

class mode_pkt;
  rand bit [7:0] addr;

  constraint addr_c { addr inside {[0:15]}; }
endclass

module constraint_control;
    mode_pkt pkt = new();
  initial begin

    $display("-- constraint ON (default) --");
    repeat (3) begin
      void'(pkt.randomize());
      $display("addr=%0d (expected 0-15)", pkt.addr);
    end

    pkt.addr_c.constraint_mode(0);
    $display("-- constraint OFF via constraint_mode(0) --");
    repeat (3) begin
      void'(pkt.randomize());
      $display("addr=%0d (full 0-255 range now)", pkt.addr);
    end

    pkt.addr_c.constraint_mode(1);
    $display("-- constraint back ON --");
    void'(pkt.randomize());
    $display("addr=%0d (expected 0-15 again)", pkt.addr);

    $display("-- inline constraint via randomize() with {} --");
    void'(pkt.randomize() with { addr == 8'd5; });
    $display("addr=%0d (forced to exactly 5 for this call only)", pkt.addr);

    $finish;
  end
endmodule
