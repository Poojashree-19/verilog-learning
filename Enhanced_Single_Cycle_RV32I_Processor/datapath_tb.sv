`timescale 1ns/1ps

module datapath_tb;

    // -------------------------------------------------
    // Testbench Signals
    // -------------------------------------------------

    logic clk;
    logic reset;

    // -------------------------------------------------
    // Instantiate Design Under Test (DUT)
    // -------------------------------------------------

    datapath dut(

        .clk(clk),
        .reset(reset)

    );

    // -------------------------------------------------
    // Clock Generation
    // -------------------------------------------------

    initial begin

        clk = 0;

        forever #5 clk = ~clk;

    end

    // -------------------------------------------------
    // Monitor
    // -------------------------------------------------

    initial begin

        $monitor("Time = %0t | PC = %0d | Instruction = %h",
                  $time,
                  dut.pc,
                  dut.instruction);

    end

    // -------------------------------------------------
    // Test Sequence
    // -------------------------------------------------

    initial begin

        $dumpfile("datapath.vcd");
        $dumpvars(0, datapath_tb);

        $display("======================================");
        $display("Starting Datapath Test");
        $display("======================================");

        // Apply Reset
        reset = 1;
        #10;

        // Release Reset
        reset = 0;

        // Let processor execute instructions
        #100;

        $display("======================================");
        $display("Datapath Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
