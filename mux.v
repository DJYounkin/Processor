module mux#(parameter WL = 32)
		(	
		input sel,	
		input [WL-1:0]a, b,
		output [WL-1:0]out
		);
		
		always @(sel)begin
			case(sel)
			
			1'b0 :	out = a;	//top
			1'b1 : 	out = b;	//bottom
			
			endcase
			
		end
		
	endmodule
			
			