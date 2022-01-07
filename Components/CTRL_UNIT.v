module CTRL_UNIT(
        clk,
        opcode,
        reset,
        signals
 );

        input clk;
        input [6:0] opcode;
        input reset;
        output reg [22:0]signals;


        always @(*)
        begin: ctrl_unit_op
                case (opcode)  
                        //one operand
                        7'b0010001 :    signals = 23'b01110111000001001100011; //NOT
                        7'b0000011 :    signals = 23'b01110110000000001100011; //INC
                        7'b0011001 :    signals = 23'b01100111000001011100011; //OUT
                        7'b0011000 :    signals = 23'b01111111000001011100011; //IN
                        7'b1100001 :    signals = 23'b00000011000001110000001; //HLT
                        7'b1101000 :    signals = 23'b01100111000001110100001; //NOP
                        7'b1100010 :    signals = 23'b01100111000000011100011; //SET C
                        //two operand
                        7'b0010101 :    signals = 23'b01110111000001011100011; //MOV
                        7'b0000001 :    signals = 23'b01110111000000001100011; //ADD
                        7'b0001001 :    signals = 23'b01110111000000101100011; //SUB
                        7'b0001101 :    signals = 23'b01110111000000111100011; //AND
                        7'b0100000 :    signals = 23'b10110111100000001100011; //IADD
                endcase 
        end // ctrl_unit_op
endmodule // CTRL_UNIT