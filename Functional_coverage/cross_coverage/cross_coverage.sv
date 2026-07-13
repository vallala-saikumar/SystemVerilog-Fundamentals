// cross_coverage_binsof
// Demonstrates cross coverage combined with binsof() to selectively
// include/exclude specific bin combinations in the cross.

class cross_coverage_pkt;
  rand bit [3:0] a;
  rand bit [3:0] b;

  covergroup cg;
    c1: coverpoint a;
    c2: coverpoint b {
      bins b1 = {1, 2};
      bins b2 = {3, 4};
    }

    // cross of c1 and c2, but restricted using binsof()
    c1xc2: cross c1, c2 {
      bins xy       = binsof(c2.b1);            // only include cross combinations where c2 hit bin b1
      illegal_bins xy1 = binsof(c2.b2);          // flag an error if c2 ever hits bin b2 in this cross
    }
  endgroup

  function new();
    cg = new();
  endfunction
endclass

module top_cross_coverage;
  cross_coverage_pkt crc;

  initial begin
    crc = new();
    repeat (16) begin
      crc.randomize();
      $display("%d %d", crc.a, crc.b);
      crc.cg.sample();
    end
  end
endmodule
