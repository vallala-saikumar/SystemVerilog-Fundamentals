class ip_monitor;
transaction pkt;
mailbox im2s;
virtual interface my_intf inter;

function new(mailbox im2s,virtual interface my_intf.tb inter);
this.im2s=im2s;
this.inter=inter;
endfunction

task run();
pkt=new();
forever begin
@(inter.a,inter.b,inter.c);
	begin
	pkt.a=inter.a;
	pkt.b=inter.b;
	pkt.c=inter.c;
	
	pkt.diff=pkt.a^pkt.b^pkt.c;
	pkt.bout=(~pkt.a & pkt.c)|(~pkt.a & pkt.b)|(pkt.b & pkt.c);
	
	im2s.put(pkt);
	$display("input monitor");
	end
end
endtask

endclass
