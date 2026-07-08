// class_basics
class Packet;
  int addr;
  int data;

  function new(int addr = 0, int data = 0);
    this.addr = addr;
    this.data = data;
  endfunction

  function void display();
    $display("Packet: addr=%0d data=%0d", addr, data);
  endfunction
endclass

module class_basics;
  initial begin
    Packet p1;
    Packet p2 = new(10, 20);

    p1 = new();
    p1.display();
    p2.display();

    p1.addr = 99;
    p1.display();

    $finish;
  end
endmodule
