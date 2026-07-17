`timescale 1ns/1ps

module datapath_tb;

    //--------------------------------------------------
    // Testbench Signals
    //--------------------------------------------------

    logic clk;
    logic reset;

    //--------------------------------------------------
    // Instantiate DUT
    //--------------------------------------------------

    datapath DUT (
        .clk(clk),
        .reset(reset)
    );

    //--------------------------------------------------
    // Clock Generation (10 ns period)
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
    // Waveform Dump
    //--------------------------------------------------

    initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, datapath_tb);
    end

    //--------------------------------------------------
    // Monitor Processor Operation
    //--------------------------------------------------

    initial begin

        $display("---------------------------------------------------------------------------------------------------------------");
        $display("Time\tPC\tInstruction\tALU_Result\tWB_Data\tZero\tPCSrc");
        $display("---------------------------------------------------------------------------------------------------------------");

        $monitor("%0t\t%h\t%h\t%h\t%h\t%b\t%b",

            $time,
            DUT.pc,
            DUT.instruction,
            DUT.alu_result,
            DUT.write_back_data,
            DUT.Zero,
            DUT.PCSrc
        );

    end

    //--------------------------------------------------
    // Wait for Program Completion
    //--------------------------------------------------

    initial begin

        #250;

        $display("\n=================================================");
        $display("FINAL REGISTER VALUES");
        $display("=================================================");

        $display("x0  = %0d", DUT.rf.registers[0]);
        $display("x1  = %0d", DUT.rf.registers[1]);
        $display("x2  = %0d", DUT.rf.registers[2]);
        $display("x3  = %0d", DUT.rf.registers[3]);
        $display("x4  = %0d", DUT.rf.registers[4]);
        $display("x5  = %0d", DUT.rf.registers[5]);
        $display("x6  = %0d", DUT.rf.registers[6]);
        $display("x7  = %0d", DUT.rf.registers[7]);
        $display("x8  = %0d", DUT.rf.registers[8]);
        $display("x9  = %0d", DUT.rf.registers[9]);

        $display("\n=================================================");
        $display("DATA MEMORY");
        $display("=================================================");

        $display("Memory[0] = %0d", DUT.dmem.memory[0]);

        $display("\n=================================================");
        $display("SELF CHECK");
        $display("=================================================");

        if (DUT.rf.registers[1] == 32'd5)
            $display("PASS : x1");
        else
            $display("FAIL : x1");

        if (DUT.rf.registers[2] == 32'd10)
            $display("PASS : x2");
        else
            $display("FAIL : x2");

        if (DUT.rf.registers[3] == 32'd15)
            $display("PASS : x3");
        else
            $display("FAIL : x3");

        if (DUT.rf.registers[4] == 32'd5)
            $display("PASS : x4");
        else
            $display("FAIL : x4");

        if (DUT.rf.registers[5] == 32'd0)
            $display("PASS : x5");
        else
            $display("FAIL : x5");

        if (DUT.rf.registers[6] == 32'd15)
            $display("PASS : x6");
        else
            $display("FAIL : x6");

        if (DUT.rf.registers[7] == 32'd15)
            $display("PASS : x7");
        else
            $display("FAIL : x7");

        if (DUT.rf.registers[8] == 32'd42)
            $display("PASS : x8");
        else
            $display("FAIL : x8");

        if (DUT.rf.registers[9] == 32'd7)
            $display("PASS : x9");
        else
            $display("FAIL : x9");

        if (DUT.dmem.memory[0] == 32'd15)
            $display("PASS : Memory[0]");
        else
            $display("FAIL : Memory[0]");

        $display("\n=================================================");
        $display("Simulation Completed");
        $display("=================================================");

        $finish;

    end

endmodule
