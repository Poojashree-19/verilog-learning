module instruction_memory(

    input  logic [31:0] address,

    output logic [31:0] instruction

);

   

    logic [31:0] memory [0:255];


    initial begin

      

        memory[0] = 32'h00100093;   // ADDI x1, x0, 1
        memory[1] = 32'h00208133;   // ADD  x2, x1, x2
        memory[2] = 32'h00012083;   // LW   x1, 0(x2)
        memory[3] = 32'h00208463;   // BEQ  x1, x2, Branch

    end

    

    assign instruction = memory[address[31:2]];

endmodule
