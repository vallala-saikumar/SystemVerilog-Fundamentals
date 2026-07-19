`include "en_transaction.sv"
`include "en_generator.sv"
`include "en_driver.sv"
`include "en_ip_monitor.sv"
`include "en_op_monitor.sv"
`include "en_scoreboard.sv"

class environment#(SIZE=4,SI=2);

transaction #(SIZE,SI) pkt;
generator #(SIZE,SI) gen;
driver #(SIZE,SI)drv;
ip_monitor #(SIZE,SI)ipmon;
op_monitor #(SIZE,SI)opmon;
scoreboard #(SIZE,SI) scrbd;

mailbox g2d;
mailbox im2s;
mailbox om2s;

virtual interface en_intf #(SIZE,SI) inter;

function new(virtual interface en_intf #(SIZE,SI) inter);
this.inter=inter;
endfunction

function void build();
	pkt=new();

	g2d=new();
	im2s=new();
	om2s=new();

	gen=new(g2d);
	drv=new(g2d,inter);
	ipmon=new(im2s,inter);
	opmon=new(om2s,inter);
	scrbd=new(im2s,om2s);
endfunction

task run();
build();
	fork
	gen.run();
	drv.run();
	ipmon.run();
	opmon.run();
	scrbd.run();
	join_any
endtask
		
endclass
