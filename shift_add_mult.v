module multiplier (input [3:0] a, b,
					input clk, reset
					output reg [7:0] output, regS);
					
					adder UUT(a,b,output);
					register uut (output, clk, reset, regS);
					assign a = regS&{32{b[0]}};
					
					
					
			endmodule