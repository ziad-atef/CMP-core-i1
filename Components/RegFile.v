module reg_file ( 
    input wire clk,write_enable,
    input wire  [15:0] write_data,
    input wire  [7: 0] write_address,read_address,
    output wire [15:0] read_data
);
    reg [15:0] array_reg [7:0];
    always @(posedge clk) begin
        if(write_enable)
            array_reg[write_address] <= write_data ;
    end
    assign read_data = array_reg[read_address];
endmodule