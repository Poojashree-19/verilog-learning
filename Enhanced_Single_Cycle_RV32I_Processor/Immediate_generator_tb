`timescale 1ns/1ps

module immediate_generator_tb;

  

    logic [31:0] instruction;
    logic [31:0] immediate;

    

    immediate_generator dut (
        .instruction(instruction),
        .immediate(immediate)
    );


    initial begin
        $monitor("Time=%0t | Instruction=%h | Immediate=%0d",
                  $time, instruction, immediate);
    end

  
    initial begin

        $dumpfile("immediate_generator.vcd");
        $dumpvars(0, immediate_generator_tb);

        $display("======================================");
        $display("Starting Immediate Generator Test");
        $display("======================================");

        // -----------------------------------------
        // Test Case 1 : ADDI (I-Type)
        // Immediate = 25
        // -----------------------------------------
        instruction = 32'h01908293;
        #10;

        // -----------------------------------------
        // Test Case 2 : LW (I-Type)
        // Immediate = 8
        // -----------------------------------------
        instruction = 32'h00812303;
        #10;

        // -----------------------------------------
        // Test Case 3 : SW (S-Type)
        // Immediate = 12
        // -----------------------------------------
        instruction = 32'h00512623;
        #10;

        // -----------------------------------------
        // Test Case 4 : BEQ (B-Type)
        // Branch Offset = 8
        // -----------------------------------------
        instruction = 32'h00208463;
        #10;

        // -----------------------------------------
        // Test Case 5 : Unsupported Opcode
        // -----------------------------------------
        instruction = 32'hFFFFFFFF;
        #10;

        $display("======================================");
        $display("Immediate Generator Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
