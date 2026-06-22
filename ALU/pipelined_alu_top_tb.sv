`timescale 1ns/1ps

module final_pipelined_alu_tb;

    logic clk;
    logic reset;
    logic stall;
    logic flush;

    logic [7:0] a;
    logic [7:0] b;
    logic [2:0] opcode;

    logic [7:0] result;

    logic z_reg;
    logic c_reg;
    logic v_reg;
    logic n_reg;
    logic p_reg;

    // DUT
    final_pipelined_alu dut(

        .clk(clk),
        .reset(reset),
        .stall(stall),
        .flush(flush),

        .a(a),
        .b(b),
        .opcode(opcode),

        .result(result),

        .z_reg(z_reg),
        .c_reg(c_reg),
        .v_reg(v_reg),
        .n_reg(n_reg),
        .p_reg(p_reg)

    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("final_pipelined_alu.vcd");
        $dumpvars(0, final_pipelined_alu_tb);

        clk    = 0;
        reset  = 1;
        stall  = 0;
        flush  = 0;

        a      = 0;
        b      = 0;
        opcode = 0;

        // Reset
        #10;
        reset = 0;

        // --------------------
        // Test 1 : ADD
        // --------------------
        a = 8'd10;
        b = 8'd5;
        opcode = 3'b000;
        #10;

        // --------------------
        // Test 2 : SUB
        // --------------------
        a = 8'd20;
        b = 8'd10;
        opcode = 3'b001;
        #10;

        // --------------------
        // Test 3 : AND
        // --------------------
        a = 8'b10101010;
        b = 8'b11001100;
        opcode = 3'b010;
        #10;

        // --------------------
        // Test 4 : Zero Flag
        // --------------------
        a = 8'd5;
        b = 8'd5;
        opcode = 3'b001;
        #10;

        // --------------------
        // Test 5 : Carry Flag
        // --------------------
        a = 8'd255;
        b = 8'd1;
        opcode = 3'b000;
        #10;

        // --------------------
        // Test 6 : Overflow Flag
        // --------------------
        a = 8'd127;
        b = 8'd1;
        opcode = 3'b000;
        #10;

        // --------------------
        // Test 7 : Stall
        // --------------------
        stall = 1;

        a = 8'd50;
        b = 8'd20;
        opcode = 3'b000;
        #10;

        stall = 0;
        #10;

        // --------------------
        // Test 8 : Flush
        // --------------------
        flush = 1;
        #10;

        flush = 0;

        // --------------------
        // Test 9 : New Data
        // --------------------
        a = 8'd15;
        b = 8'd7;
        opcode = 3'b000;
        #10;

        $finish;

    end

endmodule
