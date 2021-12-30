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


always @(posedge clk)
begin: ctrl_unit_op
        case (opcode)  
                7'b0010001 :    signals <= 23'b01110100000101001100011;
                7'b0000011 :    signals <= 23'b01110101000100001100011;
                7'b0011001 :    signals <= 23'b01100100000101011100011;
                7'b0011000 :    signals <= 23'b01111100000101011100011;
        endcase 
end // ctrl_unit_op
endmodule // CTRL_UNIT
//{PCselect,PCplace,,write data sel,addres src,Mem Read,Mem write,en32,mem buffer en,Reg Wite,WB src}