/*
  gPEAC18.v
  generalised (non-binary) PEAC scrambler/checksum/error detector
  with modulus=258114 
  See  https://hackaday.io/project/178998 
*/

/* This module compares a 18-bit number to the modulus.
   Compare a bitvector with the constant 258114 = 0x3F042 = 111111000001000010
   Any number equal or above raises X */
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
  (* keep *) sg13g2_a21o_2 L3ao_1(.X(t7), .A1(t6),   .A2(A[6]), .B1(t5));
  // Last stage
  (* keep *) sg13g2_and3_1 L4a3_3(.X( X), .A(t1),    .B(t2),    .C(t7));
endmodule



/*
//  INIT_X : std_ulogic_vector(17 downto 0) := "101101101110110111"; -- 187319
module ConstX_OrPass(
    input  wire [17:0] A,
    input  wire C,
    output wire [17:0] X  
);
  wire D;
  (* keep *) sg13g2_inv_4  inv(.Y(D), .A(C));
  (* keep *) sg13g2_or2_1  cstxR(.X(X[17]), .A(A[17]), .B(C));
  (* keep *) sg13g2_and2_1 cstxQ(.X(X[16]), .A(A[16]), .B(D));
....
endmodule
*/

/* adjust : std_ulogic_vector(17 downto 0) := "000000111110111110"; -- 4030 = 262144 - modulus; */
module ConstAdjOrPass(
    input  wire [17:0] A,
    input  wire C,
    output wire [17:0] X  
);
  (* keep *) sg13g2_nor2b_1  cstxr(.Y(X[17]), .B_N(A[17]), .A(C));
  (* keep *) sg13g2_nor2b_1  cstxq(.Y(X[16]), .B_N(A[16]), .A(C));
  (* keep *) sg13g2_nor2b_1  cstxp(.Y(X[15]), .B_N(A[15]), .A(C));
  (* keep *) sg13g2_nor2b_1  cstxo(.Y(X[14]), .B_N(A[14]), .A(C));
  (* keep *) sg13g2_nor2b_1  cstxn(.Y(X[13]), .B_N(A[13]), .A(C));
  (* keep *) sg13g2_nor2b_1  cstxm(.Y(X[12]), .B_N(A[12]), .A(C));
  (* keep *) sg13g2_nand2b_1 cstxl(.Y(X[11]), .A_N(A[11]), .B(C));
  (* keep *) sg13g2_nand2b_1 cstxk(.Y(X[10]), .A_N(A[10]), .B(C));
  (* keep *) sg13g2_nand2b_1 cstxj(.Y(X[ 9]), .A_N(A[ 9]), .B(C));
  (* keep *) sg13g2_nand2b_1 cstxi(.Y(X[ 8]), .A_N(A[ 8]), .B(C));
  (* keep *) sg13g2_nand2b_1 cstxh(.Y(X[ 7]), .A_N(A[ 7]), .B(C));
  (* keep *) sg13g2_nor2b_1  cstxg(.Y(X[ 6]), .B_N(A[ 6]), .A(C));
  (* keep *) sg13g2_nand2b_1 cstxf(.Y(X[ 5]), .A_N(A[ 5]), .B(C));
  (* keep *) sg13g2_nand2b_1 cstxe(.Y(X[ 4]), .A_N(A[ 4]), .B(C));
  (* keep *) sg13g2_nand2b_1 cstxd(.Y(X[ 3]), .A_N(A[ 3]), .B(C));
  (* keep *) sg13g2_nand2b_1 cstxc(.Y(X[ 2]), .A_N(A[ 2]), .B(C));
  (* keep *) sg13g2_nand2b_1 cstxb(.Y(X[ 1]), .A_N(A[ 1]), .B(C));
  (* keep *) sg13g2_nor2b_1  cstxa(.Y(X[ 0]), .B_N(A[ 0]), .A(C));
endmodule

//  modulus: std_ulogic_vector(17 downto 0) := "111 111 00 000 1 0000 10"; -- 258114; 
module ConstModOrNeg(
    input  wire [17:0] A,
    input  wire C,
    output wire [17:0] X  
);
  (* keep *) sg13g2_nand2_1 cstxr(.Y(X[17]), .A(A[17]), .B(C));
  (* keep *) sg13g2_nand2_1 cstxq(.Y(X[16]), .A(A[16]), .B(C));
  (* keep *) sg13g2_nand2_1 cstxp(.Y(X[15]), .A(A[15]), .B(C));
  (* keep *) sg13g2_nand2_1 cstxo(.Y(X[14]), .A(A[14]), .B(C));
  (* keep *) sg13g2_nand2_1 cstxn(.Y(X[13]), .A(A[13]), .B(C));
  (* keep *) sg13g2_nand2_1 cstxm(.Y(X[12]), .A(A[12]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxl(.Y(X[11]), .A(A[11]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxk(.Y(X[10]), .A(A[10]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxj(.Y(X[ 9]), .A(A[ 9]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxi(.Y(X[ 8]), .A(A[ 8]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxh(.Y(X[ 7]), .A(A[ 7]), .B(C));
  (* keep *) sg13g2_nand2_1 cstxg(.Y(X[ 6]), .A(A[ 6]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxf(.Y(X[ 5]), .A(A[ 5]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxe(.Y(X[ 4]), .A(A[ 4]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxd(.Y(X[ 3]), .A(A[ 3]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxc(.Y(X[ 2]), .A(A[ 2]), .B(C));  
  (* keep *) sg13g2_nand2_1 cstxb(.Y(X[ 1]), .A(A[ 1]), .B(C));
  (* keep *) sg13g2_nor2_1  cstxa(.Y(X[ 0]), .A(A[ 0]), .B(C));
endmodule

/* a 18-bit adder, I have no mapped/optimised version available (yet)
   and I have no time left for such detail */
module Add18(
    input  wire [17:0] A,
    input  wire [17:0] B,
    input  wire        Cin,
    output wire [17:0] S,
    output wire        Cout
  // carry out missing ?
);
  wire dummy;
  assign { Cout, S, dummy } = { 1'b0, A, 1'b1 } + { 1'b0, B, Cin};
endmodule
