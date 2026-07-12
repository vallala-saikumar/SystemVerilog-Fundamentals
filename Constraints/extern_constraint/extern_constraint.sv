// extern_constraint

// EXTERN CONSTRAINT - constraint is only DECLARED inside the class
// (using 'extern'), and its actual body is DEFINED outside, using
// ClassName::constraint_name syntax. Useful for keeping large class
// declarations clean/readable, similar to extern methods.

class extern_constraint_pkt;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  extern constraint addr_range_c;   // declaration only, no body here
endclass

constraint extern_constraint_pkt::addr_range_c {
  addr inside {[8'h00:8'h3F]};      // actual body defined outside the class
}

module extern_constraint;
  initial begin
    extern_constraint_pkt pkt = new();

    $display("-- extern constraint demo --");
    repeat (3) begin
      void'(pkt.randomize());
      $display("addr=%0d (expected 0-63, defined outside class)", pkt.addr);
    end

    $finish;
  end

 
endmodule
