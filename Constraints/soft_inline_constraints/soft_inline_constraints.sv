// soft_constraint with inline_constraint

class soft_pkt;
  rand bit [7:0] addr;

  constraint addr_default_c { soft addr == 8'd10; }
endclass

module soft_constraints;
  initial begin
    soft_pkt pkt = new();

    $display("-- no override, soft constraint applies --");
    void'(pkt.randomize());
    $display("addr=%0d (expected 10, soft default used)", pkt.addr);

	//constraint with soft is override by the inline constraint
    $display("-- overriding via inline hard constraint --");
    void'(pkt.randomize() with { addr == 8'd50; });
    $display("addr=%0d (expected 50, inline constraint overrides soft default)", pkt.addr);

    $finish;
  end
endmodule
