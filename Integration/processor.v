module processor(
    input rst , clk,
    input [15:0] in,
    output [15:0] out
);

wire fetchEnableBuf,  Rdst;
wire [1:0] pc_select;
wire [15:0] readData1,readData2;
wire [31:0] pc , instruction;
// -------------------------------------------------------- Fetch Stage --------------------------------------
    fetch fetchObj(
        .clk(clk),
        .enableBuf(fetchEnableBuf),
        .pc_select(pc_select),
        .pc_place(1'b0),
        .index(3'b0),
        .IVT(32'b0),
        .ret(32'b0),
        .reset(32'b0),
        .call(16'b0),
        .new_pc(pc) , 
        .instruction(instruction)
        // ,.intFlag(intFlag)
    );


// -------------------------------------------------------- Deocde Stage --------------------------------------
    reg regWrite ;
    reg [15:0] writeData;
    decode decodeObj(
        .clk(clk),                           // 1  bits
        .rst(rst),                           // 1  bits
        .regWrite(regWrite),                 // 1  bits 
        .Rsrc1(instruction[18:16]),          // 3  bits
        .Rsrc2(instruction[21:19]),          // 3  bits
        .Rdst(instruction[24:22]),           // 3  bits
        .opcode(instruction[31:25]),         // 7  bits 
        .writeData(writeData),               // 16 bits
        .inPort(16'b0),                      // 16 bits      
        .signals({pc_select,enableBuf}),     // 23 bits
        .readData1(readData1),               // 16 bits
        .readData2(readData2)                // 16 bits
    );

//     dec_alu_buf dec_alu_bufObj 
//     (
//     // input rst,
//         .clk(clk),
//         .enable(),
//         .i_WB(),                  // 4 bits
//         .i_Mem(),                 // 6 bits
//         .i_Ex() ,                 // 3 bits
//         .i_chg_flag(),            // 1 bit
//         .i_pc(),                  // 32 bits
//         .i_Rsrc1() ,              // 3 bits 
//         .i_Rsrc2() ,              // 3 bits 
//         .i_Rdst(),                // 3 bits
//         .i_immd(),                // 16 bits
//         .i_read_data1(),          // 16 bits 
//         .i_read_data2(),          // 16 bits
//         // ---------------------   output ---------------//
//         .o_WB(),   // 4 bits
//         .o_Mem(),  // 6 bits
//         .o_Ex() ,  // 3 bits
//         .o_chg_flag(),            // 1 bit
//         .o_pc()   ,        // 1 bit
//         .o_Rsrc1() ,       // 3 bits 
//         .o_Rsrc2() ,              // 3 bits
//         .o_Rdst(),                // 3 bits
//         .o_immd() ,            // 16 bits
//         .o_read_data1(),       // 16 bits
//         .o_read_data2()        // 16 bits
//     );


// // -------------------------------------------------------- Execute Stage --------------------------------------
//     execute ExcecuteObj(
//         .clk(),             // 1  bit
//         .data1(),           // 1  bit
//         .data2(),           // 1  bit
//         .imm(),             // 1  bit
//         .flag_src(),        // 1  bit
//         .ALUsrc1(),         // 2  bit
//         .ALUsrc2(),         // 2  bit
//         .ALUoperation(),    // 3  bit
//         .data1_val(),       // 16 bit
//         .data2_val(),       // 16 bit
//         .imm_val(),         // 16 bit
//         .ALU_out()          // 16 bit
//     );

//         alu_mem_buff alu_mem_buffObj(
//         // input rst,
//         .clk(),
//         .enable(),
//         .i_Mem(),           //6   bits
//         .i_WB(),            //4   bits
//         .i_pc()  ,          //32  bits
//         .i_Rdst(),          //3   bits
//         .i_alu() ,          //16  bits
//         .i_read_data1() ,   //16  bits
//         .i_flag() ,         //4   bits

//         .o_Mem(),              //6  bits
//         .o_WB(),               //4  bits
//         .o_pc(),               //32 bits
//         .o_Rdst(),             //3  bits
//         .o_alu() ,             //16 bits
//         .o_read_data1(),       //16 bits
//         .o_flag()              //4  bits
//     );

endmodule