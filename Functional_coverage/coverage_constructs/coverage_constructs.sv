// coverage_constructs
// Demonstrates binsof().intersect{} to further restrict which values
// of a cross combination are actually counted.

class coverage_constructs_pkt;
  rand bit [6:0] a;
  rand bit [6:0] b;

  covergroup cg;
    c1: coverpoint a;
    c2: coverpoint b {
      bins b1 = {[0:75]};
      bins b2 = {[76:127]};
    }

    c1xc2: cross c1, c2 {
      // only count cross combinations where c2's value also falls in [0:50],
      // regardless of which bin (b1/b2) it belongs to
      bins xy = binsof(c2) intersect {[0:50]};
      illegal_bins xy1 = binsof(c2.b2);   // error if c2 ever hits bin b2
    }
  endgroup

  function new();
    cg = new();
  endfunction
endclass

module top_coverage_constructs;
  coverage_constructs_pkt crc;

  initial begin
    crc = new();
    repeat (100) begin
      crc.randomize();
      $display("%d %d", crc.a, crc.b);
      crc.cg.sample();
    end
  end
endmodule
