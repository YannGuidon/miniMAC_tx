`timescale 1ns/10ps
`celldefine
module sg13g2_and3_1 (X, A, B, C);
	output X;
	input A, B, C;
	and (X, A, B, C);
endmodule
`endcelldefine
