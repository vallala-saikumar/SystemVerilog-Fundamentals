`include "fs_interface.sv"
`include "fs_pb.sv"
`include "fs_dut.sv"

module fs_top;
	my_intf inter();
	fs_tb tb(inter);
	fs_dut dut(inter);
endmodule
