`timescale 1ns/1ps

module register_file_tb;

    logic        clk;
    logic        reset;

    logic [4:0]  rs1;
    logic [4:0]  rs2;
    logic [4:0]  rd;

    logic [31:0] write_data;
    logic        reg_write;

    logic [31:0] read_data1;
    logic [31:0] read_data2;

    register_file dut (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time=%0t | Reset=%b | Reg_Write=%b | RD=%0d | Write_Data=%0d | RS1=%0d | Read_Data1=%0d | RS2=%0d | Read_Data2=%0d",
                 $time, reset, reg_write, rd, write_data,
                 rs1, read_data1, rs2, read_data2);
    end


    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        $display("======================================");
        $display("Starting Register File Test");
        $display("======================================");

        // Reset the register file
        reset = 1;
        reg_write = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;

        #10;

        reset = 0;

        // -----------------------------------------
        // Test Case 1 : Write 100 into x5
        // -----------------------------------------
        rd = 5;
        write_data = 32'd100;
        reg_write = 1;
        #10;

        // Read x5
        reg_write = 0;
        rs1 = 5;
        #10;

        // -----------------------------------------
        // Test Case 2 : Write 250 into x10
        // -----------------------------------------
        rd = 10;
        write_data = 32'd250;
        reg_write = 1;
        #10;

        // Read x10
        reg_write = 0;
        rs2 = 10;
        #10;

        // -----------------------------------------
        // Test Case 3 : Try writing to x0
        // -----------------------------------------
        rd = 0;
        write_data = 32'd999;
        reg_write = 1;
        #10;

        // Read x0
        reg_write = 0;
        rs1 = 0;
        #10;

        $display("======================================");
        $display("Register File Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
