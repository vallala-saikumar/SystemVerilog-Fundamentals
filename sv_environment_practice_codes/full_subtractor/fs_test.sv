`include "fs_environment.sv"

class test;

environment env;

virtual interface my_intf inter;

function new(virtual interface my_intf.tb inter);
this.inter=inter;
endfunction

task run;
	env=new(inter);
	env.run();
endtask

endclass

