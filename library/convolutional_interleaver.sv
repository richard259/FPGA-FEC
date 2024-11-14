`timescale 1ns / 1ps

module convolutional_deinterleaver #(
    //number of bits in outer FEC symbol
    parameter M = 10,
    //number of outer FEC symbols in CI symbol
    parameter W = 1,
    //delay constant
    parameter D = 2,
    //number of sub-lanes
    parameter P = 4,
    
    parameter N_PCS=1)(
    input clk,
    input rstn,
    input data_in,
    input en,
    output data_out,
    output valid);
    
    
    wire [M*W-1:0] ci_symbol;
    wire ci_symbol_valid;
    
    form_ci_symbol #(.W(W), .M(M)) fcs (
        .clk(clk),
        .rstn(rstn),
        .data_in(data_in),
        .en(en),
        .data_out(ci_symbol),
        .valid(ci_symbol_valid));
    
    wire [M*W-1:0] ci_symbol_parallel [P-1:0];
    wire [P-1:0] ci_symbol_parallel_valid;
    
    ci_demux #(.W(W), .M(M), .D(D), .P(P)) cdm (
        .clk(clk),
        .rstn(rstn),
        .en(ci_symbol_valid),
        .data_in(ci_symbol),
        .data_out(ci_symbol_parallel),
        .valid(ci_symbol_parallel_valid));
    
    wire [M*W-1:0] ci_symbol_parallel_delay [P-1:0];
    wire [P-1:0] ci_symbol_parallel_delay_valid;
    
    genvar i;
    
    generate
        for (i=1; i < P; i=i+1) begin
            delay_line #(
                .M(M),
                .W(W),
                .DELAY(i*D)
                ) dl (
                .clk(clk),
                .rstn(rstn),
                .en(ci_symbol_parallel_valid[i]),
                .data_in(ci_symbol_parallel[i]),
                .data_out(ci_symbol_parallel_delay[i]),
                .valid(ci_symbol_parallel_delay_valid[i]));
        end
    endgenerate 
    
    //0-delay line
    
    reg [M*W-1:0] no_delay_line;
    reg no_delay_line_valid;
    
    always @(posedge clk) begin
        no_delay_line <= ci_symbol_parallel[0];
        no_delay_line_valid <= ci_symbol_parallel_valid[0];
    end
       
    
    assign ci_symbol_parallel_delay[0] = no_delay_line;
    assign ci_symbol_parallel_delay_valid[0] = no_delay_line_valid;
    
    wire [M*W-1:0] ci_symbol_serial;
    wire ci_symbol_serial_valid;
    
    ci_mux #(.W(W), .M(M), .D(D), .P(P)) cm (
        .clk(clk),
        .rstn(rstn),
        .data_in(ci_symbol_parallel_delay),
        .en(ci_symbol_parallel_delay_valid),
        .data_out(ci_symbol_serial),
        .valid(ci_symbol_serial_valid));
            
    ci_symbol_to_bits #(.W(W), .M(M), .N_PCS(N_PCS)) cstb (
        .clk(clk),
        .rstn(rstn),
        .data_in(ci_symbol_serial),
        .en(ci_symbol_serial_valid),
        .data_out(data_out),
        .valid(valid));
    
endmodule

module convolutional_interleaver #(
    //number of bits in outer FEC symbol
    parameter M = 10,
    //number of outer FEC symbols in CI symbol
    parameter W = 1,
    //delay constant
    parameter D = 2,
    //number of sub-lanes
    parameter P = 4,
    
    parameter N_PCS=1)(
    input clk,
    input rstn,
    input data_in,
    input en,
    output data_out,
    output valid);
    
    
    wire [M*W-1:0] ci_symbol;
    wire ci_symbol_valid;
    
    form_ci_symbol #(.W(W), .M(M)) fcs (
        .clk(clk),
        .rstn(rstn),
        .data_in(data_in),
        .en(en),
        .data_out(ci_symbol),
        .valid(ci_symbol_valid));
    
    wire [M*W-1:0] ci_symbol_parallel [P-1:0];
    wire [P-1:0] ci_symbol_parallel_valid;
    
    ci_demux #(.W(W), .M(M), .D(D), .P(P)) cdm (
        .clk(clk),
        .rstn(rstn),
        .en(ci_symbol_valid),
        .data_in(ci_symbol),
        .data_out(ci_symbol_parallel),
        .valid(ci_symbol_parallel_valid));
    
    wire [M*W-1:0] ci_symbol_parallel_delay [P-1:0];
    wire [P-1:0] ci_symbol_parallel_delay_valid;
    
    genvar i;
    
    generate
        for (i=0; i < P-1; i=i+1) begin
            delay_line #(
                .M(M),
                .W(W),
                .DELAY((P-1-i)*D)
                ) dl (
                .clk(clk),
                .rstn(rstn),
                .en(ci_symbol_parallel_valid[i]),
                .data_in(ci_symbol_parallel[i]),
                .data_out(ci_symbol_parallel_delay[i]),
                .valid(ci_symbol_parallel_delay_valid[i]));
        end
    endgenerate 
    
    //0-delay line
    
    reg [M*W-1:0] no_delay_line;
    reg no_delay_line_valid;
    
    always @(posedge clk) begin
        no_delay_line <= ci_symbol_parallel[P-1];
        no_delay_line_valid <= ci_symbol_parallel_valid[P-1];
    end
       
    
    assign ci_symbol_parallel_delay[P-1] = no_delay_line;
    assign ci_symbol_parallel_delay_valid[P-1] = no_delay_line_valid;
    
    wire [M*W-1:0] ci_symbol_serial;
    wire ci_symbol_serial_valid;
    
    ci_mux #(.W(W), .M(M), .D(D), .P(P)) cm (
        .clk(clk),
        .rstn(rstn),
        .data_in(ci_symbol_parallel_delay),
        .en(ci_symbol_parallel_delay_valid),
        .data_out(ci_symbol_serial),
        .valid(ci_symbol_serial_valid));
            
    ci_symbol_to_bits #(.W(W), .M(M), .N_PCS(N_PCS)) cstb (
        .clk(clk),
        .rstn(rstn),
        .data_in(ci_symbol_serial),
        .en(ci_symbol_serial_valid),
        .data_out(data_out),
        .valid(valid));
    
endmodule

module ci_mux #(
    //number of bits in outer FEC symbol
    parameter M = 10,
    //number of outer FEC symbols in CI symbol
    parameter W = 1,
    //delay constant
    parameter D = 2,
    //number of sub-lanes
    parameter P = 4)(
    input clk,
    input [M*W-1:0] data_in [P-1:0],
    input rstn,
    input [P-1:0] en,
    output reg [M*W-1:0] data_out,
    output reg valid);
    
    wire [31:0] idx;
    
    onehot_enc #(.WIDTH(P)) ohe (
        .in(en),
        .out(idx)); 
    
    always @ (posedge clk)
        if (!rstn) begin
            valid <= 0;
        end else if (en != 0) begin
            
            data_out<= data_in[idx]; 
            valid <= 1;
            
        end else begin
            valid <= 0;
        end
endmodule


module onehot_enc #(
  parameter WIDTH = 1)(
  input [WIDTH-1:0] in,
  output reg [31:0] out);
   always @ (*) begin
     out = 0;
     for (int i = 0; i < WIDTH; i++) begin
       if (in[i])
         out = i;
     end
   end
endmodule


module ci_demux #(
    //number of bits in outer FEC symbol
    parameter M = 10,
    //number of outer FEC symbols in CI symbol
    parameter W = 1,
    //delay constant
    parameter D = 2,
    //number of sub-lanes
    parameter P = 4)(
    input clk,
    input [M*W-1:0] data_in,
    input rstn,
    input en,
    output reg [M*W-1:0] data_out [P-1:0],
    output reg [P-1:0] valid);
    
    reg [31:0] last_idx;
    reg [31:0] idx;
    
    always @ (posedge clk)
        if (!rstn) begin
            valid <= 0;
            idx <= 0;
            last_idx = P;
        end else if (en) begin
            last_idx <= idx;
            data_out[idx] <= data_in;
            
            valid[idx] <= 1;
            
            if  (P>1) begin
                valid[last_idx] <= 0;
            end
            
            
            if (idx == P-1) begin
                idx<= 0;
                
            end else begin
                idx<= idx+1;
            end
        end else begin
            valid <= 0;
        end
                
endmodule

module delay_line #(
    //number of bits in outer FEC symbol
    parameter M = 10,
    //number of outer FEC symbols in CI symbol
    parameter W = 1,
    //total number of ci symbol delays
    parameter DELAY)(
    input clk,
    input [M*W-1:0] data_in,
    input rstn,
    input en,
    output reg [M*W-1:0] data_out,
    output reg valid = 0);
    
    //reg [M*W-1:0] sr [DELAY-1:0];
    
    reg [M*W-1:0] sr [DELAY-1:0] = '{default:'0};
    
    reg [31:0] count = 0;
    
    always @ (posedge clk)
        if (!rstn) begin
            valid <= 0;
            count <= 0;
            //added
            sr <= '{default:'0};
            
        end else if (en) begin
            //sr not yet full
            //if (count < (DELAY)) begin
            //   sr <= {data_in,sr[DELAY-1:1]};
            //    count <= count +1;
            //end else begin
                data_out <= sr[0];
                valid<=1;
                sr <= {data_in,sr[DELAY-1:1]};
           // end       
        end else begin
            valid<=0;
        end
 endmodule
                
    

module form_ci_symbol #(
    //number of bits in outer FEC symbol
    parameter M = 10,
    //number of outer FEC symbols in CI symbol
    parameter W = 1)(
    input clk,
    input data_in,
    input rstn,
    input en,
    output reg [M*W-1:0] data_out,
    output reg valid =0);
    
    reg [31:0] bit_idx = 0;
    
    reg [M*W-2:0] buffer;
    
    always @ (posedge clk)
        
        if (!rstn) begin
            valid <= 0;
            bit_idx <= 0;
            
        end else begin
        
            if (en) begin
                if (bit_idx == M*W-1) begin
                    data_out <= {data_in,buffer};
                    valid <= 1;
                    bit_idx <= 0;
                end else begin
                    buffer[bit_idx] <= data_in;
                    bit_idx <= bit_idx+1;
                    valid <= 0;    
                end
            end else begin
            valid <=0;
        end 
    end     
endmodule

module ci_symbol_to_bits #(
    //number of bits in outer FEC symbol
    parameter M = 10,
    //number of outer FEC symbols in CI symbol
    parameter W = 1,
    //number of PCS Lanes
    parameter N_PCS = 1)(
    input clk,
    input [M*W-1:0] data_in,
    input rstn,
    input en,
    output reg data_out,
    output reg valid =0);
    
    reg [M*W-1:0] buffer;
    reg [31:0] bit_idx;
    
    reg [7:0] count = 0;
    
    always @ (posedge clk)
        
        if (!rstn) begin
            valid <= 0;
            bit_idx <= M*W;
            count <= 0;
            
        end else begin
            if (en) begin
                buffer <= data_in;
                data_out <= data_in[0];
                bit_idx <= 1;
                valid<=1;
                count <= 1;
            end else begin
                count <= (count + 1)%(N_PCS*2);
                if (bit_idx<M*W && (count<2)) begin
                    bit_idx <= bit_idx+1;
                    data_out <= buffer[bit_idx];
                    valid<=1;
                end else begin
                    valid <=0;
                end
            end
        end 
  
endmodule