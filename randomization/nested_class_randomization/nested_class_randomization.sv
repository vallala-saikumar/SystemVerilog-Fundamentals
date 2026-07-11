// nested_class_randomization

class inner_pkt;
  rand bit [7:0] payload;
  rand bit [3:0] len;

  constraint payload_range_c { payload inside {[0:255]}; }
  constraint len_range_c     { len inside {[1:15]}; }
endclass

class outer_pkt;
  rand bit [7:0] header;
  rand inner_pkt inner;   // nested class handle marked 'rand' - gets
                          // automatically randomized when outer.randomize()
                          // is called, AS LONG AS the handle is not null

  constraint header_c { header inside {[0:31]}; }

  function new();
    inner = new();   // handle must be constructed BEFORE randomize() is
                      // called, otherwise nested object stays null and
                      // its properties are never randomized
  endfunction
endclass

// A second variant showing what happens WITHOUT constructing the handle
class outer_pkt_unconstructed;
  rand bit [7:0] header;
  rand inner_pkt inner;   // left null intentionally to show the pitfall

  constraint header_c { header inside {[0:31]}; }
endclass

module nested_class_randomization;
  initial begin
    outer_pkt pkt = new();
    outer_pkt_unconstructed bad_pkt = new();

    $display("-- nested rand object, handle constructed in new() --");
    repeat (3) begin
      void'(pkt.randomize());
      $display("header=%0d | inner.payload=%0d inner.len=%0d",
                 pkt.header, pkt.inner.payload, pkt.inner.len);
    end

    $display("-- nested rand object, handle NEVER constructed (common bug) --");
    void'(bad_pkt.randomize());
    if (bad_pkt.inner == null)
      $display("header=%0d | inner handle is NULL - nested object was never randomized",
                 bad_pkt.header);

  end


endmodule
