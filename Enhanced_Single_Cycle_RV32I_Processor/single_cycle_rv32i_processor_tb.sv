`timescale 1ns/1ps

module processor_top_tb;

    logic clk;
    logic reset;

    // ----------------------------------------
    // Instantiate the Processor
    // ----------------------------------------

    processor_top dut (
        .clk(clk),
        .reset(reset)
    );

    // ----------------------------------------
    // Clock Generation
    // ----------------------------------------

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ----------------------------------------
    // Reset
    // ----------------------------------------

    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    // ----------------------------------------
    // Run Simulation
    // ----------------------------------------

    initial begin

        $dumpfile("processor.vcd");
        $dumpvars(0, processor_top_tb);

        #250;

        $display("----------------------------------------");
        $display("Simulation Finished");
        $display("----------------------------------------");

        $display("Cycle Count       = %0d", dut.cpu.cycle_count);
        $display("Instruction Count = %0d", dut.cpu.instruction_count);
        $display("Branch Count      = %0d", dut.cpu.branch_count);
        $display("Memory Count      = %0d", dut.cpu.memory_count);
        $display("AVG Count         = %0d", dut.cpu.avg_count);

        $finish;

    end

endmodule
