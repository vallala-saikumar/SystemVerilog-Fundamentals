class driver #(SIZE,SI);
transaction #(SIZE,SI) pkt;
mailbox g2d;

virtual interface en_intf #(SIZE,SI) inter;

function new(mailbox g2d,virtual interface en_intf #(SIZE,SI) inter);
this.g2d=g2d;
this.inter=inter;
endfunction

task run();
pkt=new();
forever begin
	g2d.get(pkt);
	$display("...driver...");
	$display("driving data %b",pkt.din);
	foreach(pkt.din[i])
		inter.din[i]=pkt.din[i];
end

endtask

endclass
		
