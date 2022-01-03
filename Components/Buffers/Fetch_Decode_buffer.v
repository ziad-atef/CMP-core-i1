module fetch_dec_buf (
    // input rst,
    input  clk,enable,
    input  [31:0] i_pc , i_instruction,
    output reg [31:0] o_pc , o_instruction
);
    always @(negedge clk) begin
        // if(rst == 1'b1) begin
        //     o_pc <=0;
        //     o_instruction <=0;
        // end
        // else 
        if(enable == 1'b1) begin
            o_pc <=i_pc;
            o_instruction <=i_instruction;
        end
    end
endmodule
