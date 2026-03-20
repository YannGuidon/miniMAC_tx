/*
  gPEAC18.v
  generalised (non-binary) PEAC scrambler/checksum/error detector
  with modulus=258114 
  See  https://hackaday.io/project/178998 
*/

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
