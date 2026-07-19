class op_monitor #(SIZE,SI);
transaction #(SIZE,SI) pkt;
mailbox om2s;

virtual interface en_intf #(SIZE,SI) inter;

function new(mailbox om2s,virtual interface en_intf #(SIZE,SI) inter);
this.om2s=om2s;
this.inter=inter;
endfunction

task run();
pkt=new();
forever begin
@(inter.dout)
	foreach(inter.dout[i])
	pkt.dout[i]=inter.dout[i];

	$display("...output monitor...");
$display("dout=%b",pkt.dout);

	om2s.put(pkt);

	end
endtask

endclass
