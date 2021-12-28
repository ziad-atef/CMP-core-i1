module alu_mem_buff (
    input  clk,rst,enable,

    input i_WB, i_Mem;
    input [31:0] i_pc  ;
    input [2:0]  i_Rdst;
    input [15:0] i_alu , i_read_data1 ;
    // input [size:0] flag ; 

    output reg o_WB, o_Mem;
    output reg [31:0] o_pc  ;
    output reg [2:0]  o_Rdst;
    output reg [15:0] o_alu , o_read_data1;
    // output reg [size:0] flag ; 
);
    always @(posedge clk) begin
        if(rst == 1'b1) begin
            o_WB <=        0;
            o_Mem <=       0;
            o_pc<=         0;
            o_read_data1<= 0;
            o_Rdst<=       0;
            o_alu<=        0;
        end
        else if(enable == 1'b1) begin
            o_WB <=        i_WB;
            o_Mem <=       i_Mem;
            o_pc<=         i_pc;
            o_read_data1<= i_read_data1;
            o_Rdst<=       i_Rdst;
            o_alu<=        i_alu;
        end
    end
endmodule
