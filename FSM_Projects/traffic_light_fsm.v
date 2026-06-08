module traffic_light_fsm(
    input clk,
    input reset,
    output reg [1:0] light
);

parameter RED    = 2'b00;
parameter YELLOW = 2'b01;
parameter GREEN  = 2'b10;

always @(posedge clk or posedge reset)
begin
    if(reset)
        light <= RED;
    else
    begin
        case(light)

            RED:
                light <= GREEN;

            GREEN:
                light <= YELLOW;

            YELLOW:
                light <= RED;

            default:
                light <= RED;

        endcase
    end
end

endmodule
