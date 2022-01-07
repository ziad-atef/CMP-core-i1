module execute(
    clk,
    flag_src,
    data1,
    data2,
    imm,
    ALUsrc1,
    ALUsrc2,
    ALUoperation,
    mem_flags,
    input_flags,
    imm_val,
    data1_val,
    data2_val,
    prev_ALU,
    prev_mem,
    ALU_out,
    output_flags
);
    input clk;
    input flag_src;
    input data1;
    input data2;
    input imm;
    input [1:0]  ALUsrc1;
    input [1:0]  ALUsrc2;
    input [2:0]  ALUoperation;
    input [3:0]  mem_flags;
    input [3:0]  input_flags;
    input [15:0] imm_val;
    input [15:0] data1_val;
    input [15:0] data2_val;
    input [15:0] prev_ALU;
    input [15:0] prev_mem;

    output [15:0] ALU_out;
    output [3:0] output_flags;


    wire  [3:0] ALU_output_flags; 
    wire [15:0]data1_mux,data2_mux,imm_mux; 
    reg [15:0] ALU_input2;
    reg [15:0] ALU_input1;


    assign data1_mux = (data1)?data1_val:data2_val;
    assign data2_mux = (data2)?data2_val:1;
    assign imm_mux = (imm)?imm_val:data2_mux;
    assign output_flags = (flag_src)?mem_flags:ALU_output_flags;


    ALU u0(.operand1(ALU_input1), .operand2(ALU_input2), .operation(ALUoperation), .flags_in(input_flags), .result(ALU_out), .flags_out(ALU_output_flags));
    
    always @(*) begin
        case(ALUsrc1)
            2'b00: ALU_input1 = data1_mux;
            2'b01 : ALU_input1 = prev_ALU;
            2'b10: ALU_input1 = prev_mem;
            default : ALU_input1 = data1_mux;            
        endcase
        case(ALUsrc2)
            2'b00: ALU_input2 = data2_mux;
            2'b01 : ALU_input2 = prev_ALU;
            2'b10: ALU_input2 = prev_mem;
            default : ALU_input2 = data2_mux;            
        endcase
    end

endmodule