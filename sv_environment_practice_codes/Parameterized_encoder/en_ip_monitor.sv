class ip_monitor #(SIZE,SI);
transaction #(SIZE,SI) pkt;
mailbox im2s;

virtual interface en_intf #(SIZE,SI) inter;

function new(mailbox im2s,virtual interface en_intf#(SIZE,SI) inter);
this.im2s=im2s;
this.inter=inter;
endfunction

task run();
pkt=new();
forever begin
	@(inter.din)
	foreach(pkt.din[i])
	pkt.din[i]=inter.din[i];

$display("...input monitor...");

 
    pkt.dout = 'x;                             
    for (int i = 0; i < $size(inter.din); i++) begin
        if (pkt.din[i]) begin
            pkt.dout =i;            
        end
    end
$display("din=%b dout=%b",pkt.din,pkt.dout);
	im2s.put(pkt);
end
endtask
	
endclass
