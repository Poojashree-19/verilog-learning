module final_pipelined_alu(

    input  logic       clk,
    input  logic       reset,
    input  logic       stall,
    input  logic       flush,

    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [2:0] opcode,

    output logic [7:0] result,

    output logic z_reg,
    output logic c_reg,
    output logic v_reg,
    output logic n_reg,
    output logic p_reg

);

    // Pipeline Register Outputs
    logic [7:0] a_pipe;
    logic [7:0] b_pipe;
    logic [2:0] opcode_pipe;

    // ALU Outputs
    logic [7:0] result_comb;

    logic z_flag;
    logic c_flag;
    logic v_flag;
    logic n_flag;
    logic p_flag;

    // ==========================
    // Pipeline Register
    // ==========================
    pipeline_reg pipe0(

        .clk(clk),
        .reset(reset),
        .stall(stall),
        .flush(flush),

        .a(a),
        .b(b),
        .opcode(opcode),

        .a_reg(a_pipe),
        .b_reg(b_pipe),
        .opcode_reg(opcode_pipe)

    );

    // ==========================
    // ALU
    // ==========================
    alu_8bit alu0(

        .a(a_pipe),
        .b(b_pipe),
        .opcode(opcode_pipe),

        .result(result_comb),

        .z_flag(z_flag),
        .c_flag(c_flag),
        .v_flag(v_flag),
        .n_flag(n_flag),
        .p_flag(p_flag)

    );

    // ==========================
    // Result Register
    // ==========================
    always_ff @(posedge clk) begin

        if(reset)
            result <= 8'd0;

        else
            result <= result_comb;

    end

    // ==========================
    // Flag Register
    // ==========================
    flag_register flag0(

        .clk(clk),
        .rst(reset),

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

endmodule
