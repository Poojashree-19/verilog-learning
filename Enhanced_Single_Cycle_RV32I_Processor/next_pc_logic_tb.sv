`timescale 1ns/1ps

module next_pc_logic_tb;

    

    logic [31:0] pc;
    logic [31:0] branch_target;
    logic        branch_taken;
    logic [31:0] next_pc;


    next_pc_logic dut (
        .pc(pc),
        .branch_target(branch_target),
        .branch_taken(branch_taken),
        .next_pc(next_pc)
    );


    initial begin
        $monitor("Time=%0t | PC=%0d | Branch_Target=%0d | Branch_Taken=%b | Next_PC=%0d",
                  $time, pc, branch_target, branch_taken, next_pc);
    end


    initial begin

        $dumpfile("next_pc_logic.vcd");
        $dumpvars(0, next_pc_logic_tb);

        $display("======================================");
        $display("Starting Next PC Logic Test");
        $display("======================================");

        // Test Case 1 : Branch NOT Taken
        pc            = 32'd20;
        branch_target = 32'd100;
        branch_taken  = 1'b0;
        #10;

        // Test Case 2 : Branch Taken
        branch_taken  = 1'b1;
        #10;

        // Test Case 3 : New PC, Branch NOT Taken
        pc            = 32'd40;
        branch_target = 32'd200;
        branch_taken  = 1'b0;
        #10;

        // Test Case 4 : Branch Taken
        branch_taken  = 1'b1;
        #10;

        $display("======================================");
        $display("Next PC Logic Test Completed");
        $display("======================================");

        $finish;

    end

endmodule
