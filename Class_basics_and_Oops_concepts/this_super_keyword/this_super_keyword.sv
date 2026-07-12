// this_super_keyword

class Base;
  int value;

  function new(int value = 0);
    this.value = value;   // 'this' disambiguates member from argument of same name
  endfunction

  function void show();
    $display("Base: value=%0d", this.value);
  endfunction
endclass

class Derived extends Base;
  int value;   // shadows Base's 'value'

  function new(int value = 0);
    super.new(value + 100);   // calls Base's constructor explicitly
    this.value = value;       // sets Derived's own 'value'
  endfunction

  function void show();
    super.show();                          // calls Base's show() explicitly
    $display("Derived: this.value=%0d (own member)", this.value);
    $display("Derived: super.value=%0d (Base's member, accessed via super)", super.value);
  endfunction
endclass

module this_super_diff;
  initial begin
    Derived d = new(5);
    d.show();

  end
endmodule
