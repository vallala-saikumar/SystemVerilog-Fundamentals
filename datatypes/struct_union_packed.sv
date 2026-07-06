//this code is to learn about stuct and union type datatypes and to learn how one union reflects one variable data change in another

module struct_union;
  // struct - group related fields
  typedef struct packed {
    bit [7:0]  addr;
    bit [31:0] data;
    bit        we;
  } bus_txn_t;

  bus_txn_t txn;

  // union - same memory, different interpretations
  typedef union packed {
    bit [31:0] word;
    struct packed {
      bit [7:0] b3, b2, b1, b0;
    } bytes;
  } word_union_t;

  word_union_t wu;

  initial begin
    txn.addr = 8'h10;
    txn.data = 32'hABCD_1234;
    txn.we   = 1;
    $display("txn = %p", txn);

    wu.word = 32'h11223344;
    $display("byte0=%h byte1=%h", wu.bytes.b0, wu.bytes.b1);
  end
endmodule
