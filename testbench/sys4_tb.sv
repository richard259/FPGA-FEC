`timescale 1ns / 1ps

module sys4_tb;

    reg clk=0;
    reg en;
    reg rstn;
    reg ifec_en = 1;
    
    reg [63:0] probability_in;
    reg [31:0] probability_idx= 32'hFFFFFFFF;
    
    reg [3:0] n_interleave = 4;
    
	wire [63:0] total_bits;
	wire [63:0] total_bit_errors_pre;
	wire [63:0] total_bit_errors_post;
	wire [63:0] total_frames;
	wire [63:0] total_frame_errors;
	

    parallel_sys4 #(.N_CORES(10)) dut (
    //ber_top #() dut (
	   .clk(clk),
	   .en(en),
	   .rstn(rstn),
	   .probability_in(probability_in),
	   .probability_idx(probability_idx),
	   .ifec_en(ifec_en),
	   .n_interleave(n_interleave),
	   .total_bits(total_bits),
	   .total_bit_errors_pre(total_bit_errors_pre),
	   .total_bit_errors_post(total_bit_errors_post),
	   .total_frames(total_frames),
	   .total_frame_errors(total_frame_errors));
	   
	           
    always #10 clk = ~clk;
    
    integer i;
  
    reg [63:0] probability_mem [63:0];
    
    initial begin
        en<=0;
        rstn <= 0;
        //$readmemh("no_noise.mem", probability_mem);
         $readmemh("noise15dB.mem", probability_mem);
        
        for (i=0;i<64;i=i+1) begin
            #20
            probability_idx <= i;
            probability_in <= probability_mem[i];
        end
        
        #20
        probability_idx <= 32'hFFFFFFFF;

        #20 
        en<= 1;
        rstn <=1;        
         
        
    end

endmodule
