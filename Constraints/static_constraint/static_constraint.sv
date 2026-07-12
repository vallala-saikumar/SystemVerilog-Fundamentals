// static_constraint

// STATIC CONSTRAINT - a constraint block declared 'static' is SHARED
// across all instances of the class, similar to a static class member.
// If one object's constraint mode is changed, it affects ALL instances,
// not just that one object.

class static_constraint_pkt;
  rand bit [7:0] addr;

  static constraint addr_static_c { addr inside {[0:31]}; }
endclass

module static_constraint;
  initial begin
    static_constraint_pkt obj1 = new();
    static_constraint_pkt obj2 = new();

    $display("-- static constraint demo (shared across ALL instances) --");
    void'(obj1.randomize());
    void'(obj2.randomize());
    $display("obj1.addr=%0d obj2.addr=%0d (both follow same static constraint, expected 0-31)",
               obj1.addr, obj2.addr);

    // disabling the static constraint via ONE instance affects EVERY
    // instance, since the constraint itself is shared, not per-object
    obj1.addr_static_c.constraint_mode(0);
    $display("-- disabling static constraint via obj1 affects obj2 too --");
    repeat (2) begin
      void'(obj1.randomize());
      void'(obj2.randomize());
      $display("obj1.addr=%0d obj2.addr=%0d (both now unconstrained, full 0-255 range)",
                 obj1.addr, obj2.addr);
    end
    obj1.addr_static_c.constraint_mode(1);   // re-enable for both

    $finish;
  end

 
endmodule
