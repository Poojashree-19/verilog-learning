module pipeline_reg (

    input  logic       clk,
    input  logic       reset,
    input  logic       stall,
    input  logic       flush,

    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [2:0] opcode,

    output logic [7:0] a_reg,
    output logic [7:0] b_reg,
    output logic [2:0] opcode_reg

);

always_ff @(posedge clk) begin

    if (reset) begin
        a_reg      <= 8'd0;
        b_reg      <= 8'd0;
        opcode_reg <= 3'd0;
    end

    else if (flush) begin
        a_reg      <= 8'd0;
        b_reg      <= 8'd0;
        opcode_reg <= 3'd0;
    end

    else if (stall) begin
        a_reg      <= a_reg;
        b_reg      <= b_reg;
        opcode_reg <= opcode_reg;
    end

    else begin
        a_reg      <= a;
        b_reg      <= b;
        opcode_reg <= opcode;
    end

end

endmodule


module alu_8bit(

    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic [2:0] opcode,

    output logic [7:0] result,

    output logic z_flag,
    output logic c_flag,
    output logic v_flag,
    output logic n_flag,
    output logic p_flag

);

logic [8:0] calc_out;

always_comb begin

    calc_out = 9'd0;
    result   = 8'd0;

    case(opcode)

        3'b000: begin
            calc_out = a + b;
            result   = calc_out[7:0];
        end

        3'b001: begin
            calc_out = a - b;
            result   = calc_out[7:0];
        end

        3'b010: result = a & b;

        3'b011: result = a | b;

        3'b100: result = a ^ b;

        default: result = 8'd0;

    endcase

    if(result == 8'd0)
        z_flag = 1'b1;
    else
        z_flag = 1'b0;

    n_flag = result[7];

    if(opcode == 3'b000)
        c_flag = calc_out[8];
    else
        c_flag = 1'b0;

    if(opcode == 3'b000)
        v_flag = (~(a[7] ^ b[7])) & (a[7] ^ result[7]);
    else if(opcode == 3'b001)
        v_flag = (a[7] ^ b[7]) & (a[7] ^ result[7]);
    else
        v_flag = 1'b0;

    p_flag = ~^result;

end

endmodule


module flag_register(

    input  logic clk,
    input  logic rst,

    input  logic z_flag,
    input  logic c_flag,
    input  logic v_flag,
    input  logic n_flag,
    input  logic p_flag,

    output logic z_reg,
    output logic c_reg,
    output logic v_reg,
    output logic n_reg,
    output logic p_reg

);

always_ff @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        z_reg <= 1'b0;
        c_reg <= 1'b0;
        v_reg <= 1'b0;
        n_reg <= 1'b0;
        p_reg <= 1'b0;
    end

    else
    begin
        z_reg <= z_flag;
        c_reg <= c_flag;
        v_reg <= v_flag;
        n_reg <= n_flag;
        p_reg <= p_flag;
    end

end

endmodule


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

    logic [7:0] a_pipe;
    logic [7:0] b_pipe;
    logic [2:0] opcode_pipe;

    logic [7:0] result_comb;

    logic z_flag;
    logic c_flag;
    logic v_flag;
    logic n_flag;
    logic p_flag;

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

    always_ff @(posedge clk) begin
        if(reset)
            result <= 8'd0;
        else
            result <= result_comb;
    end

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
