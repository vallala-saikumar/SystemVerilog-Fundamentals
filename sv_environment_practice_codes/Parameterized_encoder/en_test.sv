`include "en_environment.sv"

class test #(SIZE,SI);

environment #(SIZE,SI) env;

virtual interface en_intf #(SIZE,SI) inter;

function new(virtual interface en_intf #(SIZE,SI) inter);
this.inter=inter;
endfunction

task run();
begin
env=new(inter);
env.run();
end
endtask

endclass
