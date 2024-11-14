(* use_dsp = "yes" *) module delta_gen #(

    parameter TRANSITION_RESOLUTION = 16,
    parameter METRIC_RESOLUTION = 24)(
    
    input [TRANSITION_RESOLUTION-1:0] e [3:0],
    input [METRIC_RESOLUTION-1:0] survivor_path_metrics [3:0],
    //input [METRIC_RESOLUTION-1:0] cumulative_metrics [3:0],
    input valid,
    
    
    output reg [METRIC_RESOLUTION-1:0] survivor_path_delta [3:0],
    output reg [METRIC_RESOLUTION-1:0] min_metric,
    output reg [1:0] min_idx);
    
    wire [METRIC_RESOLUTION-1:0] cumulative_metrics [3:0];
    
    assign cumulative_metrics[0] = e[0]+survivor_path_metrics[0];
    assign cumulative_metrics[1] = e[1]+survivor_path_metrics[1];
    assign cumulative_metrics[2] = e[2]+survivor_path_metrics[2];
    assign cumulative_metrics[3] = e[3]+survivor_path_metrics[3];
    
    always @(*) begin
    
//        cumulative_metrics[0] <= e[0]+survivor_path_metrics[0];
//        cumulative_metrics[1] <= e[0]+survivor_path_metrics[1];
//        cumulative_metrics[2] <= e[0]+survivor_path_metrics[2];
//        cumulative_metrics[3] <= e[0]+survivor_path_metrics[3];
    
        if ( (cumulative_metrics[0]<=cumulative_metrics[1])&&(cumulative_metrics[0]<=cumulative_metrics[2])&&(cumulative_metrics[0]<=cumulative_metrics[3]) ) begin
            min_idx <= 2'd0;
            min_metric <= cumulative_metrics[0];
            survivor_path_delta[0] <= 0;
            survivor_path_delta[1] <= cumulative_metrics[1] - cumulative_metrics[0];
            survivor_path_delta[2] <= cumulative_metrics[2] - cumulative_metrics[0];
            survivor_path_delta[3] <= cumulative_metrics[3] - cumulative_metrics[0];
                  
        end else if ( (cumulative_metrics[1] <= cumulative_metrics[0]) && (cumulative_metrics[1] <= cumulative_metrics[2]) && (cumulative_metrics[1] <= cumulative_metrics[3]) ) begin
            min_idx <= 2'd1;
            min_metric <= cumulative_metrics[1];
            survivor_path_delta[0] <= cumulative_metrics[0] - cumulative_metrics[1];
            survivor_path_delta[1] <= 0;
            survivor_path_delta[2] <= cumulative_metrics[2] - cumulative_metrics[1];
            survivor_path_delta[3] <= cumulative_metrics[3] - cumulative_metrics[1];
        
        end else if ( (cumulative_metrics[2] <= cumulative_metrics[0]) && (cumulative_metrics[2] <= cumulative_metrics[1]) && (cumulative_metrics[2] <= cumulative_metrics[3]) ) begin
            min_idx <= 2'd2;
            min_metric <= cumulative_metrics[2];
            survivor_path_delta[0] <= cumulative_metrics[0] - cumulative_metrics[2];
            survivor_path_delta[1] <= cumulative_metrics[1] - cumulative_metrics[2];
            survivor_path_delta[2] <= 0;
            survivor_path_delta[3] <= cumulative_metrics[3] - cumulative_metrics[2];
        
        end else begin
            min_idx <= 2'd3;
            min_metric <= cumulative_metrics[3];
            survivor_path_delta[0] <= cumulative_metrics[0] - cumulative_metrics[3];
            survivor_path_delta[1] <= cumulative_metrics[1] - cumulative_metrics[3];
            survivor_path_delta[2] <= cumulative_metrics[2] - cumulative_metrics[3];
            survivor_path_delta[3] <= 0;
        end
    
    end

endmodule



module reliability_update #(

    parameter TRACEBACK = 10,
    parameter TRANSITION_RESOLUTION = 16,
    parameter METRIC_RESOLUTION = 24)(
    
    input [METRIC_RESOLUTION-1:0] reliability0 [3:0][TRACEBACK-1:0],
    input [METRIC_RESOLUTION-1:0] reliability1 [3:0][TRACEBACK-1:0],
    input [METRIC_RESOLUTION-1:0] reliability2 [3:0][TRACEBACK-1:0],
    input [METRIC_RESOLUTION-1:0] reliability3 [3:0][TRACEBACK-1:0],
    
    input [METRIC_RESOLUTION-1:0] delta0 [3:0],
    input [METRIC_RESOLUTION-1:0] delta1 [3:0],
    input [METRIC_RESOLUTION-1:0] delta2 [3:0],
    input [METRIC_RESOLUTION-1:0] delta3 [3:0],
    
    output reg [METRIC_RESOLUTION-1:0] new_reliability0 [3:0][TRACEBACK-1:0],
    output reg [METRIC_RESOLUTION-1:0] new_reliability1 [3:0][TRACEBACK-1:0],
    output reg [METRIC_RESOLUTION-1:0] new_reliability2 [3:0][TRACEBACK-1:0],
    output reg [METRIC_RESOLUTION-1:0] new_reliability3 [3:0][TRACEBACK-1:0]);

    genvar i;
    
    generate
        for (i = 1; i < TRACEBACK; i = i + 1) begin
            always @(*) begin
                
                //update reliability0 at time i vistinting state mu
                                
                if (((reliability0[0][i-1]+delta0[0])<=(reliability1[0][i-1]+delta0[1])) && ((reliability0[0][i-1]+delta0[0])<=(reliability2[0][i-1]+delta0[2])) && ((reliability0[0][i-1]+delta0[0])<=(reliability3[0][i-1]+delta0[3])))  begin 
                    new_reliability0[0][i]<=(reliability0[0][i-1]+delta0[0]); 
                end else if (((reliability1[0][i-1]+delta0[1])<=(reliability0[0][i-1]+delta0[0])) && ((reliability1[0][i-1]+delta0[1])<=(reliability2[0][i-1]+delta0[2])) && ((reliability1[0][i-1]+delta0[1])<=(reliability3[0][i-1]+delta0[3])))  begin 
                    new_reliability0[0][i]<=(reliability1[0][i-1]+delta0[1]); 
                end else if (((reliability2[0][i-1]+delta0[2])<=(reliability0[0][i-1]+delta0[0])) && ((reliability2[0][i-1]+delta0[2])<=(reliability1[0][i-1]+delta0[1])) && ((reliability2[0][i-1]+delta0[2])<=(reliability3[0][i-1]+delta0[3])))  begin 
                    new_reliability0[0][i]<=(reliability2[0][i-1]+delta0[2]); 
                end else begin 
                    new_reliability0[0][i]<=(reliability3[0][i-1]+delta0[3]); 
                end 
                
                if (((reliability0[1][i-1]+delta0[0])<=(reliability1[1][i-1]+delta0[1])) && ((reliability0[1][i-1]+delta0[0])<=(reliability2[1][i-1]+delta0[2])) && ((reliability0[1][i-1]+delta0[0])<=(reliability3[1][i-1]+delta0[3])))  begin 
                    new_reliability0[1][i]<=(reliability0[1][i-1]+delta0[0]); 
                end else if (((reliability1[1][i-1]+delta0[1])<=(reliability0[1][i-1]+delta0[0])) && ((reliability1[1][i-1]+delta0[1])<=(reliability2[1][i-1]+delta0[2])) && ((reliability1[1][i-1]+delta0[1])<=(reliability3[1][i-1]+delta0[3])))  begin 
                    new_reliability0[1][i]<=(reliability1[1][i-1]+delta0[1]); 
                end else if (((reliability2[1][i-1]+delta0[2])<=(reliability0[1][i-1]+delta0[0])) && ((reliability2[1][i-1]+delta0[2])<=(reliability1[1][i-1]+delta0[1])) && ((reliability2[1][i-1]+delta0[2])<=(reliability3[1][i-1]+delta0[3])))  begin 
                    new_reliability0[1][i]<=(reliability2[1][i-1]+delta0[2]); 
                end else begin 
                    new_reliability0[1][i]<=(reliability3[1][i-1]+delta0[3]); 
                end 
                
                if (((reliability0[2][i-1]+delta0[0])<=(reliability1[2][i-1]+delta0[1])) && ((reliability0[2][i-1]+delta0[0])<=(reliability2[2][i-1]+delta0[2])) && ((reliability0[2][i-1]+delta0[0])<=(reliability3[2][i-1]+delta0[3])))  begin 
                    new_reliability0[2][i]<=(reliability0[2][i-1]+delta0[0]); 
                end else if (((reliability1[2][i-1]+delta0[1])<=(reliability0[2][i-1]+delta0[0])) && ((reliability1[2][i-1]+delta0[1])<=(reliability2[2][i-1]+delta0[2])) && ((reliability1[2][i-1]+delta0[1])<=(reliability3[2][i-1]+delta0[3])))  begin 
                    new_reliability0[2][i]<=(reliability1[2][i-1]+delta0[1]); 
                end else if (((reliability2[2][i-1]+delta0[2])<=(reliability0[2][i-1]+delta0[0])) && ((reliability2[2][i-1]+delta0[2])<=(reliability1[2][i-1]+delta0[1])) && ((reliability2[2][i-1]+delta0[2])<=(reliability3[2][i-1]+delta0[3])))  begin 
                    new_reliability0[2][i]<=(reliability2[2][i-1]+delta0[2]); 
                end else begin 
                    new_reliability0[2][i]<=(reliability3[2][i-1]+delta0[3]); 
                end 
                
                if (((reliability0[3][i-1]+delta0[0])<=(reliability1[3][i-1]+delta0[1])) && ((reliability0[3][i-1]+delta0[0])<=(reliability2[3][i-1]+delta0[2])) && ((reliability0[3][i-1]+delta0[0])<=(reliability3[3][i-1]+delta0[3])))  begin 
                    new_reliability0[3][i]<=(reliability0[3][i-1]+delta0[0]); 
                end else if (((reliability1[3][i-1]+delta0[1])<=(reliability0[3][i-1]+delta0[0])) && ((reliability1[3][i-1]+delta0[1])<=(reliability2[3][i-1]+delta0[2])) && ((reliability1[3][i-1]+delta0[1])<=(reliability3[3][i-1]+delta0[3])))  begin 
                    new_reliability0[3][i]<=(reliability1[3][i-1]+delta0[1]); 
                end else if (((reliability2[3][i-1]+delta0[2])<=(reliability0[3][i-1]+delta0[0])) && ((reliability2[3][i-1]+delta0[2])<=(reliability1[3][i-1]+delta0[1])) && ((reliability2[3][i-1]+delta0[2])<=(reliability3[3][i-1]+delta0[3])))  begin 
                    new_reliability0[3][i]<=(reliability2[3][i-1]+delta0[2]); 
                end else begin 
                    new_reliability0[3][i]<=(reliability3[3][i-1]+delta0[3]); 
                end 
                
                if (((reliability0[0][i-1]+delta1[0])<=(reliability1[0][i-1]+delta1[1])) && ((reliability0[0][i-1]+delta1[0])<=(reliability2[0][i-1]+delta1[2])) && ((reliability0[0][i-1]+delta1[0])<=(reliability3[0][i-1]+delta1[3])))  begin 
                    new_reliability1[0][i]<=(reliability0[0][i-1]+delta1[0]); 
                end else if (((reliability1[0][i-1]+delta1[1])<=(reliability0[0][i-1]+delta1[0])) && ((reliability1[0][i-1]+delta1[1])<=(reliability2[0][i-1]+delta1[2])) && ((reliability1[0][i-1]+delta1[1])<=(reliability3[0][i-1]+delta1[3])))  begin 
                    new_reliability1[0][i]<=(reliability1[0][i-1]+delta1[1]); 
                end else if (((reliability2[0][i-1]+delta1[2])<=(reliability0[0][i-1]+delta1[0])) && ((reliability2[0][i-1]+delta1[2])<=(reliability1[0][i-1]+delta1[1])) && ((reliability2[0][i-1]+delta1[2])<=(reliability3[0][i-1]+delta1[3])))  begin 
                    new_reliability1[0][i]<=(reliability2[0][i-1]+delta1[2]); 
                end else begin 
                    new_reliability1[0][i]<=(reliability3[0][i-1]+delta1[3]); 
                end 
                
                if (((reliability0[1][i-1]+delta1[0])<=(reliability1[1][i-1]+delta1[1])) && ((reliability0[1][i-1]+delta1[0])<=(reliability2[1][i-1]+delta1[2])) && ((reliability0[1][i-1]+delta1[0])<=(reliability3[1][i-1]+delta1[3])))  begin 
                    new_reliability1[1][i]<=(reliability0[1][i-1]+delta1[0]); 
                end else if (((reliability1[1][i-1]+delta1[1])<=(reliability0[1][i-1]+delta1[0])) && ((reliability1[1][i-1]+delta1[1])<=(reliability2[1][i-1]+delta1[2])) && ((reliability1[1][i-1]+delta1[1])<=(reliability3[1][i-1]+delta1[3])))  begin 
                    new_reliability1[1][i]<=(reliability1[1][i-1]+delta1[1]); 
                end else if (((reliability2[1][i-1]+delta1[2])<=(reliability0[1][i-1]+delta1[0])) && ((reliability2[1][i-1]+delta1[2])<=(reliability1[1][i-1]+delta1[1])) && ((reliability2[1][i-1]+delta1[2])<=(reliability3[1][i-1]+delta1[3])))  begin 
                    new_reliability1[1][i]<=(reliability2[1][i-1]+delta1[2]); 
                end else begin 
                    new_reliability1[1][i]<=(reliability3[1][i-1]+delta1[3]); 
                end 
                
                if (((reliability0[2][i-1]+delta1[0])<=(reliability1[2][i-1]+delta1[1])) && ((reliability0[2][i-1]+delta1[0])<=(reliability2[2][i-1]+delta1[2])) && ((reliability0[2][i-1]+delta1[0])<=(reliability3[2][i-1]+delta1[3])))  begin 
                    new_reliability1[2][i]<=(reliability0[2][i-1]+delta1[0]); 
                end else if (((reliability1[2][i-1]+delta1[1])<=(reliability0[2][i-1]+delta1[0])) && ((reliability1[2][i-1]+delta1[1])<=(reliability2[2][i-1]+delta1[2])) && ((reliability1[2][i-1]+delta1[1])<=(reliability3[2][i-1]+delta1[3])))  begin 
                    new_reliability1[2][i]<=(reliability1[2][i-1]+delta1[1]); 
                end else if (((reliability2[2][i-1]+delta1[2])<=(reliability0[2][i-1]+delta1[0])) && ((reliability2[2][i-1]+delta1[2])<=(reliability1[2][i-1]+delta1[1])) && ((reliability2[2][i-1]+delta1[2])<=(reliability3[2][i-1]+delta1[3])))  begin 
                    new_reliability1[2][i]<=(reliability2[2][i-1]+delta1[2]); 
                end else begin 
                    new_reliability1[2][i]<=(reliability3[2][i-1]+delta1[3]); 
                end 
                
                if (((reliability0[3][i-1]+delta1[0])<=(reliability1[3][i-1]+delta1[1])) && ((reliability0[3][i-1]+delta1[0])<=(reliability2[3][i-1]+delta1[2])) && ((reliability0[3][i-1]+delta1[0])<=(reliability3[3][i-1]+delta1[3])))  begin 
                    new_reliability1[3][i]<=(reliability0[3][i-1]+delta1[0]); 
                end else if (((reliability1[3][i-1]+delta1[1])<=(reliability0[3][i-1]+delta1[0])) && ((reliability1[3][i-1]+delta1[1])<=(reliability2[3][i-1]+delta1[2])) && ((reliability1[3][i-1]+delta1[1])<=(reliability3[3][i-1]+delta1[3])))  begin 
                    new_reliability1[3][i]<=(reliability1[3][i-1]+delta1[1]); 
                end else if (((reliability2[3][i-1]+delta1[2])<=(reliability0[3][i-1]+delta1[0])) && ((reliability2[3][i-1]+delta1[2])<=(reliability1[3][i-1]+delta1[1])) && ((reliability2[3][i-1]+delta1[2])<=(reliability3[3][i-1]+delta1[3])))  begin 
                    new_reliability1[3][i]<=(reliability2[3][i-1]+delta1[2]); 
                end else begin 
                    new_reliability1[3][i]<=(reliability3[3][i-1]+delta1[3]); 
                end 
                
                if (((reliability0[0][i-1]+delta2[0])<=(reliability1[0][i-1]+delta2[1])) && ((reliability0[0][i-1]+delta2[0])<=(reliability2[0][i-1]+delta2[2])) && ((reliability0[0][i-1]+delta2[0])<=(reliability3[0][i-1]+delta2[3])))  begin 
                    new_reliability2[0][i]<=(reliability0[0][i-1]+delta2[0]); 
                end else if (((reliability1[0][i-1]+delta2[1])<=(reliability0[0][i-1]+delta2[0])) && ((reliability1[0][i-1]+delta2[1])<=(reliability2[0][i-1]+delta2[2])) && ((reliability1[0][i-1]+delta2[1])<=(reliability3[0][i-1]+delta2[3])))  begin 
                    new_reliability2[0][i]<=(reliability1[0][i-1]+delta2[1]); 
                end else if (((reliability2[0][i-1]+delta2[2])<=(reliability0[0][i-1]+delta2[0])) && ((reliability2[0][i-1]+delta2[2])<=(reliability1[0][i-1]+delta2[1])) && ((reliability2[0][i-1]+delta2[2])<=(reliability3[0][i-1]+delta2[3])))  begin 
                    new_reliability2[0][i]<=(reliability2[0][i-1]+delta2[2]); 
                end else begin 
                    new_reliability2[0][i]<=(reliability3[0][i-1]+delta2[3]); 
                end 
                
                if (((reliability0[1][i-1]+delta2[0])<=(reliability1[1][i-1]+delta2[1])) && ((reliability0[1][i-1]+delta2[0])<=(reliability2[1][i-1]+delta2[2])) && ((reliability0[1][i-1]+delta2[0])<=(reliability3[1][i-1]+delta2[3])))  begin 
                    new_reliability2[1][i]<=(reliability0[1][i-1]+delta2[0]); 
                end else if (((reliability1[1][i-1]+delta2[1])<=(reliability0[1][i-1]+delta2[0])) && ((reliability1[1][i-1]+delta2[1])<=(reliability2[1][i-1]+delta2[2])) && ((reliability1[1][i-1]+delta2[1])<=(reliability3[1][i-1]+delta2[3])))  begin 
                    new_reliability2[1][i]<=(reliability1[1][i-1]+delta2[1]); 
                end else if (((reliability2[1][i-1]+delta2[2])<=(reliability0[1][i-1]+delta2[0])) && ((reliability2[1][i-1]+delta2[2])<=(reliability1[1][i-1]+delta2[1])) && ((reliability2[1][i-1]+delta2[2])<=(reliability3[1][i-1]+delta2[3])))  begin 
                    new_reliability2[1][i]<=(reliability2[1][i-1]+delta2[2]); 
                end else begin 
                    new_reliability2[1][i]<=(reliability3[1][i-1]+delta2[3]); 
                end 
                
                if (((reliability0[2][i-1]+delta2[0])<=(reliability1[2][i-1]+delta2[1])) && ((reliability0[2][i-1]+delta2[0])<=(reliability2[2][i-1]+delta2[2])) && ((reliability0[2][i-1]+delta2[0])<=(reliability3[2][i-1]+delta2[3])))  begin 
                    new_reliability2[2][i]<=(reliability0[2][i-1]+delta2[0]); 
                end else if (((reliability1[2][i-1]+delta2[1])<=(reliability0[2][i-1]+delta2[0])) && ((reliability1[2][i-1]+delta2[1])<=(reliability2[2][i-1]+delta2[2])) && ((reliability1[2][i-1]+delta2[1])<=(reliability3[2][i-1]+delta2[3])))  begin 
                    new_reliability2[2][i]<=(reliability1[2][i-1]+delta2[1]); 
                end else if (((reliability2[2][i-1]+delta2[2])<=(reliability0[2][i-1]+delta2[0])) && ((reliability2[2][i-1]+delta2[2])<=(reliability1[2][i-1]+delta2[1])) && ((reliability2[2][i-1]+delta2[2])<=(reliability3[2][i-1]+delta2[3])))  begin 
                    new_reliability2[2][i]<=(reliability2[2][i-1]+delta2[2]); 
                end else begin 
                    new_reliability2[2][i]<=(reliability3[2][i-1]+delta2[3]); 
                end 
                
                if (((reliability0[3][i-1]+delta2[0])<=(reliability1[3][i-1]+delta2[1])) && ((reliability0[3][i-1]+delta2[0])<=(reliability2[3][i-1]+delta2[2])) && ((reliability0[3][i-1]+delta2[0])<=(reliability3[3][i-1]+delta2[3])))  begin 
                    new_reliability2[3][i]<=(reliability0[3][i-1]+delta2[0]); 
                end else if (((reliability1[3][i-1]+delta2[1])<=(reliability0[3][i-1]+delta2[0])) && ((reliability1[3][i-1]+delta2[1])<=(reliability2[3][i-1]+delta2[2])) && ((reliability1[3][i-1]+delta2[1])<=(reliability3[3][i-1]+delta2[3])))  begin 
                    new_reliability2[3][i]<=(reliability1[3][i-1]+delta2[1]); 
                end else if (((reliability2[3][i-1]+delta2[2])<=(reliability0[3][i-1]+delta2[0])) && ((reliability2[3][i-1]+delta2[2])<=(reliability1[3][i-1]+delta2[1])) && ((reliability2[3][i-1]+delta2[2])<=(reliability3[3][i-1]+delta2[3])))  begin 
                    new_reliability2[3][i]<=(reliability2[3][i-1]+delta2[2]); 
                end else begin 
                    new_reliability2[3][i]<=(reliability3[3][i-1]+delta2[3]); 
                end 
                
                if (((reliability0[0][i-1]+delta3[0])<=(reliability1[0][i-1]+delta3[1])) && ((reliability0[0][i-1]+delta3[0])<=(reliability2[0][i-1]+delta3[2])) && ((reliability0[0][i-1]+delta3[0])<=(reliability3[0][i-1]+delta3[3])))  begin 
                    new_reliability3[0][i]<=(reliability0[0][i-1]+delta3[0]); 
                end else if (((reliability1[0][i-1]+delta3[1])<=(reliability0[0][i-1]+delta3[0])) && ((reliability1[0][i-1]+delta3[1])<=(reliability2[0][i-1]+delta3[2])) && ((reliability1[0][i-1]+delta3[1])<=(reliability3[0][i-1]+delta3[3])))  begin 
                    new_reliability3[0][i]<=(reliability1[0][i-1]+delta3[1]); 
                end else if (((reliability2[0][i-1]+delta3[2])<=(reliability0[0][i-1]+delta3[0])) && ((reliability2[0][i-1]+delta3[2])<=(reliability1[0][i-1]+delta3[1])) && ((reliability2[0][i-1]+delta3[2])<=(reliability3[0][i-1]+delta3[3])))  begin 
                    new_reliability3[0][i]<=(reliability2[0][i-1]+delta3[2]); 
                end else begin 
                    new_reliability3[0][i]<=(reliability3[0][i-1]+delta3[3]); 
                end 
                
                if (((reliability0[1][i-1]+delta3[0])<=(reliability1[1][i-1]+delta3[1])) && ((reliability0[1][i-1]+delta3[0])<=(reliability2[1][i-1]+delta3[2])) && ((reliability0[1][i-1]+delta3[0])<=(reliability3[1][i-1]+delta3[3])))  begin 
                    new_reliability3[1][i]<=(reliability0[1][i-1]+delta3[0]); 
                end else if (((reliability1[1][i-1]+delta3[1])<=(reliability0[1][i-1]+delta3[0])) && ((reliability1[1][i-1]+delta3[1])<=(reliability2[1][i-1]+delta3[2])) && ((reliability1[1][i-1]+delta3[1])<=(reliability3[1][i-1]+delta3[3])))  begin 
                    new_reliability3[1][i]<=(reliability1[1][i-1]+delta3[1]); 
                end else if (((reliability2[1][i-1]+delta3[2])<=(reliability0[1][i-1]+delta3[0])) && ((reliability2[1][i-1]+delta3[2])<=(reliability1[1][i-1]+delta3[1])) && ((reliability2[1][i-1]+delta3[2])<=(reliability3[1][i-1]+delta3[3])))  begin 
                    new_reliability3[1][i]<=(reliability2[1][i-1]+delta3[2]); 
                end else begin 
                    new_reliability3[1][i]<=(reliability3[1][i-1]+delta3[3]); 
                end 
                
                if (((reliability0[2][i-1]+delta3[0])<=(reliability1[2][i-1]+delta3[1])) && ((reliability0[2][i-1]+delta3[0])<=(reliability2[2][i-1]+delta3[2])) && ((reliability0[2][i-1]+delta3[0])<=(reliability3[2][i-1]+delta3[3])))  begin 
                    new_reliability3[2][i]<=(reliability0[2][i-1]+delta3[0]); 
                end else if (((reliability1[2][i-1]+delta3[1])<=(reliability0[2][i-1]+delta3[0])) && ((reliability1[2][i-1]+delta3[1])<=(reliability2[2][i-1]+delta3[2])) && ((reliability1[2][i-1]+delta3[1])<=(reliability3[2][i-1]+delta3[3])))  begin 
                    new_reliability3[2][i]<=(reliability1[2][i-1]+delta3[1]); 
                end else if (((reliability2[2][i-1]+delta3[2])<=(reliability0[2][i-1]+delta3[0])) && ((reliability2[2][i-1]+delta3[2])<=(reliability1[2][i-1]+delta3[1])) && ((reliability2[2][i-1]+delta3[2])<=(reliability3[2][i-1]+delta3[3])))  begin 
                    new_reliability3[2][i]<=(reliability2[2][i-1]+delta3[2]); 
                end else begin 
                    new_reliability3[2][i]<=(reliability3[2][i-1]+delta3[3]); 
                end 
                
                if (((reliability0[3][i-1]+delta3[0])<=(reliability1[3][i-1]+delta3[1])) && ((reliability0[3][i-1]+delta3[0])<=(reliability2[3][i-1]+delta3[2])) && ((reliability0[3][i-1]+delta3[0])<=(reliability3[3][i-1]+delta3[3])))  begin 
                    new_reliability3[3][i]<=(reliability0[3][i-1]+delta3[0]); 
                end else if (((reliability1[3][i-1]+delta3[1])<=(reliability0[3][i-1]+delta3[0])) && ((reliability1[3][i-1]+delta3[1])<=(reliability2[3][i-1]+delta3[2])) && ((reliability1[3][i-1]+delta3[1])<=(reliability3[3][i-1]+delta3[3])))  begin 
                    new_reliability3[3][i]<=(reliability1[3][i-1]+delta3[1]); 
                end else if (((reliability2[3][i-1]+delta3[2])<=(reliability0[3][i-1]+delta3[0])) && ((reliability2[3][i-1]+delta3[2])<=(reliability1[3][i-1]+delta3[1])) && ((reliability2[3][i-1]+delta3[2])<=(reliability3[3][i-1]+delta3[3])))  begin 
                    new_reliability3[3][i]<=(reliability2[3][i-1]+delta3[2]); 
                end else begin 
                    new_reliability3[3][i]<=(reliability3[3][i-1]+delta3[3]); 
                end 
                
            end
        end
    endgenerate
        //reliability 0 
    
    always @(*) begin
        
        //set most recent reliability to delta
        new_reliability0[0][0] <= delta0[0];     
        new_reliability0[1][0] <= delta0[1];  
        new_reliability0[2][0] <= delta0[2];  
        new_reliability0[3][0] <= delta0[3];  
        
        new_reliability1[0][0] <= delta1[0];     
        new_reliability1[1][0] <= delta1[1];  
        new_reliability1[2][0] <= delta1[2];  
        new_reliability1[3][0] <= delta1[3];  
        
        new_reliability2[0][0] <= delta2[0];     
        new_reliability2[1][0] <= delta2[1];  
        new_reliability2[2][0] <= delta2[2];  
        new_reliability2[3][0] <= delta2[3];  
        
        new_reliability3[0][0] <= delta3[0];     
        new_reliability3[1][0] <= delta3[1];  
        new_reliability3[2][0] <= delta3[2];  
        new_reliability3[3][0] <= delta3[3];  
    
    end
    
endmodule


