`timescale 1ns/1ps

module instruction_memory_tb;

    // ---------------------------------------------
    // Testbench Signals
    // ---------------------------------------------

    logic [31:0] address;
    logic [31:0] instruction;

    // ---------------------------------------------
    // Instantiate DUT
    // ---------------------------------------------

    instruction_memory dut(

        .address(address),
        .instruction(instruction)

    );

    // ---------------------------------------------
    // Monitor
    // ---------------------------------------------

    initial begin

        $monitor("Time=%0t | Address=%0d | Instruction=%h",
                  $time, address, instruction);

    end

    // ---------------------------------------------
    // Test Cases
    // ---------------------------------------------

    initial begin

        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);

        $display("========================================");
        $display("Starting Instruction Memory Test");
        $display("========================================");

        // Instruction 0
        address = 32'd0;
        #10;

        // Instruction 1
        address = 32'd4;
        #10;

        // Instruction 2
        address = 32'd8;
        #10;

        // Instruction 3
        address = 32'd12;
        #10;

        // NOP Instructions
        address = 32'd16;
        #10;

        address = 32'd20;
        #10;

        address = 32'd24;
        #10;

        address = 32'd28;
        #10;

        $display("========================================");
        $display("Instruction Memory Test Completed");
        $display("========================================");

        $finish;

    end

endmodule
