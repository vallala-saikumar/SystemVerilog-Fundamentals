class op_monitor;
transaction pkt;
mailbox om2s;

virtual interface my_intf inter;

function new(mailbox om2s,virtual interface my_intf.tb inter);
this.om2s=om2s;
this.inter=inter;
endfunction

task run();
pkt=new();
forever begin
@(inter.diff,inter.bout);
	begin
	pkt.diff=inter.diff;
	pkt.bout=inter.bout;

	om2s.put(pkt);
	$display("output monitor");
	end
end
endtask

endclass
