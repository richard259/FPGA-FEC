module hard_slicer #(
    //bit-resolution of input signal
    parameter SIGNAL_RESOLUTION = 8,
    
    parameter SYMBOL_SEPARATION = 48)(
    
    input clk,
    input rstn,
    input en,
    input signed [SIGNAL_RESOLUTION-1:0] signal_in,
    input signal_in_valid,
    output reg [1:0] symbol_out,
    output reg valid =0);
    
    reg signed [SIGNAL_RESOLUTION-1:0] y [3:0] = {SYMBOL_SEPARATION*1.5, SYMBOL_SEPARATION*0.5,SYMBOL_SEPARATION*-0.5,SYMBOL_SEPARATION*-1.5};
    
    wire signed [SIGNAL_RESOLUTION:0] e [3:0]; 
    
    assign e[0] = signal_in-y[0];
    assign e[1] = signal_in-y[1];
    assign e[2] = signal_in-y[2];
    assign e[3] = signal_in-y[3];
    
    wire signed [2*SIGNAL_RESOLUTION+1:0] e2 [3:0]; 
    
    assign e2[0] = e[0]*e[0];
    assign e2[1] = e[1]*e[1];
    assign e2[2] = e[2]*e[2];
    assign e2[3] = e[3]*e[3];

    always @(posedge clk) begin
    
        if (!rstn || !signal_in_valid) begin
            valid <=0;
            
        end else begin
            
            valid <=1;
        
            if (e2[0]<=e2[1] && e2[0]<=e2[2] && e2[0]<=e2[3]) begin
            
                symbol_out <= 0;
                      
            end else if (e2[1]<=e2[0] && e2[1]<=e2[2] && e2[1]<=e2[3]) begin
                symbol_out <= 1;
                
            end else if (e2[2]<=e2[0] && e2[2]<=e2[1] && e2[2]<=e2[3]) begin
                symbol_out <= 2;
                
            end else begin
                symbol_out <= 3;
            end
        
        end
    end

    
endmodule

//was soft_slicer_new in prev versions

module soft_slicer #(
    //bit resolution of LLR output
    parameter LLR_RESOLUTION = 5,
    //bit-resolution of input signal
    parameter SIGNAL_RESOLUTION = 8,
    
    parameter SYMBOL_SEPARATION = 48)(
    
    input clk,
    input rstn,
    input en,
    input signed [SIGNAL_RESOLUTION-1:0] signal_in,
    input signal_in_valid,
    output wire [LLR_RESOLUTION-1:0] llr,
    output reg llr_sign,
    output reg [1:0] symbol_out,
    output reg valid =0);
    
    reg signed [SIGNAL_RESOLUTION-1:0] y [3:0] = {SYMBOL_SEPARATION*1.5, SYMBOL_SEPARATION*0.5,SYMBOL_SEPARATION*-0.5,SYMBOL_SEPARATION*-1.5};
    
    wire signed [SIGNAL_RESOLUTION:0] e [3:0]; 
    
    assign e[0] = signal_in-y[0];
    assign e[1] = signal_in-y[1];
    assign e[2] = signal_in-y[2];
    assign e[3] = signal_in-y[3];
    
    wire signed [2*SIGNAL_RESOLUTION+1:0] e2 [3:0]; 
    
    assign e2[0] = e[0]*e[0];
    assign e2[1] = e[1]*e[1];
    assign e2[2] = e[2]*e[2];
    assign e2[3] = e[3]*e[3];

    reg signed [2*SIGNAL_RESOLUTION+1:0] llr_full;
    
    saturate #(
        .INPUT_RESOLUTION(2*SIGNAL_RESOLUTION+2),
        .OUTPUT_RESOLUTION(LLR_RESOLUTION),
        .SHIFT(SIGNAL_RESOLUTION-2)//RSB changed from -1
        ) sat (
        .signal_in(llr_full),
        .signal_out(llr));
    
    //assign llr = llr_full>>>SIGNAL_RESOLUTION-1;

    always @(posedge clk) begin
    
        if (!rstn || !signal_in_valid) begin
            valid <=0;
            
        end else begin
            
            valid <=1;
        
            if (e2[0]<=e2[1] && e2[0]<=e2[2] && e2[0]<=e2[3]) begin
            
                symbol_out <= 0;
                llr_full <= e2[1]-e2[0];
                llr_sign <= 1;
                      
            end else if (e2[1]<=e2[0] && e2[1]<=e2[2] && e2[1]<=e2[3]) begin
                symbol_out <= 1;
                if (e2[0]<=e2[2]) begin
                    llr_full <= e2[0]-e2[1];
                    llr_sign <= 1;
                end else begin
                    llr_full <= e2[2]-e2[1];
                    llr_sign <= 0;
                end
                
            end else if (e2[2]<=e2[0] && e2[2]<=e2[1] && e2[2]<=e2[3]) begin
                symbol_out <= 2;
                if (e2[1]<=e2[3]) begin
                    llr_full <= e2[1]-e2[2];
                    llr_sign <= 0;
                end else begin
                    llr_full <= e2[3]-e2[2];
                    llr_sign <= 1;
                end
                
            end else begin
                symbol_out <= 3;
                llr_full <= e2[2]-e2[3];
                llr_sign <= 1;
            end
        
        end
    end

    
endmodule

//LSB is positive
//MSB is negative

module saturate #(
    parameter INPUT_RESOLUTION = 6,
    parameter OUTPUT_RESOLUTION = 6,
    parameter SHIFT = 7)(
    
    input wire [INPUT_RESOLUTION-1:0] signal_in,
    output reg [OUTPUT_RESOLUTION-1:0] signal_out);
    
    wire [INPUT_RESOLUTION-1:0] signal_shift;
    
    assign signal_shift = signal_in>>SHIFT;
    
    always @ (*) begin
        //if (signal_shift[OUTPUT_RESOLUTION] == 1'b1) begin
        if (signal_shift > {(OUTPUT_RESOLUTION){1'b1}}) begin
            signal_out <= {(OUTPUT_RESOLUTION){1'b1}};
        end else begin
            signal_out <= signal_in>>SHIFT;
        end
    end
    
    endmodule


