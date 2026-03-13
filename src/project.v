/*  project.v
 * Copyright (c) 2026 Yann Guidon / whygee@f-cpu.org
 * SPDX-License-Identifier: Apache-2.0
 *
 *   Instantiate the Hammer18 Hamming Distance Maximiser
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
  assign uio_oe  = 8'b00001111; // port uio : 4 LSB go out

  // aliasing
  wire QEN, CLK_out, Zero, Encode, Decode, DEN;
  wire [8:0] Din9, Dout9;
  assign uo_out     = Dout9[7:0];
  assign Din9[7:0]  = ui_in;

  assign uio_out[0] = Dout9[8];
  assign uio_out[1] = QEN;
  assign uio_out[2] = CLK_out;
  assign uio_out[3] = Zero;
  assign DEN        = uio_in[4];
  assign Encode     = uio_in[5];
  assign Decode     = uio_in[6];
  assign Din9[8]    = uio_in[7];
  
  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out[7:4] = 4'b0000;

  // List all unused inputs to prevent warnings
  wire _unused = &{uio_in[0], uio_in[1], uio_in[2], uio_in[3], 1'b0};

/////////////////////////////////////////////////////////////////////////////

  // ring oscillator anyone ?
  (* keep *) sg13g2_inv_1 negClkOut(.Y(CLK_out), .A(clk));

  // resynch the reset signal
  wire INT_RESET;
    (* keep *) sg13g2_dfrbpq_1 DFF_reset(.Q(INT_RESET), .D(ena), .RESET_B(rst_n), .CLK(clk));

  // Pipeline management
  wire Den_In0, Den_In1, Den_OK;
//       Stage_Encode1, Stage_Encode2,
//       Stage_Decode1, Stage_Decode2;


  // Stage_Encode1 <= Den_OK, reset= Encode  sg13g2_dfrbpq_1
  // Stage_Encode2 <= Stage_Encode1
  //  Stage_Decode1_ <= Den_OK si decode, Stage_Encode2 si loopback  => mux + and2
  // Stage_Decode1
  // Stage_Decode2 <= Stage_Decode1


  // Input buffers
  wire [8:0]  FirstHalfWord;
  wire [17:0] FirstWord;

  // Den_In0 <= DEN        sg13g2_dfrbpq_1  / 49
  (* keep *) sg13g2_dfrbpq_1 DFF_den0(.Q(Den_In0), .D(DEN), .RESET_B(INT_RESET), .CLK(clk));
  // Den_In1 <= ~Den_In0
  /* verilator lint_off PINCONNECTEMPTY */
  (* keep *) sg13g2_dfrbp_2 DFF_den1(.Q_N(Den_In1), .Q(), .D(Den_In0), .RESET_B(INT_RESET), .CLK(clk));
  /* verilator lint_on PINCONNECTEMPTY */
  // Den_OK <= Den_In0 & ~Den_In1  sg13g2_and2_2
  (* keep *) sg13g2_and2_1 Den_OK_and2(.X(Den_OK), .A(Den_In0), .B(Den_In1));

  dff_x9    fhw(.clk(clk), .rst(INT_RESET), .D(Din9), .Q(FirstHalfWord));                           // Always samples the input
  dffen_x18  fw(.clk(clk), .rst(INT_RESET), .D({Din9, FirstHalfWord}), .Q(FirstWord), .en(Den_OK)); // Samples only if DEN is ok

/*
  // Multi-mode Hammer18 unit
  wire DecOrEnc;
  (* keep *) sg13g2_or2_1 OrSel(.A(Encode), .B(Decode), .X(DecOrEnc));
  wire [17:0] Hammer_operand, Hammer_result, Hammer_delayed, Hammer_mixed;
  mux2_x18 selOperand(.sel(Decode), .if0(FirstWord), .if1(Hammer_mixed), .res(Hammer_operand));
  Hammer18x4 Ham(.I(Hammer_operand), .O(Hammer_result));
  dffen_x18 delayHam(.clk(clk), .rst(INT_RESET), .D(Hammer_result), .Q(Hammer_delayed), .en(QEN1));
  xor2_x18 mixData(.A(FirstWord), .B(Hammer_delayed), .X(Hammer_mixed) );
  mux2_x18 selResult( .sel(DecOrEnc), .if0(Hammer_result), .if1(Hammer_mixed), .res(LastWord) );
*/


  // Encoder
  wire EncResult_En;
  assign EncResult_En = QEN1;  //////////////////////////////////////////////////////////////// à changer après
  wire [17:0] HammerEnc_operand, HammerEnc_result, HammerEnc_delayed, HammerEnc_mixed;
  assign HammerEnc_operand = FirstWord;    //////////////////////////////////////////////////// à changer après
  Hammer18x4 HamEnc(.I(HammerEnc_operand), .O(HammerEnc_result));
  dffen_x18 delayEnc(.clk(clk), .rst(INT_RESET), .D(HammerEnc_result), .Q(HammerEnc_delayed), .en(EncResult_En));
  xor2_x18 mixEnc(.A(FirstWord), .B(HammerEnc_delayed), .X(HammerEnc_mixed) );


  // Decoder
  wire DecResult_En;
  assign DecResult_En = QEN1;  //////////////////////////////////////////////////////////////// à changer après
  wire DecNandEnc;
  (* keep *) sg13g2_nand2_1 NandSel(.A(Encode), .B(Decode), .Y(DecNandEnc));
  wire [17:0] HammerDec_operand, HammerDec_result, HammerDec_delayed, HammerDec_mixed;

  mux2_x18 selOperand( .sel(DecNandEnc), .if0(HammerEnc_mixed), .if1(FirstWord), .res(HammerDec_operand) );
  xor2_x18 mixDec(.A(HammerDec_operand), .B(HammerDec_delayed), .X(HammerDec_mixed) );
  Hammer18x4 HamDec(.I(HammerDec_mixed), .O(HammerDec_result));
  dffen_x18 delayDec(.clk(clk), .rst(INT_RESET), .D(HammerDec_result), .Q(HammerDec_delayed), .en(DecResult_En));


  // Result selector
  wire [17:0] tmpSel;
  mux2_x18 selEnc( .sel(Encode), .if0(HammerEnc_result), .if1(HammerEnc_mixed), .res(tmpSel) );
  mux2_x18 selDec( .sel(Decode), .if0(tmpSel), .if1(HammerDec_mixed), .res(LastWord) );


  // Output buffers
  wire Zero_value, QEN1, QEN2;
  wire [17:0] LastWord;
  wire [8:0]  LastHalfWord, LastMSB;

  // shift register : Den_OK => QEN1 => QEN2
  (* keep *) sg13g2_dfrbpq_1 DFF_QEN1(.Q(QEN1), .D(Den_OK), .RESET_B(INT_RESET), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 DFF_QEN2(.Q(QEN2), .D(QEN1),   .RESET_B(INT_RESET), .CLK(clk));
  assign QEN = QEN2;

  // Zero flag is 1 when all the 16 data bits are 0:
  nor16 zo16(.A({LastWord[16:9], LastWord[7:0]}), .X(Zero_value));   // does not NOR the C/D bit!)
  (* keep *) sg13g2_dfrbpq_1 DFF_sero(.Q(Zero), .D(Zero_value), .RESET_B(INT_RESET), .CLK(clk));  // Latch & output the sum

  // Multiplex the last half words:
  dff_x9 dffMSB(.D(LastWord[17:9]), .Q(LastMSB), .clk(clk), .rst(INT_RESET)); // save the MSB for the next cycle
  a22o_fo_x9 sel2(.A1(QEN1), .A2(LastWord[8:0]),  // LSB first
                  .B1(QEN2), .B2(LastMSB),        // then MSB
                  .Y(LastHalfWord));              // otherwise 0
  dff_x9 dffOut(.D(LastHalfWord), .Q(Dout9), .clk(clk), .rst(INT_RESET));  // Latch & output the data halfword

  
endmodule
