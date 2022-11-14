`timescale 1ns / 1ps

module ALU#(parameter WL = 32)
            (
			input [3:0] sel,
			input [WL-1:0] a,
			input [WL-1:0] b,
			input clk,rst,
			
			output reg [WL-1:0] out
			);
			
			
			//add = 0
			//sub = 1,
			
			//Logical shift left = 2
			//logical shift right = 3
			//logical variable shift left = 4
			//logical variable shift right = 5;
			//arithmetic shift-right = 6;
			//AND = 7
			//OR  = 8
			//XOR  = 9
			//XNOR = 10
			
			
			localparam 	add = 0, sub = 1, Lshleft = 2, Lshright = 3, varLshleft = 4,
						varLshright = 5, ADDshright = 6, AND = 7, OR = 8, 
						XOR = 9, XNOR = 10;
			
			
			always@(*) begin
			
			if (!rst)
                begin
				case(sel)
				
					add: 	begin
							out = a + b; //if 0000, add;
							end
							
					sub:	begin
							out = a-b; // if 0001, subtract
							end
				
					Lshleft:	begin
								out = a<<1;
								end
							
					Lshright:	begin
								out = a>>1;
								end
					
					varLshleft:	begin
								out = a >> b;
								end
								
					varLshright:begin
								out = a << b;
								end
								
					ADDshright:	begin
								out = a>>> b;
								// out = a >>> 1      //possible means
								end
								
					AND:		begin
								out = a&b;
								end
								
					OR:			begin
								out = a|b;
								end
								
					XOR:		begin
								out = a^b; 
								end
					
					XNOR:		begin
								out = a~^b;
								end
								
					endcase
					end
					end
			endmodule