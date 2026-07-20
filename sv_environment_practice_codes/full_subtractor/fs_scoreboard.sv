class scoreboard;
transaction pkt1,pkt2;

mailbox im2s;
mailbox om2s;

function new(mailbox im2s,mailbox om2s);
this.im2s=im2s;
this.om2s=om2s;
endfunction

task run;
pkt1=new();
pkt2=new();
forever begin
	im2s.get(pkt1);
	om2s.get(pkt2);

	if(pkt1.diff == pkt2.diff && pkt1.bout==pkt2.bout)begin
		$display("verification successful");
		$display("diff1=%d bout1=%d diff2=%d bout2=%d",pkt1.diff,pkt1.bout,pkt2.diff,pkt2.bout);end
	else begin
		$display("verification failed");
		$display("diff1=%d bout1=%d diff2=%d bout2=%d",pkt1.diff,pkt1.bout,pkt2.diff,pkt2.bout);end
end
endtask

endclass
