`timescale 1ns/1ps

module writeback_mux_tb;

    // ---------------------------------------------
    // Testbench Signals
    // ---------------------------------------------

    logic        MemtoReg;
    logic [31:0] alu_result;
    logic [31:0] memory_data;

    logic [31:0] write_back_data;

    // ---------------------------------------------
    // Instantiate Design Under Test (DUT)
    // ---------------------------------------------

    writeback_mux dut (

        .MemtoReg(MemtoReg),
        .alu_result(alu_result),
        .memory_data(memory_data),
        .write_back_data(write_back_data)

    );

    // ---------------------------------------------
    // Monitor Signals
    // ---------------------------------------------

    initial begin

        $monitor("Time=%0t | MemtoReg=%b | ALU_Result=%0d | Memory_Data=%0d | Write_Back_Data=%0d",
                  $time, MemtoReg, alu_result, memory_data, write_back_data);

    end

    // ---------------------------------------------
    // Test Cases
    // ---------------------------------------------

    initial begin

        $dumpfile("writeback_mux.vcd");
        $dumpvars(0, writeback_mux_tb);

        $display("==========================================");
        $display("Starting Writeback MUX Test");
        $display("==========================================");

        // -----------------------------------------
        // Test Case 1
        // Select ALU Result
        // -----------------------------------------

        MemtoReg   = 1'b0;
        alu_result = 32'd35;
        memory_data = 32'd250;
        #10;

        // -----------------------------------------
        // Test Case 2
        // Select Memory Data
        // -----------------------------------------

        MemtoReg   = 1'b1;
        alu_result = 32'd35;
        memory_data = 32'd250;
        #10;

        // -----------------------------------------
        // Test Case 3
        // Different Values
        // -----------------------------------------

        MemtoReg   = 1'b0;
        alu_result = 32'd999;
        memory_data = 32'd111;
        #10;

        // -----------------------------------------
        // Test Case 4
        // Different Values
        // -----------------------------------------

        MemtoReg   = 1'b1;
        alu_result = 32'd999;
        memory_data = 32'd111;
        #10;

        $display("==========================================");
        $display("Writeback MUX Test Completed");
        $display("==========================================");

        $finish;

    end

endmodule
