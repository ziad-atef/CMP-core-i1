module CTRL_UNIT(
 clk,
 opcode,
 reset,
 operation,
 en32,
 we, 
 re
 );

input clk;
input [6:0] opcode;
input reset;
output [2:0] operation;
output en32;
output we;
output re;

always @(posedge clk)
begin: ctrl_unit_op
    case (operation)  
        
    endcase
end // ctrl_unit_op
endmodule // CTRL_UNIT
