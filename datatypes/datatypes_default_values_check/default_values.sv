module def_val;
int a;
integer b;
shortint c;
longint d;
bit [7:0]e;
byte f;
logic [4:0]g;
shortreal h;
string i;

initial begin
	$display("default value of int=%b integer=%b shortint=%b longint=%b bit=%b byte=%b logic=%b shortreal=%b string=%s",a,b,c,d,e,f,g,h,i);
	a=56;
	b=35;
	c=22;
	d=4573;
	e=8'b10xx10zz;
	f=8'b10zz10xx;
	g=5'b10x0x;
	h=3.543;
	i="ram";
	$display("updated value of int=%b integer=%b shortint=%b longint=%b bit=%b byte=%b logic=%b shortreal=%b string=%s",a,b,c,d,e,f,g,h,i);
	end
endmodule
