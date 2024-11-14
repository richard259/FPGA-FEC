`timescale 1ns / 1ps

module precode_tx(
    input clk,
    input rstn,
    input [1:0] symbol_in,
    input en,
    input mode,
    output reg [1:0] symbol_out,
    output reg valid = 0);
    
    reg [1:0] mem = 'b00;
    reg m;
    
    always @ (posedge clk) begin
        
        if (!rstn) begin
            valid <= 0;
            mem <= 'b00;
            m <= mode;
        
        end else if (en) begin
            valid <= 1;
            case(m)
                1:  begin
                    symbol_out <= symbol_in-mem;
                    mem <= symbol_in-mem;
                end
                0:  symbol_out <= symbol_in;
            endcase
        end else begin
            valid <=0;
        end
    end
endmodule

module precode_rx(
    input clk,
    input rstn,
    input [1:0] symbol_in,
    input en,
    input mode,
    output reg [1:0] symbol_out,
    output reg valid = 0);
    
    reg [1:0] mem = 'b00;
    reg m;
    
    always @ (posedge clk) begin
        
        if (!rstn) begin
            valid <= 0;
            mem <= 'b00;
            m <= mode;
        
        end else if (en) begin
            valid <= 1;
            case(m)
                1:  begin
                    symbol_out <= symbol_in+mem;
                    mem <= symbol_in;
                    valid <= 1;
                end
                0:  symbol_out <= symbol_in;
            endcase
        end else begin
            valid <=0;
        end
    end
endmodule