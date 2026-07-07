// =====================================================================
// Description : Compares if-else priority chains vs case statements,
//               and demonstrates "unique if" and "unique case"
// =====================================================================
module unique_if_case (
  input  logic [1:0] sel,
  input  logic [3:0] a, b, c, d,
  output logic [3:0] out_if,
  output logic [3:0] out_case,
  output logic [3:0] out_unique_if,
  output logic [3:0] out_unique_case
);

  // Plain if-else chain - implies priority (first match wins)
  always_comb begin
    if (sel == 2'b00)      out_if = a;
    else if (sel == 2'b01) out_if = b;
    else if (sel == 2'b10) out_if = c;
    else                   out_if = d;
  end

  // Plain case - no implied priority, always include default
  always_comb begin
    case (sel)
      2'b00: out_case = a;
      2'b01: out_case = b;
      2'b10: out_case = c;
      default: out_case = d;
    endcase
  end

  // unique if - tool warns if 0 or more than 1 condition matches
  always_comb begin
    unique if (sel == 2'b00) out_unique_if = a;
    else if (sel == 2'b01)   out_unique_if = b;
    else if (sel == 2'b10)   out_unique_if = c;
    else if (sel == 2'b11)   out_unique_if = d;
  end

  // unique case - tool warns if 0 or more than 1 case item matches
  always_comb begin
    unique case (sel)
      2'b00: out_unique_case = a;
      2'b01: out_unique_case = b;
      2'b10: out_unique_case = c;
      2'b11: out_unique_case = d;
    endcase
  end

endmodule

// ---------------------------------------------------------------------
// Testbench
// ---------------------------------------------------------------------
module tb_if_case_demo;
  logic [1:0] sel;
  logic [3:0] a = 1, b = 2, c = 3, d = 4;
  logic [3:0] out_if, out_case, out_unique_if, out_unique_case;

  unique_if_case dut (.*);

  initial begin
    for (int i = 0; i < 4; i++) begin
      sel = i[1:0];
      #5 $display("sel=%0d out_if=%0d out_case=%0d out_unique_if=%0d out_unique_case=%0d",
                   sel, out_if, out_case, out_unique_if, out_unique_case);
    end
    $finish;
  end
endmodule
