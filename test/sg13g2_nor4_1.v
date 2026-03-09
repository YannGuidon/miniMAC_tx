`timescale 1ns/10ps
`celldefine
module sg13g2_nor4_1 (Y, A, B, C, D);
	output Y;
	input A, B, C, D;
	wire int_fwire_0;
	or (int_fwire_0, A, B, C, D);
	not (Y, int_fwire_0);
endmodule
`endcelldefine
