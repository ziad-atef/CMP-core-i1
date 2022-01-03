module dec_alu_buf 
    #( parameter    
        WbSize  = 4,
        MemSize = 6,
        ExSize  = 3
    )
    (
    // input rst,
    input  clk,enable,

    input [WbSize -1 :0] i_WB, 
    input [MemSize-1 :0] i_Mem, 
    input [ExSize-1  :0] i_Ex , 
    input i_chg_flag,
    input [31:0] i_pc,
    input [2: 0] i_Rsrc1 , i_Rsrc2 , i_Rdst,
    input [15:0] i_immd, i_read_data1, i_read_data2,

    output [WbSize -1 :0] o_WB, 
    output [MemSize-1 :0] o_Mem, 
    output [ExSize-1  :0] o_Ex , 
    output o_chg_flag,
    output [31:0] o_pc   ,
    output [2:0]  o_Rsrc1 , o_Rsrc2 , o_Rdst,
    output [15:0] o_immd , o_read_data1, o_read_data2
);
    always @(posedge clk) begin
        // if(rst == 1'b1) begin
        //     o_WB <=        0;
        //     o_Mem <=       0;
        //     o_Ex <=        0;
        //     o_chg_flag <=  0;
        //     o_pc<=         0;
        //     o_read_data1<= 0;
        //     o_read_data2<= 0;
        //     o_Rsrc1<=      0;
        //     o_Rsrc2<=      0;
        //     o_Rdst<=       0;
        //     o_immd<=       0;
        // end
        else if(enable == 1'b1) begin
            o_WB <=         i_WB;
            o_Mem <=        i_Mem;
            o_Ex <=         i_Ex;
            o_chg_flag <=   i_chg_flag;
            o_pc<=          i_pc;
            o_read_data1<=  i_read_data1;
            o_read_data2<=  i_read_data2;
            o_Rsrc1<=       i_Rsrc1;
            o_Rsrc2<=       i_Rsrc2;
            o_Rdst<=        i_Rdst;
            o_immd<=        i_immd;
        end
    end
endmodule
