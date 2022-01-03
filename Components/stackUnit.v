// module stackUnit(
//     input  i_changeSp , 
//     input [1:0] i_Sel,
//     output reg [31:0] o_stackReg 
// );
//     reg [31:0] initialValue = 2 **20 -1;
//     if(i_changeSp) begin
//         case (i_Sel)
//             2'b00:
//                 temp = o_stackReg -1;
//             2'b01:
//                 temp = o_stackReg +1;
//             2'b10:
//                 temp = o_stackReg -2;
//             default:
//                 temp = o_stackReg +2;
//         endcase
//     end
//     o_stackReg = temp;
// endmodule