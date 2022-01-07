`timescale 10ns / 1ns
module STACK_POINTER_TB;

// Inputs:

reg Change_SP;
reg [1:0] Control_Mux;
reg Rst;

// Outputs:
wire [31:0] Output_Signal;

STACK_POINTER uut(.Change_SP(Change_SP), .Control_Mux(Control_Mux), .Rst(Rst), .Output_Signal(Output_Signal));

initial begin
    Rst = 1'b1;
    Change_SP = 1'b1;
    Control_Mux = 2'b00;
    #10

    Rst = 1'b0;
    Change_SP = 1'b1;
    Control_Mux = 2'b11;
    #10

    Change_SP = 1'b0;
    Control_Mux = 2'b10;
    #10

    Change_SP = 1'b1;

    

    
end
endmodule
