module DATA_MEM(
 clk,
 re,
 we,
 en32,
 address,
 data_in, 
 data_out
 );
input clk;
input re;
input we;
input en32;   
input [19:0] address;
input [31:0] data_in; 
output reg [31:0] data_out;

reg [15:0] RAM [0:2**10];
integer adrs;

always @(posedge clk)
begin: data_mem_op
    adrs = address;

    if (re) begin
        if(en32) begin
            data_out <= {RAM[adrs+1],RAM[adrs]};
        end
        else begin
            data_out <= {16'b0,RAM[adrs]};
        end
    end
    else begin
        data_out <= {32{1'bz}};
    end

    if (we) begin
        if(en32) begin
            {RAM[adrs+1],RAM[adrs]} <= data_in;
        end
        else begin
            RAM[adrs] <= data_in;
        end
        
    end
end // data_mem_op
endmodule // DATA_MEM
