// coverage_basics
// Demonstrates two ways covergroups get sampled:
// - implicitly via @(posedge clk) built into the covergroup declaration
// - explicitly via cg.sample() (shown in the other files below)

class coverage_basics_pkt;
  randc bit [3:0] a;
  rand  bit [3:0] b;
 
//covergroup cg;
//	c1: coverpoint a;
//	c2: coverpoint b;
//endgroup
//
//function new();
//cg=new();
//endfunction

endclass

module tb_coverage_basics;
  coverage_basics_pkt fc = new();
  bit clk;
  always #5 clk = ~clk;

  // covergroup declared OUTSIDE the class, referencing fc's members directly.
  // It samples automatically on every posedge clk (implicit/clocked sampling)
  covergroup cg @(posedge clk);
    c1: coverpoint fc.a;
    c2: coverpoint fc.b;
  endgroup

  initial begin
    cg cov = new();//we need to create handle for covergroup to sample
    repeat (100) begin
      fc.randomize();
	  	//fc.cg.sample;
		//cov.sample;//we need sample with method when there is no trigger event used in coverage

      $display("%0t %d %d ", $time, fc.a, fc.b);
      #1;
    end
    #50 $finish;
  end
endmodule
