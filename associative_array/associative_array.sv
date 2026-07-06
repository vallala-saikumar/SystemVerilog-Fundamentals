//this code is to learn about the associative array and its feature of different indexing

module assoc_array_demo;
  int assoc_arr[string];   // indexed by string - like a hash map
  int assoc_by_int[int];   // sparse array, e.g. for addresses in memory model

  initial begin
    assoc_arr["addr0"] = 32'hDEAD_BEEF;
    assoc_arr["addr1"] = 32'hCAFE_1234;

    if (assoc_arr.exists("addr0"))
      $display("addr0 = %h", assoc_arr["addr0"]);
	  
	assoc_by_int[5]=25;

	$display("element at index named 5 = %d",assoc_by_int[5]);

  end
endmodule
