`ifdef _udp_def_ihp_mux2
`else
`define _udp_def_ihp_mux2
primitive ihp_mux2 (z, a, b, s);
	output z;
	input a, b, s;
	table
		1  ?  0 : 1;
		0  ?  0 : 0;
		?  1  1 : 1;
		?  0  1 : 0;
		0  0  x : 0;
		1  1  x : 1;
	endtable
endprimitive
`endif

// type: mux2
`timescale 1ns/10ps
`celldefine
module sg13g2_mux2_2 (X, A0, A1, S);
	output X;
	input A0, A1, S;

	// Function
	ihp_mux2 (X, A0, A1, S);

endmodule
`endcelldefine
