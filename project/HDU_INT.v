module HDU_INT (
    i_instruction,
    o_int,
);

input [31:0] i_instruction;
output reg o_int ;

always @(*) begin
    
    // output signal
    o_int = 1'b0;

    // if INT 
    if (i_instruction[31:25] == 7'b1111110) o_int <= 1'b1;
    
end

endmodule //HDU_INT
