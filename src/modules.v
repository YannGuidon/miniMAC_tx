/*
  modules.v
  ©2026 Yann Guidon
  A dumb collection of recurring gates structures.
  Just because I don't want to learn Verilog.
*/

module fanout3(
  input  wire A,
  output wire [2:0] X
);
  /*
  wire N;
  (* keep *) sg13g2_inv_1 foN(.Y(N),    .A(A));
  (* keep *) sg13g2_inv_1 fo0(.Y(X[0]), .A(N));
  (* keep *) sg13g2_inv_1 fo1(.Y(X[1]), .A(N));
  (* keep *) sg13g2_inv_1 fo2(.Y(X[2]), .A(N));
  */
  assign X[0] = A;
  assign X[1] = A;
  assign X[2] = A;
  //  assign X[2:0] = { 3{A} }; syntax error ???
endmodule

module fanout4(
  input  wire A,
  output wire [3:0] X
);
  /*
  wire N;
  (* keep *) sg13g2_inv_1 foN(.Y(N),    .A(A));
  (* keep *) sg13g2_inv_1 fo0(.Y(X[0]), .A(N));
  (* keep *) sg13g2_inv_1 fo1(.Y(X[1]), .A(N));
  (* keep *) sg13g2_inv_1 fo2(.Y(X[2]), .A(N));
  (* keep *) sg13g2_inv_1 fo3(.Y(X[3]), .A(N));
  */
  assign X[0] = A;
  assign X[1] = A;
  assign X[2] = A;
  assign X[3] = A;
  // assign X = { 4{A} };
endmodule


module mux2_x18(
  input  wire sel,
  input  wire [17:0] if0,
  input  wire [17:0] if1,
  output wire [17:0] res
);
  wire [4:1] s;
  fanout4 fo4(.A(sel), .X(s));

  (* keep *) sg13g2_mux2_2 mux_00(.A0(if0[ 0]), .A1(if1[ 0]), .S(s[1]), .X(res[ 0]));
  (* keep *) sg13g2_mux2_2 mux_01(.A0(if0[ 1]), .A1(if1[ 1]), .S(s[1]), .X(res[ 1]));
  (* keep *) sg13g2_mux2_2 mux_02(.A0(if0[ 2]), .A1(if1[ 2]), .S(s[1]), .X(res[ 2]));
  (* keep *) sg13g2_mux2_2 mux_03(.A0(if0[ 3]), .A1(if1[ 3]), .S(s[1]), .X(res[ 3]));
  (* keep *) sg13g2_mux2_2 mux_04(.A0(if0[ 4]), .A1(if1[ 4]), .S(s[2]), .X(res[ 4]));
  (* keep *) sg13g2_mux2_2 mux_05(.A0(if0[ 5]), .A1(if1[ 5]), .S(s[2]), .X(res[ 5]));
  (* keep *) sg13g2_mux2_2 mux_06(.A0(if0[ 6]), .A1(if1[ 6]), .S(s[2]), .X(res[ 6]));
  (* keep *) sg13g2_mux2_2 mux_07(.A0(if0[ 7]), .A1(if1[ 7]), .S(s[2]), .X(res[ 7]));
  (* keep *) sg13g2_mux2_2 mux_08(.A0(if0[ 8]), .A1(if1[ 8]), .S(s[2]), .X(res[ 8]));
  (* keep *) sg13g2_mux2_2 mux_09(.A0(if0[ 9]), .A1(if1[ 9]), .S(s[3]), .X(res[ 9]));
  (* keep *) sg13g2_mux2_2 mux_10(.A0(if0[10]), .A1(if1[10]), .S(s[3]), .X(res[10]));
  (* keep *) sg13g2_mux2_2 mux_11(.A0(if0[11]), .A1(if1[11]), .S(s[3]), .X(res[11]));
  (* keep *) sg13g2_mux2_2 mux_12(.A0(if0[12]), .A1(if1[12]), .S(s[3]), .X(res[12]));
  (* keep *) sg13g2_mux2_2 mux_13(.A0(if0[13]), .A1(if1[13]), .S(s[4]), .X(res[13]));
  (* keep *) sg13g2_mux2_2 mux_14(.A0(if0[14]), .A1(if1[14]), .S(s[4]), .X(res[14]));
  (* keep *) sg13g2_mux2_2 mux_15(.A0(if0[15]), .A1(if1[15]), .S(s[4]), .X(res[15]));
  (* keep *) sg13g2_mux2_2 mux_16(.A0(if0[16]), .A1(if1[16]), .S(s[4]), .X(res[16]));
  (* keep *) sg13g2_mux2_2 mux_17(.A0(if0[17]), .A1(if1[17]), .S(s[4]), .X(res[17]));
endmodule

module xor2_x18(
  input  wire [17:0] A,
  input  wire [17:0] B,
  output wire [17:0] X
);
  (* keep *) sg13g2_xor2_1 x00(.X(X[ 0]), .A(A[ 0]), .B(B[ 0]));
  (* keep *) sg13g2_xor2_1 x01(.X(X[ 1]), .A(A[ 1]), .B(B[ 1]));
  (* keep *) sg13g2_xor2_1 x02(.X(X[ 2]), .A(A[ 2]), .B(B[ 2]));
  (* keep *) sg13g2_xor2_1 x03(.X(X[ 3]), .A(A[ 3]), .B(B[ 3]));
  (* keep *) sg13g2_xor2_1 x04(.X(X[ 4]), .A(A[ 4]), .B(B[ 4]));
  (* keep *) sg13g2_xor2_1 x05(.X(X[ 5]), .A(A[ 5]), .B(B[ 5]));
  (* keep *) sg13g2_xor2_1 x06(.X(X[ 6]), .A(A[ 6]), .B(B[ 6]));
  (* keep *) sg13g2_xor2_1 x07(.X(X[ 7]), .A(A[ 7]), .B(B[ 7]));
  (* keep *) sg13g2_xor2_1 x08(.X(X[ 8]), .A(A[ 8]), .B(B[ 8]));
  (* keep *) sg13g2_xor2_1 x09(.X(X[ 9]), .A(A[ 9]), .B(B[ 9]));
  (* keep *) sg13g2_xor2_1 x10(.X(X[10]), .A(A[10]), .B(B[10]));
  (* keep *) sg13g2_xor2_1 x11(.X(X[11]), .A(A[11]), .B(B[11]));
  (* keep *) sg13g2_xor2_1 x12(.X(X[12]), .A(A[12]), .B(B[12]));
  (* keep *) sg13g2_xor2_1 x13(.X(X[13]), .A(A[13]), .B(B[13]));
  (* keep *) sg13g2_xor2_1 x14(.X(X[14]), .A(A[14]), .B(B[14]));
  (* keep *) sg13g2_xor2_1 x15(.X(X[15]), .A(A[15]), .B(B[15]));
  (* keep *) sg13g2_xor2_1 x16(.X(X[16]), .A(A[16]), .B(B[16]));
  (* keep *) sg13g2_xor2_1 x17(.X(X[17]), .A(A[17]), .B(B[17]));
endmodule

module dffen_x18(
  input  wire clk,
  input  wire rst,
  input  wire en,
  input  wire [17:0] D,
  output wire [17:0] Q
);
  wire [17:0] fb;
  assign Q = fb;

  wire [4:1] r; fanout4 fo_r(.A(rst), .X(r));
  wire [4:1] e; fanout4 fo_e(.A(en),  .X(e));
  
  (* keep *) sg13g2_sdfrbpq_1 dffe00(.Q(fb[ 0]), .D(fb[ 0]), .SCD(D[ 0]), .SCE(e[1]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe01(.Q(fb[ 1]), .D(fb[ 1]), .SCD(D[ 1]), .SCE(e[1]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe02(.Q(fb[ 2]), .D(fb[ 2]), .SCD(D[ 2]), .SCE(e[1]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe03(.Q(fb[ 3]), .D(fb[ 3]), .SCD(D[ 3]), .SCE(e[1]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe04(.Q(fb[ 4]), .D(fb[ 4]), .SCD(D[ 4]), .SCE(e[2]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe05(.Q(fb[ 5]), .D(fb[ 5]), .SCD(D[ 5]), .SCE(e[2]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe06(.Q(fb[ 6]), .D(fb[ 6]), .SCD(D[ 6]), .SCE(e[2]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe07(.Q(fb[ 7]), .D(fb[ 7]), .SCD(D[ 7]), .SCE(e[2]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe08(.Q(fb[ 8]), .D(fb[ 8]), .SCD(D[ 8]), .SCE(e[2]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe09(.Q(fb[ 9]), .D(fb[ 9]), .SCD(D[ 9]), .SCE(e[3]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe10(.Q(fb[10]), .D(fb[10]), .SCD(D[10]), .SCE(e[3]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe11(.Q(fb[11]), .D(fb[11]), .SCD(D[11]), .SCE(e[3]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe12(.Q(fb[12]), .D(fb[12]), .SCD(D[12]), .SCE(e[3]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe13(.Q(fb[13]), .D(fb[13]), .SCD(D[13]), .SCE(e[3]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe14(.Q(fb[14]), .D(fb[14]), .SCD(D[14]), .SCE(e[4]), .RESET_B(r[4]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe15(.Q(fb[15]), .D(fb[15]), .SCD(D[15]), .SCE(e[4]), .RESET_B(r[4]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe16(.Q(fb[16]), .D(fb[16]), .SCD(D[16]), .SCE(e[4]), .RESET_B(r[4]), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe17(.Q(fb[17]), .D(fb[17]), .SCD(D[17]), .SCE(e[4]), .RESET_B(r[4]), .CLK(clk));
endmodule

module dff_x9(
  input  wire clk,
  input  wire rst,
  input  wire [8:0] D,
  output wire [8:0] Q
);
  wire [3:1] r; fanout3 fo_r(.A(rst), .X(r));

  (* keep *) sg13g2_dfrbpq_1 dff0(.Q(Q[0]), .D(D[0]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff1(.Q(Q[1]), .D(D[1]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff2(.Q(Q[2]), .D(D[2]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff3(.Q(Q[3]), .D(D[3]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff4(.Q(Q[4]), .D(D[4]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff5(.Q(Q[5]), .D(D[5]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff6(.Q(Q[6]), .D(D[6]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff7(.Q(Q[7]), .D(D[7]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff8(.Q(Q[8]), .D(D[8]), .RESET_B(r[3]), .CLK(clk));
endmodule

module dffn_x9(
  input  wire clk,
  input  wire rst,
  input  wire [8:0] D,
  output wire [8:0] QN
);
  wire [3:1] r; fanout3 fo_r(.A(rst), .X(r));
  /* verilator lint_off PINCONNECTEMPTY */
  (* keep *) sg13g2_dfrbp_2 dffn0(.Q(), .Q_N(QN[0]), .D(D[0]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn1(.Q(), .Q_N(QN[1]), .D(D[1]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn2(.Q(), .Q_N(QN[2]), .D(D[2]), .RESET_B(r[1]), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn3(.Q(), .Q_N(QN[3]), .D(D[3]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn4(.Q(), .Q_N(QN[4]), .D(D[4]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn5(.Q(), .Q_N(QN[5]), .D(D[5]), .RESET_B(r[2]), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn6(.Q(), .Q_N(QN[6]), .D(D[6]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn7(.Q(), .Q_N(QN[7]), .D(D[7]), .RESET_B(r[3]), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn8(.Q(), .Q_N(QN[8]), .D(D[8]), .RESET_B(r[3]), .CLK(clk));
  /* verilator lint_on PINCONNECTEMPTY */
endmodule

module a22oi_x9(
  input  wire [8:0] A1,
  input  wire [8:0] A2,
  input  wire [8:0] B1,
  input  wire [8:0] B2,
  output wire [8:0] Y
);
  (* keep *) sg13g2_a22oi_1 a22oi_0(.A1(A1[0]), .A2(A2[0]), .B1(B1[0]), .B2(B2[0]), .Y(Y[0]));
  (* keep *) sg13g2_a22oi_1 a22oi_1(.A1(A1[1]), .A2(A2[1]), .B1(B1[1]), .B2(B2[1]), .Y(Y[1]));
  (* keep *) sg13g2_a22oi_1 a22oi_2(.A1(A1[2]), .A2(A2[2]), .B1(B1[2]), .B2(B2[2]), .Y(Y[2]));
  (* keep *) sg13g2_a22oi_1 a22oi_3(.A1(A1[3]), .A2(A2[3]), .B1(B1[3]), .B2(B2[3]), .Y(Y[3]));
  (* keep *) sg13g2_a22oi_1 a22oi_4(.A1(A1[4]), .A2(A2[4]), .B1(B1[4]), .B2(B2[4]), .Y(Y[4]));
  (* keep *) sg13g2_a22oi_1 a22oi_5(.A1(A1[5]), .A2(A2[5]), .B1(B1[5]), .B2(B2[5]), .Y(Y[5]));
  (* keep *) sg13g2_a22oi_1 a22oi_6(.A1(A1[6]), .A2(A2[6]), .B1(B1[6]), .B2(B2[6]), .Y(Y[6]));
  (* keep *) sg13g2_a22oi_1 a22oi_7(.A1(A1[7]), .A2(A2[7]), .B1(B1[7]), .B2(B2[7]), .Y(Y[7]));
  (* keep *) sg13g2_a22oi_1 a22oi_8(.A1(A1[8]), .A2(A2[8]), .B1(B1[8]), .B2(B2[8]), .Y(Y[8]));
endmodule

module a22oi_fo_x9(
  input             A1,
  input  wire [8:0] A2,
  input             B1,
  input  wire [8:0] B2,
  output wire [8:0] Y
);
  wire [3:1] A; fanout3 fo_A(.A(A1), .X(A));
  wire [3:1] B; fanout3 fo_B(.A(B1), .X(B));

  (* keep *) sg13g2_a22oi_1 a22oi_0(.A1(A[1]), .A2(A2[0]), .B1(B[1]), .B2(B2[0]), .Y(Y[0]));
  (* keep *) sg13g2_a22oi_1 a22oi_1(.A1(A[1]), .A2(A2[1]), .B1(B[1]), .B2(B2[1]), .Y(Y[1]));
  (* keep *) sg13g2_a22oi_1 a22oi_2(.A1(A[1]), .A2(A2[2]), .B1(B[1]), .B2(B2[2]), .Y(Y[2]));
  (* keep *) sg13g2_a22oi_1 a22oi_3(.A1(A[2]), .A2(A2[3]), .B1(B[2]), .B2(B2[3]), .Y(Y[3]));
  (* keep *) sg13g2_a22oi_1 a22oi_4(.A1(A[2]), .A2(A2[4]), .B1(B[2]), .B2(B2[4]), .Y(Y[4]));
  (* keep *) sg13g2_a22oi_1 a22oi_5(.A1(A[2]), .A2(A2[5]), .B1(B[2]), .B2(B2[5]), .Y(Y[5]));
  (* keep *) sg13g2_a22oi_1 a22oi_6(.A1(A[3]), .A2(A2[6]), .B1(B[3]), .B2(B2[6]), .Y(Y[6]));
  (* keep *) sg13g2_a22oi_1 a22oi_7(.A1(A[3]), .A2(A2[7]), .B1(B[3]), .B2(B2[7]), .Y(Y[7]));
  (* keep *) sg13g2_a22oi_1 a22oi_8(.A1(A[3]), .A2(A2[8]), .B1(B[3]), .B2(B2[8]), .Y(Y[8]));
endmodule

module a22o_fo_x9(
  input             A1,
  input  wire [8:0] A2,
  input             B1,
  input  wire [8:0] B2,
  output wire [8:0] Y
);
  wire [3:1] A; fanout3 fo_A(.A(A1), .X(A));
  wire [3:1] B; fanout3 fo_B(.A(B1), .X(B));
  wire [8:0] t;
  (* keep *) sg13g2_a22oi_1 a22oi_0(.A1(A[1]), .A2(A2[0]), .B1(B[1]), .B2(B2[0]), .Y(t[0]));
  (* keep *) sg13g2_a22oi_1 a22oi_1(.A1(A[1]), .A2(A2[1]), .B1(B[1]), .B2(B2[1]), .Y(t[1]));
  (* keep *) sg13g2_a22oi_1 a22oi_2(.A1(A[1]), .A2(A2[2]), .B1(B[1]), .B2(B2[2]), .Y(t[2]));
  (* keep *) sg13g2_a22oi_1 a22oi_3(.A1(A[2]), .A2(A2[3]), .B1(B[2]), .B2(B2[3]), .Y(t[3]));
  (* keep *) sg13g2_a22oi_1 a22oi_4(.A1(A[2]), .A2(A2[4]), .B1(B[2]), .B2(B2[4]), .Y(t[4]));
  (* keep *) sg13g2_a22oi_1 a22oi_5(.A1(A[2]), .A2(A2[5]), .B1(B[2]), .B2(B2[5]), .Y(t[5]));
  (* keep *) sg13g2_a22oi_1 a22oi_6(.A1(A[3]), .A2(A2[6]), .B1(B[3]), .B2(B2[6]), .Y(t[6]));
  (* keep *) sg13g2_a22oi_1 a22oi_7(.A1(A[3]), .A2(A2[7]), .B1(B[3]), .B2(B2[7]), .Y(t[7]));
  (* keep *) sg13g2_a22oi_1 a22oi_8(.A1(A[3]), .A2(A2[8]), .B1(B[3]), .B2(B2[8]), .Y(t[8]));

  (* keep *) sg13g2_inv_1 in0(.Y(Y[0]), .A(t[0]));
  (* keep *) sg13g2_inv_1 in1(.Y(Y[1]), .A(t[1]));
  (* keep *) sg13g2_inv_1 in2(.Y(Y[2]), .A(t[2]));
  (* keep *) sg13g2_inv_1 in3(.Y(Y[3]), .A(t[3]));
  (* keep *) sg13g2_inv_1 in4(.Y(Y[4]), .A(t[4]));
  (* keep *) sg13g2_inv_1 in5(.Y(Y[5]), .A(t[5]));
  (* keep *) sg13g2_inv_1 in6(.Y(Y[6]), .A(t[6]));
  (* keep *) sg13g2_inv_1 in7(.Y(Y[7]), .A(t[7]));
  (* keep *) sg13g2_inv_1 in8(.Y(Y[8]), .A(t[8]));
endmodule

module or16(
  input  wire [15:0] A,
  output wire        Y
);
  wire [3:0] t;

  (* keep *) sg13g2_nor4_1 nor0(.Y(t[0]), .A(A[ 0]), .B(A[ 1]), .C(A[ 2]), .D(A[ 3]));
  (* keep *) sg13g2_nor4_1 nor1(.Y(t[1]), .A(A[ 4]), .B(A[ 5]), .C(A[ 6]), .D(A[ 7]));
  (* keep *) sg13g2_nor4_1 nor2(.Y(t[2]), .A(A[ 8]), .B(A[ 9]), .C(A[10]), .D(A[11]));
  (* keep *) sg13g2_nor4_1 nor3(.Y(t[3]), .A(A[12]), .B(A[13]), .C(A[14]), .D(A[15]));
  (* keep *) sg13g2_nand4_1 nand4(.Y(Y), .A(t[0]), .B(t[1]), .C(t[2]), .D(t[3]));
endmodule

module nor16(
  input  wire [15:0] A,
  output wire        X
);
  wire [3:0] t;

  (* keep *) sg13g2_nor4_1 nor0(.Y(t[0]), .A(A[ 0]), .B(A[ 1]), .C(A[ 2]), .D(A[ 3]));
  (* keep *) sg13g2_nor4_1 nor1(.Y(t[1]), .A(A[ 4]), .B(A[ 5]), .C(A[ 6]), .D(A[ 7]));
  (* keep *) sg13g2_nor4_1 nor2(.Y(t[2]), .A(A[ 8]), .B(A[ 9]), .C(A[10]), .D(A[11]));
  (* keep *) sg13g2_nor4_1 nor3(.Y(t[3]), .A(A[12]), .B(A[13]), .C(A[14]), .D(A[15]));
  (* keep *) sg13g2_and4_1 and4(.X(X), .A(t[0]), .B(t[1]), .C(t[2]), .D(t[3]));
endmodule

