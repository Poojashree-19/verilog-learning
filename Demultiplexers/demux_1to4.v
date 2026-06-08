module demux_1to2(
    input i,
    input s,
    output y0,
    output y1
);

assign y0 = ~s & i;
assign y1 =  s & i;

endmodule
