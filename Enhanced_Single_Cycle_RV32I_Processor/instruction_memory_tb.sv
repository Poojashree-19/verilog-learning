`timescale 1ns/1ps

module instruction_memory_tb;

   
    logic [31:0] address;
    logic [31:0] instruction;

    instruction_memory dut (
        .address(address),
        .instruction(instruction)
    );

    initial begin
        $monitor("Time=%0t | Address=%0d | Instruction=%h",
                 $time, address, instruction);
    end

    

    initial begin

        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);

        $display("======================================");
        $display("Starting Instruction Memory Test");
        $display("======================================");

        // Test Case 1 : Fetch Instruction at Address 0
        address = 32'd0;
        #10;

        // Test Case 2 : Fetch Instruction at Address 4
        address = 32'd4;
        #10;

        // Test Case 3 : Fetch Instruction at Address 8
        address = 32'd8;
        #10;

        // Test Case 4 : Fetch Instruction at Address 12
        address = 32'd12;
        #10;

        $display("======================================");
        $display("Instruction Memory Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
