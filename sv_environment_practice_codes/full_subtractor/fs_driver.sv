class driver;
transaction pkt;
mailbox g2d;
virtual interface my_intf inter;

function new(mailbox g2d,virtual interface my_intf.tb inter);
this.g2d=g2d;
this.inter=inter;
endfunction

task run();
		pkt=new();
	forever begin

		g2d.get(pkt);

		inter.a=pkt.a;
		inter.b=pkt.b;
		inter.c=pkt.c;

		$display(".....driver.....");
	end
endtask

endclass

