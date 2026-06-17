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

    calc_out  = 9'd0;
    result = 8'd0;

    case(opcode)

        3'b000: begin          // ADD
            calc_out = a + b;
            result = temp[7:0];
        end

        3'b001: begin          // SUB
            calc_out  = a - b;
            result = temp[7:0];
        end

        3'b010: begin          // AND
            result = a & b;
        end

        3'b011: begin          // OR
            result = a | b;
        end

        3'b100: begin          // XOR
            result = a ^ b;
        end

        default: begin
            result = 8'd0;
        end

    endcase

    // Zero Flag
    if(result == 8'd0)
        z_flag = 1'b1;
    else
        z_flag = 1'b0;

    // Negative Flag
    n_flag = result[7];

    // Carry Flag (only for addition)
    if(opcode == 3'b000)
        c_flag = temp[8];
    else
        c_flag = 1'b0;

    // Overflow Flag
    if(opcode == 3'b000)
        v_flag = (~(a[7] ^ b[7])) & (a[7] ^ result[7]);
    else if(opcode == 3'b001)
        v_flag = (a[7] ^ b[7]) & (a[7] ^ result[7]);
    else
        v_flag = 1'b0;

    // Parity Flag (even parity)
    p_flag = ~^result;

end

endmodule
