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
  wire Din_OK, Dout_OK;
  wire [17:0] FirstWord;
  wire [17:0] LastWord;

  input_demux dmx(
    .clk(clk), .rst(INT_RESET), .DEN(DEN), .Din9(Din9),
    .Din_OK(Din_OK), .FirstWord(FirstWord));



  // gPEAC encoder and decoder sans Hammer:

  // Scrambler
  wire [17:0] scrambled;
  wire emPEAC_phase1, emPEAC_phase2;
  // pipeline : Din_OK---[]---emPEAC_phase1---[]---emPEAC_phase2
  //              \__phase0       \__phase1
  (* keep *) sg13g2_dfrbpq_1 dff_enc1(.Q(emPEAC_phase1), .D(Din_OK      ), .RESET_B(INT_RESET), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff_enc2(.Q(emPEAC_phase2), .D(emPEAC_phase1), .RESET_B(INT_RESET), .CLK(clk));
  gPEAC18_scrambler emPEAC(
      .clk(clk), .rst(INT_RESET), .Phase0(Din_OK), .Phase1(emPEAC_phase1),
      .Message_in(FirstWord[16:0]), .X(scrambled));


  // deScrambler
  wire [17:0] scrambled_in;
  wire [17:0] descrambled;
  wire dePEAC_phase0, dePEAC_phase1, dePEAC_phase2;
  // pipeline : Din_OK/emPEAC_phase2=>dePEAC_phase0---[]---dePEAC_phase1---[]---dePEAC_phase2
  //                                      \__phase0            \__phase1
  mux2_x18 selDec( .sel(Decode), .if0(scrambled), .if1(FirstWord), .res(scrambled_in) );
  (* keep *) sg13g2_mux2_2 sel_src(.S(Decode), .A0(Din_OK), .A1(emPEAC_phase2), .X(dePEAC_phase0));
  (* keep *) sg13g2_dfrbpq_1 dff_dec1(.Q(dePEAC_phase1), .D(dePEAC_phase0), .RESET_B(INT_RESET), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff_dec2(.Q(dePEAC_phase2), .D(dePEAC_phase1), .RESET_B(INT_RESET), .CLK(clk));


assign descrambled = scrambled; //////////////////////////////////////////////////////////////////////////////////


  // Select the output
  mux2_x18 selDest( .sel(Encode), .if0(descrambled), .if1(scrambled), .res(LastWord) );
  (* keep *) sg13g2_mux2_2 selDestpulse(.S(Encode), .A0(Din_OK), .A1(emPEAC_phase2), .X(Dout_OK));


  output_muxer mxr(
    .clk(clk), .rst(INT_RESET), .Dout_OK(Dout_OK), .LastWord(LastWord),
    .Zero(Zero), .QEN(QEN), .Dout9(Dout9));
endmodule


/*
Utilisation 32.123% (looks 45%)
Cell usage by Category
  Fill	decap fill	1465
  NOR	nor2 xnor2 nor3 nor2b nor4	117
  Flip Flops	dfrbpq dfrbp sdfrbpq sdfbbp	92
  Misc	dlygate4sd3	91
  Buffer	buf	85
  Combo Logic	o21ai a221oi a21oi a22oi a21o	62
  OR	xor2 or2	45
  Multiplexer	mux2	37
  NAND	nand2 nand2b nand3b nand3	29
  AND	and2 and4	16
  Inverter	inv	13
587 total cells  

  // gPEAC encoder alone:
  wire gPEAC_phase1, gPEAC_phase2;
  wire [17:0] scrambled;

  // pipeline : Din_OK---[]---gPEAC_phase1---[]---Dout_OK
  //             \__phase0       \__phase1
  (* keep *) sg13g2_dfrbpq_1 dff_enc1(.Q(gPEAC_phase1), .D(Din_OK      ), .RESET_B(INT_RESET), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff_enc2(.Q(gPEAC_phase2), .D(gPEAC_phase1), .RESET_B(INT_RESET), .CLK(clk));

  gPEAC18_scrambler emPEAC(
      .clk(clk), .rst(INT_RESET), .Phase0(Din_OK), .Phase1(gPEAC_phase1),
      .Message_in(FirstWord[16:0]), .X(scrambled));
*/

/*
Routing stats:
  Utilisation  40.186 % (looks 55-60%)
  Wire length  44427 µm
Cell usage by Category
  Fill	decap fill	1270
  OR	xor2 or2	127
  NOR	nor2 nor2b xnor2 nor3 nor4	117
  Flip Flops	dfrbpq sdfrbpq dfrbp sdfbbp	110
  Misc	dlygate4sd3	109
  Buffer	buf	95
  Combo Logic	o21ai a21oi a221oi a22oi a21o	62
  Multiplexer	mux2	37
  NAND	nand2 nand2b nand3b nand3	29
  AND	and2 and4	16
  Inverter	inv	12
714 total


  // gPEAC encoder then Hammer encoder:
  wire gPEAC_phase1, gPEAC_phase2;
  wire [17:0] scrambled, HammerEnc_result;

  // pipeline : Din_OK---[]---gPEAC_phase1---[]---Dout_OK
  //             \__phase0       \__phase1
  (* keep *) sg13g2_dfrbpq_1 dff_enc1(.Q(gPEAC_phase1), .D(Din_OK      ), .RESET_B(INT_RESET), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff_enc2(.Q(gPEAC_phase2), .D(gPEAC_phase1), .RESET_B(INT_RESET), .CLK(clk));

  gPEAC18_scrambler emPEAC(
      .clk(clk), .rst(INT_RESET), .Phase0(Din_OK), .Phase1(gPEAC_phase1),
      .Message_in(FirstWord[16:0]), .X(scrambled));

  Encode_Hamming_early Henc(
      .clk(clk), .rst(INT_RESET), .HammEn(gPEAC_phase2),
      .HammIn(scrambled), .HammOut(HammerEnc_result) );

  // prevent a lot of warnings caused by gPEAC18_scrambler's narrower input ( /!\ Encode==Decode /!\ )
  mux2_x18 selEnc( .sel(Encode), .if0(FirstWord), .if1(HammerEnc_result), .res(LastWord) );
  (* keep *) sg13g2_mux2_2 sel_pulse(.A0(Din_OK), .A1(gPEAC_phase2), .S(Decode), .X(Dout_OK));
*/



/*
  // only one Hammer encoder:
  Encode_Hamming_early Henc(
      .clk(clk), .rst(INT_RESET), .HammEn(Din_OK),
      .HammIn(FirstWord), .HammOut(LastWord) );
  assign Dout_OK = Din_OK;

Routing stats:
  Utilisation  18.920 %
  Wire length  17970 um
Cell usage by Category
  OR	xor2	82
  Misc	dlygate4sd3	78
  Flip Flops    dfrbpq sdfrbpq dfrbp	70
  Buffer	buf	58
  Inverter	inv	20
  Combo Logic	a22oi	9
  NOR	nor4	4
  AND	and2 and4	2
323 total cells (excluding fill and tap cells)
*/

/*
Short circuit config :
  assign LastWord = FirstWord;
  assign Dout_OK = Din_OK;

Routing stats:
  Utilisation  10.858 %
  Wire length  8629um
Cell usage by Category:
  Fill	decap fill	1993
  Flip Flops	dfrbpq dfrbp sdfrbpq	52
  Misc	dlygate4sd3	52
  Buffer	buf	45
  Inverter	inv	14
  Combo Logic	a22oi	9
  NOR	nor4	4
  AND and2 and4	2
178 total cells (excluding fill and tap cells)
*/




/*
//       Stage_Encode1, Stage_Encode2,
//       Stage_Decode1, Stage_Decode2;
  // Stage_Encode1 <= Den_OK, reset= Encode  sg13g2_dfrbpq_1
  // Stage_Encode2 <= Stage_Encode1
  //  Stage_Decode1_ <= Den_OK si decode, Stage_Encode2 si loopback  => mux + and2
  // Stage_Decode1
  // Stage_Decode2 <= Stage_Decode1


  // Hammer Encoder
  wire EncResult_En;
  assign EncResult_En = QEN1;  //////////////////////////////////////////////////////////////// à changer après
  wire [17:0] HammerEnc_operand, HammerEnc_result, HammerEnc_delayed, HammerEnc_mixed;
  assign HammerEnc_operand = FirstWord;    //////////////////////////////////////////////////// à changer après
  Hammer18x4 HamEnc(.I(HammerEnc_operand), .O(HammerEnc_result));
  dffen_x18 delayEnc(.clk(clk), .rst(INT_RESET), .D(HammerEnc_result), .Q(HammerEnc_delayed), .en(EncResult_En));
  xor2_x18 mixEnc(.A(FirstWord), .B(HammerEnc_delayed), .X(HammerEnc_mixed) );


  // Decoder
  wire DecResult_En, Loopback_n;
  wire [17:0] HammerDec_operand, HammerDec_result, HammerDec_delayed, HammerDec_mixed;
  (* keep *) sg13g2_nand2_1 NandSel(.A(Encode), .B(Decode), .Y(Loopback_n));
  assign DecResult_En = QEN1;   //////////////////////////////////////////////////// à changer après
//  (* keep *) sg13g2_mux2_2 selEncEn(.X(DecResult_En), .A0(EncResult_En), .A1(QEN1), S(Loopback_n));  // en mode loopback sélectionne EN en sortie de l'encodeur
  mux2_x18 selOperand( .sel(Loopback_n), .if0(HammerEnc_mixed), .if1(FirstWord), .res(HammerDec_operand) );
  xor2_x18 mixDec(.A(HammerDec_operand), .B(HammerDec_delayed), .X(HammerDec_mixed) );
  Hammer18x4 HamDec(.I(HammerDec_mixed), .O(HammerDec_result));
  dffen_x18 delayDec(.clk(clk), .rst(INT_RESET), .D(HammerDec_result), .Q(HammerDec_delayed), .en(DecResult_En));


  // Result selector
  wire [17:0] tmpSel;
  mux2_x18 selEnc( .sel(Encode), .if0(HammerEnc_result), .if1(HammerEnc_mixed), .res(tmpSel) );
  mux2_x18 selDec( .sel(Decode), .if0(tmpSel), .if1(HammerDec_mixed), .res(LastWord) );  ///////////////// à changer après
*/
