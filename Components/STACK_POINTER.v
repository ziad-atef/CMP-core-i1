module STACK_POINTER(
    Change_SP,
    Control_Mux,
    Rst,
    Output_Signal
);
input Change_SP;
input [1:0] Control_Mux;
input Rst;
output reg[31:0] Output_Signal;



always @(*) begin


    //RESET
    if (Rst) Output_Signal = 1048575;

    else if (Change_SP) begin

      case (Control_Mux)
        2'b00  : Output_Signal = Output_Signal + 2;
        2'b01: Output_Signal = Output_Signal - 2;
        2'b10: Output_Signal = Output_Signal + 1;
        2'b11: Output_Signal = Output_Signal - 1;
      endcase
    
    //Output_Signal <= next_counter;
    
    end



end

endmodule