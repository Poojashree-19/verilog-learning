module pipeline_reg (

    input  logic        clk,
    input  logic        reset,

    input  logic [7:0]  a,
    input  logic [7:0]  b,
    input  logic [2:0]  opcode,

    output logic [7:0]  a_reg,
    output logic [7:0]  b_reg,
    output logic [2:0]  opcode_reg

);

always_ff @(posedge clk) begin

    if (reset) begin
        a_reg      <= 8'd0;
        b_reg      <= 8'd0;
        opcode_reg <= 3'd0;
    end

    else begin
        a_reg      <= a;
        b_reg      <= b;
        opcode_reg <= opcode;
    end

end

endmodule
