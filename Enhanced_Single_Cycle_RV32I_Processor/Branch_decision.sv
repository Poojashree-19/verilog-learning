module branch_decision(

    input  logic Branch,
    input  logic Zero,

    output logic PCSrc

);

    assign PCSrc = Branch & Zero;

endmodule
