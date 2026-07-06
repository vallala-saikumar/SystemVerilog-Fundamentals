//this code is implemented to learn about different types of arrays and difference between them.

module array_demo;
  bit [7:0] packed_arr;          // packed: contiguous bits, treated as a vector
  bit unpacked_arr [7:0];        // unpacked: array of separate 1-bit elements
  bit [3:0] mixed_arr [0:3];     // packed dimension + unpacked dimension

  initial begin
    packed_arr = 8'hFF;
    $display("packed_arr = %h", packed_arr);   // can do arithmetic directly

    unpacked_arr[0] = 1;
    unpacked_arr[1] = 0;
    // unpacked_arr = 8'hFF; // ILLEGAL - can't treat as one vector

    mixed_arr[0] = 4'hA;
    mixed_arr[1] = 4'hB;
    $display("mixed_arr[0]=%h mixed_arr[1]=%h", mixed_arr[0], mixed_arr[1]);
  end
endmodule
