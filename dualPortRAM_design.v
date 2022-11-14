`timescale 1ns / 1ps


module MIPS_RF#(parameter AWL = 5, DWL = 16)//dual port ram
                (input clk, WE,
                input [AWL-1:0] raddr1, raddr2, RFWA,
                input [DWL-1:0] RFWD,
                output wire [DWL-1:0] do1,do2);
                
        reg[DWL-1:0] RAM [2**AWL-1:0];      //create Storage element to have do1 & do2 read from
        initial begin
            $readmemb ("mem.mem", RAM);     //fill RAM with 32, 32 bit binary nums
        end
        
            always @(posedge clk)begin
                if(WE) begin
                RAM[RFWA] <= RFWD; //Write Data to specified address in the ram
                end
                end
                
                
            assign do1 = RAM[raddr1];       //asymch read 
            assign do2 = RAM[raddr2];

        
endmodule