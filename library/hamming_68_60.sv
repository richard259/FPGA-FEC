`timescale 1ns / 1ps

//combinational logic to calculate 8 parity bits from 60 information bits

module enc_68_60 (
    input [59:0] data_in,
	output [7:0] parity);
    
//    assign parity[0] = data_in[0]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[40]^data_in[48]^data_in[57]^data_in[58]^data_in[59];
//    assign parity[1] = data_in[0]^data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[9]^data_in[16]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[24]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[33]^data_in[40]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[49]^data_in[56]^data_in[58]^data_in[59];
//    assign parity[2] = data_in[0]^data_in[1]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[18]^data_in[26]^data_in[32]^data_in[33]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[40]^data_in[41]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[50]^data_in[56]^data_in[57]^data_in[59];
//    assign parity[3] = data_in[0]^data_in[1]^data_in[2]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[10]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[19]^data_in[24]^data_in[25]^data_in[26]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[35]^data_in[43]^data_in[48]^data_in[49]^data_in[50]^data_in[52]^data_in[53]^data_in[54]^data_in[55]^data_in[59];
//    assign parity[4] = data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[5]^data_in[6]^data_in[7]^data_in[12]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[21]^data_in[22]^data_in[23]^data_in[28]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[37]^data_in[38]^data_in[39]^data_in[44]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[53]^data_in[54]^data_in[55];
//    assign parity[5] = data_in[5]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[14]^data_in[15]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[22]^data_in[23]^data_in[29]^data_in[37]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[46]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[54]^data_in[55];
//    assign parity[6] = data_in[6]^data_in[14]^data_in[22]^data_in[24]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[39]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[53]^data_in[55];
//    assign parity[7] = data_in[7]^data_in[15]^data_in[23]^data_in[31]^data_in[39]^data_in[47]^data_in[55]^data_in[56]^data_in[57]^data_in[58]^data_in[59];
    
    assign parity[0] = data_in[0]^data_in[3]^data_in[4]^data_in[7]^data_in[9]^data_in[11]^data_in[12]^data_in[16]^data_in[17]^data_in[22]^data_in[25]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[32]^data_in[34]^data_in[36]^data_in[42]^data_in[44]^data_in[45]^data_in[47]^data_in[49]^data_in[50]^data_in[51]^data_in[54]^data_in[58]^data_in[59];
    assign parity[1] = data_in[1]^data_in[3]^data_in[5]^data_in[7]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[13]^data_in[16]^data_in[18]^data_in[22]^data_in[23]^data_in[25]^data_in[26]^data_in[27]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[42]^data_in[43]^data_in[44]^data_in[46]^data_in[47]^data_in[48]^data_in[49]^data_in[52]^data_in[54]^data_in[55]^data_in[58];
    assign parity[2] = data_in[2]^data_in[4]^data_in[6]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[14]^data_in[17]^data_in[19]^data_in[23]^data_in[24]^data_in[26]^data_in[27]^data_in[28]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[43]^data_in[44]^data_in[45]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[53]^data_in[55]^data_in[56]^data_in[59];
    assign parity[3] = data_in[0]^data_in[4]^data_in[5]^data_in[10]^data_in[13]^data_in[15]^data_in[16]^data_in[17]^data_in[18]^data_in[20]^data_in[22]^data_in[24]^data_in[30]^data_in[32]^data_in[33]^data_in[35]^data_in[37]^data_in[38]^data_in[39]^data_in[42]^data_in[46]^data_in[47]^data_in[48]^data_in[56]^data_in[57]^data_in[58]^data_in[59];
    assign parity[4] = data_in[1]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[9]^data_in[12]^data_in[14]^data_in[18]^data_in[19]^data_in[21]^data_in[22]^data_in[23]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[32]^data_in[33]^data_in[38]^data_in[39]^data_in[40]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[48]^data_in[50]^data_in[51]^data_in[54]^data_in[57];
    assign parity[5] = data_in[0]^data_in[2]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[10]^data_in[13]^data_in[15]^data_in[19]^data_in[20]^data_in[22]^data_in[23]^data_in[24]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[39]^data_in[40]^data_in[41]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[49]^data_in[51]^data_in[52]^data_in[55]^data_in[58];
    assign parity[6] = data_in[1]^data_in[3]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[11]^data_in[14]^data_in[16]^data_in[20]^data_in[21]^data_in[23]^data_in[24]^data_in[25]^data_in[29]^data_in[30]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[40]^data_in[41]^data_in[42]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[50]^data_in[52]^data_in[53]^data_in[56]^data_in[59];
    assign parity[7] = data_in[2]^data_in[3]^data_in[6]^data_in[8]^data_in[10]^data_in[11]^data_in[15]^data_in[16]^data_in[21]^data_in[24]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[31]^data_in[33]^data_in[35]^data_in[41]^data_in[43]^data_in[44]^data_in[46]^data_in[48]^data_in[49]^data_in[50]^data_in[53]^data_in[57]^data_in[58]^data_in[59];

    
endmodule

module codeword_xor (
    input [119:0] data_in,
    input en,
	output reg [59:0] data_out);
    
    genvar i;
    
    generate
    for (i=0;i<60;i=i+1) begin
        always @(posedge en) begin
            data_out[i] <= data_in[i*2]^data_in[i*2+1];
        end
    end
    endgenerate
    
endmodule

//hamming encoder
module hamming_enc_68_60 #(
    //number of virtual PCS lanes in optical module
    parameter N_PCS = 1,
    parameter DELAY_PARITY=0)(
    input clk,
    input rstn,
    input data_in,
    input data_in_valid,
    output reg data_out,
    output reg valid = 0);
    
    //state 0: length: 120  input: r1       output: none    action: none
    //state 1: length: 8    input: none     output: none    action: calculate p1
    //state 2: length: 120  input: r2       output: r1      action: none
    //state 3: length: 8    input: none     output: p1      action: calculate p2
    //state 4: length: 120  input r1,       output: r2      action: none
    //state 5: length: 8    input:none      output: p2      action: calculate p1
    //then back to state 2
    
    reg [7:0] state = 0;    
    reg [7:0] counter = 0;
    
    //for channel interleaving
    reg [31:0] delay = 0;
    
    reg [119:0] r1_temp;
    wire [59:0] r1;
    wire [7:0] p1;
    reg xor_en1;
    
    codeword_xor xor1 (
        .data_in(r1_temp),
        .data_out(r1),
        .en(xor_en1));
    
    enc_68_60 e1 (
        .data_in(r1),
        .parity(p1));
    
    reg [119:0] r2_temp;
    reg [59:0] r2;
    wire [7:0] p2;
    reg xor_en2;
    
    codeword_xor xor2 (
        .data_in(r2_temp),
        .data_out(r2),
        .en(xor_en2));
        
    enc_68_60 e2 (
        .data_in(r2),
        .parity(p2));
    
    always @ (posedge clk)
        
        if (!rstn) begin
            state <= 0;
            counter = 0;
            valid <= 0;
            delay<=2;
            
        end else begin
        
            //data_in_valid is just to start the encoder, after we expect 120 valid followed by 8 cycles pause. 
            if (state==0 && data_in_valid) begin
                counter <= counter + 1;
                r1_temp[counter] <= data_in;
                valid <= 0;
                
                if (counter == 119) begin
                    state <= 1;
                    counter <= 0;
                end
                
            end else if (state == 1) begin
                counter <= counter + 1;
                if (counter ==0) begin
                    xor_en1 <= 1;
                end else if (counter == 7) begin
                    xor_en1 <= 0;
                    state <= 2;
                    counter <= 0;
                end
            
            end else if (state == 2 && data_in_valid) begin
                counter <= counter + 1;
                
                r2_temp[counter] <= data_in;
                data_out <= r1_temp[counter];
                valid <= 1;
                
                if (counter == 119) begin
                    state <= 3;
                    counter <= 0;
                    delay<=0;
                end
            
            end else if (state ==3) begin
            
                //delay <= (delay + 1)%(N_PCS*2);
                delay <= (delay + 1);
                
                //if (delay<2 || N_PCS == 1) begin
                //if (delay>= (N_PCS-1)*W*10 || N_PCS == 1) begin
                if (delay>= DELAY_PARITY || N_PCS == 1) begin
                
                    counter <= counter + 1;
                    data_out<= p1[counter];
                    valid <= 1;
                    
                    if (counter ==0) begin
                        xor_en2 <= 1;
                    end else if (counter == 7) begin
                        xor_en2 <= 0;
                        state <= 4;
                        counter <= 0;
                    end
                
                end else begin
                    valid<=0;
                end
                
            end else if (state == 4 && data_in_valid) begin
                counter <= counter + 1;
                
                r1_temp[counter] <= data_in;
                data_out <= r2_temp[counter];
                valid <= 1;
                
                if (counter == 119) begin
                    state <= 5;
                    counter <= 0;
                    //delay<=2;
                    delay <= 0;
                end
            
            end else if (state == 5) begin
            
            //delay <= (delay + 1)%(N_PCS*2);
            delay <= (delay + 1);
            
                //if (delay<2 || N_PCS == 1) begin
                if (delay>= DELAY_PARITY || N_PCS == 1) begin
                
                    counter <= counter + 1;
                    
                    data_out<= p2[counter];
                    valid <= 1;
                    
                    if (counter ==0) begin
                        xor_en1 <= 1;
                    end else if (counter == 7) begin
                        xor_en1 <= 0;
                        state <= 2;
                        counter <= 0;
                    end
                end else begin
                    valid<=0;
                end
            end else begin
                valid<=0;
            end
    end
        
endmodule

module dec_68_60 (
    input [67:0] data_in,
	output [7:0] syndrome);
	
//    assign syndrome[0] = data_in[0]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[40]^data_in[48]^data_in[57]^data_in[58]^data_in[59]^data_in[60];
//    assign syndrome[1] = data_in[0]^data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[9]^data_in[16]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[24]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[33]^data_in[40]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[49]^data_in[56]^data_in[58]^data_in[59]^data_in[61];
//    assign syndrome[2] = data_in[0]^data_in[1]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[18]^data_in[26]^data_in[32]^data_in[33]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[40]^data_in[41]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[50]^data_in[56]^data_in[57]^data_in[59]^data_in[62];
//    assign syndrome[3] = data_in[0]^data_in[1]^data_in[2]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[10]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[19]^data_in[24]^data_in[25]^data_in[26]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[35]^data_in[43]^data_in[48]^data_in[49]^data_in[50]^data_in[52]^data_in[53]^data_in[54]^data_in[55]^data_in[59]^data_in[63];
//    assign syndrome[4] = data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[5]^data_in[6]^data_in[7]^data_in[12]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[21]^data_in[22]^data_in[23]^data_in[28]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[37]^data_in[38]^data_in[39]^data_in[44]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[53]^data_in[54]^data_in[55]^data_in[64];
//    assign syndrome[5] = data_in[5]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[14]^data_in[15]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[22]^data_in[23]^data_in[29]^data_in[37]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[46]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[54]^data_in[55]^data_in[65];
//    assign syndrome[6] = data_in[6]^data_in[14]^data_in[22]^data_in[24]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[39]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[53]^data_in[55]^data_in[66];
//    assign syndrome[7] = data_in[7]^data_in[15]^data_in[23]^data_in[31]^data_in[39]^data_in[47]^data_in[55]^data_in[56]^data_in[57]^data_in[58]^data_in[59]^data_in[67];
    
    assign syndrome[0] = data_in[0]^data_in[3]^data_in[4]^data_in[7]^data_in[9]^data_in[11]^data_in[12]^data_in[16]^data_in[17]^data_in[22]^data_in[25]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[32]^data_in[34]^data_in[36]^data_in[42]^data_in[44]^data_in[45]^data_in[47]^data_in[49]^data_in[50]^data_in[51]^data_in[54]^data_in[58]^data_in[59]^data_in[60];
    assign syndrome[1] = data_in[1]^data_in[3]^data_in[5]^data_in[7]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[13]^data_in[16]^data_in[18]^data_in[22]^data_in[23]^data_in[25]^data_in[26]^data_in[27]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[42]^data_in[43]^data_in[44]^data_in[46]^data_in[47]^data_in[48]^data_in[49]^data_in[52]^data_in[54]^data_in[55]^data_in[58]^data_in[61];
    assign syndrome[2] = data_in[2]^data_in[4]^data_in[6]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[14]^data_in[17]^data_in[19]^data_in[23]^data_in[24]^data_in[26]^data_in[27]^data_in[28]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[43]^data_in[44]^data_in[45]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[53]^data_in[55]^data_in[56]^data_in[59]^data_in[62];
    assign syndrome[3] = data_in[0]^data_in[4]^data_in[5]^data_in[10]^data_in[13]^data_in[15]^data_in[16]^data_in[17]^data_in[18]^data_in[20]^data_in[22]^data_in[24]^data_in[30]^data_in[32]^data_in[33]^data_in[35]^data_in[37]^data_in[38]^data_in[39]^data_in[42]^data_in[46]^data_in[47]^data_in[48]^data_in[56]^data_in[57]^data_in[58]^data_in[59]^data_in[63];
    assign syndrome[4] = data_in[1]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[9]^data_in[12]^data_in[14]^data_in[18]^data_in[19]^data_in[21]^data_in[22]^data_in[23]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[32]^data_in[33]^data_in[38]^data_in[39]^data_in[40]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[48]^data_in[50]^data_in[51]^data_in[54]^data_in[57]^data_in[64];
    assign syndrome[5] = data_in[0]^data_in[2]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[10]^data_in[13]^data_in[15]^data_in[19]^data_in[20]^data_in[22]^data_in[23]^data_in[24]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[39]^data_in[40]^data_in[41]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[49]^data_in[51]^data_in[52]^data_in[55]^data_in[58]^data_in[65];
    assign syndrome[6] = data_in[1]^data_in[3]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[11]^data_in[14]^data_in[16]^data_in[20]^data_in[21]^data_in[23]^data_in[24]^data_in[25]^data_in[29]^data_in[30]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[40]^data_in[41]^data_in[42]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[50]^data_in[52]^data_in[53]^data_in[56]^data_in[59]^data_in[66];
    assign syndrome[7] = data_in[2]^data_in[3]^data_in[6]^data_in[8]^data_in[10]^data_in[11]^data_in[15]^data_in[16]^data_in[21]^data_in[24]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[31]^data_in[33]^data_in[35]^data_in[41]^data_in[43]^data_in[44]^data_in[46]^data_in[48]^data_in[49]^data_in[50]^data_in[53]^data_in[57]^data_in[58]^data_in[59]^data_in[67];
    
    
endmodule



(* use_dsp = "yes" *) module llr_adder #(
    parameter LLR_RESOLUTION = 5,
    parameter Q = 6)(
    input wire [LLR_RESOLUTION-1:0] in [Q-1:0],
    output wire [15:0] out);
    
    genvar i;
    
    reg [15:0] sumreg [Q-1:0];
    
    assign sumreg[0] = in[0];
    
    generate
    
        for(i=1;i<Q;i++)begin
            assign sumreg[i] = sumreg[i-1]+in[i]; 
        end
    
    endgenerate
    
    assign out = sumreg[Q-1];

endmodule

(* use_dsp = "yes" *) module hamming_dec_68_60 #(
    //bit resolution of LLR output
    parameter LLR_RESOLUTION = 5,
    
    //number of low-reliability bits that are tested with test patterns
    parameter Q = 6,
    
    //number of test patterns for chase decoder
    parameter N_TP = 42)(
    input clk,
    input rstn,
    input [1:0] symbol_in,
    input symbol_in_valid,
    input [LLR_RESOLUTION-1:0] llr_in,
    input llr_sign,
    input en,
    output reg data_out,
    output reg valid = 0);
    
    //take absolute value of log-likelihood ratio
    //wire [LLR_RESOLUTION-1:0] abs_llr;
    //assign abs_llr = llr_in[LLR_RESOLUTION-1] ? -llr_in : llr_in;

    //look-up table for to map syndrome values to error locations. 
    //syndrome_lut[syndrome] is error location. if syndrome_lut[s] = 8'hFF, decoder failure
    reg [7:0] syndrome_lut [255:0];
    initial $readmemh("syndrome_lut_68_60.mem", syndrome_lut);
    
    
    //test patterns for least reliable Q bits 
    reg [Q-1:0] test_patterns [N_TP-1:0];
    initial $readmemh("test_patterns.mem", test_patterns);
    
    //state 0: input new codeword and output decoded codeword (binary)
    //state 1: 
    //state 2: 
    //state 3: 
    //state 4: 
    
    //FSM state
    reg [7:0] state = 0;
    
    //track input symbol index
    reg [7:0] counter = 0;
    
    //track test pattern index
    reg [7:0] test_pattern_idx = 0;
    
    //input binary codeword
    reg [119:0] data1_reg;
    
    //reg to hold corrected binary codeword 
    reg [119:0] data_output_reg;
    
    //reg to hold input to decoder (first 60b are xored PAM symbols, last 8 parity bits are from 4 PAM symbols)
    reg [67:0] symbol1_reg;
    //LLrs of the corresponding PAM symbols
    reg [LLR_RESOLUTION-1:0] llr1_reg [63:0];
    //Sign of LLRs indicating if error in MSB or LSB
    reg llr1_sign_reg [63:0];
    
    //reg to hold index ot the least reliable Q symbols
    reg [7:0] least_reliable_symbols [Q-1:0] = '{default:'0};
    //reg to hold absolut value of the least Q LLRs 
    reg [LLR_RESOLUTION-1:0] least_llrs [Q-1:0] = '{default:'1};
   
    //syndrome
    reg [7:0] syndrome1;
    
    //error location corresponding to syndrome
    reg [7:0] error_location;
    
    //reg at input to combinational decoder block
    reg [67:0] dec1_in;
    
    
    //combinational decoder block, calculates syndrome
    dec_68_60 dec1 (
        .data_in(dec1_in),
        .syndrome(syndrome1));
   
    //reg to sum up LLRS for all bits flipped in test pattern
    reg [LLR_RESOLUTION-1:0] adder_in [Q-1:0] = '{default:'0};
    //sum of adder_in
    reg [15:0] tp_wt;
    
    //module to add up LLRs for each bit flip in test pattern
    llr_adder #(.LLR_RESOLUTION(LLR_RESOLUTION), .Q(Q)) adder(
        .in(adder_in),
        .out(tp_wt));
    
    //variables to track info about test-pattern that results in most-reliable codeword
    reg [15:0] most_reliable_tp_wt = 16'hFFFF;
    reg [15:0] most_reliable_tp_idx = 0;
    reg [7:0] most_reliable_error_location = 0;
    reg [15:0] current_tp_reliability = 16'hFFFF;
    
    // flag when codeword is ready for output
    reg output_ready = 0;
    //counter for output bits
    reg [7:0] output_counter = 0;
       
    always @ (posedge clk) begin
        
        if (!rstn) begin
            state <= 0;
            counter <= 0;
            test_pattern_idx <=0;
            valid <=0;
            least_llrs <= '{default:'1};
            output_ready <=0;
            output_counter <=0;
            
            most_reliable_tp_wt <= 16'hFFFF;
            most_reliable_tp_idx <= 0;
            most_reliable_error_location <= 0;
            current_tp_reliability <= 16'hFFFF;
            adder_in <='{default:'0};
            
        end else begin
        
            
            if (state == 0) begin
            
                if (output_ready) begin
                
                        data_out <= data_output_reg[output_counter];
                        valid <=1;
                        output_counter <= output_counter+1;
                        
                        if (output_counter == 119) begin
                            output_ready <= 0;
                            output_counter <= 0;
                        end
                end else begin
                    valid <=0;
                end
            
                if  (symbol_in_valid == 1) begin
                
                    counter <= counter + 1;
                    
                    //record new symbol reliability                                 
                    llr1_reg[counter] <= llr_in;
                    //record sign of llr
                    llr1_sign_reg[counter] <= llr_sign;
                    
                    //record grey decoded data as well as xored data for information bits
                    if (counter<60) begin
                        if (symbol_in == 0) begin
                            data1_reg[counter*2] <= 1'b0;
                            data1_reg[counter*2+1] <= 1'b0;
                            symbol1_reg[counter] <= 1'b0;
                            
                        end else if (symbol_in == 1) begin 
                            data1_reg[counter*2] <= 1'b0;
                            data1_reg[counter*2+1] <= 1'b1;
                            symbol1_reg[counter] <= 1'b1;
                            
                        end else if (symbol_in ==2) begin
                            data1_reg[counter*2] <= 1'b1;
                            data1_reg[counter*2+1] <= 1'b1;
                            symbol1_reg[counter] <= 1'b0;
                            
                        end else begin
                            data1_reg[counter*2] <= 1'b1;
                            data1_reg[counter*2+1] <= 1'b0;
                            symbol1_reg[counter] <= 1'b1;
                        end
                        
                    //record parity bits
                    end else begin
                        if (symbol_in == 0) begin
                            symbol1_reg[60+(counter-60)*2] <= 1'b0;
                            symbol1_reg[60+(counter-60)*2+1] <= 1'b0;
                            
                        end else if (symbol_in == 1) begin 
                            symbol1_reg[60+(counter-60)*2] <= 1'b0;
                            symbol1_reg[60+(counter-60)*2+1] <= 1'b1;
                            
                        end else if (symbol_in ==2) begin
                            symbol1_reg[60+(counter-60)*2] <= 1'b1;
                            symbol1_reg[60+(counter-60)*2+1] <= 1'b1;
                            
                        end else begin
                            symbol1_reg[60+(counter-60)*2] <= 1'b1;
                            symbol1_reg[60+(counter-60)*2+1] <= 1'b0;
                        end

                    end
                                       
                    //sort least reliable Q symbols as they come in
                    if (llr_in<least_llrs[0]) begin
                        least_llrs[0] <= llr_in;
                        least_reliable_symbols[0] <= counter;
                        
                        least_llrs[Q-1:1] <= least_llrs[Q-2:0];
                        least_reliable_symbols[Q-1:1] <= least_reliable_symbols[Q-2:0];
                        
                    end else if (llr_in<least_llrs[1]) begin
                        least_llrs[1] <= llr_in;
                        least_reliable_symbols[1] <= counter;
                        
                        least_llrs[Q-1:2] <= least_llrs[Q-2:1];
                        least_reliable_symbols[Q-1:2] <= least_reliable_symbols[Q-2:1];
                        
                    end else if  (llr_in<least_llrs[2]) begin
                        least_llrs[2] <= llr_in;
                        least_reliable_symbols[2] <= counter;
                                                
                        least_llrs[Q-1:3] <= least_llrs[Q-2:2];
                        least_reliable_symbols[Q-1:3] <= least_reliable_symbols[Q-2:2];
                        
                    end else if  (llr_in<least_llrs[3]) begin
                        least_llrs[3] <= llr_in;
                        least_reliable_symbols[3] <= counter;
                                                
                        least_llrs[Q-1:4] <= least_llrs[Q-2:3];
                        least_reliable_symbols[Q-1:4] <= least_reliable_symbols[Q-2:3];
                        
                    end else if  (llr_in<least_llrs[4]) begin
                        least_llrs[4] <= llr_in;
                        least_reliable_symbols[4] <= counter;
                        
                                                
                        least_llrs[5] <= least_llrs[4];
                        least_reliable_symbols[5] <= least_reliable_symbols[4];
                        
                    end else if  (llr_in<least_llrs[5]) begin
                        
                        least_llrs[5] <= llr_in;
                        least_reliable_symbols[5] <= counter;
                    end
                    //when full codeword is received, go to next state
                    if (counter == 63) begin
                        state <= 1;
                        counter <= 0;
                    end
                end                
               
            end else if (state ==1) begin
            
                //enter ML recieved sequence to decoder input
                dec1_in <= symbol1_reg;
                state <= 2;
            
            //apply test_pattern and calculate analog weight for just test pattern
            end else if (state ==2) begin
            
                if (test_patterns[test_pattern_idx][0] == 1) begin
                    adder_in[0] <= least_llrs[0];
                    //bit flip is in info bits
                    if (least_reliable_symbols[0] <60) begin
                       dec1_in[least_reliable_symbols[0]] <= ~ dec1_in[least_reliable_symbols[0]];
                       //bit flip is in party bits
                   end else begin
                        dec1_in[60+(least_reliable_symbols[0]-60)*2+llr1_sign_reg[least_reliable_symbols[0]]] <= ~ dec1_in[60+(least_reliable_symbols[0]-60)*2+llr1_sign_reg[least_reliable_symbols[0]]];
                   end
                    
                end if (test_patterns[test_pattern_idx][1] == 1) begin
                    adder_in[1] <= least_llrs[1];
                    //bit flip is in info bits
                    if (least_reliable_symbols[1] <60) begin
                       dec1_in[least_reliable_symbols[1]] <= ~ dec1_in[least_reliable_symbols[1]];
                       //bit flip is in party bits
                   end else begin
                        dec1_in[60+(least_reliable_symbols[1]-60)*2+llr1_sign_reg[least_reliable_symbols[1]]] <= ~ dec1_in[60+(least_reliable_symbols[1]-60)*2+llr1_sign_reg[least_reliable_symbols[1]]];
                   end
                    
                end if (test_patterns[test_pattern_idx][2] == 1) begin
                    adder_in[2] <= least_llrs[2];
                        //bit flip is in info bits
                    if (least_reliable_symbols[2] <60) begin
                       dec1_in[least_reliable_symbols[2]] <= ~ dec1_in[least_reliable_symbols[2]];
                       //bit flip is in party bits
                   end else begin
                        dec1_in[60+(least_reliable_symbols[2]-60)*2+llr1_sign_reg[least_reliable_symbols[2]]] <= ~ dec1_in[60+(least_reliable_symbols[2]-60)*2+llr1_sign_reg[least_reliable_symbols[2]]];
                   end
                    
                end if (test_patterns[test_pattern_idx][3] == 1) begin
                    adder_in[3] <= least_llrs[3];
                                            //bit flip is in info bits
                    if (least_reliable_symbols[3] <60) begin
                       dec1_in[least_reliable_symbols[3]] <= ~ dec1_in[least_reliable_symbols[3]];
                       //bit flip is in party bits
                   end else begin
                        dec1_in[60+(least_reliable_symbols[3]-60)*2+llr1_sign_reg[least_reliable_symbols[3]]] <= ~ dec1_in[60+(least_reliable_symbols[3]-60)*2+llr1_sign_reg[least_reliable_symbols[3]]];
                   end
                    
                end if (test_patterns[test_pattern_idx][4] == 1) begin
                    adder_in[4] <= least_llrs[4];
                                            //bit flip is in info bits
                    if (least_reliable_symbols[4] <60) begin
                       dec1_in[least_reliable_symbols[4]] <= ~ dec1_in[least_reliable_symbols[4]];
                       //bit flip is in party bits
                   end else begin
                        dec1_in[60+(least_reliable_symbols[4]-60)*2+llr1_sign_reg[least_reliable_symbols[4]]] <= ~ dec1_in[60+(least_reliable_symbols[4]-60)*2+llr1_sign_reg[least_reliable_symbols[4]]];
                   end
                    
                end if (test_patterns[test_pattern_idx][5] == 1) begin
                    adder_in[5] <= least_llrs[5];
                                            //bit flip is in info bits
                    if (least_reliable_symbols[5] <60) begin
                       dec1_in[least_reliable_symbols[5]] <= ~ dec1_in[least_reliable_symbols[5]];
                       //bit flip is in party bits
                   end else begin
                       dec1_in[60+(least_reliable_symbols[5]-60)*2+llr1_sign_reg[least_reliable_symbols[5]]] <= ~ dec1_in[60+(least_reliable_symbols[5]-60)*2+llr1_sign_reg[least_reliable_symbols[5]]];
                   end
                end
            
                state <= 3;
            
            //find error location
            end else if (state == 3) begin
                
                //test_pattern_weights[test_pattern_idx] <= tp_wt;
                current_tp_reliability <= tp_wt;
                adder_in <= '{default:'0};
                error_location <= syndrome_lut[syndrome1];
                state <= 4;
            
            //calculate analog weight with correction
            end else if (state == 4) begin
            
                //no added weight for valid codeword
                if (syndrome1 == 8'h00) begin
                    //check if most reliable
                    if (current_tp_reliability < most_reliable_tp_wt) begin
                        most_reliable_tp_wt <= current_tp_reliability;
                        most_reliable_tp_idx <= test_pattern_idx;                        
                        most_reliable_error_location <= 8'hFF;
                    end
                end else if (error_location == 8'hFF) begin
                    //not valid codeword, don't consider it
                    
                //add weight for error bit and check if most reliable
                end else if (current_tp_reliability+llr1_reg[error_location] < most_reliable_tp_wt) begin
                    most_reliable_tp_wt <= current_tp_reliability+llr1_reg[error_location];
                    most_reliable_tp_idx <= test_pattern_idx;  
                    most_reliable_error_location <= error_location;
                
                end
                
                if (test_pattern_idx < 41) begin
                    test_pattern_idx <= test_pattern_idx + 1;
                    state <= 1;
                end else begin
                    state <= 5;
                end
                
            //perform correction for most reliable test pattern
            end else if (state == 5) begin
            
                // only correct if in info bits
                if (test_patterns[most_reliable_tp_idx][0] == 1 && least_reliable_symbols[0]<60) begin
                    data1_reg[least_reliable_symbols[0]*2+llr1_sign_reg[least_reliable_symbols[0]]] <= ~data1_reg[least_reliable_symbols[0]*2+llr1_sign_reg[least_reliable_symbols[0]]];
                    
                end if (test_patterns[most_reliable_tp_idx][1] == 1 && least_reliable_symbols[1]<60) begin
                    data1_reg[least_reliable_symbols[1]*2+llr1_sign_reg[least_reliable_symbols[1]]] <= ~data1_reg[least_reliable_symbols[1]*2+llr1_sign_reg[least_reliable_symbols[1]]];
                    
                end if (test_patterns[most_reliable_tp_idx][2] == 1 && least_reliable_symbols[2]<60) begin
                    data1_reg[least_reliable_symbols[2]*2+llr1_sign_reg[least_reliable_symbols[2]]] <= ~data1_reg[least_reliable_symbols[2]*2+llr1_sign_reg[least_reliable_symbols[2]]];
                    
                end if (test_patterns[most_reliable_tp_idx][3] == 1 && least_reliable_symbols[3]<60) begin
                    data1_reg[least_reliable_symbols[3]*2+llr1_sign_reg[least_reliable_symbols[3]]] <= ~data1_reg[least_reliable_symbols[3]*2+llr1_sign_reg[least_reliable_symbols[3]]];
                    
                end if (test_patterns[most_reliable_tp_idx][4] == 1 && least_reliable_symbols[4]<60) begin
                    data1_reg[least_reliable_symbols[4]*2+llr1_sign_reg[least_reliable_symbols[4]]] <= ~data1_reg[least_reliable_symbols[4]*2+llr1_sign_reg[least_reliable_symbols[4]]];
                    
                end if (test_patterns[most_reliable_tp_idx][5] == 1 && least_reliable_symbols[5]<60) begin
                    data1_reg[least_reliable_symbols[5]*2+llr1_sign_reg[least_reliable_symbols[5]]] <= ~data1_reg[least_reliable_symbols[5]*2+llr1_sign_reg[least_reliable_symbols[5]]];
                    
                end if (most_reliable_error_location<60) begin
                    data1_reg[most_reliable_error_location*2+llr1_sign_reg[most_reliable_error_location]] <= ~data1_reg[most_reliable_error_location*2+llr1_sign_reg[most_reliable_error_location]];
                    
                end
                
                state <= 6;
                
            end else if (state==6) begin
            
                data_output_reg <= data1_reg;
                output_ready <= 1;
                output_counter <=0;
                
                test_pattern_idx <=0;
                least_llrs <= '{default:'1};
                most_reliable_tp_wt <= 16'hFFFF;
                most_reliable_tp_idx <= 0;
                most_reliable_error_location <= 0;
                current_tp_reliability <= 16'hFFFF;
                state <=7;
                
            end else if (state==7) begin
                if (en) begin
                    state <= 0;
                end
            end
        end
    end
endmodule

module SD_decoder_top #(
    //bit resolution of LLR output
    parameter LLR_RESOLUTION = 6,
    
    //number of low-reliability bits that are tested with test patterns
    parameter Q = 6,
    
    //number of test patterns for chase decoder
    parameter N_TP = 42)(
    input clk,
    input rstn,
    input [1:0] symbol_in,
    input symbol_in_valid,
    input [LLR_RESOLUTION-1:0] llr_in,
    input llr_sign,
    output reg data_out,
    output reg valid);
    
    reg [7:0] state = 0;
    reg [7:0] counter = 0;
    
    reg [1:0] symbol_in_mux [2:0];
    reg [2:0] in_valid_mux = 0;
    reg [LLR_RESOLUTION-1:0] llr_in_mux [2:0];
    reg [2:0] en_mux = 0;
    reg [2:0] llr_sign_mux = 0;
    wire [2:0] data_out_mux;
    wire [2:0] data_out_valid_mux;   
    
    
    hamming_dec_68_60 #(.LLR_RESOLUTION(LLR_RESOLUTION),.Q(Q),. N_TP(N_TP)) dec0 (
        .clk(clk),
        .rstn(rstn),
        .symbol_in(symbol_in_mux[0]),
        .symbol_in_valid(in_valid_mux[0]),
        .llr_in(llr_in_mux[0]),
        .llr_sign(llr_sign_mux[0]),
        .en(en_mux[0]),
        .data_out(data_out_mux[0]),
        .valid(data_out_valid_mux[0]));
        
    hamming_dec_68_60 #(.LLR_RESOLUTION(LLR_RESOLUTION),.Q(Q),. N_TP(N_TP)) dec1 (
        .clk(clk),
        .rstn(rstn),
        .symbol_in(symbol_in_mux[1]),
        .symbol_in_valid(in_valid_mux[1]),
        .llr_in(llr_in_mux[1]),
        .llr_sign(llr_sign_mux[1]),
        .en(en_mux[1]),
        .data_out(data_out_mux[1]),
        .valid(data_out_valid_mux[1]));
        
    hamming_dec_68_60 #(.LLR_RESOLUTION(LLR_RESOLUTION),.Q(Q),. N_TP(N_TP)) dec2 (
        .clk(clk),
        .rstn(rstn),
        .symbol_in(symbol_in_mux[2]),
        .symbol_in_valid(in_valid_mux[2]),
        .llr_in(llr_in_mux[2]),
        .llr_sign(llr_sign_mux[2]),
        .en(en_mux[2]),
        .data_out(data_out_mux[2]),
        .valid(data_out_valid_mux[2]));

    always @(posedge clk) begin
    
            
        if (!rstn) begin
            state <= 0;
            counter <= 0;            
            valid <= 0;
            en_mux <=0;
            in_valid_mux<=0;
            
        end else begin
            if (state==0) begin
                
                en_mux[0] <= 0;
            
                symbol_in_mux[0] <= symbol_in;
                in_valid_mux[0] <= symbol_in_valid;
                llr_in_mux[0] <= llr_in;
                llr_sign_mux[0] <= llr_sign;
               
                data_out <= data_out_mux[0]; 
                valid <= data_out_valid_mux[0];
                
                if (symbol_in_valid) begin
                    counter <= counter+1;
                end
            
                if (counter==64) begin
                   state<=1;
                   en_mux[1] <= 1;
                   counter <=0;
                end
                        
            end else if (state==1) begin
            
                en_mux[1] <= 0;
            
                symbol_in_mux[1] <= symbol_in;
                in_valid_mux[1] <= symbol_in_valid;
                llr_in_mux[1] <= llr_in;
                llr_sign_mux[1] <= llr_sign;
               
                data_out <= data_out_mux[1]; 
                valid <= data_out_valid_mux[1];
                
                if (symbol_in_valid) begin
                    counter <= counter+1;
                end
            
                if (counter==64) begin
                   state<=2;
                   en_mux[2] <= 1;
                   counter <=0;
                end
            
            end else if (state==2) begin
            
                en_mux[2] <= 0;
            
                symbol_in_mux[2] <= symbol_in;
                in_valid_mux[2] <= symbol_in_valid;
                llr_in_mux[2] <= llr_in;
                llr_sign_mux[2] <= llr_sign;
               
                data_out <= data_out_mux[2]; 
                valid <= data_out_valid_mux[2];
                
                if (symbol_in_valid) begin
                    counter <= counter+1;
                end
            
                if (counter==64) begin
                   state<=0;
                   en_mux[0] <= 1;
                   counter <=0;
                end
            
            end
        end
        
    end
    
    endmodule


module remove_parity_bits(
    input clk,
    input rstn,
    input data_in,
    input data_in_valid,
    output reg data_out,
    output reg valid);
    
    reg [7:0] counter = 0;
    
    always @(posedge clk) begin
    
            
        if (!rstn) begin
            counter <= 0;     
            
        end else begin
            if (data_in_valid) begin
            
                counter <= counter +1;
                if (counter<120) begin
                    data_out<= data_in;
                    valid <= 1;
                end else if (counter<128)begin
                    valid<=0;
                end
                if (counter ==127) begin
                    counter<=0;
                end
            
            end
        end
    end
endmodule
    