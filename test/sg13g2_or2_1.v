`timescale 1ns/10ps
`celldefine
module sg13g2_or2_1 (X, A, B);
	output X;
	input A, B;
	or (X, A, B);
endmodule
`endcelldefine
