module CTRL_UNIT(
        clk,
        opcode,
        reset,
        signals
 );

        input clk;
        input [6:0] opcode;
        input reset;
        output reg [23:0]signals;


        always @(*)
        begin: ctrl_unit_op
                case (opcode)  
                        //one operand
                        7'b0010001 :    signals = 24'b001110111000001001100011; //NOT
                        7'b0000011 :    signals = 24'b001110110000000001100011; //INC
                        7'b0011001 :    signals = 24'b101100111000001011100011; //OUT
                        7'b0011000 :    signals = 24'b001111111000001011100011; //IN
                        7'b1100001 :    signals = 24'b000000011000001110000001; //HLT
                        7'b1101000 :    signals = 24'b001100111000001110100001; //NOP
                        7'b1100010 :    signals = 24'b001100111000000011100011; //SET C
                        //two operand
                        7'b0010101 :    signals = 24'b001110111000001011100011; //MOV
                        7'b0000001 :    signals = 24'b001110111000000001100011; //ADD
                        7'b0001001 :    signals = 24'b001110111000000101100011; //SUB
                        7'b0001101 :    signals = 24'b001110111000000111100011; //AND
                        7'b0100000 :    signals = 24'b010110111100000001100011; //IADD
                        //memory operations
                        7'b0110101 :    signals = 24'b010110111100001101100011; //LDM
                        7'b0100010 :    signals = 24'b010110111100000001110010;  //LDD
                endcase 
        end // ctrl_unit_op
endmodule // CTRL_UNIT