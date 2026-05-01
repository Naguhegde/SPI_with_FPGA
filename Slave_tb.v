`timescale 1ns/1ps

module siso_tb;

reg clk = 0;
reg cs;
reg serial_in;
wire serial_out;
wire [7:0]out;

// Instantiate DUT
spi_master uut (
    .clk(clk),
    .cs(cs),
    .serial_in(serial_in),
    .serial_out(serial_out),
    .out(out)
);

// Clock generation
always #5 clk = ~clk;

integer i;
reg [7:0] test_data = 8'b10110011;
initial 
begin
  cs = 1;
    #10
    cs = 0;
    end
initial begin
    $display("Time\tIn\tOut");
    $display("------------------");

  

    // Send 8 bits (MSB first)
    for (i = 7; i >= 0; i = i - 1) begin
        @(posedge clk);
        
        serial_in = test_data[i];
        $display("%0t\t%b\t%b", $time, serial_in, serial_out);
    end
#10;
cs=1;
    // Extra clocks to see output coming out
  

    #20;
    
    $finish;
end

endmodule
