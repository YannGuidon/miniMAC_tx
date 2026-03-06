`timescale 1ns/10ps
`celldefine
module sg13g2_inv_4 (Y, A);
	output Y;
	input A;
	not (Y, A);
endmodule
`endcelldefine
