/*
  gPEAC18.v
  generalised (non-binary) PEAC scrambler/checksum/error detector
  with modulus=258114 
  See  https://hackaday.io/project/178998 
*/

/* This module compares a 18-bit number to the modulus.
   Compare a bitvector with the constant 258114 = 0x3F042 = 111111000001000010
   Any number equal or above raises X
*/

module Compare_modulus(
    input wire [17:0] A,
    output wire X
);
  wire t1, t2, t3, t4, t5, t6, t7, _unused;
  assign _unused = A[0]; // The LSB has no effect.

  // first layer
  (* keep *) sg13g2_and3_1 L1a3_1(.X(t1), .A(A[17]), .B(A[16]), .C(A[15]));
  (* keep *) sg13g2_and3_1 L1a3_2(.X(t2), .A(A[14]), .B(A[13]), .C(A[12]));
  (* keep *) sg13g2_or3_1  L1o3_1(.X(t3), .A(A[11]), .B(A[10]), .C(A[ 9]));
  (* keep *) sg13g2_or3_1  L1o3_2(.X(t4), .A(A[ 3]), .B(A[ 2]), .C(A[ 1]));
  // 2nd layer
  (* keep *) sg13g2_or3_1  L2o3_3(.X(t5), .A(t3),    .B(A[ 8]), .C(A[ 7]));
  (* keep *) sg13g2_or3_1  L2o3_4(.X(t6), .A(t4),    .B(A[ 5]), .C(A[ 4]));
  // 3rd layer
  (* keep *) sg13g2_a21o_2 L3ao_1(.X(t7), .A1(t4),   .A2(A[6]), .B1(t3));
  // Last stage
  (* keep *) sg13g2_and3_1 L4a3_3(.X( X), .A(t1),    .B(t2),    .C(t7));

endmodule

/*
module Inverters_x4 (
    input  wire [3:0] A,
    output wire [3:0] Y);
  (* keep *) sg13g2_inv_4  Amp0(.Y(Y[0]), .A(A[0]));
  (* keep *) sg13g2_inv_4  Amp1(.Y(Y[1]), .A(A[1]));
  (* keep *) sg13g2_inv_4  Amp2(.Y(Y[2]), .A(A[2]));
  (* keep *) sg13g2_inv_4  Amp3(.Y(Y[3]), .A(A[3]));
endmodule
*/

module ConstOrPass(
    input  wire [17:0] A,
    input  wire C,
    output wire [17:0] X  
);
  assign X = A;

endmodule


/* a 18-bit adder, I have no mapped/optimised version available (yet)
   and I have no time left for such detail */
module Add18(
    input  wire [17:0] A,
    input  wire [17:0] B,
    output wire [17:0] S
  // carry out missing ?
);
  assign S = A + B;
endmodule
