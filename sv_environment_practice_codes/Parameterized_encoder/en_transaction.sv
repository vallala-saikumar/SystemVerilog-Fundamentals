class transaction #(SIZE,SI);

rand bit [SIZE-1:0]din;
bit [SI-1:0]dout;

//constraint c1{$countones(din)==1;}

function void disp();
$display("...transaction...");
endfunction
endclass

