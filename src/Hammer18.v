// Hammer18.v
// created dim. 28 déc. 2025 11:02:33 CET by whygee@f-cpu.org
// version sam. 07 mars 2026 06:16:08 CET : Converted by Jerem's AI
//    from Hammer18.vhdl, applying iHP PDK gates and fixing original typos
//
// A 18-bit bijective Hamming distance maximiser with 64 XOR gates in 4 layers
// See https://hackaday.io/project/198914/log/246545
// "untangled" diagram: https://is.gd/WA6oiP
//
// Original permutation (it got altered somewhere, it's not an absolute reference)
// Perm1965 =
//  forward(  3  5  9 17 16 10 15 12  1  2  0 14  6  7 13  8 11  4 )
//  reverse( 10  8  9  0 17  1 12 13 15  2  5 16  7 14 11  6  4  3 )
// Perm7515 =
//  forward( 17  2 11  0  6 16  8  9 10 14  1  7 13 15  5 12  4  3 )
//  reverse(  3 10  1 17 16 14  4 11  6  7  8  2 15 12  9 13  5  0 )
// Perm4021 =
//  forward(  4 17  6  5  1 15  7 14 16 13  0  9 10  8 12  2  3 11 )
//  reverse( 10  4 15 16  0  3  2  6 13 11 12 17 14  9  7  5  8  1 )
//
// sorted avalanche profile for single bitflip: 
//    7 8 8 8 8 9 9 9 9 1 12 13 14 15 15 15 15 15
// total: 200

module Hammer18x4 (
  input  wire [17:0] I,
  output wire [17:0] O
);

  wire [17:0] L1;
  wire [17:0] L2;
  wire [17:0] L3;

  // Layer 1 : Decoder, no permutation (yet)
  sg13g2_xor2_1 xor_L1_17 (.X(L1[17]), .A(I[17]),  .B( I[13]));
  sg13g2_xor2_1 xor_L1_16 (.X(L1[16]), .A(I[16]),  .B( I[13]));
  sg13g2_xor2_1 xor_L1_15 (.X(L1[15]), .A(I[15]),  .B( I[13]));
  sg13g2_xor2_1 xor_L1_14 (.X(L1[14]), .A(I[14]),  .B( I[13]));
//assign                      L1[13]  =                I[13];   // pass-through
  sg13g2_xor2_1 xor_L1_12 (.X(L1[12]), .A(I[12]),  .B( I[13]));   // cascade
  sg13g2_xor2_1 xor_L1_11 (.X(L1[11]), .A(I[11]),  .B(L1[12]));
  sg13g2_xor2_1 xor_L1_10 (.X(L1[10]), .A(I[10]),  .B(L1[11]));
  sg13g2_xor2_1 xor_L1_9  (.X(L1[ 9]), .A(I[ 9]),  .B(L1[10]));
  sg13g2_xor2_1 xor_L1_8  (.X(L1[ 8]), .A(I[ 8]),  .B( I[ 4]));
  sg13g2_xor2_1 xor_L1_7  (.X(L1[ 7]), .A(I[ 7]),  .B( I[ 4]));
  sg13g2_xor2_1 xor_L1_6  (.X(L1[ 6]), .A(I[ 6]),  .B( I[ 4]));
  sg13g2_xor2_1 xor_L1_5  (.X(L1[ 5]), .A(I[ 5]),  .B( I[ 4]));
//assign                      L1[ 4]  =                I[ 4];   // pass-through
  sg13g2_xor2_1 xor_L1_3  (.X(L1[ 3]), .A(I[ 3]),  .B( I[ 4]));   // cascade
  sg13g2_xor2_1 xor_L1_2  (.X(L1[ 2]), .A(I[ 2]),  .B(L1[ 3]));
  sg13g2_xor2_1 xor_L1_1  (.X(L1[ 1]), .A(I[ 1]),  .B(L1[ 2]));
  sg13g2_xor2_1 xor_L1_0  (.X(L1[ 0]), .A(I[ 0]),  .B(L1[ 1]));

  // Layer 2 : Encoder, first permutation
  sg13g2_xor2_1 xor_L2_17 (.X(L2[17]), .A(L1[17]), .B(L1[ 5]));
  sg13g2_xor2_1 xor_L2_16 (.X(L2[16]), .A( I[13]), .B(L1[ 5]));
  sg13g2_xor2_1 xor_L2_15 (.X(L2[15]), .A(L1[12]), .B(L1[ 5]));
  sg13g2_xor2_1 xor_L2_14 (.X(L2[14]), .A(L1[ 2]), .B(L1[ 5]));
//assign                      L2[13]  =               L1[ 5];   // pass-through
  sg13g2_xor2_1 xor_L2_12 (.X(L2[12]), .A(L1[16]), .B(L1[ 5]));
  sg13g2_xor2_1 xor_L2_11 (.X(L2[11]), .A(L1[ 8]), .B(L1[16]));
  sg13g2_xor2_1 xor_L2_10 (.X(L2[10]), .A(L1[15]), .B(L1[ 8]));
  sg13g2_xor2_1 xor_L2_9  (.X(L2[ 9]), .A(L1[11]), .B(L1[15]));
  sg13g2_xor2_1 xor_L2_8  (.X(L2[ 8]), .A(L1[10]), .B(L1[ 7]));
  sg13g2_xor2_1 xor_L2_7  (.X(L2[ 7]), .A(L1[ 6]), .B(L1[ 7]));
  sg13g2_xor2_1 xor_L2_6  (.X(L2[ 6]), .A( I[ 4]), .B(L1[ 7]));
  sg13g2_xor2_1 xor_L2_5  (.X(L2[ 5]), .A(L1[ 3]), .B(L1[ 7]));
//assign                      L2[ 4]  =               L1[ 7];   // pass-through
  sg13g2_xor2_1 xor_L2_3  (.X(L2[ 3]), .A(L1[ 9]), .B(L1[ 7]));
  sg13g2_xor2_1 xor_L2_2  (.X(L2[ 2]), .A(L1[ 0]), .B(L1[ 9]));
  sg13g2_xor2_1 xor_L2_1  (.X(L2[ 1]), .A(L1[14]), .B(L1[ 0]));
  sg13g2_xor2_1 xor_L2_0  (.X(L2[ 0]), .A(L1[ 1]), .B(L1[14]));

  // Layer 3 : Decoder, permutation
  sg13g2_xor2_1 xor_L3_17 (.X(L3[17]), .A(L2[14]), .B(L2[12]));
  sg13g2_xor2_1 xor_L3_16 (.X(L3[16]), .A(L2[ 9]), .B(L2[12]));
  sg13g2_xor2_1 xor_L3_15 (.X(L3[15]), .A(L2[ 8]), .B(L2[12]));
  sg13g2_xor2_1 xor_L3_14 (.X(L3[14]), .A(L2[ 0]), .B(L2[12]));
//assign                      L3[13]  =   L2[12];               // pass-through
  sg13g2_xor2_1 xor_L3_12 (.X(L3[12]), .A(L2[17]), .B(L2[12]));
  sg13g2_xor2_1 xor_L3_11 (.X(L3[11]), .A(L2[ 2]), .B(L3[12]));
  sg13g2_xor2_1 xor_L3_10 (.X(L3[10]), .A(L2[ 7]), .B(L3[11]));
  sg13g2_xor2_1 xor_L3_9  (.X(L3[ 9]), .A(L2[ 6]), .B(L3[10]));
  sg13g2_xor2_1 xor_L3_8  (.X(L3[ 8]), .A(L1[ 5]), .B(L2[16]));
  sg13g2_xor2_1 xor_L3_7  (.X(L3[ 7]), .A(L2[11]), .B(L2[16]));
  sg13g2_xor2_1 xor_L3_6  (.X(L3[ 6]), .A(L2[ 5]), .B(L2[16]));
  sg13g2_xor2_1 xor_L3_5  (.X(L3[ 5]), .A(L1[ 7]), .B(L2[16]));
//assign                      L3[ 4]  =               L2[16];  // pass-through
  sg13g2_xor2_1 xor_L3_3  (.X(L3[ 3]), .A(L2[15]), .B(L2[16]));
  sg13g2_xor2_1 xor_L3_2  (.X(L3[ 2]), .A(L2[ 1]), .B(L3[ 3]));
  sg13g2_xor2_1 xor_L3_1  (.X(L3[ 1]), .A(L2[10]), .B(L3[ 2]));
  sg13g2_xor2_1 xor_L3_0  (.X(L3[ 0]), .A(L2[ 3]), .B(L3[ 1]));

  // Layer 4 : Encoder, permutation
  sg13g2_xor2_1 xor_O_17  (.X(O[17]),  .A(L2[12]), .B(L3[ 0]));
  sg13g2_xor2_1 xor_O_16  (.X(O[16]),  .A(L3[ 5]), .B(L3[ 0]));
  sg13g2_xor2_1 xor_O_15  (.X(O[15]),  .A(L3[ 2]), .B(L3[ 0]));
  sg13g2_xor2_1 xor_O_14  (.X(O[14]),  .A(L3[ 3]), .B(L3[ 0]));
  assign                      O[13]  =                L3[ 0];
  sg13g2_xor2_1 xor_O_12  (.X(O[12]),  .A(L3[15]), .B(L3[ 0]));
  sg13g2_xor2_1 xor_O_11  (.X(O[11]),  .A(L3[17]), .B(L3[15]));
  sg13g2_xor2_1 xor_O_10  (.X(O[10]),  .A(L3[10]), .B(L3[17]));
  sg13g2_xor2_1 xor_O_9   (.X(O[ 9]),  .A(L2[16]), .B(L3[10]));
  sg13g2_xor2_1 xor_O_8   (.X(O[ 8]),  .A(L3[ 8]), .B(L3[ 9]));
  sg13g2_xor2_1 xor_O_7   (.X(O[ 7]),  .A(L3[ 7]), .B(L3[ 9]));
  sg13g2_xor2_1 xor_O_6   (.X(O[ 6]),  .A(L3[ 6]), .B(L3[ 9]));
  sg13g2_xor2_1 xor_O_5   (.X(O[ 5]),  .A(L3[ 1]), .B(L3[ 9]));
  assign                      O[ 4]  =                L3[ 9];
  sg13g2_xor2_1 xor_O_3   (.X(O[ 3]),  .A(L3[16]), .B(L3[ 9]));
  sg13g2_xor2_1 xor_O_2   (.X(O[ 2]),  .A(L3[14]), .B(L3[16]));
  sg13g2_xor2_1 xor_O_1   (.X(O[ 1]),  .A(L3[12]), .B(L3[14]));
  sg13g2_xor2_1 xor_O_0   (.X(O[ 0]),  .A(L3[11]), .B(L3[12]));
endmodule
