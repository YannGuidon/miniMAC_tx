`timescale 1ns/10ps
`celldefine
module sg13g2_nor2b_1 (Y, A, B_N);
	output Y;
	input A, B_N;
	wire B_N__bar, int_fwire_0;
	not (B_N__bar, B_N);
	or (int_fwire_0, A, B_N__bar);
	not (Y, int_fwire_0);
endmodule
`endcelldefine
