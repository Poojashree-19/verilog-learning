`timescale 1ns/1ps

module pipeline_reg_tb;

    logic clk;
    logic reset;
    logic stall;
    logic flush;

    logic [7:0] a;
    logic [7:0] b;
    logic [2:0] opcode;

    logic [7:0] a_reg;
    logic [7:0] b_reg;
    logic [2:0] opcode_reg;

    // DUT
    pipeline_reg dut (
        .clk(clk),
        .reset(reset),
        .stall(stall),
        .flush(flush),
        .a(a),
        .b(b),
        .opcode(opcode),
        .a_reg(a_reg),
        .b_reg(b_reg),
        .opcode_reg(opcode_reg)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        $dumpfile("pipeline_reg.vcd");
        $dumpvars(0, pipeline_reg_tb);

        // Initialize
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

        // -------------------------
        // Test 1 : Normal Load
        // -------------------------
        a = 8'd10;
        b = 8'd5;
        opcode = 3'd0;
        #10;

        // -------------------------
        // Test 2 : Stall
        // -------------------------
        stall = 1;

        a = 8'd20;
        b = 8'd3;
        opcode = 3'd1;
        #10;

        stall = 0;

        // -------------------------
        // Test 3 : Load After Stall
        // -------------------------
        #10;

        // -------------------------
        // Test 4 : Flush
        // -------------------------
        flush = 1;
        #10;

        flush = 0;

        // -------------------------
        // Test 5 : New Data
        // -------------------------
        a = 8'd15;
        b = 8'd7;
        opcode = 3'd2;
        #10;

        $finish;

    end

endmodule
