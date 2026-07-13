// coverage_options
// Demonstrates covergroup-level and coverpoint-level coverage options:
// option.name, option.comment, option.per_instance, option.auto_bin_max,
// option.at_least, option.goal.

class coverage_options_pkt;
  rand bit [7:0] a;
  rand bit [3:0] b;

  covergroup cg;
    option.name        = "option code";        // custom name shown in coverage reports
    option.comment      = "this is for fun";     // descriptive text, report-only, no functional effect
    option.per_instance = 2;                     // when nonzero, coverage is tracked separately per instance rather than merged

    c1: coverpoint a {
      option.auto_bin_max = 120;   // caps how many auto-generated implicit bins are created for this coverpoint
      option.at_least     = 3;      // a bin only counts as covered once hit at least 3 times
    }

    c2: coverpoint b {
      option.goal = 75;   // custom target percentage considered "complete" for this coverpoint
    }
  endgroup

  function new();
    cg = new();
  endfunction
endclass

module top_coverage_options;
  coverage_options_pkt op;

  initial begin
    op = new();
    repeat (50) begin
      op.randomize();
      $display("%d %d", op.a, op.b);
      op.cg.sample();
    end
  end
endmodule
