//this is code is about the dynamic array memory creation during runtime

module dynamic_array;
  int dyn_arr[];   // size unknown at compile time

  initial begin
    dyn_arr = new[5];
    foreach (dyn_arr[i]) dyn_arr[i] = i * 2;

    $display("Size = %0d", dyn_arr.size());

    // resize while keeping old values
    dyn_arr = new[8](dyn_arr);//creating extra 8 bits size to size of dyn_arr
    dyn_arr[7] = 99;

    foreach (dyn_arr[i]) $display("dyn_arr[%0d] = %0d", i, dyn_arr[i]);

    dyn_arr.delete();  // deletes all elements and size will be {}
    $display("After delete, size = %0d", dyn_arr.size());
  end
endmodule
