// virtual_interface

interface simple_if(input logic clk);
  logic [7:0] data;
endinterface

class driver;
  virtual simple_if vif;   // a CLASS cannot instantiate a real interface,
                           // so it holds a virtual interface HANDLE instead

  function new(virtual simple_if vif);
    this.vif = vif;   // handle assigned from outside, connecting class to actual HW interface
  endfunction

  task automatic drive(int val);
    @(posedge vif.clk);   // class code can wait on/drive signals via the handle
    vif.data = val;
    $display("[%0t] driver (class) drove data=%0d", $time, val);
  endtask
endclass

module virtual_interface;
  logic clk = 0;
  always #5 clk = ~clk;

  simple_if sif(clk);   // the actual physical interface instance
  driver drv;

  initial begin
    drv = new(sif);   // pass physical interface into class via virtual interface
    drv.drive(77);
    #10;
    drv.drive(88);
    #20 $finish;
  end
endmodule
