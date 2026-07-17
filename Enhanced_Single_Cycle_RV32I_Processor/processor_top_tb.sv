`timescale 1ns/1ps

module processor_top_tb;

    logic clk;
    logic reset;

    //--------------------------------------------------
    // Instantiate Processor
    //--------------------------------------------------

    processor_top DUT(

        .clk(clk),
        .reset(reset)

    );

    //--------------------------------------------------
    // Clock Generation
    //--------------------------------------------------

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //--------------------------------------------------
    // Reset
    //--------------------------------------------------

    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    //--------------------------------------------------
    // Waveform
    //--------------------------------------------------

    initial begin
        $dumpfile("processor_top.vcd");
        $dumpvars(0, processor_top_tb);
    end

    //--------------------------------------------------
    // Monitor
    //--------------------------------------------------

    initial begin

        $display("-------------------------------------------------------------");
        $display("Time\tPC\tInstruction\tALU Result");
        $display("-------------------------------------------------------------");

        $monitor("%0t\t%h\t%h\t%h",

            $time,
            DUT.cpu.pc,
            DUT.cpu.instruction,
            DUT.cpu.alu_result

        );

    end

    //--------------------------------------------------
    // Final Results
    //--------------------------------------------------

    initial begin

        #250;

        $display("\n========== FINAL REGISTER VALUES ==========");

        $display("x1 = %0d", DUT.cpu.rf.registers[1]);
        $display("x2 = %0d", DUT.cpu.rf.registers[2]);
        $display("x3 = %0d", DUT.cpu.rf.registers[3]);
        $display("x4 = %0d", DUT.cpu.rf.registers[4]);
        $display("x5 = %0d", DUT.cpu.rf.registers[5]);
        $display("x6 = %0d", DUT.cpu.rf.registers[6]);
        $display("x7 = %0d", DUT.cpu.rf.registers[7]);
        $display("x8 = %0d", DUT.cpu.rf.registers[8]);
        $display("x9 = %0d", DUT.cpu.rf.registers[9]);

        $display("\nMemory[0] = %0d", DUT.cpu.dmem.memory[0]);

        $finish;

    end

endmodule
