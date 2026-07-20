class generator;
transaction pkt;
mailbox g2d;

function new(mailbox g2d);
this.g2d=g2d;
endfunction

task run();
		pkt=new();
		repeat(10) begin
		#1;
		assert(pkt.randomize());
		pkt.disp();
		$display(".......generator.......");

		g2d.put(pkt);
		$display("..generator to mailbox done..");
		#1;
		end
endtask

endclass


