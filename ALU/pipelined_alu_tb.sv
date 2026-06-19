`timescale 1ns/1ps

module pipelined_alu_tb;

    logic clk;
    logic reset;

    logic [7:0] a;
    logic [7:0] b;
    logic [2:0] opcode;

    logic [7:0] result;

    // DUT
    pipelined_alu dut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
      $dumpfile("pipelined_alu.vcd");
      $dumpvars(0, pipelined_alu_tb);

        // Initialize signals
        clk    = 0;
        reset  = 1;
        a      = 0;
        b      = 0;
        opcode = 0;

        // Hold reset for one clock cycle
        #10;
        reset = 0;

        // Test 1 : ADD
        a = 8'd10;
        b = 8'd5;
        opcode = 3'd0;
        #10;

        // Test 2 : SUB
        a = 8'd20;
        b = 8'd3;
        opcode = 3'd1;
        #10;

        // Test 3 : AND
        a = 8'd12;
        b = 8'd10;
        opcode = 3'd2;
        #10;

        // Test 4 : OR
        a = 8'd12;
        b = 8'd10;
        opcode = 3'd3;
        #10;

        // Test 5 : XOR
        a = 8'd12;
        b = 8'd10;
        opcode = 3'd4;
        #10;

        $finish;

    end

endmodule
