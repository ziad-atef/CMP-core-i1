module Mem_WB_buff (
    input  clk,rst,enable,

    input        i_WB;
    input [31:0] i_Mem ;
    input [15:0] i_alu;
    input [2:0]  i_Rdst; 

    output reg        o_WB;
    output reg [31:0] o_Mem ;
    output reg [15:0] o_alu;
    output reg [ 2:0] o_Rdst; 
);
    always @(posedge clk) begin
        if(rst == 1'b1) begin
            o_WB  <=       0;
            o_Mem <=       0;
            o_alu <=       0;
            o_Rdst<=       0;
        end
        else if(enable == 1'b1) begin
            o_WB  <=       i_WB;
            o_Mem <=       i_Mem;
            o_alu <=       i_alu;
            o_Rdst<=       i_Rdst;
        end
    end
endmodule
