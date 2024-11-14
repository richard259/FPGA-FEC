`timescale 1ns / 1ps

module epf_channel_programmable #(
    parameter RNG_SEED0 = 64'h1391A0B350391A0B,
    parameter RNG_SEED1 = 64'h50391A0B0392A7D3,
    parameter RNG_SEED2 = 64'h0392A7D350391A0B) (
    input clk,
    input [1:0] symbol_in,
    input rstn,
    input en,
    input [63:0] probability_in,
    input [31:0] probability_idx,
    
    output reg [1:0] symbol_out,
    output reg valid = 0);
    
    
    //IEP (random Symbol error ratio) is probability of symbol error given previous symbol is not an error. range 0 - 2^64 corresponds to 0 to 1 probability value
    reg [63:0] IEP;
    
    //EPF (error propagation factor) is probability of symbol error given previous symbol is an error. range 0 - 2^64 corresponds to 0 to 1 probability value
    reg [63:0] EPF;
        
    wire [63:0] random;
    
    //state 0 corresponds to no error, 1 corresponds to an error
    reg state = 0;
    
    reg err_sign = 0;
            
    urng_64 #(
        .SEED0(RNG_SEED0),
        .SEED1(RNG_SEED1),
        .SEED2(RNG_SEED2)
        ) rng (
        .clk(clk),
        .rstn(rstn),
        .en(en),
        .data_out(random));
        
        
    always @ (posedge clk) begin
        
        //all probability values are loaded while resetn is held low
        if (!rstn) begin
            valid <= 0;
            state <= 0;
            err_sign <= 0;
            
            //interface for loading probability values while rstn held low
            //probability index 0 correspond to IEP
            //probability index 1 correspond to EPF
            if (probability_idx != 32'hFFFFFFFF) begin
                if (probability_idx == 0) begin
                    IEP <= probability_in;
                end else if (probability_idx == 1) begin
                    EPF <= probability_in;
                end
            end
            
            
        end else begin
        
            if (en) begin
                valid <=1;
                
                case (state)
                
                    1'b0: begin
                        symbol_out <= symbol_in;
                        
                        if (random < IEP) begin
                            state <= 1;
                        end
                    end
                    
                    1'b1: begin
                        
                        err_sign <= ~err_sign;
                    
                        case (err_sign)
                        
                            1'b0: symbol_out <= symbol_in+1;
                            1'b1: symbol_out <= symbol_in-1;
                        
                        endcase
                        
                        if (random >= EPF) begin
                            state<= 0;
                        end
                    end
                endcase
                
                
            end else begin
                valid <= 0;
            end
        end
    end
        
endmodule


module epf_channel #(
    parameter RNG_SEED0 = 64'h937285FF37486972,
    parameter RNG_SEED1 = 64'h10FF563829563892,
    parameter RNG_SEED2 = 64'h72074007FFFF2084,
    
    parameter IEP = 64'h0000000000000000,
    parameter EPF = 64'b1100000000000000000000000000000000000000000000000000000000000000)(
    //parameter EPF = 64'h0000000000000000) (
    input clk,
    input [1:0] symbol_in,
    input rstn,
    input en,
    input epf_en,
    
    output reg [1:0] symbol_out,
    output reg valid = 0);
    
    //reg [63:0] EPF;
        
    wire [63:0] random;
    
    //state 0 corresponds to no error, 1 corresponds to an error
    reg state = 0;
    
    reg err_sign = 0;
    
    reg mode = 0;
            
    urng_64 #(
        .SEED0(RNG_SEED0),
        .SEED1(RNG_SEED1),
        .SEED2(RNG_SEED2)
        ) rng (
        .clk(clk),
        .rstn(rstn),
        .en(en),
        .data_out(random));
        
        
    always @ (posedge clk) begin
        
        if (!rstn) begin
            valid <= 0;
            state <= 0;
            err_sign <= 0;
            mode <= epf_en;
            
            
        end else begin
        
            if (en) begin
                valid <=1;
                
                if (mode==0) begin
                    symbol_out <= symbol_in;
                
                end else begin
                
                case (state)
                
                    1'b0: begin
                        symbol_out <= symbol_in;
                        
                        if (random < IEP) begin
                            state <= 1;
                        end
                    end
                    
                    1'b1: begin
                        
                        err_sign <= ~err_sign;
                    
                        case (err_sign)
                        
                            1'b0: symbol_out <= symbol_in+1;
                            1'b1: symbol_out <= symbol_in-1;
                        
                        endcase
                        
                        if (random >= EPF) begin
                            state<= 0;
                        end
                    end
                endcase
                end
                
            end else begin
                valid <= 0;
            end
        end
    end
        
endmodule




