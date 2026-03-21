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

/* modules.v already defines the registers A, B, X, Y & T
dffen_x18(
  input  wire clk,
  input  wire rst,
  input  wire en,
  input  wire [17:0] D,
  output wire [17:0] Q
);
*/

/*
    modulus: std_ulogic_vector(17 downto 0) := "111111000001000010"; -- 258114; 
    adjust : std_ulogic_vector(17 downto 0) := "000000111110111110"; -- 4030 = 262144 - modulus;
*/

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
  (* keep *) sg13g2_or2_1  cstxP(.X(X[15]), .A(A[15]), .B(C));
  (* keep *) sg13g2_or2_1  cstxO(.X(X[14]), .A(A[14]), .B(C));
  (* keep *) sg13g2_and2_1 cstxN(.X(X[13]), .A(A[13]), .B(D));
  (* keep *) sg13g2_or2_1  cstxM(.X(X[12]), .A(A[12]), .B(C));
  (* keep *) sg13g2_or2_1  cstxL(.X(X[11]), .A(A[11]), .B(C));
  (* keep *) sg13g2_and2_1 cstxK(.X(X[10]), .A(A[10]), .B(D));
  (* keep *) sg13g2_or2_1  cstxJ(.X(X[ 9]), .A(A[ 9]), .B(C));
  (* keep *) sg13g2_or2_1  cstxI(.X(X[ 8]), .A(A[ 8]), .B(C));
  (* keep *) sg13g2_or2_1  cstxH(.X(X[ 7]), .A(A[ 7]), .B(C));
  (* keep *) sg13g2_and2_1 cstxG(.X(X[ 6]), .A(A[ 6]), .B(D));
  (* keep *) sg13g2_or2_1  cstxF(.X(X[ 5]), .A(A[ 5]), .B(C));
  (* keep *) sg13g2_or2_1  cstxE(.X(X[ 4]), .A(A[ 4]), .B(C));
  (* keep *) sg13g2_and2_1 cstxD(.X(X[ 3]), .A(A[ 3]), .B(D));
  (* keep *) sg13g2_or2_1  cstxC(.X(X[ 2]), .A(A[ 2]), .B(C));
  (* keep *) sg13g2_or2_1  cstxB(.X(X[ 1]), .A(A[ 1]), .B(C));
  (* keep *) sg13g2_or2_1  cstxA(.X(X[ 0]), .A(A[ 0]), .B(C));
endmodule

//  INIT_Y : std_ulogic_vector(17 downto 0) := "011 011 0101 0110 1101"  -- 111981
module ConstY_OrPass(
    input  wire [17:0] A,
    input  wire C,
    output wire [17:0] X  
);
  wire D;
  (* keep *) sg13g2_inv_4  inv(.Y(D), .A(C));
  (* keep *) sg13g2_and2_1 cstxR(.X(X[17]), .A(A[17]), .B(D));
  (* keep *) sg13g2_or2_1  cstxQ(.X(X[16]), .A(A[16]), .B(C));
  (* keep *) sg13g2_or2_1  cstxP(.X(X[15]), .A(A[15]), .B(C));
  (* keep *) sg13g2_and2_1 cstxO(.X(X[14]), .A(A[14]), .B(D));
  (* keep *) sg13g2_or2_1  cstxN(.X(X[13]), .A(A[13]), .B(C));
  (* keep *) sg13g2_or2_1  cstxM(.X(X[12]), .A(A[12]), .B(C));
  (* keep *) sg13g2_and2_1 cstxL(.X(X[11]), .A(A[11]), .B(D));
  (* keep *) sg13g2_or2_1  cstxK(.X(X[10]), .A(A[10]), .B(C));
  (* keep *) sg13g2_and2_1 cstxJ(.X(X[ 9]), .A(A[ 9]), .B(D));
  (* keep *) sg13g2_or2_1  cstxI(.X(X[ 8]), .A(A[ 8]), .B(C));
  (* keep *) sg13g2_and2_1 cstxH(.X(X[ 7]), .A(A[ 7]), .B(D));
  (* keep *) sg13g2_or2_1  cstxG(.X(X[ 6]), .A(A[ 6]), .B(C));
  (* keep *) sg13g2_or2_1  cstxF(.X(X[ 5]), .A(A[ 5]), .B(C));
  (* keep *) sg13g2_and2_1 cstxE(.X(X[ 4]), .A(A[ 4]), .B(D));
  (* keep *) sg13g2_or2_1  cstxD(.X(X[ 3]), .A(A[ 3]), .B(C));
  (* keep *) sg13g2_or2_1  cstxC(.X(X[ 2]), .A(A[ 2]), .B(C));
  (* keep *) sg13g2_and2_1 cstxB(.X(X[ 1]), .A(A[ 1]), .B(D));
  (* keep *) sg13g2_or2_1  cstxA(.X(X[ 0]), .A(A[ 0]), .B(C));
endmodule


module ConstOrNeg(
    input  wire [17:0] A,
    input  wire C,
    output wire [17:0] X  
);
  assign X = ~A;

endmodule


/* a 18-bit adder, I have no mapped/optimised version available (yet)
   and I have no time left for such detail */
module Add18(
    input  wire [17:0] A,
    input  wire [17:0] B,
    input  wire        Cin,
    output wire [17:0] S
    output wire        Cout
  // carry out missing ?
);
  wire dummy;
  assign { Cout, S, dummy } = { 1'b0, A, 1'b1 } + { 1'b0, B, Cin};
endmodule
