//this code is about the queue functioning and methods of queue

module queue_demo;
  int q[$];  // queue - dynamic size, efficient push/pop from both ends

  initial begin
    q.push_back(10);
    q.push_back(20);
    q.push_front(5);
    $display("Queue = %p", q);       // %p prints total arrays/queues

    q.insert(1, 15);
    $display("After insert = %p", q);

    int popped = q.pop_front();
    $display("Popped = %0d, Queue now = %p", popped, q);

  end
endmodule
