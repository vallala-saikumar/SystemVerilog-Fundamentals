`include "en_test.sv"

program en_tb #(SIZE,SI)(en_intf inter);
test #(SIZE,SI) tb;

initial begin
tb=new(inter);
tb.run();
end
endprogram
