module fetch(
    input clk,
    input enableBuf,
    input [1:0] pc_select ,
    input [3:0] pc_place ,
    input [2:0] index,
    input [31:0] IVT , ret , reset,
    input [15:0] call,

    output [31:0] instruction,  
    output [31:0] new_pc  
    // ,output reg intFlag     
);
    wire [31:0] instructionWire; 
    reg [31:0] pc; 
    reg [31:0] wire1 ;
    always @(posedge clk) begin
    // always @(*) begin
        case (pc_place)
            4'b00:
                case (pc_select) 
                    4'b01:
                        wire1 = wire1+2;
                    4'b10:
                        wire1 = wire1+4;
                    default: 
                        wire1 = wire1;
                endcase
            4'b0001:     
                wire1  =  0;
            4'b0010:
                wire1  =  2;
            4'b0011:
                wire1  =  4;
            4'b0100:
                wire1  =  6;
            4'b0101:
                wire1  = index + IVT;
            4'b0110:
                wire1  = ret;
            4'b0111:
                wire1  = { {16{1'b0}} , call};
            default:
                wire1  = reset; // zero extend 
        endcase
        pc  = wire1;
        // intFlag = 1;
    end
    INST_MEM instMem(
        .address(pc),
        .data_out(instructionWire)
    );

    fetch_dec_buf fetchBuffer (
        .clk(clk),  .enable(enableBuf),
        .i_pc(pc), 
        .i_instruction(instructionWire),
        .o_pc(new_pc),
        .o_instruction(instruction)
    );
endmodule