`timescale 1ns / 1ps

module multadd#(parameter signed[3:0] a, b, c)

        (
        input signed [3:0] x,
        output reg signed [7:0] y
        );
    
    
    reg signed [3:0] a = -4;
    reg signed [3:0] b = 3;
    reg signed [3:0] c = -3;
    
    always @(posedge clk)
    begin
    y = (a*(x**2))+(b*x)+ c;
    end
endmodule
