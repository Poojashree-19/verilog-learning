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
