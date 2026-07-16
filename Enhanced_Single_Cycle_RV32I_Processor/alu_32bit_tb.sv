`timescale 1ns/1ps

module alu_32bit_tb;

    // -------------------------------------------------
    // Testbench Signals
    // -------------------------------------------------

    logic [31:0] operand_a;
    logic [31:0] operand_b;
    logic [3:0]  alu_control;

    logic [31:0] result;
    logic        Zero;

    // -------------------------------------------------
    // DUT
    // -------------------------------------------------

    alu_32bit dut (

        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_control(alu_control),

        .result(result),
        .Zero(Zero)

    );

    // -------------------------------------------------
    // Monitor
    // -------------------------------------------------

    initial begin

        $monitor("Time=%0t | A=%0d | B=%0d | ALU_Control=%b | Result=%0d | Zero=%b",
                 $time, operand_a, operand_b,
                 alu_control, result, Zero);

    end

    // -------------------------------------------------
    // Test Cases
    // -------------------------------------------------

    initial begin

        $dumpfile("alu_32bit.vcd");
        $dumpvars(0, alu_32bit_tb);

        $display("========================================");
        $display("Starting ALU Test");
        $display("========================================");

        // ADD
        operand_a   = 32'd20;
        operand_b   = 32'd10;
        alu_control = 4'b0000;
        #10;

        // SUB
        operand_a   = 32'd20;
        operand_b   = 32'd10;
        alu_control = 4'b0001;
        #10;

        // SUB (Zero Flag Test)
        operand_a   = 32'd20;
        operand_b   = 32'd20;
        alu_control = 4'b0001;
        #10;

        // AND
        operand_a   = 32'd12;
        operand_b   = 32'd10;
        alu_control = 4'b0010;
        #10;

        // OR
        operand_a   = 32'd12;
        operand_b   = 32'd10;
        alu_control = 4'b0011;
        #10;

        // XOR
        operand_a   = 32'd12;
        operand_b   = 32'd10;
        alu_control = 4'b0100;
        #10;

        // SLL
        operand_a   = 32'd8;
        operand_b   = 32'd2;
        alu_control = 4'b0101;
        #10;

        // SRL
        operand_a   = 32'd32;
        operand_b   = 32'd2;
        alu_control = 4'b0110;
        #10;

        // SRA
        operand_a   = -32'd16;
        operand_b   = 32'd2;
        alu_control = 4'b0111;
        #10;

        // SLT
        operand_a   = 32'd5;
        operand_b   = 32'd10;
        alu_control = 4'b1000;
        #10;

        // SLTU
        operand_a   = 32'd15;
        operand_b   = 32'd10;
        alu_control = 4'b1001;
        #10;

        $display("========================================");
        $display("ALU Test Completed");
        $display("========================================");

        $finish;

    end

endmodule
