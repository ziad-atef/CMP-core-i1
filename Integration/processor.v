module processor(
    input  rst , clk,
    input  [15:0] in,
    output [15:0] out
);

wire fetchEnableBuf,  Rdst;
wire [1:0] pc_select;
wire [15:0] readData1,readData2;
wire [31:0] pc , instruction;
// -------------------------------------------------------- Fetch Stage --------------------------------------
    wire [31:0] tmpPc, tmpInstruction;
    reg [3:0] pcPlace;
    fetch fetchObj(
        .clk(clk),                                 //1  bits
        .pc_select(pc_select),                     //2  bits
        .pc_place(4'd0),                           //4  bits
        .index(3'd3),                              //3  bits
        .IVT(32'd12),                              //32  bits
        .ret(32'd27),                              //32  bits
        .reset(32'd57),                            //32  bits
        .call(16'd33),                             //16  bits
        .new_pc(tmpPc) ,                           //32  bits
        .instruction(tmpInstruction)               //32  bits
        // ,.intFlag(intFlag)
    );

    fetch_dec_buf fetchBuf (
        // .rst(rst),
        .clk(clk),  
        .enable(1'b1),
        .i_pc(tmpPc), 
        .i_instruction(tmpInstruction),               
        .o_pc(pc),          
        .o_instruction(instruction)
    );
// -------------------------------------------------------- Deocde Stage --------------------------------------
    reg regWrite ;
    reg [15:0] writeData;
    decode decodeObj(
<<<<<<< HEAD
        .clk(clk),                           // 1  bits
        .rst(rst),                           // 1  bits
        .regWrite(regWrite),                 // 1  bits 
        .Rsrc1(instruction[18:16]),          // 3  bits
        .Rsrc2(instruction[21:19]),          // 3  bits
        .Rdst(instruction[24:22]),           // 3  bits
        .opcode(instruction[31:25]),         // 7  bits 
        .writeData(writeData),               // 16 bits
        .inPort(16'b0),                      // 16 bits      
        .signals({pc_select}),               // 23 bits
        .readData1(readData1),               // 16 bits
        .readData2(readData2)                // 16 bits
=======
        .clk(clk),                                                               // 1  bits
        .rst(rst),                                                               // 1  bits
        .regWrite(o_MemBuf_Wb[1]),                                               // 1  bits 
        .Rsrc1(instruction[18:16]),                                              // 3  bits
        .Rsrc2(instruction[21:19]),                                              // 3  bits
        .Rdst(o_MemBuf_Rdst),                                                    // 3  bits
        .opcode(instruction[31:25]),                                             // 7  bits 
        .writeData(writeBackData),                                               // 16 bits
        .inPort(16'b0),                                                          // 16 bits      
        .signals(signals),                                                       // 23 bits
        .readData1(readData1),                                                   // 16 bits
        .readData2(readData2)                                                    // 16 bits
>>>>>>> 3441dd44a3ac157b14288d87c2b2077efc4ca7ba
    );

    wire [3:0] o_decBuf_Wb;
    wire [5:0] o_decBuf_Mem;
    wire [2:0] o_decBuf_Ex;
    wire  o_decBuf_chgFlag;
    wire [31:0] o_decBuf_pc;
    wire [2:0] o_decBuf_Rsrc1, o_decBuf_Rsrc2, o_decBuf_Rdst;
    wire [15:0] o_decBuf_immd, o_decBuf_ReadData1, o_decBuf_ReadData2;
    dec_alu_buf dec_alu_bufObj 
    (
    // input rst,
        .clk(clk),
        .enable(1'b1),
        .i_WB( 4'd5),                       // 4 bits
        .i_Mem(6'd7),                       // 6 bits
        .i_Ex (3'd9) ,                      // 3 bits
        .i_chg_flag(1'b0),                  // 1 bit
        .i_pc(pc),                          // 32 bits
        .i_Rdst(instruction[24:22]),        // 3 bits
        .i_Rsrc2(instruction[21:19]),       // 3 bits 
        .i_Rsrc1(instruction[18:16]),       // 3 bits 
        .i_immd(instruction[15:0]),         // 16 bits
        .i_read_data1(readData1),           // 16 bits 
        .i_read_data2(readData2),           // 16 bits
    // ---------------------   output ---------------//
        .o_WB(o_decBuf_Wb),                     // 4 bits
        .o_Mem(o_decBuf_Mem),                   // 6 bits
        .o_Ex(o_decBuf_Ex) ,                    // 3 bits
        .o_chg_flag(o_decBuf_chgFlag),          // 1 bit
        .o_pc(o_decBuf_pc)   ,                  // 1 bit
        .o_Rsrc1(o_decBuf_Rsrc1) ,              // 3 bits 
        .o_Rsrc2(o_decBuf_Rsrc2) ,              // 3 bits
        .o_Rdst(o_decBuf_Rdst),                 // 3 bits
        .o_immd(o_decBuf_immd) ,                // 16 bits
        .o_read_data1(o_decBuf_ReadData1),      // 16 bits
        .o_read_data2(o_decBuf_ReadData2)       // 16 bits
    );


    wire [15:0] alu_out;
    wire [15:0] execute_buffer_alu_output;
    wire [3:0] flags;
    wire [3:0] execute_buffer_flags_output;

    execute ExecuteObj (
        .clk(clk),
        .data1_val(o_decBuf_ReadData1),
        .data_val2(o_decBuf_ReadData2),
        .imm_val(o_decBuf_immd),
        .ALU_out(alu_out),
        .flags(flags)
    );

    alu_mem_buff alu_mem_buffObj(
        .clk(clk),
        .enable(1'b1),
        .i_alu(alu_out), 
        .o_out(execute_buffer_alu_output),
        .i_flag(flags),
        .o_flag(execute_buffer_flags_output)
        

    );
// -------------------------------------------------------- Execute Stage --------------------------------------
        // execute ExcecuteObj(
        //     .clk(clk),             // 1  bit
        //     
        
        //     .data1_val(),       // 16 bit
        //     .data2_val(),       // 16 bit
        //     .imm_val(),         // 16 bit
        //     .ALU_out()          // 16 bit
        // );

        //     alu_mem_buff alu_mem_buffObj(
        //     // input rst,
        //     .clk(clk),
        //     .enable(1'b1),
        //     .i_Mem( ),           //6   bits
        //     .i_WB(),            //4   bits   
        //     .i_pc()  ,          //32  bits
        //     .i_Rdst(),          //3   bits
        //     .i_alu() ,          //16  bits
        //     .i_read_data1() ,   //16  bits
        //     .i_flag() ,         //4   bits

        //     .o_Mem(),              //6  bits
        //     .o_WB(),               //4  bits
        //     .o_pc(),               //32 bits
        //     .o_Rdst(),             //3  bits
        //     .o_alu() ,             //16 bits
        //     .o_read_data1(),       //16 bits
        //     .o_flag()              //4  bits
        // );
// -------------------------------------------------------- Memory Stage --------------------------------------

//     wire [3:0]  o_MemoryStage_Wb;
//     wire [15:0] o_MemoryStage_alu;
//     wire [31:0] o_MemoryStage_MemData; 
//     memStage MemStageObj(
//         .clk(clk) ,            // 1 bit
//         .i_isStack(1'b1),          // 1 bit
//         .i_reset(1'b1),            // 1 bit
//         .i_isPushPc(1'b1),         // 1 bit
//         .i_memRead(1'b1),          // 1 bit
//         .i_memWrite(1'b0),         // 1 bit
//         .i_en32(1'b1),             // 1 bit
//         .i_wb(4'd7),               // 4 bit
//         .i_aluData(16'd15),          // 16 bit
//         .i_stackData(32'd120),        // 32 bit
//         .i_pc(32'd50),               // 32 bit
//         .i_instruction(32'd68),      // 32 bit


//         .o_wb(o_MemoryStage_Wb) ,              // 4 bit
//         .o_aluData(o_MemoryStage_alu) ,         // 16 bit
//         .o_memData(o_MemoryStage_MemData)           // 32 bit
//         // .o_hazardUnit()  // 20 bit
//     );
//     wire [3:0]  o_MemBuf_Wb;
//     wire [15:0] o_MemBuf_alu;
//     wire [31:0] o_MemBuf_MemData;
//     wire [2:0]  o_MemBuf_Rdst;

//     Mem_WB_buff Mem_WB_buffObj(
//     .clk(clk),                 // 1 bit
//     .enable(1'b1),              // 1 bit
//     .i_WB(o_MemoryStage_Wb),                // 4 bit
//     .i_MemData(o_MemoryStage_MemData) ,          // 32 bit
//     .i_alu(o_MemoryStage_alu),               // 16 bit
//     .i_Rdst(3'd4),              // 3 bit

//     .o_WB(o_MemBuf_Wb),                // 4 bit
//     .o_MemData(o_MemBuf_MemData) ,          // 32 bit
//     .o_alu(o_MemBuf_alu),               // 16 bit
//     .o_Rdst(o_MemBuf_Rdst)               // 3 bit
// );


// ----------------------- WriteBack Stage --------------------------------------

// wire [15:0] writeBackData;
// writeBack writeBackObj(
//     .sel(),
//     .memData(o_MemBuf_MemData),       // 32bit
//     .aluData(o_MemBuf_alu),       // 16bit

//     .writeBackData(writeBackData)    // 16 bit
// );

endmodule