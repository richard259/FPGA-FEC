`timescale 1ns / 1ps

module DFE #(
    parameter SYMBOL_SEPARATION = 48,
    //bit-resolution of output signal
    parameter SIGNAL_RESOLUTION = 8,
    
    parameter ALPHA = 0.5)(
    
    input clk,
    input rstn,
    input signed [SIGNAL_RESOLUTION-1:0] signal_in,
    input signal_in_valid,
    
    
    output reg [1:0] symbol_out,
    output reg valid = 0);
    
    reg [1:0] prev_symbol = 2'd1;
    
    reg signed [SIGNAL_RESOLUTION-1:0] signal_isi_removed;
    
    assign signal_isi_removed = signal_in - y_isi[prev_symbol];
    
    reg signed [SIGNAL_RESOLUTION-1:0] y_isi [3:0] = {SYMBOL_SEPARATION*1.5*ALPHA, SYMBOL_SEPARATION*0.5*ALPHA, SYMBOL_SEPARATION*-0.5*ALPHA ,SYMBOL_SEPARATION*-1.5*ALPHA};
    
    reg signed [SIGNAL_RESOLUTION-1:0] y [3:0] = {SYMBOL_SEPARATION*1.5, SYMBOL_SEPARATION*0.5,SYMBOL_SEPARATION*-0.5,SYMBOL_SEPARATION*-1.5};
    
    wire signed [SIGNAL_RESOLUTION:0] e [3:0]; 
    
    assign e[0] = signal_isi_removed-y[0];
    assign e[1] = signal_isi_removed-y[1];
    assign e[2] = signal_isi_removed-y[2];
    assign e[3] = signal_isi_removed-y[3];
    
    wire signed [2*SIGNAL_RESOLUTION+1:0] e2 [3:0]; 
    
    assign e2[0] = e[0]*e[0];
    assign e2[1] = e[1]*e[1];
    assign e2[2] = e[2]*e[2];
    assign e2[3] = e[3]*e[3];
    
    always @(posedge clk) begin
    
        if (!rstn) begin
            valid <=0;
            prev_symbol = 2'd1;
        end else if (!signal_in_valid) begin
            valid <=0;
            
        end else begin
            
            valid <=1;
        
            if (e2[0]<=e2[1] && e2[0]<=e2[2] && e2[0]<=e2[3]) begin
                prev_symbol <= 0;
                symbol_out <= 0;
                      
            end else if (e2[1]<=e2[0] && e2[1]<=e2[2] && e2[1]<=e2[3]) begin
                prev_symbol <= 1;
                symbol_out <= 1;
                
            end else if (e2[2]<=e2[0] && e2[2]<=e2[1] && e2[2]<=e2[3]) begin
                prev_symbol <= 2;
                symbol_out <= 2;
                
            end else begin
                prev_symbol <= 3;
                symbol_out <= 3;
            end
        
        end
    end
    
    endmodule

module MLSE #(

    parameter SYMBOL_SEPARATION = 48,
    //bit-resolution of output signal
    parameter SIGNAL_RESOLUTION = 8,
    
    parameter ALPHA = 0.1,
    
    parameter TRACEBACK = 10,
    
    parameter METRIC_RESOLUTION = 20)(
    
    input clk,
    input rstn,
    input signed [SIGNAL_RESOLUTION-1:0] signal_in,
    input signal_in_valid,
    
    
    output reg [1:0] symbol_out,
    output reg valid = 0);
    
    
    reg signed [SIGNAL_RESOLUTION-1:0] y0 [3:0] = {(SYMBOL_SEPARATION*-1.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    
    wire signed [2*SIGNAL_RESOLUTION+1:0] e0 [3:0];
    assign e0[0] = (signal_in-y0[0])*(signal_in-y0[0]);
    assign e0[1] = (signal_in-y0[1])*(signal_in-y0[1]);
    assign e0[2] = (signal_in-y0[2])*(signal_in-y0[2]);
    assign e0[3] = (signal_in-y0[3])*(signal_in-y0[3]);
    
    reg signed [SIGNAL_RESOLUTION-1:0] y1 [3:0] = {(SYMBOL_SEPARATION*-0.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    
    wire signed [2*SIGNAL_RESOLUTION+1:0] e1 [3:0];
    assign e1[0] = (signal_in-y1[0])*(signal_in-y1[0]);
    assign e1[1] = (signal_in-y1[1])*(signal_in-y1[1]);
    assign e1[2] = (signal_in-y1[2])*(signal_in-y1[2]);
    assign e1[3] = (signal_in-y1[3])*(signal_in-y1[3]);
    
    reg signed [SIGNAL_RESOLUTION-1:0] y2 [3:0] = {(SYMBOL_SEPARATION*0.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    
    wire signed [2*SIGNAL_RESOLUTION+1:0] e2 [3:0];
    assign e2[0] = (signal_in-y2[0])*(signal_in-y2[0]);
    assign e2[1] = (signal_in-y2[1])*(signal_in-y2[1]);
    assign e2[2] = (signal_in-y2[2])*(signal_in-y2[2]);
    assign e2[3] = (signal_in-y2[3])*(signal_in-y2[3]);
    
    reg signed [SIGNAL_RESOLUTION-1:0] y3 [3:0] = {(SYMBOL_SEPARATION*1.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    
    wire signed [2*SIGNAL_RESOLUTION+1:0] e3 [3:0];
    assign e3[0] = (signal_in-y3[0])*(signal_in-y3[0]);
    assign e3[1] = (signal_in-y3[1])*(signal_in-y3[1]);
    assign e3[2] = (signal_in-y3[2])*(signal_in-y3[2]);
    assign e3[3] = (signal_in-y3[3])*(signal_in-y3[3]);
    
    reg [METRIC_RESOLUTION-1:0] survivor_path_metrics [3:0] = {0, 0, 0, 0};
    
//    reg signed [63:0] survivor_path_metrics [3:0] = {0, 0, 0, 0};
    
    reg [1:0] prev_survivor_path_state [3:0] = {0, 0, 0, 0};
    
    //survivor path terminating at states 0-3
    reg [1:0] survivor0 [TRACEBACK-1:0] = '{default:2'd0};
    reg [1:0] survivor1 [TRACEBACK-1:0] = '{default:2'd1};
    reg [1:0] survivor2 [TRACEBACK-1:0] = '{default:2'd2};
    reg [1:0] survivor3 [TRACEBACK-1:0] = '{default:2'd3};
    
    reg [7:0] delay = 0;
    
    always @(posedge clk) begin
    
        if (!rstn) begin
            valid <=0;
            delay <= 0;
        
        end else if (!signal_in_valid) begin
            valid <=0;
            
            //normalize path metrics
            if ((survivor_path_metrics[0][METRIC_RESOLUTION-1] == 1'b1) && (survivor_path_metrics[1][METRIC_RESOLUTION-1] == 1'b1) && (survivor_path_metrics[2][METRIC_RESOLUTION-1] == 1'b1) && (survivor_path_metrics[3][METRIC_RESOLUTION-1] == 1'b1)) begin
                survivor_path_metrics[0] <= {1'b0,survivor_path_metrics[0][METRIC_RESOLUTION-2:0]};
                survivor_path_metrics[1] <= {1'b0,survivor_path_metrics[1][METRIC_RESOLUTION-2:0]};
                survivor_path_metrics[2] <= {1'b0,survivor_path_metrics[2][METRIC_RESOLUTION-2:0]};
                survivor_path_metrics[3] <= {1'b0,survivor_path_metrics[3][METRIC_RESOLUTION-2:0]};
            end
            
        end else begin
        
            //survivor terminating in state 0
            if ((e0[0]+survivor_path_metrics[0])<=(e0[1]+survivor_path_metrics[1]) && (e0[0]+survivor_path_metrics[0])<=(e0[2]+survivor_path_metrics[2]) && (e0[0]+survivor_path_metrics[0])<=(e0[3]+survivor_path_metrics[3])) begin
            //prev state was 0
            survivor_path_metrics[0] <= e0[0]+survivor_path_metrics[0];
            prev_survivor_path_state[0] <= 0;
                      
            end else if ((e0[1]+survivor_path_metrics[1])<=(e0[0]+survivor_path_metrics[0]) && (e0[1]+survivor_path_metrics[1])<=(e0[2]+survivor_path_metrics[2]) && (e0[1]+survivor_path_metrics[1])<=(e0[3]+survivor_path_metrics[3]))  begin
            //prev_state was 1
            survivor_path_metrics[0] <= e0[1]+survivor_path_metrics[1];
            prev_survivor_path_state[0] <= 1;
            
            end else if ((e0[2]+survivor_path_metrics[2])<=(e0[0]+survivor_path_metrics[0]) && (e0[2]+survivor_path_metrics[2])<=(e0[1]+survivor_path_metrics[1]) && (e0[2]+survivor_path_metrics[2])<=(e0[3]+survivor_path_metrics[3])) begin
            //prev_state was 2
            survivor_path_metrics[0] <= e0[2]+survivor_path_metrics[2];
            prev_survivor_path_state[0] <= 2;
            
            end else begin
            //prev_state was 3
            survivor_path_metrics[0] <= e0[3]+survivor_path_metrics[3];
            prev_survivor_path_state[0] <= 3;
            end
            
            //survivor terminating in state 1
            if ((e1[0]+survivor_path_metrics[0])<=(e1[1]+survivor_path_metrics[1]) && (e1[0]+survivor_path_metrics[0])<=(e1[2]+survivor_path_metrics[2]) && (e1[0]+survivor_path_metrics[0])<=(e1[3]+survivor_path_metrics[3])) begin
            //prev state was 0
            survivor_path_metrics[1] <= e1[0]+survivor_path_metrics[0];
            prev_survivor_path_state[1] <= 0;
                      
            end else if ((e1[1]+survivor_path_metrics[1])<=(e1[0]+survivor_path_metrics[0]) && (e1[1]+survivor_path_metrics[1])<=(e1[2]+survivor_path_metrics[2]) && (e1[1]+survivor_path_metrics[1])<=(e1[3]+survivor_path_metrics[3]))  begin
            //prev_state was 1
            survivor_path_metrics[1] <= e1[1]+survivor_path_metrics[1];
            prev_survivor_path_state[1] <= 1;
            
            end else if ((e1[2]+survivor_path_metrics[2])<=(e1[0]+survivor_path_metrics[0]) && (e1[2]+survivor_path_metrics[2])<=(e1[1]+survivor_path_metrics[1]) && (e1[2]+survivor_path_metrics[2])<=(e1[3]+survivor_path_metrics[3])) begin
            //prev_state was 2
            survivor_path_metrics[1] <= e1[2]+survivor_path_metrics[2];
            prev_survivor_path_state[1] <= 2;
            
            end else begin
            //prev_state was 3
            survivor_path_metrics[1] <= e1[3]+survivor_path_metrics[3];
            prev_survivor_path_state[1] <= 3;
            end
            
            //survivor terminating in state 2
            if ((e2[0]+survivor_path_metrics[0])<=(e2[1]+survivor_path_metrics[1]) && (e2[0]+survivor_path_metrics[0])<=(e2[2]+survivor_path_metrics[2]) && (e2[0]+survivor_path_metrics[0])<=(e2[3]+survivor_path_metrics[3])) begin
            //prev state was 0
            survivor_path_metrics[2] <= e2[0]+survivor_path_metrics[0];
            prev_survivor_path_state[2] <= 0;
                      
            end else if ((e2[1]+survivor_path_metrics[1])<=(e2[0]+survivor_path_metrics[0]) && (e2[1]+survivor_path_metrics[1])<=(e2[2]+survivor_path_metrics[2]) && (e2[1]+survivor_path_metrics[1])<=(e2[3]+survivor_path_metrics[3]))  begin
            //prev_state was 1
            survivor_path_metrics[2] <= e2[1]+survivor_path_metrics[1];
            prev_survivor_path_state[2] <= 1;
            
            end else if ((e2[2]+survivor_path_metrics[2])<=(e2[0]+survivor_path_metrics[0]) && (e2[2]+survivor_path_metrics[2])<=(e2[1]+survivor_path_metrics[1]) && (e2[2]+survivor_path_metrics[2])<=(e2[3]+survivor_path_metrics[3])) begin
            //prev_state was 2
            survivor_path_metrics[2] <= e2[2]+survivor_path_metrics[2];
            prev_survivor_path_state[2] <= 2;
            
            end else begin
            //prev_state was 3
            survivor_path_metrics[2] <= e2[3]+survivor_path_metrics[3];
            prev_survivor_path_state[2] <= 3;
            end
            
            //survivor terminating in state 3
            if ((e3[0]+survivor_path_metrics[0])<=(e3[1]+survivor_path_metrics[1]) && (e3[0]+survivor_path_metrics[0])<=(e3[2]+survivor_path_metrics[2]) && (e3[0]+survivor_path_metrics[0])<=(e3[3]+survivor_path_metrics[3])) begin
            //prev state was 0
            survivor_path_metrics[3] <= e3[0]+survivor_path_metrics[0];
            prev_survivor_path_state[3] <= 0;
                      
            end else if ((e3[1]+survivor_path_metrics[1])<=(e3[0]+survivor_path_metrics[0]) && (e3[1]+survivor_path_metrics[1])<=(e3[2]+survivor_path_metrics[2]) && (e3[1]+survivor_path_metrics[1])<=(e3[3]+survivor_path_metrics[3]))  begin
            //prev_state was 1
            survivor_path_metrics[3] <= e3[1]+survivor_path_metrics[1];
            prev_survivor_path_state[3] <= 1;
            
            end else if ((e3[2]+survivor_path_metrics[2])<=(e3[0]+survivor_path_metrics[0]) && (e3[2]+survivor_path_metrics[2])<=(e3[1]+survivor_path_metrics[1]) && (e3[2]+survivor_path_metrics[2])<=(e3[3]+survivor_path_metrics[3])) begin
            //prev_state was 2
            survivor_path_metrics[3] <= e3[2]+survivor_path_metrics[2];
            prev_survivor_path_state[3] <= 2;
            
            end else begin
            //prev_state was 3
            survivor_path_metrics[3] <= e3[3]+survivor_path_metrics[3];
            prev_survivor_path_state[3] <= 3;
            end
            
                         //update path0
            if (prev_survivor_path_state[0] == 2'd0) begin
                survivor0 <= {survivor0[TRACEBACK-2:0], 2'd0};
            end else if (prev_survivor_path_state[0] == 2'd1) begin
                survivor0 <= {survivor1[TRACEBACK-2:0], 2'd0};
            end else if (prev_survivor_path_state[0] == 2'd2) begin
                survivor0 <= {survivor2[TRACEBACK-2:0], 2'd0};
            end else begin
                survivor0 <= {survivor3[TRACEBACK-2:0], 2'd0};
            end
            
                        //update path1
            if (prev_survivor_path_state[1] == 2'd0) begin
                survivor1 <= {survivor0[TRACEBACK-2:0], 2'd1};
            end else if (prev_survivor_path_state[1] == 2'd1) begin
                survivor1 <= {survivor1[TRACEBACK-2:0], 2'd1};
            end else if (prev_survivor_path_state[1] == 2'd2) begin
                survivor1 <= {survivor2[TRACEBACK-2:0], 2'd1};
            end else begin
                survivor1 <= {survivor3[TRACEBACK-2:0], 2'd1};
            end
            
                        //update path2
            if (prev_survivor_path_state[2] == 2'd0) begin
                survivor2 <= {survivor0[TRACEBACK-2:0], 2'd2};
            end else if (prev_survivor_path_state[2] == 2'd1) begin
                survivor2 <= {survivor1[TRACEBACK-2:0], 2'd2};
            end else if (prev_survivor_path_state[2] == 2'd2) begin
                survivor2 <= {survivor2[TRACEBACK-2:0], 2'd2};
            end else begin
                survivor2 <= {survivor3[TRACEBACK-2:0], 2'd2};
            end
            
                        //update path3
            if (prev_survivor_path_state[3] == 2'd0) begin
                survivor3 <= {survivor0[TRACEBACK-2:0], 2'd3};
            end else if (prev_survivor_path_state[3] == 2'd1) begin
                survivor3 <= {survivor1[TRACEBACK-2:0], 2'd3};
            end else if (prev_survivor_path_state[3] == 2'd2) begin
                survivor3 <= {survivor2[TRACEBACK-2:0], 2'd3};
            end else begin
                survivor3 <= {survivor3[TRACEBACK-2:0], 2'd3};
            end
            
            if (delay<TRACEBACK+1) begin
                delay <= delay + 1;
                valid <= 0;
            end else begin
                symbol_out <= survivor0[TRACEBACK-1];
                valid <= 1;
            end
            

            //update path metrics
        
        end
        
    end
    
    
    endmodule

//was ISI_channel_new in prev versions
module ISI_channel #(
    //length of pulse response (UI) eg: if the pulse response is h = [1 0.5], PULSE_RESPONSE_LENGTH = 2
    parameter PULSE_RESPONSE_LENGTH = 3,
    //bit-resolution of output signal
    parameter SIGNAL_RESOLUTION = 8)(
    
    input clk,
    input rstn,
    input signed [SIGNAL_RESOLUTION-1:0] signal_in,
    input signal_in_valid,
    
    //specify channel coefficient and index when rstn is low

    input signed [SIGNAL_RESOLUTION+1:0] channel_coefficient,
    input [7:0] channel_coefficient_idx,
    
    output reg signed [SIGNAL_RESOLUTION-1:0] signal_out,
    output reg signal_out_valid =0);
       
    // stores time-dealayed memory of input signal
    reg signed [SIGNAL_RESOLUTION-1:0] channel_memory [PULSE_RESPONSE_LENGTH-1:0] = '{default:'0};
    
    //stores channel pulse response
    reg signed [SIGNAL_RESOLUTION+1:0] channel_coefficient_reg [PULSE_RESPONSE_LENGTH-1:0] = '{default:'0};
    
    //stores element-wise multiplication of channel coefficients with channel memory
    wire signed [2*SIGNAL_RESOLUTION:0] channel_memory_scaled [PULSE_RESPONSE_LENGTH-1:0];
    
    
    genvar i;
    
    //instantiate our custom multiplication blocks for each channel coefficient
    generate
        for (i=0; i < PULSE_RESPONSE_LENGTH; i=i+1) begin    
            
            assign channel_memory_scaled[i] = channel_memory[i]*channel_coefficient_reg[i];
                        
        end
    endgenerate
    
    //sum them up to calculate channel output
    wire signed [2*SIGNAL_RESOLUTION:0] channel_memory_scaled_sum [PULSE_RESPONSE_LENGTH-1:0];
    assign channel_memory_scaled_sum[0] = channel_memory_scaled[0];
    
    generate
        for (i=1; i < PULSE_RESPONSE_LENGTH; i=i+1) begin
            assign channel_memory_scaled_sum[i] = channel_memory_scaled_sum[i-1] + channel_memory_scaled[i];
        end
    endgenerate

    wire [SIGNAL_RESOLUTION-1:0] channel_out;

    wire [1:0] round;
    
    assign round = channel_memory_scaled_sum[PULSE_RESPONSE_LENGTH-1][SIGNAL_RESOLUTION-1];
    
    assign channel_out = (channel_memory_scaled_sum[PULSE_RESPONSE_LENGTH-1]>>>SIGNAL_RESOLUTION) + round;
    
    reg delay = 0;


    always @ (posedge clk) begin
        if (!rstn) begin
            delay <= 0;
            signal_out_valid <= 0;
            
            // program channel coefficients when rstn is low
            // channel_coefficient_idx = 0 corresponds to first (precursor) coefficient
            // channel_coefficient_idx = 8'hFF when no coefficient is being programmed
            if (channel_coefficient_idx != 8'hFF) begin
                channel_coefficient_reg[channel_coefficient_idx] <= channel_coefficient;
            end
            
        end else begin
            if (signal_in_valid) begin
                
                //update channel memory shift register
                channel_memory[PULSE_RESPONSE_LENGTH-1:1] <= channel_memory[PULSE_RESPONSE_LENGTH-2:0];
                channel_memory[0] <= signal_in;
                
                // wait 1 cycle before output signal is valid
                if (delay == 0) begin
                    delay <= 1;
                    
                end else begin
                
                    //output signal
                    signal_out <= channel_out;
                    signal_out_valid <= 1;
                
                end
                
            end else begin
                signal_out_valid <= 0;
            end
        end
    end

endmodule


//was ISI_channel_new in prev versions
module ISI_channel_one_tap #(
    //bit-resolution of output signal
    parameter SIGNAL_RESOLUTION = 8,
    
    parameter SYMBOL_SEPARATION = 48,
    
    parameter ALPHA = 0.5)(
    
    input clk,
    input rstn,
    input [1:0] symbol_in,
    input symbol_in_valid,
    
    //specify channel coefficient and index when rstn is low

//    input signed [SIGNAL_RESOLUTION+1:0] channel_coefficient,
//    input [7:0] channel_coefficient_idx,
    
    output reg signed [SIGNAL_RESOLUTION-1:0] signal_out,
    output reg signal_out_valid =0);
    
    //target signal levels for states with most recent symbol = 0
    reg signed [SIGNAL_RESOLUTION-1:0] y0 [3:0] = {(SYMBOL_SEPARATION*-1.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    reg signed [SIGNAL_RESOLUTION-1:0] y1 [3:0] = {(SYMBOL_SEPARATION*-0.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    reg signed [SIGNAL_RESOLUTION-1:0] y2 [3:0] = {(SYMBOL_SEPARATION*0.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    reg signed [SIGNAL_RESOLUTION-1:0] y3 [3:0] = {(SYMBOL_SEPARATION*1.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    
    //reg delay = 0;
    
    reg [1:0] prev_symbol = 2'd1;


    always @ (posedge clk) begin
        if (!rstn) begin
           // delay <= 0;
            signal_out_valid <= 0;
            prev_symbol <= 2'd1;
            
        end else begin
            if (symbol_in_valid) begin
                
                prev_symbol <= symbol_in;
                
                // wait 1 cycle before output signal is valid
                //if (delay == 0) begin
                //    delay <= 1;
                    
                //end else begin
                if (symbol_in == 0) begin
                    signal_out <= y0[prev_symbol];
                end else if (symbol_in == 1) begin
                    signal_out <= y1[prev_symbol];
                end else if (symbol_in == 2) begin
                    signal_out <= y2[prev_symbol];
                end else begin 
                    signal_out <= y3[prev_symbol];
                end
                
                signal_out_valid <= 1;
                //end
                
            end else begin
                signal_out_valid <= 0;
            end
        end
    end

endmodule
