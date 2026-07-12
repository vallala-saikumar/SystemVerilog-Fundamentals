// implication_if_else_constraints

class cond_pkt;
  rand bit       is_write;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  constraint implication_c {
    is_write -> data inside {[8'h10:8'hFF]};
  }

  constraint if_else_c {
    if (is_write)
      addr inside {[8'h00:8'h7F]};
    else
      addr inside {[8'h80:8'hFF]};
  }
endclass

module implication_if_else_cnstnt;
  initial begin
    cond_pkt pkt = new();

    $display("-- implication constraint (is_write -> data range) --");
    repeat (4) begin
      void'(pkt.randomize());
      $display("is_write=%0b data=%0d", pkt.is_write, pkt.data);
    end

    $display("-- if-else constraint (addr range depends on is_write) --");
    repeat (4) begin
      void'(pkt.randomize());
      $display("is_write=%0b addr=%0d", pkt.is_write, pkt.addr);
    end

    $finish;
  end
endmodule
