// randomization_basics

class basic_rand;
  rand bit [3:0] rand_val;    // standard random - can repeat any value
  randc bit [3:0] randc_val;  // cyclic random - cycles through all values before repeating
endclass

module randomization_basics;
  initial begin
    basic_rand obj = new();

    $display("-- rand (can repeat) --");
    repeat (5) begin
      void'(obj.randomize());   // check return value in real code, void' here for brevity
      $display("rand_val = %0d", obj.rand_val);
    end

    $display("-- randc (cycles through all 16 values before repeating) --");
    repeat (5) begin
      void'(obj.randomize());
      $display("randc_val = %0d", obj.randc_val);
    end

    $finish;
  end
endmodule
