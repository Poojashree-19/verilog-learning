module next_pc_logic(

    input  logic [31:0] pc,
    input  logic [31:0] branch_target,
    input  logic        branch_taken,

    output logic [31:0] next_pc

);

always_comb begin

    if (branch_taken)
        next_pc = branch_target;

    else
        next_pc = pc + 32'd4;

end

endmodule
