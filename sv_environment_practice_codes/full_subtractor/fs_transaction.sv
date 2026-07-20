class transaction;
rand bit a;
rand bit b;
rand bit c;
bit diff;
bit bout;

function void disp();
$display("TRANSACTION");
$display("TRANSACTION a=%d b=%d c=%d",a,b,c);
endfunction

endclass
