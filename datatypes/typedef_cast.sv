//this code is to learn how casting of data types will be done from one form to another using static cast

module typedef_cast;
  typedef bit [15:0] addr_t;  // custom type alias - improves readability
  addr_t my_addr;

  int i = 10;
  real r;

  initial begin
    my_addr = 16'hABCD;
    $display("my_addr = %h", my_addr);

    r = real'(i) / 3;              // static cast
    $display("real cast: %f", r);

    // dynamic cast example (used heavily with class handles in uvm and polymorphism)
    // if (!$cast(derived_handle, bc)) $error("cast failed");
  end
endmodule
