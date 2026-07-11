// Disabling randomization using randmode

class randmode_pkt;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  constraint addr_c { addr inside {[0:15]}; }
endclass

module randmode;
  initial begin
    randmode_pkt pkt = new();

    $display("-- both addr and data random by default --");
    repeat (2) begin
      void'(pkt.randomize());
      $display("addr=%0d data=%0d", pkt.addr, pkt.data);
    end

    // rand_mode(0) turns a variable OFF from randomization - it keeps
    // its last/current value and is skipped during randomize()
    pkt.data.rand_mode(0);
    $display("-- data.rand_mode(0): data excluded from randomization --");
    pkt.data = 8'hFF;   // manually set since it won't be randomized anymore
    repeat (2) begin
      void'(pkt.randomize());
      $display("addr=%0d data=%0d (expected data stays 255)", pkt.addr, pkt.data);
    end

    pkt.data.rand_mode(1);  // re-enable randomization for data
    $display("-- data.rand_mode(1): data included again --");
    void'(pkt.randomize());
    $display("addr=%0d data=%0d", pkt.addr, pkt.data);

    $finish;
  end

  // Interview note:
  // - constraint_mode() enables/disables a CONSTRAINT block
  // - rand_mode() enables/disables a VARIABLE from being randomized at all
  // - these are two different controls and are often confused

endmodule
