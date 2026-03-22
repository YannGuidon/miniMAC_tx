/*
  modules.v
  ©2026 Yann Guidon
  A dumb collection of recurring gates structures.
  Just because I don't want to learn Verilog.
  mer. 11 mars 2026 20:35:38 CET : version sans fanout manuel
*/


module mux2_x18(
    input  wire sel,
    input  wire [17:0] if0,
    input  wire [17:0] if1,
    output wire [17:0] res
);
  (* keep *) sg13g2_mux2_2 mux_00(.A0(if0[ 0]), .A1(if1[ 0]), .S(sel), .X(res[ 0]));
  (* keep *) sg13g2_mux2_2 mux_01(.A0(if0[ 1]), .A1(if1[ 1]), .S(sel), .X(res[ 1]));
  (* keep *) sg13g2_mux2_2 mux_02(.A0(if0[ 2]), .A1(if1[ 2]), .S(sel), .X(res[ 2]));
  (* keep *) sg13g2_mux2_2 mux_03(.A0(if0[ 3]), .A1(if1[ 3]), .S(sel), .X(res[ 3]));
  (* keep *) sg13g2_mux2_2 mux_04(.A0(if0[ 4]), .A1(if1[ 4]), .S(sel), .X(res[ 4]));
  (* keep *) sg13g2_mux2_2 mux_05(.A0(if0[ 5]), .A1(if1[ 5]), .S(sel), .X(res[ 5]));
  (* keep *) sg13g2_mux2_2 mux_06(.A0(if0[ 6]), .A1(if1[ 6]), .S(sel), .X(res[ 6]));
  (* keep *) sg13g2_mux2_2 mux_07(.A0(if0[ 7]), .A1(if1[ 7]), .S(sel), .X(res[ 7]));
  (* keep *) sg13g2_mux2_2 mux_08(.A0(if0[ 8]), .A1(if1[ 8]), .S(sel), .X(res[ 8]));
  (* keep *) sg13g2_mux2_2 mux_09(.A0(if0[ 9]), .A1(if1[ 9]), .S(sel), .X(res[ 9]));
  (* keep *) sg13g2_mux2_2 mux_10(.A0(if0[10]), .A1(if1[10]), .S(sel), .X(res[10]));
  (* keep *) sg13g2_mux2_2 mux_11(.A0(if0[11]), .A1(if1[11]), .S(sel), .X(res[11]));
  (* keep *) sg13g2_mux2_2 mux_12(.A0(if0[12]), .A1(if1[12]), .S(sel), .X(res[12]));
  (* keep *) sg13g2_mux2_2 mux_13(.A0(if0[13]), .A1(if1[13]), .S(sel), .X(res[13]));
  (* keep *) sg13g2_mux2_2 mux_14(.A0(if0[14]), .A1(if1[14]), .S(sel), .X(res[14]));
  (* keep *) sg13g2_mux2_2 mux_15(.A0(if0[15]), .A1(if1[15]), .S(sel), .X(res[15]));
  (* keep *) sg13g2_mux2_2 mux_16(.A0(if0[16]), .A1(if1[16]), .S(sel), .X(res[16]));
  (* keep *) sg13g2_mux2_2 mux_17(.A0(if0[17]), .A1(if1[17]), .S(sel), .X(res[17]));
endmodule

module xor2_x18(
    input  wire [17:0] A,
    input  wire [17:0] B,
    output wire [17:0] X
);
  (* keep *) sg13g2_xor2_1 xo00(.X(X[ 0]), .A(A[ 0]), .B(B[ 0]));
  (* keep *) sg13g2_xor2_1 xo01(.X(X[ 1]), .A(A[ 1]), .B(B[ 1]));
  (* keep *) sg13g2_xor2_1 xo02(.X(X[ 2]), .A(A[ 2]), .B(B[ 2]));
  (* keep *) sg13g2_xor2_1 xo03(.X(X[ 3]), .A(A[ 3]), .B(B[ 3]));
  (* keep *) sg13g2_xor2_1 xo04(.X(X[ 4]), .A(A[ 4]), .B(B[ 4]));
  (* keep *) sg13g2_xor2_1 xo05(.X(X[ 5]), .A(A[ 5]), .B(B[ 5]));
  (* keep *) sg13g2_xor2_1 xo06(.X(X[ 6]), .A(A[ 6]), .B(B[ 6]));
  (* keep *) sg13g2_xor2_1 xo07(.X(X[ 7]), .A(A[ 7]), .B(B[ 7]));
  (* keep *) sg13g2_xor2_1 xo08(.X(X[ 8]), .A(A[ 8]), .B(B[ 8]));
  (* keep *) sg13g2_xor2_1 xo09(.X(X[ 9]), .A(A[ 9]), .B(B[ 9]));
  (* keep *) sg13g2_xor2_1 xo10(.X(X[10]), .A(A[10]), .B(B[10]));
  (* keep *) sg13g2_xor2_1 xo11(.X(X[11]), .A(A[11]), .B(B[11]));
  (* keep *) sg13g2_xor2_1 xo12(.X(X[12]), .A(A[12]), .B(B[12]));
  (* keep *) sg13g2_xor2_1 xo13(.X(X[13]), .A(A[13]), .B(B[13]));
  (* keep *) sg13g2_xor2_1 xo14(.X(X[14]), .A(A[14]), .B(B[14]));
  (* keep *) sg13g2_xor2_1 xo15(.X(X[15]), .A(A[15]), .B(B[15]));
  (* keep *) sg13g2_xor2_1 xo16(.X(X[16]), .A(A[16]), .B(B[16]));
  (* keep *) sg13g2_xor2_1 xo17(.X(X[17]), .A(A[17]), .B(B[17]));
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
  
  (* keep *) sg13g2_sdfrbpq_1 dffe00(.Q(fb[ 0]), .D(fb[ 0]), .SCD(D[ 0]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe01(.Q(fb[ 1]), .D(fb[ 1]), .SCD(D[ 1]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe02(.Q(fb[ 2]), .D(fb[ 2]), .SCD(D[ 2]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe03(.Q(fb[ 3]), .D(fb[ 3]), .SCD(D[ 3]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe04(.Q(fb[ 4]), .D(fb[ 4]), .SCD(D[ 4]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe05(.Q(fb[ 5]), .D(fb[ 5]), .SCD(D[ 5]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe06(.Q(fb[ 6]), .D(fb[ 6]), .SCD(D[ 6]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe07(.Q(fb[ 7]), .D(fb[ 7]), .SCD(D[ 7]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe08(.Q(fb[ 8]), .D(fb[ 8]), .SCD(D[ 8]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe09(.Q(fb[ 9]), .D(fb[ 9]), .SCD(D[ 9]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe10(.Q(fb[10]), .D(fb[10]), .SCD(D[10]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe11(.Q(fb[11]), .D(fb[11]), .SCD(D[11]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe12(.Q(fb[12]), .D(fb[12]), .SCD(D[12]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe13(.Q(fb[13]), .D(fb[13]), .SCD(D[13]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe14(.Q(fb[14]), .D(fb[14]), .SCD(D[14]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe15(.Q(fb[15]), .D(fb[15]), .SCD(D[15]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe16(.Q(fb[16]), .D(fb[16]), .SCD(D[16]), .SCE(en), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_sdfrbpq_1 dffe17(.Q(fb[17]), .D(fb[17]), .SCD(D[17]), .SCE(en), .RESET_B(rst), .CLK(clk));
endmodule

module dffen_rs_x18(
    input  wire clk,
    input  wire [17:0] rst,
    input  wire [17:0] set,
    input  wire en,
    input  wire [17:0] D,
    output wire [17:0] Q
);
  wire [17:0] fb;
  wire [17:0] U;
  assign Q = fb;
///  sg13g2_sdfbbp_1 (Q, Q_N, D, SCD, SCE, RESET_B, SET_B, CLK);
  (* keep *) sg13g2_sdfbbp_1 dffe00(.Q(fb[ 0]), .D(fb[ 0]), .SCD(D[ 0]), .SCE(en), .RESET_B(rst[17]), .SET_B(set[17]), .CLK(clk), .Q_N(U[17]));
  (* keep *) sg13g2_sdfbbp_1 dffe01(.Q(fb[ 1]), .D(fb[ 1]), .SCD(D[ 1]), .SCE(en), .RESET_B(rst[16]), .SET_B(set[16]), .CLK(clk), .Q_N(U[16]));
  (* keep *) sg13g2_sdfbbp_1 dffe02(.Q(fb[ 2]), .D(fb[ 2]), .SCD(D[ 2]), .SCE(en), .RESET_B(rst[15]), .SET_B(set[15]), .CLK(clk), .Q_N(U[15]));
  (* keep *) sg13g2_sdfbbp_1 dffe03(.Q(fb[ 3]), .D(fb[ 3]), .SCD(D[ 3]), .SCE(en), .RESET_B(rst[14]), .SET_B(set[14]), .CLK(clk), .Q_N(U[14]));
  (* keep *) sg13g2_sdfbbp_1 dffe04(.Q(fb[ 4]), .D(fb[ 4]), .SCD(D[ 4]), .SCE(en), .RESET_B(rst[13]), .SET_B(set[13]), .CLK(clk), .Q_N(U[13]));
  (* keep *) sg13g2_sdfbbp_1 dffe05(.Q(fb[ 5]), .D(fb[ 5]), .SCD(D[ 5]), .SCE(en), .RESET_B(rst[12]), .SET_B(set[12]), .CLK(clk), .Q_N(U[12]));
  (* keep *) sg13g2_sdfbbp_1 dffe06(.Q(fb[ 6]), .D(fb[ 6]), .SCD(D[ 6]), .SCE(en), .RESET_B(rst[11]), .SET_B(set[11]), .CLK(clk), .Q_N(U[11]));
  (* keep *) sg13g2_sdfbbp_1 dffe07(.Q(fb[ 7]), .D(fb[ 7]), .SCD(D[ 7]), .SCE(en), .RESET_B(rst[10]), .SET_B(set[10]), .CLK(clk), .Q_N(U[10]));
  (* keep *) sg13g2_sdfbbp_1 dffe08(.Q(fb[ 8]), .D(fb[ 8]), .SCD(D[ 8]), .SCE(en), .RESET_B(rst[ 9]), .SET_B(set[ 9]), .CLK(clk), .Q_N(U[ 9]));
  (* keep *) sg13g2_sdfbbp_1 dffe09(.Q(fb[ 9]), .D(fb[ 9]), .SCD(D[ 9]), .SCE(en), .RESET_B(rst[ 8]), .SET_B(set[ 8]), .CLK(clk), .Q_N(U[ 8]));
  (* keep *) sg13g2_sdfbbp_1 dffe10(.Q(fb[10]), .D(fb[10]), .SCD(D[10]), .SCE(en), .RESET_B(rst[ 7]), .SET_B(set[ 7]), .CLK(clk), .Q_N(U[ 7]));
  (* keep *) sg13g2_sdfbbp_1 dffe11(.Q(fb[11]), .D(fb[11]), .SCD(D[11]), .SCE(en), .RESET_B(rst[ 6]), .SET_B(set[ 6]), .CLK(clk), .Q_N(U[ 6]));
  (* keep *) sg13g2_sdfbbp_1 dffe12(.Q(fb[12]), .D(fb[12]), .SCD(D[12]), .SCE(en), .RESET_B(rst[ 5]), .SET_B(set[ 5]), .CLK(clk), .Q_N(U[ 5]));
  (* keep *) sg13g2_sdfbbp_1 dffe13(.Q(fb[13]), .D(fb[13]), .SCD(D[13]), .SCE(en), .RESET_B(rst[ 4]), .SET_B(set[ 4]), .CLK(clk), .Q_N(U[ 4]));
  (* keep *) sg13g2_sdfbbp_1 dffe14(.Q(fb[14]), .D(fb[14]), .SCD(D[14]), .SCE(en), .RESET_B(rst[ 3]), .SET_B(set[ 3]), .CLK(clk), .Q_N(U[ 3]));
  (* keep *) sg13g2_sdfbbp_1 dffe15(.Q(fb[15]), .D(fb[15]), .SCD(D[15]), .SCE(en), .RESET_B(rst[ 2]), .SET_B(set[ 2]), .CLK(clk), .Q_N(U[ 2]));
  (* keep *) sg13g2_sdfbbp_1 dffe16(.Q(fb[16]), .D(fb[16]), .SCD(D[16]), .SCE(en), .RESET_B(rst[ 1]), .SET_B(set[ 1]), .CLK(clk), .Q_N(U[ 1]));
  (* keep *) sg13g2_sdfbbp_1 dffe17(.Q(fb[17]), .D(fb[17]), .SCD(D[17]), .SCE(en), .RESET_B(rst[ 0]), .SET_B(set[ 0]), .CLK(clk), .Q_N(U[ 0]));
  wire _unused;
  assign _unused = &{ U, 1'b0};
endmodule


module dff_x9(
    input  wire clk,
    input  wire rst,
    input  wire [8:0] D,
    output wire [8:0] Q
);
  (* keep *) sg13g2_dfrbpq_1 dff0(.Q(Q[0]), .D(D[0]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff1(.Q(Q[1]), .D(D[1]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff2(.Q(Q[2]), .D(D[2]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff3(.Q(Q[3]), .D(D[3]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff4(.Q(Q[4]), .D(D[4]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff5(.Q(Q[5]), .D(D[5]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff6(.Q(Q[6]), .D(D[6]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff7(.Q(Q[7]), .D(D[7]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 dff8(.Q(Q[8]), .D(D[8]), .RESET_B(rst), .CLK(clk));
endmodule

module dffn_x9(
    input  wire clk,
    input  wire rst,
    input  wire [8:0] D,
    output wire [8:0] QN
);
  /* verilator lint_off PINCONNECTEMPTY */
  (* keep *) sg13g2_dfrbp_2 dffn0(.Q(), .Q_N(QN[0]), .D(D[0]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn1(.Q(), .Q_N(QN[1]), .D(D[1]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn2(.Q(), .Q_N(QN[2]), .D(D[2]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn3(.Q(), .Q_N(QN[3]), .D(D[3]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn4(.Q(), .Q_N(QN[4]), .D(D[4]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn5(.Q(), .Q_N(QN[5]), .D(D[5]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn6(.Q(), .Q_N(QN[6]), .D(D[6]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn7(.Q(), .Q_N(QN[7]), .D(D[7]), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbp_2 dffn8(.Q(), .Q_N(QN[8]), .D(D[8]), .RESET_B(rst), .CLK(clk));
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
  (* keep *) sg13g2_a22oi_1 a22oi_0(.A1(A1), .A2(A2[0]), .B1(B1), .B2(B2[0]), .Y(Y[0]));
  (* keep *) sg13g2_a22oi_1 a22oi_1(.A1(A1), .A2(A2[1]), .B1(B1), .B2(B2[1]), .Y(Y[1]));
  (* keep *) sg13g2_a22oi_1 a22oi_2(.A1(A1), .A2(A2[2]), .B1(B1), .B2(B2[2]), .Y(Y[2]));
  (* keep *) sg13g2_a22oi_1 a22oi_3(.A1(A1), .A2(A2[3]), .B1(B1), .B2(B2[3]), .Y(Y[3]));
  (* keep *) sg13g2_a22oi_1 a22oi_4(.A1(A1), .A2(A2[4]), .B1(B1), .B2(B2[4]), .Y(Y[4]));
  (* keep *) sg13g2_a22oi_1 a22oi_5(.A1(A1), .A2(A2[5]), .B1(B1), .B2(B2[5]), .Y(Y[5]));
  (* keep *) sg13g2_a22oi_1 a22oi_6(.A1(A1), .A2(A2[6]), .B1(B1), .B2(B2[6]), .Y(Y[6]));
  (* keep *) sg13g2_a22oi_1 a22oi_7(.A1(A1), .A2(A2[7]), .B1(B1), .B2(B2[7]), .Y(Y[7]));
  (* keep *) sg13g2_a22oi_1 a22oi_8(.A1(A1), .A2(A2[8]), .B1(B1), .B2(B2[8]), .Y(Y[8]));
endmodule

module a22o_fo_x9(
    input             A1,
    input  wire [8:0] A2,
    input             B1,
    input  wire [8:0] B2,
    output wire [8:0] Y
);
  wire [8:0] t;
  (* keep *) sg13g2_a22oi_1 a22oi_0(.A1(A1), .A2(A2[0]), .B1(B1), .B2(B2[0]), .Y(t[0]));
  (* keep *) sg13g2_a22oi_1 a22oi_1(.A1(A1), .A2(A2[1]), .B1(B1), .B2(B2[1]), .Y(t[1]));
  (* keep *) sg13g2_a22oi_1 a22oi_2(.A1(A1), .A2(A2[2]), .B1(B1), .B2(B2[2]), .Y(t[2]));
  (* keep *) sg13g2_a22oi_1 a22oi_3(.A1(A1), .A2(A2[3]), .B1(B1), .B2(B2[3]), .Y(t[3]));
  (* keep *) sg13g2_a22oi_1 a22oi_4(.A1(A1), .A2(A2[4]), .B1(B1), .B2(B2[4]), .Y(t[4]));
  (* keep *) sg13g2_a22oi_1 a22oi_5(.A1(A1), .A2(A2[5]), .B1(B1), .B2(B2[5]), .Y(t[5]));
  (* keep *) sg13g2_a22oi_1 a22oi_6(.A1(A1), .A2(A2[6]), .B1(B1), .B2(B2[6]), .Y(t[6]));
  (* keep *) sg13g2_a22oi_1 a22oi_7(.A1(A1), .A2(A2[7]), .B1(B1), .B2(B2[7]), .Y(t[7]));
  (* keep *) sg13g2_a22oi_1 a22oi_8(.A1(A1), .A2(A2[8]), .B1(B1), .B2(B2[8]), .Y(t[8]));

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

// de-multiplex the 18-bit word
module input_demux(
    input wire clk,
    input wire rst,
    input wire DEN,
    input wire [8:0] Din9,

    output wire Din_OK,
    output wire [17:0] FirstWord
);
  wire Den_In0, Den_In1, valid;

  // Input / resynch buffers
  wire [8:0]  FirstHalfWord;
  // Den_In0 <= DEN        sg13g2_dfrbpq_1  / 49
  (* keep *) sg13g2_dfrbpq_1 DFF_den0(.Q(Den_In0), .D(DEN), .RESET_B(rst), .CLK(clk));
  // Den_In1 <= ~Den_In0
  /* verilator lint_off PINCONNECTEMPTY */
  (* keep *) sg13g2_dfrbp_2 DFF_den1(.Q_N(Den_In1), .Q(), .D(Den_In0), .RESET_B(rst), .CLK(clk));
  /* verilator lint_on PINCONNECTEMPTY */
  // valid <= Den_In0 & ~Den_In1  sg13g2_and2_2
  (* keep *) sg13g2_and2_1 Din_and2(.X(valid), .A(Den_In0), .B(Den_In1));
  // The data buffers
  (* keep *) sg13g2_dfrbpq_1 DFF_val(.Q(Din_OK), .D(valid), .RESET_B(rst), .CLK(clk));
  dff_x9    fhw(.clk(clk), .rst(rst), .D(Din9), .Q(FirstHalfWord));                           // Always samples the input
  dffen_x18  fw(.clk(clk), .rst(rst), .D({Din9, FirstHalfWord}), .Q(FirstWord), .en(valid)); // Samples only if DEN is ok (going from low to high)
endmodule

  
// re-multiplex the 18-bit word
module output_muxer(
    input wire clk,
    input wire rst,
    input wire Dout_OK,
    input wire [17:0] LastWord,

    output wire Zero,
    output wire QEN,
    output wire [8:0] Dout9
);
  wire Zero_value, QEN1;
  wire [8:0]  LastHalfWord, LastMSB;

  // shift register : Dout_OK => QEN1 => QEN
  (* keep *) sg13g2_dfrbpq_1 DFF_QEN1(.Q(QEN1), .D(Dout_OK), .RESET_B(rst), .CLK(clk));
  (* keep *) sg13g2_dfrbpq_1 DFF_QEN2(.Q(QEN ), .D(QEN1),    .RESET_B(rst), .CLK(clk));

  // Zero flag is 1 when all the 16 data bits are 0:
  nor16 zo16(.A({LastWord[16:9], LastWord[7:0]}), .X(Zero_value));   // does not NOR the C/D bit!
  (* keep *) sg13g2_dfrbpq_1 DFF_sero(.Q(Zero), .D(Zero_value), .RESET_B(rst), .CLK(clk));  // Latch & output the "sum"

  // Multiplex the last half words:
  dff_x9 dffMSB(.D(LastWord[17:9]), .Q(LastMSB), .clk(clk), .rst(rst)); // save the MSB for the next cycle
  a22o_fo_x9 sel2(.A1(QEN1), .A2(LastWord[8:0]),  // LSB first
                  .B1(QEN ), .B2(LastMSB),        // then MSB
                  .Y(LastHalfWord));              // otherwise 0
  dff_x9 dffOut(.D(LastHalfWord), .Q(Dout9), .clk(clk), .rst(rst));  // Latch & output the data halfword
endmodule

module Encode_Hamming_early(
    input wire clk,
    input wire rst,
    input wire HammEn,
    input wire [17:0] HammIn,
    output wire [17:0] HammOut  
);
  wire [17:0] HammerEnc_result, HammerEnc_delayed;
  Hammer18x4 HamEnc(.I(HammIn), .O(HammerEnc_result));
  dffen_x18 delayEnc(.clk(clk), .rst(rst), .D(HammerEnc_result), .Q(HammerEnc_delayed), .en(HammEn));
  xor2_x18 mixEnc(.A(HammIn), .B(HammerEnc_delayed), .X(HammOut) );
endmodule

module Decode_Hamming_early(
    input wire clk,
    input wire rst,
    input wire HammEn,
    input wire [17:0] HammIn,
    input wire [17:0] HammOut  
);
  wire [17:0] HammerDec_result, HammerDec_delayed;
  xor2_x18 mixDec(.A(HammIn), .B(HammerDec_delayed), .X(HammOut) );
  Hammer18x4 HamDec(.I(HammOut), .O(HammerDec_result));
  dffen_x18 delayDec(.clk(clk), .rst(rst), .D(HammerDec_result), .Q(HammerDec_delayed), .en(DecResult_En));
endmodule
