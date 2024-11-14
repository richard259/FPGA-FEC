`timescale 1ns / 1ps

module sys1_tb;

    reg clk=0;
    reg en;
    reg rstn;
    
    reg precode_en = 0;
    
    reg [63:0] probability_in;
    reg [31:0] probability_idx= 32'hFFFFFFFF;
    
    reg [3:0] n_interleave = 1;
    
	wire [63:0] total_bits;
	wire [63:0] total_bit_errors_pre;
	wire [63:0] total_bit_errors_post;
	wire [63:0] total_frames;
	wire [63:0] total_frame_errors;
	

    parallel_sys1 #() dut (
	   .clk(clk),
	   .en(en),
	   .rstn(rstn),
	   .probability_in(probability_in),
	   .probability_idx(probability_idx),
	   .precode_en(precode_en),
	   .n_interleave(n_interleave),
	   .total_bits(total_bits),
	   .total_bit_errors_pre(total_bit_errors_pre),
	   .total_bit_errors_post(total_bit_errors_post),
	   .total_frames(total_frames),
	   .total_frame_errors(total_frame_errors));
	   
	           
    always #10 clk = ~clk;
    
    
    initial begin
        en<=0;
        rstn <= 0;
        probability_idx <= 32'hFFFFFFFF;
        #20
        
        probability_idx <= 0;
        probability_in <= 64'h028f5c28f5c28f60;
        
        #20
        probability_idx <= 1;
        probability_in <= 64'hc000000000000000;
        
        #20
        probability_idx <= 32'hFFFFFFFF;

        #20 
        en<= 1;
        rstn <=1;        
        
    end

endmodule
