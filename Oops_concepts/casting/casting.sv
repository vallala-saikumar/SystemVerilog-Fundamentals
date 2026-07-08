// $cast_downcasting

class Base;
  virtual function void identify();
    $display("I am Base");
  endfunction
endclass

class Derived extends Base;
  int extra_data = 42;

  virtual function void identify();
    $display("I am Derived, extra_data=%0d", extra_data);
  endfunction
endclass


module dollar_cast;
  initial begin
    Base b_handle;
    Derived d_handle;
    Derived d_new;
    int cast_status;

    // upcasting - always safe, done implicitly, no $cast needed
    d_new = new();
    b_handle = d_new;
    b_handle.identify();

    // downcasting - base handle to derived handle, NOT implicit,
    // must use $cast since it can fail at runtime
    cast_status = $cast(d_handle, b_handle);
    if (cast_status)
      $display("Downcast succeeded, extra_data=%0d", d_handle.extra_data);
    else
      $display("Downcast failed");

    // downcast failure example - b_handle actually holds a plain Base,
    // not a Derived, so the cast should fail
    b_handle = new();  // reassign to a plain Base object
    cast_status = $cast(d_handle, b_handle);
    if (!cast_status)
      $display("Downcast correctly failed - b_handle does not hold a Derived object");

   
  end
endmodule
