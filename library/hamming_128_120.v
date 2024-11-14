`timescale 1ns / 1ps

module enc (
    input [119:0] data_in,
	output [7:0] parity);
    
    assign parity[0] = data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[24]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[53]^data_in[54]^data_in[55]^data_in[56]^data_in[57]^data_in[58]^data_in[59]^data_in[60]^data_in[61]^data_in[62];
    assign parity[1] = data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[24]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[63]^data_in[64]^data_in[65]^data_in[66]^data_in[67]^data_in[68]^data_in[69]^data_in[70]^data_in[71]^data_in[72]^data_in[73]^data_in[74]^data_in[75]^data_in[76]^data_in[77]^data_in[78]^data_in[79]^data_in[80]^data_in[81]^data_in[82]^data_in[83]^data_in[84]^data_in[85]^data_in[86]^data_in[87]^data_in[88]^data_in[89]^data_in[90]^data_in[91]^data_in[92]^data_in[93];
    assign parity[2] = data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[63]^data_in[64]^data_in[65]^data_in[66]^data_in[67]^data_in[68]^data_in[69]^data_in[70]^data_in[71]^data_in[72]^data_in[73]^data_in[74]^data_in[75]^data_in[76]^data_in[77]^data_in[78]^data_in[94]^data_in[95]^data_in[96]^data_in[97]^data_in[98]^data_in[99]^data_in[100]^data_in[101]^data_in[102]^data_in[103]^data_in[104]^data_in[105]^data_in[106]^data_in[107]^data_in[108];
    assign parity[3] = data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[53]^data_in[54]^data_in[55]^data_in[63]^data_in[64]^data_in[65]^data_in[66]^data_in[67]^data_in[68]^data_in[69]^data_in[70]^data_in[79]^data_in[80]^data_in[81]^data_in[82]^data_in[83]^data_in[84]^data_in[85]^data_in[86]^data_in[94]^data_in[95]^data_in[96]^data_in[97]^data_in[98]^data_in[99]^data_in[100]^data_in[101]^data_in[109]^data_in[110]^data_in[111]^data_in[112]^data_in[113]^data_in[114]^data_in[115];
    assign parity[4] = data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[24]^data_in[25]^data_in[26]^data_in[27]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[56]^data_in[57]^data_in[58]^data_in[59]^data_in[63]^data_in[64]^data_in[65]^data_in[66]^data_in[71]^data_in[72]^data_in[73]^data_in[74]^data_in[79]^data_in[80]^data_in[81]^data_in[82]^data_in[87]^data_in[88]^data_in[89]^data_in[90]^data_in[94]^data_in[95]^data_in[96]^data_in[97]^data_in[102]^data_in[103]^data_in[104]^data_in[105]^data_in[109]^data_in[110]^data_in[111]^data_in[112]^data_in[116]^data_in[117]^data_in[118];
    assign parity[5] = data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[10]^data_in[11]^data_in[12]^data_in[13]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[50]^data_in[51]^data_in[52]^data_in[53]^data_in[58]^data_in[59]^data_in[60]^data_in[61]^data_in[65]^data_in[66]^data_in[67]^data_in[68]^data_in[73]^data_in[74]^data_in[75]^data_in[76]^data_in[81]^data_in[82]^data_in[83]^data_in[84]^data_in[89]^data_in[90]^data_in[91]^data_in[92]^data_in[96]^data_in[97]^data_in[98]^data_in[99]^data_in[104]^data_in[105]^data_in[106]^data_in[107]^data_in[111]^data_in[112]^data_in[113]^data_in[114]^data_in[117]^data_in[118]^data_in[119];
    assign parity[6] = data_in[0]^data_in[2]^data_in[4]^data_in[6]^data_in[8]^data_in[10]^data_in[12]^data_in[14]^data_in[16]^data_in[18]^data_in[20]^data_in[22]^data_in[24]^data_in[26]^data_in[28]^data_in[30]^data_in[32]^data_in[34]^data_in[36]^data_in[38]^data_in[40]^data_in[42]^data_in[44]^data_in[46]^data_in[48]^data_in[50]^data_in[52]^data_in[54]^data_in[56]^data_in[58]^data_in[60]^data_in[62]^data_in[63]^data_in[65]^data_in[67]^data_in[69]^data_in[71]^data_in[73]^data_in[75]^data_in[77]^data_in[79]^data_in[81]^data_in[83]^data_in[85]^data_in[87]^data_in[89]^data_in[91]^data_in[93]^data_in[94]^data_in[96]^data_in[98]^data_in[100]^data_in[102]^data_in[104]^data_in[106]^data_in[108]^data_in[109]^data_in[111]^data_in[113]^data_in[115]^data_in[116]^data_in[117]^data_in[119];
    assign parity[7] = data_in[0]^data_in[3]^data_in[4]^data_in[7]^data_in[9]^data_in[10]^data_in[13]^data_in[14]^data_in[17]^data_in[18]^data_in[21]^data_in[22]^data_in[24]^data_in[27]^data_in[28]^data_in[31]^data_in[33]^data_in[34]^data_in[37]^data_in[38]^data_in[40]^data_in[43]^data_in[44]^data_in[47]^data_in[48]^data_in[51]^data_in[52]^data_in[55]^data_in[57]^data_in[58]^data_in[61]^data_in[62]^data_in[64]^data_in[65]^data_in[68]^data_in[69]^data_in[71]^data_in[74]^data_in[75]^data_in[78]^data_in[79]^data_in[82]^data_in[83]^data_in[86]^data_in[88]^data_in[89]^data_in[92]^data_in[93]^data_in[94]^data_in[97]^data_in[98]^data_in[101]^data_in[103]^data_in[104]^data_in[107]^data_in[108]^data_in[110]^data_in[111]^data_in[114]^data_in[115]^data_in[116]^data_in[118]^data_in[119];

endmodule

module hamming_enc (
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
    
    reg [119:0] r1_temp;
    reg [119:0] r1;
    wire [7:0] p1;
    
    enc e1 (
        .data_in(r1),
        .parity(p1));
    
    reg [119:0] r2;
    reg [119:0] r2_temp;
    wire [7:0] p2;
    
    enc e2 (
        .data_in(r2),
        .parity(p2));
    
    always @ (posedge clk)
        
        if (!rstn) begin
            state <= 0;
            counter = 0;
            valid <= 0;
            
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
                    r1 <= r1_temp;
                end else if (counter == 7) begin
                    state <= 2;
                    counter <= 0;
                end
            
            end else if (state == 2) begin
                counter <= counter + 1;
                
                r2_temp[counter] <= data_in;
                data_out <= r1[counter];
                valid <= 1;
                
                if (counter == 119) begin
                    state <= 3;
                    counter <= 0;
                end
            
            end else if (state ==3) begin
                counter <= counter + 1;
                
                data_out<= p1[counter];
                valid <= 1;
                
                if (counter ==0) begin
                    r2 <= r2_temp;
                end else if (counter == 7) begin
                    state <= 4;
                    counter <= 0;
                end
                
            end else if (state == 4) begin
                counter <= counter + 1;
                
                r1_temp[counter] <= data_in;
                data_out <= r2[counter];
                valid <= 1;
                
                if (counter == 119) begin
                    state <= 5;
                    counter <= 0;
                end
            
            end else if (state == 5) begin
                counter <= counter + 1;
                
                data_out<= p2[counter];
                valid <= 1;
                
                if (counter ==0) begin
                    r1 <= r1_temp;
                end else if (counter == 7) begin
                    state <= 2;
                    counter <= 0;
                end
            end
    end
        
endmodule

module dec (
    input [127:0] data_in,
	output [7:0] syndrome);
	
    assign syndrome[0] = data_in[1]^data_in[3]^data_in[5]^data_in[7]^data_in[9]^data_in[11]^data_in[13]^data_in[15]^data_in[17]^data_in[19]^data_in[21]^data_in[23]^data_in[25]^data_in[27]^data_in[29]^data_in[31]^data_in[33]^data_in[35]^data_in[37]^data_in[39]^data_in[41]^data_in[43]^data_in[45]^data_in[47]^data_in[49]^data_in[51]^data_in[53]^data_in[55]^data_in[57]^data_in[59]^data_in[61]^data_in[64]^data_in[66]^data_in[68]^data_in[70]^data_in[72]^data_in[74]^data_in[76]^data_in[78]^data_in[80]^data_in[82]^data_in[84]^data_in[86]^data_in[88]^data_in[90]^data_in[92]^data_in[95]^data_in[97]^data_in[99]^data_in[101]^data_in[103]^data_in[105]^data_in[107]^data_in[110]^data_in[112]^data_in[114]^data_in[118]^data_in[120]^data_in[121]^data_in[122]^data_in[123]^data_in[124]^data_in[125]^data_in[127];
    assign syndrome[1] = data_in[2]^data_in[3]^data_in[6]^data_in[7]^data_in[10]^data_in[11]^data_in[14]^data_in[15]^data_in[18]^data_in[19]^data_in[22]^data_in[23]^data_in[26]^data_in[27]^data_in[30]^data_in[31]^data_in[34]^data_in[35]^data_in[38]^data_in[39]^data_in[42]^data_in[43]^data_in[46]^data_in[47]^data_in[50]^data_in[51]^data_in[54]^data_in[55]^data_in[58]^data_in[59]^data_in[62]^data_in[65]^data_in[66]^data_in[69]^data_in[70]^data_in[73]^data_in[74]^data_in[77]^data_in[78]^data_in[81]^data_in[82]^data_in[85]^data_in[86]^data_in[89]^data_in[90]^data_in[93]^data_in[96]^data_in[97]^data_in[100]^data_in[101]^data_in[104]^data_in[105]^data_in[108]^data_in[111]^data_in[112]^data_in[115]^data_in[117]^data_in[118]^data_in[120]^data_in[121]^data_in[122]^data_in[123]^data_in[126]^data_in[127];
    assign syndrome[2] = data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[52]^data_in[53]^data_in[54]^data_in[55]^data_in[60]^data_in[61]^data_in[62]^data_in[67]^data_in[68]^data_in[69]^data_in[70]^data_in[75]^data_in[76]^data_in[77]^data_in[78]^data_in[83]^data_in[84]^data_in[85]^data_in[86]^data_in[91]^data_in[92]^data_in[93]^data_in[98]^data_in[99]^data_in[100]^data_in[101]^data_in[106]^data_in[107]^data_in[108]^data_in[113]^data_in[114]^data_in[115]^data_in[119]^data_in[120]^data_in[121]^data_in[122]^data_in[123]^data_in[125]^data_in[126]^data_in[127];
    assign syndrome[3] = data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[24]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[56]^data_in[57]^data_in[58]^data_in[59]^data_in[60]^data_in[61]^data_in[62]^data_in[71]^data_in[72]^data_in[73]^data_in[74]^data_in[75]^data_in[76]^data_in[77]^data_in[78]^data_in[87]^data_in[88]^data_in[89]^data_in[90]^data_in[91]^data_in[92]^data_in[93]^data_in[102]^data_in[103]^data_in[104]^data_in[105]^data_in[106]^data_in[107]^data_in[108]^data_in[116]^data_in[117]^data_in[118]^data_in[119]^data_in[120]^data_in[121]^data_in[122]^data_in[124]^data_in[125]^data_in[126]^data_in[127];
    assign syndrome[4] = data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[24]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[53]^data_in[54]^data_in[55]^data_in[56]^data_in[57]^data_in[58]^data_in[59]^data_in[60]^data_in[61]^data_in[62]^data_in[79]^data_in[80]^data_in[81]^data_in[82]^data_in[83]^data_in[84]^data_in[85]^data_in[86]^data_in[87]^data_in[88]^data_in[89]^data_in[90]^data_in[91]^data_in[92]^data_in[93]^data_in[109]^data_in[110]^data_in[111]^data_in[112]^data_in[113]^data_in[114]^data_in[115]^data_in[116]^data_in[117]^data_in[118]^data_in[119]^data_in[120]^data_in[121]^data_in[123]^data_in[124]^data_in[125]^data_in[126]^data_in[127];
    assign syndrome[5] = data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[53]^data_in[54]^data_in[55]^data_in[56]^data_in[57]^data_in[58]^data_in[59]^data_in[60]^data_in[61]^data_in[62]^data_in[94]^data_in[95]^data_in[96]^data_in[97]^data_in[98]^data_in[99]^data_in[100]^data_in[101]^data_in[102]^data_in[103]^data_in[104]^data_in[105]^data_in[106]^data_in[107]^data_in[108]^data_in[109]^data_in[110]^data_in[111]^data_in[112]^data_in[113]^data_in[114]^data_in[115]^data_in[116]^data_in[117]^data_in[118]^data_in[119]^data_in[120]^data_in[122]^data_in[123]^data_in[124]^data_in[125]^data_in[126]^data_in[127];
    assign syndrome[6] = data_in[63]^data_in[64]^data_in[65]^data_in[66]^data_in[67]^data_in[68]^data_in[69]^data_in[70]^data_in[71]^data_in[72]^data_in[73]^data_in[74]^data_in[75]^data_in[76]^data_in[77]^data_in[78]^data_in[79]^data_in[80]^data_in[81]^data_in[82]^data_in[83]^data_in[84]^data_in[85]^data_in[86]^data_in[87]^data_in[88]^data_in[89]^data_in[90]^data_in[91]^data_in[92]^data_in[93]^data_in[94]^data_in[95]^data_in[96]^data_in[97]^data_in[98]^data_in[99]^data_in[100]^data_in[101]^data_in[102]^data_in[103]^data_in[104]^data_in[105]^data_in[106]^data_in[107]^data_in[108]^data_in[109]^data_in[110]^data_in[111]^data_in[112]^data_in[113]^data_in[114]^data_in[115]^data_in[116]^data_in[117]^data_in[118]^data_in[119]^data_in[121]^data_in[122]^data_in[123]^data_in[124]^data_in[125]^data_in[126]^data_in[127];
    assign syndrome[7] = data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]^data_in[8]^data_in[9]^data_in[10]^data_in[11]^data_in[12]^data_in[13]^data_in[14]^data_in[15]^data_in[16]^data_in[17]^data_in[18]^data_in[19]^data_in[20]^data_in[21]^data_in[22]^data_in[23]^data_in[24]^data_in[25]^data_in[26]^data_in[27]^data_in[28]^data_in[29]^data_in[30]^data_in[31]^data_in[32]^data_in[33]^data_in[34]^data_in[35]^data_in[36]^data_in[37]^data_in[38]^data_in[39]^data_in[40]^data_in[41]^data_in[42]^data_in[43]^data_in[44]^data_in[45]^data_in[46]^data_in[47]^data_in[48]^data_in[49]^data_in[50]^data_in[51]^data_in[52]^data_in[53]^data_in[54]^data_in[55]^data_in[56]^data_in[57]^data_in[58]^data_in[59]^data_in[60]^data_in[61]^data_in[62]^data_in[63]^data_in[64]^data_in[65]^data_in[66]^data_in[67]^data_in[68]^data_in[69]^data_in[70]^data_in[71]^data_in[72]^data_in[73]^data_in[74]^data_in[75]^data_in[76]^data_in[77]^data_in[78]^data_in[79]^data_in[80]^data_in[81]^data_in[82]^data_in[83]^data_in[84]^data_in[85]^data_in[86]^data_in[87]^data_in[88]^data_in[89]^data_in[90]^data_in[91]^data_in[92]^data_in[93]^data_in[94]^data_in[95]^data_in[96]^data_in[97]^data_in[98]^data_in[99]^data_in[100]^data_in[101]^data_in[102]^data_in[103]^data_in[104]^data_in[105]^data_in[106]^data_in[107]^data_in[108]^data_in[109]^data_in[110]^data_in[111]^data_in[112]^data_in[113]^data_in[114]^data_in[115]^data_in[116]^data_in[117]^data_in[118]^data_in[119]^data_in[120]^data_in[121]^data_in[122]^data_in[123]^data_in[124]^data_in[125]^data_in[126]^data_in[127];
endmodule


module hamming_dec (
    input clk,
    input rstn,
    input ifec_en,
    input data_in,
    input data_in_valid,
    output reg data_out,
    output reg valid = 0);
    
    reg decode = 0;
    
    reg [7:0] syndrome_lut [255:0];
    
    initial $readmemh("syndrome_lut_128_120.mem", syndrome_lut);
    
    //state 0: length: 128  input: r1           output: none        action: none
    //state 1: length: 8    input: r2[0:7]      output: none        action: calculate e1 and correct
    //state 2: length: 120  input: r2[8:127]    output: r1[0:119]   action: none
    //state 3: length: 8    input: r1[0:7]      output: none        action: calculate e2 and correct
    //state 4: length: 120  input: r1[8:127]    output: r2[0:119]   action: none
    //then back to state 1
    reg [7:0] state = 0;
    
    reg [7:0] counter = 0;
    
    reg [7:0] e;

    
    reg [127:0] r1_temp;
    reg [127:0] r1;
    wire [7:0] s1;
    
    dec dec1 (
        .data_in(r1),
        .syndrome(s1));
    
    reg [127:0] r2_temp;
    reg [127:0] r2;
    wire [7:0] s2;
    
    dec dec2 (
        .data_in(r2),
        .syndrome(s2));
    
    always @ (posedge clk)
        
        if (!rstn) begin
            state <= 0;
            counter <= 0;
            valid <=0;
            decode <= ifec_en;
            
        end else begin
        
            if (state == 0 && data_in_valid == 1) begin
                counter <= counter +1;
                r1_temp[counter] <= data_in;
                valid <= 0;
                
                if (counter == 127) begin
                    state <= 1;
                    counter <= 0;
                end
                
            end else if (state == 1) begin
                counter <= counter + 1;
                r2_temp[counter] <= data_in;
                valid <= 0;
                if (counter ==0) begin
                    r1 <= r1_temp;
                end else if (counter == 3) begin
                    e <= syndrome_lut[s1];
                end else if (counter == 5) begin
                    if (e>0 && decode) begin
                        r1[e-1] <= ~ r1[e-1];
                    end
                end else if (counter == 7) begin
                    state <= 2;
                    counter <= 0;
                end
                
            end else if (state == 2) begin
                counter <= counter + 1;
                r2_temp[counter+8] <= data_in;
                data_out <= r1[counter];
                valid <= 1;
                if (counter == 119) begin
                    state <= 3;
                    counter <= 0;
                end
            
            end else if (state == 3) begin
                counter <= counter + 1;
                r1_temp[counter] <= data_in;
                valid <= 0;
                if (counter ==0) begin
                    r2 <= r2_temp;
                end else if (counter == 3) begin
                    e <= syndrome_lut[s2];
                end else if (counter == 5) begin
                    if (e>0 && decode) begin
                        r2[e-1] <= ~ r2[e-1];
                    end
                end else if (counter == 7) begin
                    state <= 4;
                    counter <= 0;
                end
                
            end else if (state == 4) begin
                counter <= counter + 1;
                r1_temp[counter+8] <= data_in;
                data_out <= r2[counter];
                valid <= 1;
                if (counter == 119) begin
                    state <= 1;
                    counter <= 0;
                end
                
            end
            
        end
        
endmodule