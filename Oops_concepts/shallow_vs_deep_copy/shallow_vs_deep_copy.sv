// deep_vs_shallow_copy.sv
class Inner;
  int val;

  function new(int val = 0);
    this.val = val;
  endfunction
endclass

class Outer;
  int id;
  Inner inner;

  function new(int id = 0, int inner_val = 0);
    this.id = id;
    inner = new(inner_val);
  endfunction

//copy method which creates separate memory for nested class 
//and copies its properties and methods
  function Outer deep_copy();
    Outer new_obj = new();
    new_obj.id = this.id;
    new_obj.inner = new(this.inner.val);
    return new_obj;
  endfunction
endclass

module sv_copy_techniques;
  initial begin
    Outer o1 = new(1, 100);
    Outer o2_shallow;
    Outer o3_deep;

    o2_shallow = new o1;        // shallow copy - inner handle is shared
    o3_deep    = o1.deep_copy(); // deep copy - inner is a separate object

    o1.inner.val = 999;

    $display("shallow copy: o2_shallow.inner.val = %0d (changed too, expected 999)", o2_shallow.inner.val);
    $display("deep copy   : o3_deep.inner.val     = %0d (unaffected, expected 100)", o3_deep.inner.val);

    
  end
endmodule
