/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none


function [31:0] prbs31;
	input [31:0] in;
	begin
		prbs31[31] = in[30] ^ in[27];
		prbs31[30] = in[29] ^ in[26];
		prbs31[29] = in[28] ^ in[25];
		prbs31[28] = in[27] ^ in[24];
		prbs31[27] = in[26] ^ in[23];
		prbs31[26] = in[25] ^ in[22];
		prbs31[25] = in[24] ^ in[21];
		prbs31[24] = in[23] ^ in[20];
		prbs31[23] = in[22] ^ in[19];
		prbs31[22] = in[21] ^ in[18];
		prbs31[21] = in[20] ^ in[17];
		prbs31[20] = in[19] ^ in[16];
		prbs31[19] = in[18] ^ in[15];
		prbs31[18] = in[17] ^ in[14];
		prbs31[17] = in[16] ^ in[13];
		prbs31[16] = in[15] ^ in[12];
		prbs31[15] = in[14] ^ in[11];
		prbs31[14] = in[13] ^ in[10];
		prbs31[13] = in[12] ^ in[ 9];
		prbs31[12] = in[11] ^ in[ 8];
		prbs31[11] = in[10] ^ in[ 7];
		prbs31[10] = in[ 9] ^ in[ 6];
		prbs31[ 9] = in[ 8] ^ in[ 5];
		prbs31[ 8] = in[ 7] ^ in[ 4];
		prbs31[ 7] = in[ 6] ^ in[ 3];
		prbs31[ 6] = in[ 5] ^ in[ 2];
		prbs31[ 5] = in[ 4] ^ in[ 1];
		prbs31[ 4] = in[ 3] ^ in[ 0];
		prbs31[ 3] = in[ 2] ^ (in[30] ^ in[27]);
		prbs31[ 2] = in[ 1] ^ (in[29] ^ in[26]);
		prbs31[ 1] = in[ 0] ^ (in[28] ^ in[25]);
		prbs31[ 0] = (in[30] ^ in[27]) ^ (in[27] ^ in[24]);
	end
endfunction




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

    wire data [31:1] = 32'b0;
    
    
    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            data = 32'b0;
        end
        data = {out_data[23:0], ui_in};

        

    end

    
  // All output pins must be assigned. If not used, assign to 0.
    assign uo_out = prbs31(data);  
  assign uio_out = 0;
  assign uio_oe  = 0;

endmodule
