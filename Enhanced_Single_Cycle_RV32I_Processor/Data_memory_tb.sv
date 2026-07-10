`timescale 1ns/1ps

module data_memory_tb;

    // ---------------------------------------------
    // Testbench Signals
    // ---------------------------------------------

    logic        clk;
    logic        MemRead;
    logic        MemWrite;

    logic [31:0] address;
    logic [31:0] write_data;

    logic [31:0] read_data;

    // ---------------------------------------------
    // Instantiate Design Under Test (DUT)
    // ---------------------------------------------

    data_memory dut (

        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)

    );

    // ---------------------------------------------
    // Clock Generation
    // ---------------------------------------------

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ---------------------------------------------
    // Monitor Signals
    // ---------------------------------------------

    initial begin

        $monitor("Time=%0t | Address=%0d | Write_Data=%0d | MemRead=%b | MemWrite=%b | Read_Data=%0d",
                  $time, address, write_data, MemRead, MemWrite, read_data);

    end

    // ---------------------------------------------
    // Test Cases
    // ---------------------------------------------

    initial begin

        $dumpfile("data_memory.vcd");
        $dumpvars(0, data_memory_tb);

        $display("======================================");
        $display("Starting Data Memory Test");
        $display("======================================");

        // Initialize signals
        MemRead   = 0;
        MemWrite  = 0;
        address   = 0;
        write_data = 0;

        // -----------------------------------------
        // Test Case 1 : Write 250 to Address 108
        // -----------------------------------------

        address    = 32'd108;
        write_data = 32'd250;
        MemWrite   = 1;
        #10;

        MemWrite = 0;

        // -----------------------------------------
        // Test Case 2 : Read from Address 108
        // -----------------------------------------

        MemRead = 1;
        #10;

        MemRead = 0;

        // -----------------------------------------
        // Test Case 3 : Write 500 to Address 80
        // -----------------------------------------

        address    = 32'd80;
        write_data = 32'd500;
        MemWrite   = 1;
        #10;

        MemWrite = 0;

        // -----------------------------------------
        // Test Case 4 : Read from Address 80
        // -----------------------------------------

        MemRead = 1;
        #10;

        MemRead = 0;

        // -----------------------------------------
        // Test Case 5 : Read Disabled
        // -----------------------------------------

        address = 32'd108;
        #10;

        $display("======================================");
        $display("Data Memory Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
