// dist_weighted_constraints
class weighted_pkt;
  rand bit [2:0] mode;

  constraint mode_dist_c {
    mode dist { 0 := 50, [1:3] :/ 30, [4:7] :/ 20 };
  }
endclass

module dist_weighted;
  initial begin
    weighted_pkt pkt = new();
    int count[8];

    repeat (1000) begin
      void'(pkt.randomize());
      count[pkt.mode]++;
    end

    $display("-- distribution over 1000 randomizations --");
    foreach (count[i])
      $display("mode=%0d occurred %0d times", i, count[i]);

    $finish;
  end
endmodule
