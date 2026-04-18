`timescale 1ns / 1ps

module clock_devider(input clk, input res , output clk_div);
reg [28:0] count;

always @(posedge clk)
begin 
if(res)
begin
count <= 28'd0;
end
else
begin 
count<=count+1;
end
end
assign clk_div=count[1];











endmodule
