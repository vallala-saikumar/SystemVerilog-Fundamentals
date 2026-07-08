// parameterized_class
//Here we parameterized datatype and named constant
class Fifo #(type T = int, int DEPTH = 8);
  T queue_data[$];

  function bit push(T item);
    if (queue_data.size() >= DEPTH) begin
      $display("FIFO full, cannot push");
      return 0;
    end
    queue_data.push_back(item);
    return 1;
  endfunction

  function bit pop(output T item);
    if (queue_data.size() == 0) begin
      $display("FIFO empty, cannot pop");
      return 0;
    end
    item = queue_data.pop_front();
    return 1;
  endfunction

  function int current_size();
    return queue_data.size();
  endfunction
endclass

module parameterized_class;
  initial begin
  //passing param arguments 
    Fifo #(int, 4) int_fifo = new();
    Fifo #(string, 2) string_fifo = new();
    int val;
    string s_val;

    void'(int_fifo.push(10));
    void'(int_fifo.push(20));
    void'(int_fifo.push(30));
    $display("int_fifo size = %0d", int_fifo.current_size());

    void'(int_fifo.pop(val));
    $display("popped from int_fifo = %0d", val);

    void'(string_fifo.push("hello"));
    void'(string_fifo.push("world"));
    void'(string_fifo.push("overflow"));  // should fail, DEPTH=2

    void'(string_fifo.pop(s_val));
    $display("popped from string_fifo = %s", s_val);

  end
endmodule
