// inheritance.sv
class Base;
  int id;

  function new(int id = 0);
    this.id = id;
  endfunction

  function void display();
    $display("Base: id=%0d", id);
  endfunction
endclass

class Derived extends Base;
  int extra;

  function new(int id = 0, int extra = 0);
    super.new(id);
    this.extra = extra;
  endfunction

  function void display();
    super.display();
    $display("Derived: extra=%0d", extra);
  endfunction
endclass

module inheritance;
  initial begin
    Base b;
    Derived d;

    b = new(1);
    b.display();

    d = new(2, 100);
    d.display();

    $finish;
  end
endmodule
