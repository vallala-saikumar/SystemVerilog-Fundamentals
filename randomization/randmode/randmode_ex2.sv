class packet;
randc reg[4:0] w_addr;
randc byte w_data;
	 bit[2:0] r_addr;
randc logic r_data;
endclass

module tb;
bit [3:0]count;
packet p1;
initial begin
	p1=new();
	repeat(10)begin
	if(count>5)begin
		p1.w_addr.rand_mode(1);
		p1.randomize();
		$display("value of w_addr %d w_data %d r_addr %d r_data %d",p1.w_addr,p1.w_data,p1.r_addr,p1.r_data);
		end
	else begin
		p1.w_addr.rand_mode(0);
		p1.randomize();
		$display("value of w_addr %d w_data %d r_addr %d r_data %d",p1.w_addr,p1.w_data,p1.r_addr,p1.r_data);
		end
	count++;
		end
	end
endmodule
