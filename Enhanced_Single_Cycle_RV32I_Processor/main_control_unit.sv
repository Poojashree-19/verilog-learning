module main_control_unit(

    input logic [6:0] opcode,

    output logic RegWrite,
    output logic MemRead,
    output logic MemWrite,
    output logic Branch,
    output logic ALUSrc,
    output logic MemtoReg,
    output logic [1:0] ALUOp

);

always_comb begin

    // Default Values
    RegWrite = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    Branch   = 1'b0;
    ALUSrc   = 1'b0;
    MemtoReg = 1'b0;
    ALUOp    = 2'b00;

    case (opcode)

        // -----------------------------------------
        // R-Type Instructions
        // ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU
        // -----------------------------------------
        7'b0110011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b0;
            ALUOp    = 2'b10;
        end

        // -----------------------------------------
        // Load Word (LW)
        // -----------------------------------------
        7'b0000011: begin
            RegWrite = 1'b1;
            MemRead  = 1'b1;
            ALUSrc   = 1'b1;
            MemtoReg = 1'b1;
            ALUOp    = 2'b00;
        end

        // -----------------------------------------
        // Store Word (SW)
        // -----------------------------------------
        7'b0100011: begin
            MemWrite = 1'b1;
            ALUSrc   = 1'b1;
            ALUOp    = 2'b00;
        end

        // -----------------------------------------
        // Branch Equal (BEQ)
        // -----------------------------------------
        7'b1100011: begin
            Branch = 1'b1;
            ALUSrc = 1'b0;
            ALUOp  = 2'b01;
        end

        // -----------------------------------------
        // ADD Immediate (ADDI)
        // -----------------------------------------
        7'b0010011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b1;
            ALUOp    = 2'b11;
        end

        // -----------------------------------------
        // Default
        // -----------------------------------------
        default: begin
            RegWrite = 1'b0;
            MemRead  = 1'b0;
            MemWrite = 1'b0;
            Branch   = 1'b0;
            ALUSrc   = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b00;
        end

    endcase

end

endmodule
