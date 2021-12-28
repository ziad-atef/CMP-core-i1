module CTRL_UNIT(
 clk,
 opcode,
 reset,
 signals
 );

input clk;
input [6:0] opcode;
input reset;
output [2:0] signals;

always @(posedge clk)
begin: ctrl_unit_op
    
end // ctrl_unit_op
endmodule // CTRL_UNIT
//{PCselect,PCplace,,write data sel,addres src,Mem Read,Mem write,en32,mem buffer en,Reg Wite,WB src}