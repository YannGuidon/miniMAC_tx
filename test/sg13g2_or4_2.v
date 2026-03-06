`timescale 1ns/10ps
`celldefine
module sg13g2_or4_2 (X, A, B, C, D);
	output X;
	input A, B, C, D;
	or (X, A, B, C, D);
endmodule
`endcelldefine
