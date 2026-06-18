`timescale 1ns/1ps

module flag_register_tb;

    logic clk;
    logic rst;

    logic z_flag;
    logic c_flag;
    logic v_flag;
    logic n_flag;
    logic p_flag;

    logic z_reg;
    logic c_reg;
    logic v_reg;
    logic n_reg;
    logic p_reg;

    // DUT
    flag_register dut (
        .clk(clk),
        .rst(rst),
        .z_flag(z_flag),
        .c_flag(c_flag),
        .v_flag(v_flag),
        .n_flag(n_flag),
        .p_flag(p_flag),
        .z_reg(z_reg),
        .c_reg(c_reg),
        .v_reg(v_reg),
        .n_reg(n_reg),
        .p_reg(p_reg)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Dump waveform
        $dumpfile("flag_register.vcd");
        $dumpvars(0, flag_register_tb);

        clk = 0;
        rst = 1;

        z_flag = 0;
        c_flag = 0;
        v_flag = 0;
        n_flag = 0;
        p_flag = 0;

        // Reset
        #10;
        rst = 0;

        // Test Case 1
        z_flag = 1;
        c_flag = 0;
        v_flag = 0;
        n_flag = 0;
        p_flag = 1;
        #10;

        // Test Case 2
        z_flag = 0;
        c_flag = 1;
        v_flag = 1;
        n_flag = 0;
        p_flag = 0;
        #10;

        // Test Case 3
        z_flag = 0;
        c_flag = 0;
        v_flag = 0;
        n_flag = 1;
        p_flag = 1;
        #10;

        $finish;

    end

endmodule
