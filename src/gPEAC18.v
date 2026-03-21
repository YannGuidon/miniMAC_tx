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
  (* keep *) sg13g2_or2_1    cstxl(.X(X[11]), .A(  A[11]), .B(C));
  (* keep *) sg13g2_or2_1    cstxk(.X(X[10]), .A(  A[10]), .B(C));
  (* keep *) sg13g2_or2_1    cstxj(.X(X[ 9]), .A(  A[ 9]), .B(C));
  (* keep *) sg13g2_or2_1    cstxi(.X(X[ 8]), .A(  A[ 8]), .B(C));
  (* keep *) sg13g2_or2_1    cstxh(.X(X[ 7]), .A(  A[ 7]), .B(C));
  (* keep *) sg13g2_nor2b_1  cstxg(.Y(X[ 6]), .B_N(A[ 6]), .A(C));
  (* keep *) sg13g2_or2_1    cstxf(.X(X[ 5]), .A(  A[ 5]), .B(C));
  (* keep *) sg13g2_or2_1    cstxe(.X(X[ 4]), .A(  A[ 4]), .B(C));
  (* keep *) sg13g2_or2_1    cstxd(.X(X[ 3]), .A(  A[ 3]), .B(C));
  (* keep *) sg13g2_or2_1    cstxc(.X(X[ 2]), .A(  A[ 2]), .B(C));
  (* keep *) sg13g2_or2_1    cstxb(.X(X[ 1]), .A(  A[ 1]), .B(C));
  (* keep *) sg13g2_nor2b_1  cstxa(.Y(X[ 0]), .B_N(A[ 0]), .A(C));
endmodule

//  modulus: std_ulogic_vector(17 downto 0) := "111 111 00 000 1 0000 10"; -- 258114; 
module ConstModOrNeg(
    input  wire [17:0] A,
    input  wire C,
    output wire [17:0] X  
);
  (* keep *) sg13g2_nand2b_1 cstxr(.Y(X[17]), .B(A[17]), .A_N(C));
  (* keep *) sg13g2_nand2b_1 cstxq(.Y(X[16]), .B(A[16]), .A_N(C));
  (* keep *) sg13g2_nand2b_1 cstxp(.Y(X[15]), .B(A[15]), .A_N(C));
  (* keep *) sg13g2_nand2b_1 cstxo(.Y(X[14]), .B(A[14]), .A_N(C));
  (* keep *) sg13g2_nand2b_1 cstxn(.Y(X[13]), .B(A[13]), .A_N(C));
  (* keep *) sg13g2_nand2b_1 cstxm(.Y(X[12]), .B(A[12]), .A_N(C));
  (* keep *) sg13g2_nor2_1   cstxl(.Y(X[11]), .B(A[11]), .A(  C));
  (* keep *) sg13g2_nor2_1   cstxk(.Y(X[10]), .B(A[10]), .A(  C));
  (* keep *) sg13g2_nor2_1   cstxj(.Y(X[ 9]), .B(A[ 9]), .A(  C));
  (* keep *) sg13g2_nor2_1   cstxi(.Y(X[ 8]), .B(A[ 8]), .A(  C));
  (* keep *) sg13g2_nor2_1   cstxh(.Y(X[ 7]), .B(A[ 7]), .A(  C));
  (* keep *) sg13g2_nand2b_1 cstxg(.Y(X[ 6]), .B(A[ 6]), .A_N(C));
  (* keep *) sg13g2_nor2_1   cstxf(.Y(X[ 5]), .B(A[ 5]), .A(  C));
  (* keep *) sg13g2_nor2_1   cstxe(.Y(X[ 4]), .B(A[ 4]), .A(  C));
  (* keep *) sg13g2_nor2_1   cstxd(.Y(X[ 3]), .B(A[ 3]), .A(  C));
  (* keep *) sg13g2_nor2_1   cstxc(.Y(X[ 2]), .B(A[ 2]), .A(  C));  
  (* keep *) sg13g2_nand2b_1 cstxb(.Y(X[ 1]), .B(A[ 1]), .A_N(C));
  (* keep *) sg13g2_nor2_1   cstxa(.Y(X[ 0]), .B(A[ 0]), .A(  C));
endmodule

/* a 18-bit adder, I have no mapped/optimised version available (yet)
   and I have no time left for such detail */
module Add18(
    input  wire [17:0] A,
    input  wire [17:0] B,
    input  wire        Cin,
    output wire [17:0] S,
    output wire        Cout
);
  wire dummy;
  assign { Cout, S, dummy } = { 1'b0, A, 1'b1 } + { 1'b0, B, Cin};
endmodule

module Register_InitX(
  input  wire clk,
  input  wire rst,
  input  wire en,
  input  wire [17:0] D,
  output wire [17:0] Q
);
  wire [17:0] S, R;
  // Init_X = "1011 0110 1110 110 111"
  assign S = { rst,1'b1,rst, rst,   1'b1,rst,rst,1'b1,  rst, rst, rst, 1'b1,  rst, rst, 1'b1,  rst, rst, rst };
  assign R = { 1'b1,rst,1'b1,1'b1,  rst,1'b1,1'b1,rst,  1'b1,1'b1,1'b1,rst,   1'b1,1'b1,rst,   1'b1,1'b1,1'b1};
  dffen_rs_x18 register(.clk(clk), .rst(R), .set(S), .en(en), .D(D), .Q(Q));
endmodule

module Register_InitY(
  input  wire clk,
  input  wire rst,
  input  wire en,
  input  wire [17:0] D,
  output wire [17:0] Q
);
  wire [17:0] S, R;
  // Init_Y = "01 101  101 0 101 101 101"
  assign S = { 1'b1,rst,   rst, 1'b1,rst,   rst, 1'b1,rst,    1'b1,  rst, 1'b1,rst,   rst, 1'b1,rst,   rst, 1'b1,rst  };
  assign R = { rst, 1'b1,  1'b1,rst, 1'b1,  1'b1,rst, 1'b1,   rst,   1'b1,rst, 1'b1,  1'b1,rst, 1'b1,  1'b1,rst, 1'b1 };
  dffen_rs_x18 register(.clk(clk), .rst(R), .set(S), .en(en), .D(D), .Q(Q));
endmodule

////////////////////////////////////////////////////////////////////

module gPEAC18_scrambler(
  input  wire clk,
  input  wire rst,
  input  wire Enable,
  input  wire Phase,
  input  wire [16:0] Message_in, // C/D bit as Message_in[8]
  output wire [17:0] Scrambled_out // 0 < data < modulus
);

  wire [17:0] X;
  wire [17:0] Y;
  wire [17:0] OPM;
  wire [17:0] OPX;
  wire [17:0] OPY;
  wire [17:0] ResX;
  wire [17:0] ResY;
  wire CinX, CinY, CoutX, CoutY;

  mux2_x18(.sel(Phase), .if0(Message_in), .if1(X), .res(OPM));
  ConstAdjOrPass(.A(Y), .C(Phase), .X(OPY));
  Add18 adX(.A(OPM), .B(OPY), .Cin(CinX), .S(ResX), .Cout(CoutX));
  Register_InitX RegX( .clk(clk), .rst(rst), .en(en), .D(ResX), .Q(X));  // EN à contrôler !

  ConstAdjOrPass(.A(X), .C(Phase), .X(OPX));
  Add18 adY(.A(OPX), .B(Y), .Cin(CinY), .S(ResY), .Cout(CoutY));
  Register_InitX RegY( .clk(clk), .rst(rst), .en(en), .D(ResY), .Q(Y));  // EN à contrôler !
);
  
  
endmodule

////////////////////////////////////////////////////////////////////

module gPEAC18_scrambler(
  input  wire clk,
  input  wire rst,
  input  wire Enable,
  input  wire Phase,
  input  wire [17:0] Scrambled_in // 0 < data < modulus
  output wire [16:0] Message_out, // C/D bit as Message_in[8]
  output wire Error
);

  // Sticky error flag : pull rst low to clear
  wire error_transient, error_MSB, error_Modulus;
  Compare_modulus cmp(.A(Scrambled_in), .X(error_Modulus));
  (* keep *) sg13g2_or3_1  ErrCom(.X(error_transient), .A(error_Modulus), .B(error_MSB), .C(Error));
  (* keep *) sg13g2_dfrbpq_1 dffErr(.Q(Error), .D(error_transient), .RESET_B(rst), .CLK(clk));

  wire [17:0] A;
  wire [17:0] B;
  wire [17:0] OPM;
  wire [17:0] OPX;
  wire [17:0] OPY1;
  wire [17:0] OPY2;
  wire [17:0] ResX;
  wire [17:0] ResY;
  wire CinX, CinY, CoutX, CoutY;
endmodule
