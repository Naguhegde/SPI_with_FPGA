'''verilog'''


module spi_master (
    input wire clk,
    input wire cs,          // Active low chip select
    input wire serial_in,
    output wire serial_out,
    output reg [7:0] out    // Changed to reg to store the completed byte
);

reg [7:0] shift_reg;
reg [2:0] count;

// The serial_out usually tracks the MSB of the shifting register


always @(posedge clk or negedge cs) begin
    if (cs) begin
        // While CS is high (inactive), reset internals
        shift_reg <= 8'b0;
        out<=8'b0;
        count <= 3'd0;
        out <= {serial_in,shift_reg[6:0]};
    end 
    else begin
        // Shift bit in from the right (LSB)
        shift_reg <= {shift_reg[6:0], serial_in};
        
        if (count == 3'd7) begin
            // On the 8th clock cycle, transfer the completed 
            // shift_reg (plus the new bit) to the output vector
            
            count <= 3'd0;
            
            
        end 
        else begin
            count <= count + 1'b1;
        end
    end
end
assign serial_out = shift_reg[0];
endmodule
