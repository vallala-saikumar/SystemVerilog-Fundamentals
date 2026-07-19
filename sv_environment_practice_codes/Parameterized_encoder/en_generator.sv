class generator #(SIZE,SI);
transaction #(SIZE,SI) pkt;
mailbox g2d;

function new(mailbox g2d);
this.g2d=g2d;
endfunction

task run();
	pkt=new();
	repeat(10)	begin
	#1;
	pkt.randomize();
	pkt.disp();
	$display("...generator...");
	$display("din=%p ",pkt.din);
	g2d.put(pkt);
	$display("..g2d..");
	#1;
	end
endtask

endclass


