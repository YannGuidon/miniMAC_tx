`timescale 1ns/10ps
`celldefine
module sg13g2_xor2_1 (X, A, B);
	output X;
	input A, B;
	xor (X, A, B);
endmodule
`endcelldefine
