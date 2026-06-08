module testbench;

reg clk;
reg reset;

wire [1:0] light;

traffic_light_fsm uut(
    .clk(clk),
    .reset(reset),
    .light(light)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0,testbench);

    clk = 0;
    reset = 1;

    #10 reset = 0;

    #100;

    $finish;

end

initial begin
    $monitor("Time=%0t Light=%b", $time, light);
end

endmodule
