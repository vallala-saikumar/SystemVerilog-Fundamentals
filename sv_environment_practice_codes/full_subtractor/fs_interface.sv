interface my_intf;
logic a,b,c;
logic diff,bout;

modport tb(output a,b,c,input diff,bout);
modport dut(output diff,bout,input a,b,c);

endinterface
