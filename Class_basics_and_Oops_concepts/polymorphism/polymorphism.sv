// polymorphism with example

class Animal;
  function void speak();
    $display("Animal speaks");
  endfunction

  virtual function void speak_virtual();
    $display("Animal speaks (virtual)");
  endfunction
endclass

class Dog extends Animal;
  function void speak();
    $display("Dog barks");
  endfunction

  virtual function void speak_virtual();
    $display("Dog barks (virtual)");
  endfunction
endclass

module polymorphism;
  initial begin
    Animal a_handle;
    Dog d = new();

    a_handle = d;

    a_handle.speak();          // non-virtual - calls Animal's version
    a_handle.speak_virtual();  // virtual - calls Dog's version

  end
endmodule
