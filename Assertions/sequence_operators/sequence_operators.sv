// sequence_operators
// Demonstrates key sequence-level operators: ##n, ##[m:n], and, or,
// intersect, throughout, within, first_match.

module sequence_operators (
  input logic clk,
  input logic a, b, c
);

  // ##n - exact delay
  sequence seq_exact_delay;
    a ##2 b;   // b must occur exactly 2 cycles after a
  endsequence

  // ##[m:n] - delay range
  sequence seq_delay_range;
    a ##[1:3] b;   // b must occur anywhere from 1 to 3 cycles after a
  endsequence

  // and - both sequences must complete, can end at DIFFERENT times
  sequence seq_and;
    (a ##1 b) and (a ##2 c);
  endsequence

  // or - either sequence completing satisfies it
  sequence seq_or;
    (a ##1 b) or (a ##1 c);
  endsequence

  // intersect - both sequences must complete at the SAME time
  sequence seq_intersect;
    (a ##[1:3] b) intersect (a ##2 c);
  endsequence

  // throughout - a condition must hold true for the ENTIRE duration of another sequence
  sequence seq_throughout;
    a throughout (b ##1 c);   // 'a' must stay true until b then c complete
  endsequence

  // within - one sequence must occur entirely within the window of another
  sequence seq_within;
    (a ##1 b) within (c ##[1:5] c);
  endsequence

  // first_match - only the FIRST match of a sequence with multiple
  // possible endpoints is considered (useful with delay ranges)
  sequence seq_first_match;
    first_match(a ##[1:3] b);
  endsequence

  assert property (@(posedge clk) seq_exact_delay)
  else $error("[%0t] exact delay sequence failed", $time);

endmodule
