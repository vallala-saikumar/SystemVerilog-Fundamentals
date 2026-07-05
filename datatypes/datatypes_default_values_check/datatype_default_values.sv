//==============================================================
// File Name : datatype_default_values.sv
// Description:
// Demonstrates the default values of various SystemVerilog
// data types and illustrates the behavior of 2-state and
// 4-state data types when assigned X and Z values.
//==============================================================

module datatype_default_values;

    // Integer data types
    int        a;
    integer    b;
    shortint   c;
    longint    d;

    // 2-state data types
    bit   [7:0] e;
    byte        f;

    // 4-state data type
    logic [4:0] g;

    // Floating-point type
    shortreal h;

    // String type
    string i;

    initial begin

        $display("\n======================================================");
        $display("        DEFAULT VALUES OF SYSTEMVERILOG DATATYPES");
        $display("======================================================");

        $display("int        : %0d", a);
        $display("integer    : %0d", b);
        $display("shortint   : %0d", c);
        $display("longint    : %0d", d);
        $display("bit [7:0]  : %b", e);
        $display("byte       : %0d", f);
        $display("logic[4:0] : %b", g);
        $display("shortreal  : %f", h);
        $display("string     : \"%s\"", i);

        // Assign values
        a = 56;
        b = 35;
        c = 22;
        d = 4573;

        // 2-state types (X and Z become 0)
        e = 8'b10xx10zz;
        f = 8'b10zz10xx;

        // 4-state type (X and Z are preserved)
        g = 5'b10x0x;

        h = 3.543;
        i = "RAM";

        $display("\n======================================================");
        $display("              UPDATED VALUES");
        $display("======================================================");

        $display("int        : %0d", a);
        $display("integer    : %0d", b);
        $display("shortint   : %0d", c);
        $display("longint    : %0d", d);
        $display("bit [7:0]  : %b", e);
        $display("byte       : %0d", f);
        $display("logic[4:0] : %b", g);
        $display("shortreal  : %f", h);
        $display("string     : \"%s\"", i);

        $display("\n======================================================");
        $display("OBSERVATION");
        $display("======================================================");
        $display("1. int, integer, shortint, longint, byte default to 0.");
        $display("2. bit defaults to all zeros (2-state type).");
        $display("3. logic defaults to X (4-state type).");
        $display("4. shortreal defaults to 0.0.");
        $display("5. string defaults to an empty string.");
        $display("6. Assigning X/Z to bit or byte converts them to 0.");
        $display("7. logic preserves X and Z values.");

    end

endmodule



