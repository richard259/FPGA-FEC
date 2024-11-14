`timescale 1ns / 1ps

module grey_encode(
    input clk,
    input data,
    input rstn,
    input en,
    output reg [1:0] symbol,
    output reg valid =0);
    
    //reg [1:0] sr = 'b00;
    reg msb;
    
    reg bit_idx = 0;
    
    always @ (posedge clk) begin
        
        if (!rstn) begin
            valid <= 0;
            bit_idx <= 0;
        end else if (en) begin
            if (bit_idx == 0) begin
                bit_idx <=1;
                valid <= 0;
                msb <= data;
            end else if (bit_idx == 1) begin
                bit_idx <=0;
                valid <= 1;
                case(msb)
                    1'b0: begin
                        case(data)
                            1'b0:symbol <= 2'b00;
                            1'b1:symbol <= 2'b01;
                        endcase
                    end 1'b1: begin
                        case(data)
                            1'b0:symbol <= 2'b11;
                            1'b1:symbol <= 2'b10;
                        endcase
                    end
                endcase
            end
        end else begin
            valid <=0;
        end
    end     
endmodule


module grey_decode(
    input clk,
    input [1:0] symbol,
    input rstn,
    input en,
    output data,
    output reg valid = 0);
    
    reg [1:0] cur_symbol;
    reg bit_idx = 0;
    
    assign data = cur_symbol[bit_idx];
    
    always @ (posedge clk)
        
        if (!rstn) begin
            valid <= 0;
            bit_idx <= 0;
        end else begin
            if (en) begin
                case(symbol)
                    2'b00: cur_symbol <= 2'b00;
                    2'b01: cur_symbol <= 2'b01;
                    2'b11: cur_symbol <= 2'b10;
                    2'b10: cur_symbol <= 2'b11;
                endcase
                bit_idx <= 1;
                valid <= 1;
            end else if (bit_idx ==1) begin
                bit_idx <= 0;
                valid <= 1;
            end else begin
                valid <= 0;
        end
    end
        
endmodule
    
