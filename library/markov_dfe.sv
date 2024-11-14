`timescale 1ns / 1ps

module markov_1tap_dfe_32 #(
    parameter RNG_SEED0 = 64'h1391A0B350391A0B,
    parameter RNG_SEED1 = 64'h50391A0B0392A7D3,
    parameter RNG_SEED2 = 64'h0392A7D350391A0B) (
    input clk,
    input [1:0] symbol_in,
    input rstn,
    input en,
    input [31:0] probability_in,
    input [31:0] probability_idx,
    
    output reg [1:0] symbol_out,
    output reg valid = 0);
    
    //7 source states go to 4 possible sink states conditioned on the 4 possible transmitted symbols (-1 because sum or probability is 1) 
    
    
    reg [31:0] probability [7*4*3-1:0];
    //(* ram_style = "registers" *)  reg [31:0] probability [7*4*3-1:0];
    
    
    wire [31:0] random;
    
    //wire random_valid;
    
    reg [7:0] state = 0;
    
    
    //DFE error states:
    //state0: D = 0
    //state1: D = +2
    //state2: D = -2
    //state3: D = +4
    //state4: D = -4
    //state5: D = +6
    //state6: D = +6
        
    urng_64 #(
        .SEED0(RNG_SEED0),
        .SEED1(RNG_SEED1),
        .SEED2(RNG_SEED2)
        ) rng (
        .clk(clk),
        .rstn(rstn),
        .en(en),
        .data_out(random));
        
    //indicate ofsett for transmitted symbols
    localparam P0_offset = 0;
    localparam P1_offset = 1*7*3;
    localparam P2_offset = 2*7*3;
    localparam P3_offset = 3*7*3;
        
    always @ (posedge clk)
        
        //all probability values are loaded while resetn is held low
        if (!rstn) begin
            valid <= 0;
            state <= 0;
            if (probability_idx != 32'hFFFFFFFF) begin
                probability[probability_idx] <= probability_in;
            end
            
            
        end else begin
        
            if (en) begin
                valid <=1;
                
                case (symbol_in)
                    
                    //-3 is transmitted
                    2'b00: begin
                        if (random <= probability[P0_offset+state*3]) begin
                            //D = 0
                            state<= 0;
                            symbol_out<= 2'b00;
                            
                        end else if (random <= probability[P0_offset+state*3+1]) begin
                            // -1 is recieved D = +2 
                            state<= 1;
                            symbol_out<= 2'b01;
                        
                        // state 2 - D = -2 is imposible 
                        
                        end else if (random <= probability[P0_offset+state*3+2]) begin
                            // +1 is recieved, D = +4
                            state<= 3;
                            symbol_out<= 2'b10;
                        
                        // state 4 - D = -4 is imposible 
                        
                        end else begin
                            // +3 is recieved, D = +6
                            state<= 5;
                            symbol_out<= 2'b11;
                        end
                            
                        //state 6 - D = -6 is impossible
                            
                    end
                    
                    //-1 is transmitted
                    2'b01: begin
                        if (random <= probability[P1_offset+state*3]) begin
                            //-1 is recieved D = 0
                            state<= 0;
                            symbol_out<= 2'b01;
                            
                        end else if (random <= probability[P1_offset+state*3+1]) begin
                            // +1 is recieved D = +2 
                            state<= 1;
                            symbol_out<= 2'b10;
                        
                        end else if (random <= probability[P1_offset+state*3+2]) begin
                            // -3 is recieved, D = -2
                            state<= 2;
                            symbol_out<= 2'b00;
                        
                        end else begin
                            // +3 is recieved, D = +4
                            state<= 3;
                            symbol_out<= 2'b11;
                            
                        //state 4 - D = -4 is imposible 
                        //state 5 - D = +6 is impossible
                        //state 6 - D = -6 is impossible
                        end
                    
                    end     
                    
                    //+1 is transmitted
                    2'b10: begin
                            if (random <= probability[P2_offset+state*3]) begin
                            //+1 is recieved D = 0
                            state<= 0;
                            symbol_out<= 2'b10;
                            
                        end else if (random <= probability[P2_offset+state*3+1]) begin
                            // +3 is recieved D = +2 
                            state<= 1;
                            symbol_out<= 2'b11;
                        
                        end else if (random <= probability[P2_offset+state*3+2]) begin
                            // -1 is recieved, D = -2
                            state<= 2;
                            symbol_out<= 2'b01;
                            
                        //state 3 - D = +4 is imposible 
                        
                        end else begin
                            // -3 is recieved, D = -4
                            state<= 4;
                            symbol_out<= 2'b00;
                        
                        //state 5 - D = +6 is impossible
                        //state 6 - D = -6 is impossible
                        end
                    
                    end     
                    
                    //+3 is transmitted
                    2'b11: begin
                        if (random <= probability[P3_offset+state*3]) begin
                            // +3 is recieved D = 0
                            state<= 0;
                            symbol_out<= 2'b11;
                            
                        //state 1 - D = +2 is impossible     
                                            
                        end else if (random <= probability[P3_offset+state*3+1]) begin
                            // +1 is recieved D = -2 
                            state<= 2;
                            symbol_out<= 2'b10;
                        
                        // state 3 - D = +4 is imposible 
                        
                        end else if (random <= probability[P3_offset+state*3+2]) begin
                            // -1 is recieved, D = -4
                            state<= 4;
                            symbol_out<= 2'b01;
                        
                        // state 5 - D = +6 is imposible 
                        
                        end else begin
                            // -3 is recieved, D = -6
                            state<= 6;
                            symbol_out<= 2'b00;
                        end
                        
                    end     
                
                endcase
            end else begin
                valid <= 0;
            end
        end
        
endmodule


module markov_1tap_dfe_64 #(
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
    

    reg [63:0] probability [7*4*4-1:0];
    
    wire [63:0] random;
    wire random_valid;
    
    reg [7:0] state = 0;
    
    
    //DFE error states:
    //state0: D = 0
    //state1: D = +2
    //state2: D = -2
    //state3: D = +4
    //state4: D = -4
    //state5: D = +6
    //state6: D = +6
        
    urng_64 #(
        .SEED0(RNG_SEED0),
        .SEED1(RNG_SEED0),
        .SEED2(RNG_SEED0)
        ) rng (
        .clk(clk),
        .rstn(rstn),
        .en(en),
        .valid(random_valid),
        .data_out(random));
        
        
    localparam P0_offset = 0;
    localparam P1_offset = 1*7*4;
    localparam P2_offset = 2*7*4;
    localparam P3_offset = 3*7*4;
        
    always @ (posedge clk)
        
        //all probability values are loaded while resetn is held low
        if (!rstn) begin
            valid <= 0;
            state <= 0;
            if (probability_idx != 32'hFFFFFFFF) begin
                probability[probability_idx] <= probability_in;
            end
            
            
        end else begin
        
            if (en) begin
                valid <=1;
                
                case (symbol_in)
                    
                    //-3 is transmitted
                    2'b00: begin
                        if (random <= probability[P0_offset+state*4]) begin
                            //D = 0
                            state<= 0;
                            symbol_out<= 2'b00;
                            
                        end else if (random <= probability[P0_offset+state*4+1]) begin
                            // -1 is recieved D = +2 
                            state<= 1;
                            symbol_out<= 2'b01;
                        
                        // state 2 - D = -2 is imposible 
                        
                        end else if (random <= probability[P0_offset+state*4+2]) begin
                            // +1 is recieved, D = +4
                            state<= 3;
                            symbol_out<= 2'b10;
                        
                        // state 4 - D = -4 is imposible 
                        
                        end else if (random <= probability[P0_offset+state*4+3]) begin
                            // +3 is recieved, D = +6
                            state<= 5;
                            symbol_out<= 2'b11;
                        end
                            
                        //state 6 - D = -6 is impossible
                            
                    end
                    
                    //-1 is transmitted
                    2'b01: begin
                        if (random <= probability[P1_offset+state*4]) begin
                            //-1 is recieved D = 0
                            state<= 0;
                            symbol_out<= 2'b01;
                            
                        end else if (random <= probability[P1_offset+state*4+1]) begin
                            // +1 is recieved D = +2 
                            state<= 1;
                            symbol_out<= 2'b10;
                        
                        end else if (random <= probability[P1_offset+state*4+2]) begin
                            // -3 is recieved, D = -2
                            state<= 2;
                            symbol_out<= 2'b00;
                        
                        end else if (random <= probability[P1_offset+state*4+3]) begin
                            // +3 is recieved, D = +4
                            state<= 3;
                            symbol_out<= 2'b11;
                            
                        //state 4 - D = -4 is imposible 
                        //state 5 - D = +6 is impossible
                        //state 6 - D = -6 is impossible
                        end
                    
                    end     
                    
                    //+1 is transmitted
                    2'b10: begin
                            if (random <= probability[P2_offset+state*4]) begin
                            //+1 is recieved D = 0
                            state<= 0;
                            symbol_out<= 2'b10;
                            
                        end else if (random <= probability[P2_offset+state*4+1]) begin
                            // +3 is recieved D = +2 
                            state<= 1;
                            symbol_out<= 2'b11;
                        
                        end else if (random <= probability[P2_offset+state*4+2]) begin
                            // -1 is recieved, D = -2
                            state<= 2;
                            symbol_out<= 2'b01;
                            
                        //state 3 - D = +4 is imposible 
                        
                        end else if (random <= probability[P2_offset+state*4+3]) begin
                            // -3 is recieved, D = -4
                            state<= 4;
                            symbol_out<= 2'b00;
                        
                        //state 5 - D = +6 is impossible
                        //state 6 - D = -6 is impossible
                        end
                    
                    end     
                    
                    //+3 is transmitted
                    2'b11: begin
                        if (random <= probability[P3_offset+state*4]) begin
                            // +3 is recieved D = 0
                            state<= 0;
                            symbol_out<= 2'b11;
                            
                        //state 1 - D = +2 is impossible     
                                            
                        end else if (random <= probability[P3_offset+state*4+1]) begin
                            // +1 is recieved D = -2 
                            state<= 2;
                            symbol_out<= 2'b10;
                        
                        // state 3 - D = +4 is imposible 
                        
                        end else if (random <= probability[P3_offset+state*4+2]) begin
                            // -1 is recieved, D = -4
                            state<= 4;
                            symbol_out<= 2'b01;
                        
                        // state 5 - D = +6 is imposible 
                        
                        end else if (random <= probability[P3_offset+state*4+3]) begin
                            // -3 is recieved, D = -6
                            state<= 6;
                            symbol_out<= 2'b00;
                        end
                        
                    end     
                
                endcase
            end else begin
                valid <= 0;
            end
        end
        
endmodule

