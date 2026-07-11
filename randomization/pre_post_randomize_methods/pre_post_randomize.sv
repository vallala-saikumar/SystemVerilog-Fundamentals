// pre_post_randomize

class base;
  rand bit [7:0] addr;
  rand bit [7:0] data;
  int randomize_count;

  // pre_randomize - called automatically BEFORE randomization happens
  function void pre_randomize();
    $display("[pre_randomize] about to randomize, current addr=%0d", addr);
  endfunction

  // post_randomize - called automatically AFTER randomization completes
  function void post_randomize();
    randomize_count++;
    $display("[post_randomize] randomized #%0d -> addr=%0d data=%0d", randomize_count, addr, data);
  endfunction
endclass

module pre_post_randomize;
  initial begin
    base pkt = new();

    repeat (3) void'(pkt.randomize());

  end
endmodule
