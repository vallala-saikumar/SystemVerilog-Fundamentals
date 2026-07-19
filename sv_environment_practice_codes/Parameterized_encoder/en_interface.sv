interface en_intf #(SIZE,SI)();

logic  [SIZE-1:0]din;
logic  [SI-1:0]dout;

modport tb(input dout,output din);
modport dut(input din,output dout);

endinterface
