`include "fs_transaction.sv"
`include "fs_generator.sv"
`include "fs_driver.sv"
`include "fs_ip_monitor.sv"
`include "fs_op_monitor.sv"
`include "fs_scoreboard.sv"

class environment;

transaction pkt;
generator gen;
driver drv;
ip_monitor ipmon;
op_monitor opmon;
scoreboard scrbd;

mailbox g2d;
mailbox im2s;
mailbox om2s;

virtual interface my_intf inter;

function new(virtual interface my_intf.tb inter);
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
