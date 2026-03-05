/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_miniMAC (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // IO config & misc.
  assign uio_oe  = 8'b00000011; // port uio : only 2 LSB go out

  // aliasing
  wire Den, Qen, Encode, Decode, ExtReset;
  assign uio_out[1] = Qen;
  assign Den        = uio_in[3];
  assign Encode     = uio_in[4];
  assign Decode     = uio_in[5];
  assign ExtReset   = uio_in[6];

  wire [8:0] Din9, Dout9;
  assign uo_out     = Dout9[7:0];
  assign uio_out[0] = Dout9[8];
  assign Din9[8]    = uio_in[7];
  assign Din9[7:0]  = ui_in;
  
  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out[7:2] = 6'b000000;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
