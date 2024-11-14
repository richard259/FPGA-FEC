`timescale 1ns / 1ps

module pam_4_encode #(
    parameter SIGNAL_RESOLUTION = 8,
    parameter SYMBOL_SEPARATION = 48)(
    input clk,
    input rstn,
    input [1:0] symbol_in,
    input symbol_in_valid,
    output reg [SIGNAL_RESOLUTION-1:0] signal_out, //128 to -127 as signed int
    output reg signal_out_valid = 0);

    always @ (posedge clk) begin
        if (!rstn) begin
            signal_out_valid <= 0;
        end else begin
            if (symbol_in_valid) begin
                case(symbol_in)
                    2'b00: signal_out <= -SYMBOL_SEPARATION*1.5;
                    2'b01: signal_out <= -SYMBOL_SEPARATION*0.5;
                    2'b10: signal_out <= SYMBOL_SEPARATION*0.5;
                    2'b11: signal_out <= SYMBOL_SEPARATION*1.5;
                endcase
                signal_out_valid <= 1;
            end else begin
                signal_out_valid <= 0; // To align with previous valid signal in order to convert back to binary data
            end
        end
    end
endmodule
