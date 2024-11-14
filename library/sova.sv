`timescale 1ns / 1ps


(* use_dsp = "yes" *) module SOVA #(

    parameter LLR_RESOLUTION = 5,

    parameter SYMBOL_SEPARATION = 48,
    //bit-resolution of output signal
    parameter SIGNAL_RESOLUTION = 8,
    
    parameter ALPHA = 0.1,
    
    parameter TRACEBACK = 6,
    
    parameter METRIC_RESOLUTION = 18)(
    
    input clk,
    input rstn,
    input signed [SIGNAL_RESOLUTION-1:0] signal_in,
    input signal_in_valid,
    
    
    output reg signed [1:0] symbol_out,
    output reg [LLR_RESOLUTION-1:0] llr,
    output reg llr_sign,
    output reg valid = 0);
    
    //target signal levels for states with most recent symbol = 0
    reg signed [SIGNAL_RESOLUTION-1:0] y0 [3:0] = {(SYMBOL_SEPARATION*-1.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-1.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    //squared error from each target symbol level
    wire [2*SIGNAL_RESOLUTION-1:0] e0 [3:0];
    assign e0[0] = (signal_in-y0[0])*(signal_in-y0[0]);
    assign e0[1] = (signal_in-y0[1])*(signal_in-y0[1]);
    assign e0[2] = (signal_in-y0[2])*(signal_in-y0[2]);
    assign e0[3] = (signal_in-y0[3])*(signal_in-y0[3]);
    
    
    reg signed [SIGNAL_RESOLUTION-1:0] y1 [3:0] = {(SYMBOL_SEPARATION*-0.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*-0.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    
    wire [2*SIGNAL_RESOLUTION-1:0] e1 [3:0];
    assign e1[0] = (signal_in-y1[0])*(signal_in-y1[0]);
    assign e1[1] = (signal_in-y1[1])*(signal_in-y1[1]);
    assign e1[2] = (signal_in-y1[2])*(signal_in-y1[2]);
    assign e1[3] = (signal_in-y1[3])*(signal_in-y1[3]);
    
    reg signed [SIGNAL_RESOLUTION-1:0] y2 [3:0] = {(SYMBOL_SEPARATION*0.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*0.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    
    wire [2*SIGNAL_RESOLUTION-1:0] e2 [3:0];
    assign e2[0] = (signal_in-y2[0])*(signal_in-y2[0]);
    assign e2[1] = (signal_in-y2[1])*(signal_in-y2[1]);
    assign e2[2] = (signal_in-y2[2])*(signal_in-y2[2]);
    assign e2[3] = (signal_in-y2[3])*(signal_in-y2[3]);
    
    reg signed [SIGNAL_RESOLUTION-1:0] y3 [3:0] = {(SYMBOL_SEPARATION*1.5)+1.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)+0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)-0.5*ALPHA*SYMBOL_SEPARATION, (SYMBOL_SEPARATION*1.5)-1.5*ALPHA*SYMBOL_SEPARATION};
    
    wire [2*SIGNAL_RESOLUTION-1:0] e3 [3:0];
    assign e3[0] = (signal_in-y3[0])*(signal_in-y3[0]);
    assign e3[1] = (signal_in-y3[1])*(signal_in-y3[1]);
    assign e3[2] = (signal_in-y3[2])*(signal_in-y3[2]);
    assign e3[3] = (signal_in-y3[3])*(signal_in-y3[3]);
    
    reg [METRIC_RESOLUTION-1:0] survivor_path_metrics [3:0] = {0, 0, 0, 0};
        
    reg [1:0] prev_survivor_path_state [3:0] = {0, 0, 0, 0};
    
    //survivor path terminating at states 0-3
    reg [1:0] survivor0 [TRACEBACK-1:0] = '{default:2'd0};
    reg [1:0] survivor1 [TRACEBACK-1:0] = '{default:2'd1};
    reg [1:0] survivor2 [TRACEBACK-1:0] = '{default:2'd2};
    reg [1:0] survivor3 [TRACEBACK-1:0] = '{default:2'd3};
    
    reg [7:0] delay = 0;
    
   
     //delta generation
    wire [METRIC_RESOLUTION-1:0] delta0 [3:0];
    wire [METRIC_RESOLUTION-1:0] min_metric0;
    wire [1:0] min_idx0;
    
//    wire [METRIC_RESOLUTION-1:0] cumulative_metrics0 [3:0];
    
//    assign cumulative_metrics0[0] = e0[0]+survivor_path_metrics[0];
//    assign cumulative_metrics0[1] = e0[1]+survivor_path_metrics[1];
//    assign cumulative_metrics0[2] = e0[2]+survivor_path_metrics[2];
//    assign cumulative_metrics0[3] = e0[3]+survivor_path_metrics[3];

    delta_gen #(.METRIC_RESOLUTION(METRIC_RESOLUTION),.TRANSITION_RESOLUTION(2*SIGNAL_RESOLUTION)) dg0 (
        .valid(signal_in_valid),
        .e(e0),
        .survivor_path_metrics(survivor_path_metrics),
        //.cumulative_metrics(cumulative_metrics0),
        .survivor_path_delta(delta0),
        .min_metric(min_metric0),
        .min_idx(min_idx0));
        
             //delta generation
    wire [METRIC_RESOLUTION-1:0] delta1 [3:0];
    wire [METRIC_RESOLUTION-1:0] min_metric1;
    wire [1:0] min_idx1;
    
//    wire [METRIC_RESOLUTION-1:0] cumulative_metrics1 [3:0];
    
//    assign cumulative_metrics1[0] = e1[0]+survivor_path_metrics[0];
//    assign cumulative_metrics1[1] = e1[1]+survivor_path_metrics[1];
//    assign cumulative_metrics1[2] = e1[2]+survivor_path_metrics[2];
//    assign cumulative_metrics1[3] = e1[3]+survivor_path_metrics[3];

    delta_gen #(.METRIC_RESOLUTION(METRIC_RESOLUTION),.TRANSITION_RESOLUTION(2*SIGNAL_RESOLUTION)) dg1 (
        .valid(signal_in_valid),
        .e(e1),
        .survivor_path_metrics(survivor_path_metrics),
        //.cumulative_metrics(cumulative_metrics1),
        .survivor_path_delta(delta1),
        .min_metric(min_metric1),
        .min_idx(min_idx1));
        
                     //delta generation
    wire [METRIC_RESOLUTION-1:0] delta2 [3:0];
    wire [METRIC_RESOLUTION-1:0] min_metric2;
    wire [1:0] min_idx2;
    
//    wire [METRIC_RESOLUTION-1:0] cumulative_metrics2 [3:0];
    
//    assign cumulative_metrics2[0] = e2[0]+survivor_path_metrics[0];
//    assign cumulative_metrics2[1] = e2[1]+survivor_path_metrics[1];
//    assign cumulative_metrics2[2] = e2[2]+survivor_path_metrics[2];
//    assign cumulative_metrics2[3] = e2[3]+survivor_path_metrics[3];
    
    delta_gen #(.METRIC_RESOLUTION(METRIC_RESOLUTION),.TRANSITION_RESOLUTION(2*SIGNAL_RESOLUTION)) dg2 (
        .valid(signal_in_valid),
        .e(e2),
        .survivor_path_metrics(survivor_path_metrics),
        //.cumulative_metrics(cumulative_metrics2),
        .survivor_path_delta(delta2),
        .min_metric(min_metric2),
        .min_idx(min_idx2));
        
        
    wire [METRIC_RESOLUTION-1:0] delta3 [3:0];
    wire [METRIC_RESOLUTION-1:0] min_metric3;
    wire [1:0] min_idx3;
        
//    wire [METRIC_RESOLUTION-1:0] cumulative_metrics3 [3:0];
    
//    assign cumulative_metrics3[0] = e2[0]+survivor_path_metrics[0];
//    assign cumulative_metrics3[1] = e2[1]+survivor_path_metrics[1];
//    assign cumulative_metrics3[2] = e2[2]+survivor_path_metrics[2];
//    assign cumulative_metrics3[3] = e2[3]+survivor_path_metrics[3];
    
    delta_gen #(.METRIC_RESOLUTION(METRIC_RESOLUTION),.TRANSITION_RESOLUTION(2*SIGNAL_RESOLUTION)) dg3 (
        .valid(signal_in_valid),
        .e(e3),
        .survivor_path_metrics(survivor_path_metrics),
        //.cumulative_metrics(cumulative_metrics3),
        .survivor_path_delta(delta3),
        .min_metric(min_metric3),
        .min_idx(min_idx3));
        
    reg [METRIC_RESOLUTION-1:0] reliability0 [3:0][TRACEBACK-1:0] = '{default: '0};
    reg [METRIC_RESOLUTION-1:0] reliability1 [3:0][TRACEBACK-1:0] = '{default: '0};
    reg [METRIC_RESOLUTION-1:0] reliability2 [3:0][TRACEBACK-1:0] = '{default: '0};
    reg [METRIC_RESOLUTION-1:0] reliability3 [3:0][TRACEBACK-1:0] = '{default: '0};
    
    wire [METRIC_RESOLUTION-1:0] new_reliability0 [3:0][TRACEBACK-1:0];
    wire [METRIC_RESOLUTION-1:0] new_reliability1 [3:0][TRACEBACK-1:0];
    wire [METRIC_RESOLUTION-1:0] new_reliability2 [3:0][TRACEBACK-1:0];
    wire [METRIC_RESOLUTION-1:0] new_reliability3 [3:0][TRACEBACK-1:0];
    
    reliability_update  #(.METRIC_RESOLUTION(METRIC_RESOLUTION),
        .TRACEBACK(TRACEBACK)) ru (
        .reliability0(reliability0),
        .reliability1(reliability1),
        .reliability2(reliability2),
        .reliability3(reliability3),
        .delta0(delta0),
        .delta1(delta1),
        .delta2(delta2),
        .delta3(delta3),
        .new_reliability0(new_reliability0),
        .new_reliability1(new_reliability1),
        .new_reliability2(new_reliability2),
        .new_reliability3(new_reliability3));
    
    reg [METRIC_RESOLUTION-1:0] llr_full;
    
    saturate #(
        .INPUT_RESOLUTION(METRIC_RESOLUTION),
        .OUTPUT_RESOLUTION(LLR_RESOLUTION),
        .SHIFT(6)
        ) sat (
        .signal_in(llr_full),
        .signal_out(llr));
    
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
        
            prev_survivor_path_state[0] <= min_idx0;
            survivor_path_metrics[0] <= min_metric0;
            
            prev_survivor_path_state[1] <= min_idx1;
            survivor_path_metrics[1] <= min_metric1;
            
            prev_survivor_path_state[2] <= min_idx2;
            survivor_path_metrics[2] <= min_metric2;
            
            prev_survivor_path_state[3] <= min_idx3;
            survivor_path_metrics[3] <= min_metric3;
            
            //update reliability matrix
            reliability0 <= new_reliability0;
            reliability1 <= new_reliability1;
            reliability2 <= new_reliability2;
            reliability3 <= new_reliability3;
            
            
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
            //output symbol
                symbol_out <= survivor0[TRACEBACK-1];
                valid <= 1;
                
                //llr ratio
                if (survivor0[TRACEBACK-1] == 0) begin

                    llr_full <= reliability0[1][TRACEBACK-1];
                    llr_sign <= 1;
                          
                end else if (survivor0[TRACEBACK-1] == 1) begin

                    if (reliability0[0][TRACEBACK-1]<=reliability0[2][TRACEBACK-1]) begin
                        llr_full <= reliability0[0][TRACEBACK-1];
                        llr_sign <= 1;
                    end else begin
                        llr_full <= reliability0[2][TRACEBACK-1];
                        llr_sign <= 0;
                    end
                    
                end else if (survivor0[TRACEBACK-1] == 2) begin

                    if (reliability0[1][TRACEBACK-1]<=reliability0[3][TRACEBACK-1]) begin
                        llr_full <= reliability0[1][TRACEBACK-1];
                        llr_sign <= 0;
                    end else begin
                        llr_full <= reliability0[3][TRACEBACK-1];
                        llr_sign <= 1;
                    end
                    
                end else begin

                    llr_full <= reliability0[2][TRACEBACK-1];
                    llr_sign <= 1;
                end
                
            end
            
        
        end
        
    end
    
    
    endmodule
    

