/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_irrationalanalysis_PRBS31 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

	reg data [31:0] = 0;
	reg random [31:0] = 0;
    
//reg [31:0] in;
reg [31:0] prbs31;
always @ (*) begin
	prbs31[31] = data[30] ^ data[27];
		prbs31[30] = data[29] ^ data[26];
		prbs31[29] = data[28] ^ data[25];
		prbs31[28] = data[27] ^ data[24];
		prbs31[27] = data[26] ^ data[23];
		prbs31[26] = data[25] ^ data[22];
		prbs31[25] = data[24] ^ data[21];
		prbs31[24] = data[23] ^ data[20];
		prbs31[23] = data[22] ^ data[19];
		prbs31[22] = data[21] ^ data[18];
		prbs31[21] = data[20] ^ data[17];
		prbs31[20] = data[19] ^ data[16];
		prbs31[19] = data[18] ^ data[15];
		prbs31[18] = data[17] ^ data[14];
		prbs31[17] = data[16] ^ data[13];
		prbs31[16] = data[15] ^ data[12];
		prbs31[15] = data[14] ^ data[11];
		prbs31[14] = data[13] ^ data[10];
		prbs31[13] = data[12] ^ data[ 9];
		prbs31[12] = data[11] ^ data[ 8];
		prbs31[11] = data[10] ^ data[ 7];
		prbs31[10] = data[ 9] ^ data[ 6];
		prbs31[ 9] = data[ 8] ^ data[ 5];
		prbs31[ 8] = data[ 7] ^ data[ 4];
		prbs31[ 7] = data[ 6] ^ data[ 3];
		prbs31[ 6] = data[ 5] ^ data[ 2];
  prbs31[ 5] = data[ 4] ^ data[ 1];
  prbs31[ 4] = data[ 3] ^ data[ 0];
  prbs31[ 3] = data[ 2] ^ (data[30] ^ data[27]);
  prbs31[ 2] = data[ 1] ^ (data[29] ^ data[26]);
  prbs31[ 1] = data[ 0] ^ (data[28] ^ data[25]);
  prbs31[ 0] = (data[30] ^ data[27]) ^ (data[27] ^ data[24]);
end

    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            data <= 0;
        end
	    
        data <= {data[23:0], ui_in};
	random <= prbs31; 
        

    end

    
  // All output pins must be assigned. If not used, assign to 0.
assign uo_out = random[7:0];   
  assign uio_out = 0;
  assign uio_oe  = 0;

endmodule
