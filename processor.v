module processor(
    input rst , clk 
);

// -------------------------------------------------------- Fetch Stage --------------------------------------

    fetch fetchObj(
        .clk(clk),
        .enableBuf(enableBuf),
        .pc_select(),
        .pc_place(),
        .index(),
        .IVT(),
        .ret(),
        .reset(),
        .call(),
        .new_pc() , 
        .instruction()
        // ,.intFlag(intFlag)
    );


// -------------------------------------------------------- Deocde Stage --------------------------------------
    decode decodeObj(
        .clk(clk),      // 1  bits
        .rst(rst),      // 1  bits
        .regWrite(),    // 1  bits 
        .Rsrc1(),       // 3  bits
        .Rsrc2(),       // 3  bits
        .Rdst(),        // 3  bits
        .opcode(),      // 7  bits 
        .writeData(),   // 16 bits
        .inPort(),      // 16 bits      
        .signals(),     // 23 bits
        .readData1(),   // 16 bits
        .readData2()    // 16 bits
    );

    dec_alu_buf dec_alu_bufObj 
    (
    // input rst,
     .clk(),
     .enable(),

     .i_WB(),                  // 4 bits
     .i_Mem(),                 // 6 bits
     .i_Ex() ,                 // 3 bits
     .i_chg_flag(),            // 1 bit
     .i_pc(),                  // 32 bits
     .i_Rsrc1() ,              // 3 bits 
     .i_Rsrc2() ,              // 3 bits 
     .i_Rdst(),                // 3 bits
     .i_immd(),                // 16 bits
     .i_read_data1(),          // 16 bits 
     .i_read_data2(),          // 16 bits
     // ---------------------   output ---------------//
     .o_WB(),   // 4 bits
     .o_Mem(),  // 6 bits
     .o_Ex() ,  // 3 bits
     .o_chg_flag(),            // 1 bit
     .o_pc()   ,        // 1 bit
     .o_Rsrc1() ,       // 3 bits 
     .o_Rsrc2() ,              // 3 bits
     .o_Rdst(),                // 3 bits
     .o_immd() ,            // 16 bits
     .o_read_data1(),       // 16 bits
     .o_read_data2()        // 16 bits
);


// -------------------------------------------------------- Execute Stage --------------------------------------
execute ExcecuteObj(
    .clk(),             // 1  bit
    .data1(),           // 1  bit
    .data2(),           // 1  bit
    .imm(),             // 1  bit
    .flag_src(),        // 1  bit
    .ALUsrc1(),         // 2  bit
    .ALUsrc2(),         // 2  bit
    .ALUoperation(),    // 3  bit
    .data1_val(),       // 16 bit
    .data2_val(),       // 16 bit
    .imm_val(),         // 16 bit
    .ALU_out()          // 16 bit
);

    alu_mem_buff alu_mem_buffObj(
    // input rst,
    .clk(),
    .enable(),
    .i_Mem(),           //6   bits
    .i_WB(),            //4   bits
    .i_pc()  ,          //32  bits
    .i_Rdst(),          //3   bits
    .i_alu() ,          //16  bits
    .i_read_data1() ,   //16  bits
    .i_flag() ,         //4   bits

    .o_Mem(),              //6  bits
    .o_WB(),               //4  bits
    .o_pc(),               //32 bits
    .o_Rdst(),             //3  bits
    .o_alu() ,             //16 bits
    .o_read_data1(),       //16 bits
    .o_flag()              //4  bits
);

endmodule