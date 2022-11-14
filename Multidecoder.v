`timescale 1ns / 1ps
module controlUnit(
                    input CLK, RST,
                    input [5:0]opcode,
                    output[1:0] ALUOp,
                    output MtoRFSel,  
                    ALUInSel1,
                    output[1:0]ALUInSel2,
                    RFDSel,J,Zero, IDSel,
                    output [1:0] PCSel,
                    output IRWE,DMWE, PCWE,
                    Branch, RFWE
                    ); 
    localparam state, nextstate;               
    always @(posedge CLK)begin
    if(RST)
    state <= 0;
    else
    state <= nextstate;end
    
    always @(opcode)
        case(state)
        
        0:  begin       //fetch state. add one to PC
                IDSel = 1'b0;
                ALUInSel1 = 1'b0;
                ALUInSel2 = 2'b01;
                ALUOp = 2'b00;
                PCSel = 2'b00;
                IRWE = 1'b1;
                PCWE = 1'b1;
                nextstate = 1;
            end
        1:  begin       //decode state
                PCWE = 0;
                ALUInSel1 = 1'b0;
                ALUInSel2 = 2'b10;  //calculate branch always
                ALUOp = 2'b00;
                if(opcode == 100011 | 101011) //lw or sw
                nextstate = 2;
                else if (opcode == 6'b000000)  //R-type
                nextstate = 6;
                else if (opcode == 6'b000100)  //beq
                nextstate = 8;
                else if (opcode == 6'b000010)  //jump
                nextstate = 9;
                 // for other opcodes
                    
            end              
        2:  begin       //MemAdr
                ALUInSel1 = 1'b1;
                ALUInSel2 = 2'b10;
                ALUOp = 2'b00;
                if(opcode == 6'b100011)
                    nextstate = 3;
                else if (opcode == 6'b101011)
                nextstate = 5; //sw state
            end
        3:  begin
                IDSel = 1'b1;
                nextstate = 4;
            end
        4:  begin       //Mem Writeback
                RFDSel = 1'b0;
                MtoRFSel = 1'b1;
                RFWE = 1;
                nextstate = 0;
            end
        5:  begin       //DMWE
                IDSel = 1;
                DMWE = 1;
                nextstate = 0;
            end
        6:  begin       //execute state
                ALUInSel1 = 1'b1;
                ALUInSel2 = 2'b00;
                ALUOp = 2'b10;
                nextstate = 7;
            end
        7:  begin       //ALU Writeback
                RFDSel = 1'b1;
                MtoRFSel = 1'b0;
                RFWE = 1'b1;
                nextstate = 0;  //end go to fetch
            end
        8:  begin       //branch if equal
                ALUInSel1 = 1'b1;
                ALUInSel2 = 2'b00;
                ALUOp = 2'b01;
                PCSel = 2'b01;
                Branch = 1;
                nextstate = 0;  //end go to fetch
            end
        9:  begin   //Jump
                PCSel = 2'b10;
                PCWE = 1;
                nextstate = 0;  //end J instruction go to fetch
            end 
        10: begin   //addI
                ALUInSel1 = 1'b1;
                ALUInSel2 = 2'b10;
                ALUOp = 2'b00;
                nextstate = 11;
            end
        11: begin   //addi stage 2
                RFDSel = 1'b0;
                MtoRFSel = 1'b0;
                RFWE = 1'b1;
                nextstate = 0;  // back to fetch
            end
            
            endcase
        
          
                    
endmodule
