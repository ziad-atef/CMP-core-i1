module execute(
    clk,
    data1,
    data2,
    imm,
    ALUsrc1,
    ALUsrc2,
    ALUoperation,
    flag_src,
    data1_val,
    data2_val,
    imm_val,
    ALU_out
);
    input clk;
    input flag_src;
    input data1;
    input data2;
    input imm;
    input [1:0]ALUsrc1;
    input [1:0]ALUsrc2;
    input [2:0]ALUoperation;
    input [15:0] imm_val;
    input [15:0] data1_val;
    input [15:0] data2_val;
    output [15:0] ALU_out;

    wire [15:0]data1_mux,data2_mux,imm_mux;
    output [3:0] flags;

    assign data1_mux = (data1)?data1_val:data2_val;
    assign data2_mux = (data2)?data2_val:1;
    assign imm_mux = (imm)?imm_val:data2_mux;

    ALU u0(.operand1(data1_mux), .operand2(imm_mux), .operation(ALUoperation), .flags_in(3'b0), .result(ALU_out), .flags_out(flags));
    
    
    /*
    always @(posedge clk) 
    begin: execute_unit_op
        
    end// execute_unit_op
    
    CTRL_UNIT u0(.clk(clk),.opcode(opcode),.reset(rst),.signals(signals));
    reg_file  u1(.clk(clk),.regWrite(regWrite),.writeData(writeData),.Rsrc1(Rsrc1),.Rsrc2(Rsrc2),.Rdst(Rdst),.readData1(regFileOut),.readData2(readData2));
    always @(posedge clk) 
    begin: decode_unit_op
        if(signals[18]) //  detect if output is from in Register or register file
            readData1 <= inPort;
        else
            readData1 <= regFileOut;
    end// decode_unit_op
    */
endmodule