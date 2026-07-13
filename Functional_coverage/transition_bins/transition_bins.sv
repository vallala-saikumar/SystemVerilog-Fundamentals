// transition_bins
// Demonstrates all transition bin variations - single transition,
// sequence transition, set transition, consecutive repeat, range
// repeat, goto repeat, non-consecutive repeat, and a combined example.

class transition_bins_pkt;
  rand bit [3:0] a;
  constraint c1 { a inside {[1:10]}; }

  covergroup cg;
    cp1: coverpoint a {
      bins single_val_trans      = (8=>9);              // single bin for one sequence
      bins single_val_trans_dyn[] = (8=>9);              // same sequence, but as an indexed/dynamic bin
      bins sequence_trans        = (8=>9=>6);            // single bin, multi-step sequence
      bins sequence_trans_dyn[]  = (8=>9=>6);             // multi-step sequence as indexed bin
      bins set_trans             = (6,8=>7,9);            // single bin covering all combinations of the set transition
      bins set_trans_dyn[]       = (6,8=>7,9);             // separate bin per combination (4 bins for 4 combinations)
      bins consec_rept           = (3[*3]);                // single bin: exactly 3 consecutive repeats of value 3
      bins consec_rept_dyn[]     = (3[*3]);                 // same, but as an indexed/dynamic bin
      bins rnge_rept             = (3[*1:3]);               // single bin covering repeat counts 1 to 3
      bins rnge_rept_dyn[]       = (3[*1:3]);                // separate bin per repeat count (e.g. 3, 33, 333)
      bins goto_rept             = (2=>4=>3[->2]=>8);         // goto repetition - value 3 seen, then skips ahead after 2nd occurrence
      // bins goto_rept1[1]      = (3=>4=>5[->2]=>7);          // ILLEGAL - unsized array of bins not allowed here
      bins non_consec_rept       = (3=>4=>5[=2]=>7);           // non-consecutive repeat - 5 occurs twice, not necessarily back-to-back
      bins random                = (10=>9=>4[=2]=>2[*2]=>1);   // combined example mixing repeat styles in one sequence
    }
  endgroup

  function new();
    cg = new();
  endfunction
endclass

module top_transition_bins;
  transition_bins_pkt bin = new();

  initial begin
    repeat (500) begin
      bin.randomize();
      $display("%d ", bin.a);
      bin.cg.sample();   // explicit sampling call, since no clocking event drives this covergroup
      #1;
    end
  end
endmodule
