`timescale 1ns/1ps

module main_control_unit_tb;

    // ---------------------------------------------
    // Testbench Signals
    // ---------------------------------------------

    logic [6:0] opcode;

    logic RegWrite;
    logic MemRead;
    logic MemWrite;
    logic Branch;
    logic ALUSrc;
    logic MemtoReg;
    logic [1:0] ALUOp;

    // ---------------------------------------------
    // Instantiate Design Under Test (DUT)
    // ---------------------------------------------

    main_control_unit dut (

        .opcode(opcode),

        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp)

    );

    // ---------------------------------------------
    // Monitor Signals
    // ---------------------------------------------

    initial begin

        $monitor("Time=%0t | Opcode=%b | RegWrite=%b | MemRead=%b | MemWrite=%b | Branch=%b | ALUSrc=%b | MemtoReg=%b | ALUOp=%b",
                 $time, opcode, RegWrite, MemRead, MemWrite,
                 Branch, ALUSrc, MemtoReg, ALUOp);

    end

    // ---------------------------------------------
    // Test Cases
    // ---------------------------------------------

    initial begin

        $dumpfile("main_control_unit.vcd");
        $dumpvars(0, main_control_unit_tb);

        $display("======================================");
        $display("Starting Main Control Unit Test");
        $display("======================================");

        // -----------------------------------------
        // Test Case 1 : R-Type
        // Opcode = 0110011
        // -----------------------------------------

        opcode = 7'b0110011;
        #10;

        // -----------------------------------------
        // Test Case 2 : Load Word (LW)
        // Opcode = 0000011
        // -----------------------------------------

        opcode = 7'b0000011;
        #10;

        // -----------------------------------------
        // Test Case 3 : Store Word (SW)
        // Opcode = 0100011
        // -----------------------------------------

        opcode = 7'b0100011;
        #10;

        // -----------------------------------------
        // Test Case 4 : Branch Equal (BEQ)
        // Opcode = 1100011
        // -----------------------------------------

        opcode = 7'b1100011;
        #10;

        // -----------------------------------------
        // Test Case 5 : ADD Immediate (ADDI)
        // Opcode = 0010011
        // -----------------------------------------

        opcode = 7'b0010011;
        #10;

        // -----------------------------------------
        // Test Case 6 : Invalid Opcode
        // -----------------------------------------

        opcode = 7'b1111111;
        #10;

        $display("======================================");
        $display("Main Control Unit Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
