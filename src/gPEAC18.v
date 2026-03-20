/*
  gPEAC18.v
  generalised (non-binary) PEAC scrambler/checksum/error detector
  with modulus=258114 
  See  https://hackaday.io/project/178998 
*/

module ConstOrPass(
    input  wire [17:0] A,
    input  wire C,
    output wire [17:0] X  
);
  assign X = A;

endmodule


/* a 18-bit adder, I have no mapped/optimised version available (yet)
   and I have no time left for such detail */
module Add18(
    input  wire [17:0] A,
    input  wire [17:0] B, 
    output wire [17:0] S
  // carry out missing ?
);
  assign S = A + B;
endmodule
