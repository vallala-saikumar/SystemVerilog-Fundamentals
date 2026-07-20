module fs_dut(my_intf.dut inter);

always@(*)
begin

inter.diff=inter.a^inter.b^inter.c;
inter.bout=(~inter.a&inter.b)|(~inter.a&inter.c)|(inter.b&inter.c);

end

endmodule
