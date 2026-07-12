// abstract_class_virtual_methods- abstraction example

virtual class Shape;
  pure virtual function int area();

  function void display();
    $display("Area = %0d", area());
  endfunction
endclass

class Square extends Shape;
  int side;

  function new(int side);
    this.side = side;
  endfunction

  function int area();
    return side * side;
  endfunction
endclass

class Rectangle extends Shape;
  int length, breadth;

  function new(int length, int breadth);
    this.length = length;
    this.breadth = breadth;
  endfunction

  function int area();
    return length * breadth;
  endfunction
endclass

module abstraction;
  initial begin
    Shape shapes[2];

    shapes[0] = new Square(4);
    shapes[1] = new Rectangle(3, 5);

    foreach (shapes[i])
      shapes[i].display();

    // Shape s = new Shape(); // ILLEGAL - cannot instantiate virtual class

    
  end
endmodule
