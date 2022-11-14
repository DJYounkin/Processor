`timescale 1ns / 1ps

module data_memory#(parameter WL = 32)
                    (input clk, WE,
                    input[WL-1:0] DMA,DMWD,
                    output[WL-1:0] DMRD);
                    
                    
            reg [WL-1: 0] data [0:1024];
            initial begin
            $readmemb("mem.mem", data);
            end
            
            
            always @(DMA | clk)//whenever address changes, check if write enabled
            begin
            if(WE)      //if so, write data to address in stack.
            data[DMA] <= DMWD;      //if write enable.. move Write Data onto the stack
            end
                    
            assign DMRD = data[DMA];
endmodule
