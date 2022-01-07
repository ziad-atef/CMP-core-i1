module HDU_EXCEPTIONS (
    i_address,
    o_changeEPC,
);

input [31:0] i_address;
output reg o_changeEPC = 1'b0 ;

always @(*) begin
    
    o_changeEPC = 1'b0;
    if ((i_address[31:0] == 32'h00100000 ) || (i_address[31:0] > 32'h0000ff00 && i_address[31:0] < 32'h00010000 ) ) o_changeEPC = 1'b1;
    
end


endmodule //HDU_EXCEPTIONS
