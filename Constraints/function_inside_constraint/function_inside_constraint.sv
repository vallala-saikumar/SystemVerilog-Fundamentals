// function_inside_constraint

// FUNCTION CALLED INSIDE A CONSTRAINT - a constraint can call a
// function to compute a bound or check a condition dynamically.
// The function must not itself call randomize() - it should be a
// simple, side-effect-free helper used purely to shape the random space.

class func_in_constraint_pkt;
  rand bit [7:0] addr;

  function bit [7:0] get_max_allowed();
    return 8'd50;   // could be based on other state/config in a real class
  endfunction

  constraint addr_limit_c {
    addr < get_max_allowed();   // function call used directly in constraint
  }
endclass

module function_inside_constraint;
  initial begin
    func_in_constraint_pkt pkt = new();

    $display("-- function-in-constraint demo --");
    repeat (3) begin
      void'(pkt.randomize());
      $display("addr=%0d (expected < 50, bound computed via function call)", pkt.addr);
    end

    $finish;
  end


endmodule
