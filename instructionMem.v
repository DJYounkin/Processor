`timescale 1ns / 1ps

module instruction_mem#(
        parameter DW = 32,
        parameter AWL = 5,
        parameter MEMFILE = "mem.mem")
    (input [AWL-1:0] IMA,
    output [DW-1:0] IMRD
    );
    
    reg [DW-1:0] IM [0:DW-1];
    
    
    initial begin
    $readmemb("mem.mem", IM);       //fill IM with 32. 32 bit words
    end 
    
    assign IMRD = IM[IMA];          //asynch Read = Memory @ address [IMD]
    
    
endmodule
