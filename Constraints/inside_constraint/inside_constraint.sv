// basic_constraints- inside constraint
class constrained_pkt;
  rand bit [7:0] addr;
  rand bit [7:0] data;
  rand bit [3:0] burst_len;

  constraint addr_range_c { addr inside {[120:250]}; }
  constraint data_gt_addr_c { data > addr; }
  constraint burst_len_c { burst_len inside {1, 2, 4, 8}; }
endclass

module basic_constraints;
  initial begin
    constrained_pkt pkt = new();

    repeat (5) begin
      if (pkt.randomize())
        $display("addr=%0d data=%0d burst_len=%0d", pkt.addr, pkt.data, pkt.burst_len);
      else
        $display("randomize failed");
    end

    $finish;
  end
endmodule
