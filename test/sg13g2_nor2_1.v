`timescale 1ns/10ps
`celldefine
module sg13g2_nor2_1 (Y, A, B);
	output Y;
	input A, B;
	wire int_fwire_0;
	or (int_fwire_0, A, B);
	not (Y, int_fwire_0);
endmodule
`endcelldefine
