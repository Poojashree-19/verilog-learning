`timescale 1ns/1ps

module alu_control_tb;

    // ---------------------------------------------
    // Testbench Signals
    // ---------------------------------------------

    logic [1:0] ALUOp;
    logic [2:0] funct3;
    logic [6:0] funct7;

    logic [3:0] alu_control;

    // ---------------------------------------------
    // DUT
    // ---------------------------------------------

    alu_control dut(

        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control)

    );

    // ---------------------------------------------
    // Monitor
    // ---------------------------------------------

    initial begin

        $monitor("Time=%0t | ALUOp=%b | funct3=%b | funct7=%b | alu_control=%b",
                  $time, ALUOp, funct3, funct7, alu_control);

    end

    // ---------------------------------------------
    // Test Cases
    // ---------------------------------------------

    initial begin

        $dumpfile("alu_control.vcd");
        $dumpvars(0, alu_control_tb);

        $display("======================================");
        $display("Starting ALU Control Test");
        $display("======================================");

        // ---------------------------------------------
        // LW / SW
        // ---------------------------------------------

        ALUOp  = 2'b00;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;

        // ---------------------------------------------
        // BEQ
        // ---------------------------------------------

        ALUOp  = 2'b01;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;

        // ---------------------------------------------
        // ADD
        // ---------------------------------------------

        ALUOp  = 2'b10;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;

        // SUB

        ALUOp  = 2'b10;
        funct3 = 3'b000;
        funct7 = 7'b0100000;
        #10;

        // SLL

        ALUOp  = 2'b10;
        funct3 = 3'b001;
        funct7 = 7'b0000000;
        #10;

        // SLT

        ALUOp  = 2'b10;
        funct3 = 3'b010;
        funct7 = 7'b0000000;
        #10;

        // SLTU

        ALUOp  = 2'b10;
        funct3 = 3'b011;
        funct7 = 7'b0000000;
        #10;

        // XOR

        ALUOp  = 2'b10;
        funct3 = 3'b100;
        funct7 = 7'b0000000;
        #10;

        // SRL

        ALUOp  = 2'b10;
        funct3 = 3'b101;
        funct7 = 7'b0000000;
        #10;

        // SRA

        ALUOp  = 2'b10;
        funct3 = 3'b101;
        funct7 = 7'b0100000;
        #10;

        // OR

        ALUOp  = 2'b10;
        funct3 = 3'b110;
        funct7 = 7'b0000000;
        #10;

        // AND

        ALUOp  = 2'b10;
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        #10;

        // ---------------------------------------------
        // I-Type Instructions
        // ---------------------------------------------

        // ADDI

        ALUOp  = 2'b11;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;

        // SLLI

        ALUOp  = 2'b11;
        funct3 = 3'b001;
        funct7 = 7'b0000000;
        #10;

        // SLTI

        ALUOp  = 2'b11;
        funct3 = 3'b010;
        funct7 = 7'b0000000;
        #10;

        // SLTIU

        ALUOp  = 2'b11;
        funct3 = 3'b011;
        funct7 = 7'b0000000;
        #10;

        // XORI

        ALUOp  = 2'b11;
        funct3 = 3'b100;
        funct7 = 7'b0000000;
        #10;

        // SRLI

        ALUOp  = 2'b11;
        funct3 = 3'b101;
        funct7 = 7'b0000000;
        #10;

        // SRAI

        ALUOp  = 2'b11;
        funct3 = 3'b101;
        funct7 = 7'b0100000;
        #10;

        // ORI

        ALUOp  = 2'b11;
        funct3 = 3'b110;
        funct7 = 7'b0000000;
        #10;

        // ANDI

        ALUOp  = 2'b11;
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        #10;

        $display("======================================");
        $display("ALU Control Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
