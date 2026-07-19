class scoreboard #(SIZE,SI);
transaction #(SIZE,SI) ref_pkt,dut_pkt;
mailbox im2s,om2s;

function new(mailbox im2s,mailbox om2s);
this.im2s=im2s;
this.om2s=om2s;
endfunction

task run();
ref_pkt=new();
dut_pkt=new();

forever begin
	im2s.get(ref_pkt);
	om2s.get(dut_pkt);

		if(ref_pkt.dout==dut_pkt.dout)begin
			$display("ref_dout=%b dut_dout=%b",ref_pkt.dout,dut_pkt.dout);
			$display("...test passed...");end
		else begin
			$display("ref_dout=%b dut_dout=%b",ref_pkt.dout,dut_pkt.dout);
			$display("...test failed...");end
end
endtask
endclass
