`include "fs_test.sv"

program fs_tb(my_intf.tb inter);
test tst;

initial begin
tst=new(inter);
tst.run();
end

endprogram
