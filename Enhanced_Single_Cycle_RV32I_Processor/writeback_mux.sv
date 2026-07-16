module writeback_mux(

    input logic MemtoReg,

    input logic [31:0] alu_result,
    input logic [31:0] memory_data,

    output logic [31:0] write_back_data

);

    assign write_back_data =
        (MemtoReg) ? memory_data : alu_result;

endmodule
