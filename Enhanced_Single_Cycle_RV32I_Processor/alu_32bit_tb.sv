`timescale 1ns/1ps

module alu_32bit_tb;

    logic [31:0] operand_a;
    logic [31:0] operand_b;
    logic [3:0]  alu_control;

    logic [31:0] result;

    alu_32bit dut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_control(alu_control),
        .result(result)
    );

    

    initial begin
        $monitor("Time=%0t | ALU_Control=%b | A=%0d | B=%0d | Result=%0d",
                 $time, alu_control, operand_a, operand_b, result);
    end

    
    initial begin

        $dumpfile("alu_32bit.vcd");
        $dumpvars(0, alu_32bit_tb);

        $display("======================================");
        $display("Starting ALU Test");
        $display("======================================");

        // -----------------------------------------
        // Test Case 1 : ADD
        // 25 + 15 = 40
        // -----------------------------------------
        operand_a   = 32'd25;
        operand_b   = 32'd15;
        alu_control = 4'b0000;
        #10;

        // -----------------------------------------
        // Test Case 2 : SUB
        // 25 - 15 = 10
        // -----------------------------------------
        alu_control = 4'b0001;
        #10;

        // -----------------------------------------
        // Test Case 3 : AND
        // 12 & 10 = 8
        // -----------------------------------------
        operand_a   = 32'd12;
        operand_b   = 32'd10;
        alu_control = 4'b0010;
        #10;

        // -----------------------------------------
        // Test Case 4 : OR
        // 12 | 5 = 13
        // -----------------------------------------
        operand_a   = 32'd12;
        operand_b   = 32'd5;
        alu_control = 4'b0011;
        #10;

        // -----------------------------------------
        // Test Case 5 : XOR
        // 12 ^ 10 = 6
        // -----------------------------------------
        operand_a   = 32'd12;
        operand_b   = 32'd10;
        alu_control = 4'b0100;
        #10;

        // -----------------------------------------
        // Test Case 6 : SLL
        // 8 << 2 = 32
        // -----------------------------------------
        operand_a   = 32'd8;
        operand_b   = 32'd2;
        alu_control = 4'b0101;
        #10;

        // -----------------------------------------
        // Test Case 7 : SRL
        // 32 >> 2 = 8
        // -----------------------------------------
        operand_a   = 32'd32;
        operand_b   = 32'd2;
        alu_control = 4'b0110;
        #10;

        // -----------------------------------------
        // Test Case 8 : SRA
        // -8 >>> 1 = -4
        // -----------------------------------------
        operand_a   = -32'd8;
        operand_b   = 32'd1;
        alu_control = 4'b0111;
        #10;

        // -----------------------------------------
        // Test Case 9 : SLT (Signed)
        // 5 < 10 -> 1
        // -----------------------------------------
        operand_a   = 32'd5;
        operand_b   = 32'd10;
        alu_control = 4'b1000;
        #10;

        // -----------------------------------------
        // Test Case 10 : SLTU (Unsigned)
        // 15 < 10 -> 0
        // -----------------------------------------
        operand_a   = 32'd15;
        operand_b   = 32'd10;
        alu_control = 4'b1001;
        #10;

        // -----------------------------------------
        // Test Case 11 : Invalid ALU Control
        // -----------------------------------------
        alu_control = 4'b1111;
        #10;

        $display("======================================");
        $display("ALU Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
