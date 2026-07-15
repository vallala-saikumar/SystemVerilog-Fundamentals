// semaphore_basics
// Demonstrates semaphores used to control access to a shared resource
// among multiple concurrent processes - e.g. multiple drivers sharing
// one physical bus.

module semaphore_basics;

  semaphore sem = new(1);   // 1 key available - only one process can access the resource at a time

  task automatic access_resource(string name, int delay);
    sem.get(1);   // blocks until a key is available, then takes it
    $display("[%0t] %s acquired the resource", $time, name);
    #(delay);
    $display("[%0t] %s releasing the resource", $time, name);
    sem.put(1);   // returns the key, allowing another process to proceed
  endtask

  initial begin
    fork
      access_resource("ProcessA", 10);
      access_resource("ProcessB", 5);
      access_resource("ProcessC", 8);
    join

    $finish;
  end

endmodule
