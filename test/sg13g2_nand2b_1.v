`timescale 1ns/10ps
`celldefine
module sg13g2_nand2b_1 (Y, A_N, B);
	output Y;
	input A_N, B;
	wire A_N__bar, int_fwire_0;
	not (A_N__bar, A_N);
	and (int_fwire_0, A_N__bar, B);
	not (Y, int_fwire_0);
endmodule
`endcelldefine
