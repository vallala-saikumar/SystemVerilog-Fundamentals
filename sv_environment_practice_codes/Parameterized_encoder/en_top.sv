`include "en_interface.sv"
`include "en_pb.sv"
`include "en_dut.sv"

module top #(SIZE=8,SI=3);

en_intf #(SIZE,SI) inter();
en_tb #(SIZE,SI) tb(inter);
en_dut dut(inter);

endmodule
