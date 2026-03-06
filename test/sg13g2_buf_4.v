`timescale 1ns/10ps
`celldefine
module sg13g2_buf_4 (X, A);
	output X;
	input A;
	buf (X, A);
endmodule
`endcelldefine
