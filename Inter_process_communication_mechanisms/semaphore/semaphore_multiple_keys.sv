// semaphore_multiple_keys
// Demonstrates a semaphore initialized with MULTIPLE keys, allowing a
// limited number of concurrent accesses (e.g. a resource pool).

module semaphore_multiple_keys;

  semaphore sem = new(2);   // 2 keys available - up to 2 processes can proceed concurrently

  task automatic use_pool_resource(string name, int delay);
    sem.get(1);
    $display("[%0t] %s acquired a resource from the pool", $time, name);
    #(delay);
    $display("[%0t] %s returning resource to the pool", $time, name);
    sem.put(1);
  endtask

  initial begin
    fork
      use_pool_resource("Worker1", 10);
      use_pool_resource("Worker2", 10);
      use_pool_resource("Worker3", 5);   // will have to wait since only 2 keys exist
    join

    $finish;
  end
endmodule
