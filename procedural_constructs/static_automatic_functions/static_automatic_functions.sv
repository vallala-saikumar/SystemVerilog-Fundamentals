// =====================================================================
// Description : Demonstrates static vs automatic local variable
//               behavior using independent, non-recursive calls.
// =====================================================================
module static_vs_automatic_function_demo;

  // STATIC function - 'call_count' persists across separate calls,
  // like a hidden global counter - often an unintended bug
  function static int static_call_counter();
    static int call_count = 0;
    call_count++;
    return call_count;
  endfunction

  // AUTOMATIC function - 'call_count' resets fresh every call
  function automatic int automatic_call_counter();
    automatic int call_count = 0;
    call_count++;
    return call_count;
  endfunction

  initial begin
    $display("-- static function called 3 times --");
    $display("static_call_counter() call 1 = %0d", static_call_counter());
    $display("static_call_counter() call 2 = %0d", static_call_counter());
    $display("static_call_counter() call 3 = %0d", static_call_counter());
    // Output: 1, 2, 3 - value PERSISTS across calls even though
    // 'call_count' is declared fresh inside the function each time

    $display("-- automatic function called 3 times --");
    $display("automatic_call_counter() call 1 = %0d", automatic_call_counter());
    $display("automatic_call_counter() call 2 = %0d", automatic_call_counter());
    $display("automatic_call_counter() call 3 = %0d", automatic_call_counter());
    // Output: 1, 1, 1 - resets every call, as most people assume
    // a local variable should behave

    $finish;
  end


endmodule
