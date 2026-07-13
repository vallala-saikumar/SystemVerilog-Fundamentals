// illegal_ignore_bins
// Demonstrates illegal_bins (errors if hit) and ignore_bins (excluded
// from coverage silently) using array-of-bins syntax.

class illegal_ignore_bins_pkt;
  randc bit [3:0] a;

  covergroup cg;
    c1: coverpoint a {
      illegal_bins b[]  = {1, 2, 3};   // simulation errors out if 'a' ever equals 1, 2, or 3
      ignore_bins  b1[] = {4, 5, 6};   // these values are excluded from coverage, no error raised
    }
  endgroup

  function new();
    cg = new();
  endfunction
endclass

module top_illegal_ignore_bins;
  illegal_ignore_bins_pkt cb;

  initial begin
    cb = new();
    repeat (16) begin
      cb.randomize();
      $display("%d", cb.a);
      cb.cg.sample();
    end
  end
endmodule
