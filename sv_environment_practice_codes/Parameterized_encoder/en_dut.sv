module en_dut(en_intf.dut inter);

always_comb begin

    for (int i = 0; i <$size(inter.din); i++) begin
        if (inter.din[i]) begin
            inter.dout = i;               // assign index as output
        end
    end
end

endmodule
