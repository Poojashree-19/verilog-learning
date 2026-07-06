`timescale 1ns/1ps

module program_counter_tb;

   
    logic clk;
    logic reset;
    logic [31:0] next_pc;
    logic [31:0] pc;

    program_counter dut (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

   
    initial begin
        $monitor("Time=%0t | Reset=%b | Next_PC=%0d | PC=%0d",
                 $time, reset, next_pc, pc);
    end

  
    initial begin
      $dumpfile("program_counter.vcd");
      $dumpvars(0, program_counter_tb);

        $display("======================================");
        $display("Starting Program Counter Test");
        $display("======================================");

        reset   = 1;
        next_pc = 32'd0;

        #10;

        reset = 0;

        // Normal execution
        next_pc = 32'd4;
        #10;

        next_pc = 32'd8;
        #10;

        next_pc = 32'd12;
        #10;

        // Simulate branch
        next_pc = 32'd40;
        #10;

        next_pc = 32'd44;
        #10;

        $display("======================================");
        $display("Program Counter Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
