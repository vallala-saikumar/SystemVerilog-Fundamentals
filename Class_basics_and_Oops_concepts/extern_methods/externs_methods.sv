// extern_methods

class Calculator;
  int last_result;

//we need to use extern keyword to define there existance in class
  extern function new(int init_val = 0);
  extern function int add(int a, int b);
  extern function int multiply(int a, int b);
  extern task display_result();
endclass

//externally defined functions

function Calculator::new(int init_val = 0);
  last_result = init_val;
endfunction

function int Calculator::add(int a, int b);
  last_result = a + b;
  return last_result;
endfunction

function int Calculator::multiply(int a, int b);
  last_result = a * b;
  return last_result;
endfunction

//externally defined task

task Calculator::display_result();
  $display("last_result = %0d", last_result);
endtask

module extern_methods;
  initial begin
    Calculator calc = new();

    void'(calc.add(3, 4));
    calc.display_result();

    void'(calc.multiply(5, 6));
    calc.display_result();

    
  end
endmodule
