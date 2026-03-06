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

`ifdef _udp_def_ihp_dff_r_err_
`else
`define _udp_def_ihp_dff_r_err_
primitive ihp_dff_r_err (q, clk, d, r);
	output q;
	reg q;
	input clk, d, r;
	table
		 ?   0 (0x) : ? : -;
		 ?   0 (x0) : ? : -;
		(0x) ?  0   : ? : 0;
		(0x) 0  x   : ? : 0;
		(1x) ?  0   : ? : 1;
		(1x) 0  x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_ihp_dff_r_
`else
`define _udp_def_ihp_dff_r_
primitive ihp_dff_r (q, v, clk, d, r, xcr);
	output q;
	reg q;
	input v, clk, d, r, xcr;
	table
		*  ?   ?  ?   ? : ? : x;
		?  ?   ?  1   ? : ? : 0;
		?  b   ? (1?) ? : 0 : -;
		?  x   0 (1?) ? : 0 : -;
		?  ?   ? (10) ? : ? : -;
		?  ?   ? (x0) ? : ? : -;
		?  ?   ? (0x) ? : 0 : -;
		? (x1) 0  ?   0 : ? : 0;
		? (x1) 1  0   0 : ? : 1;
		? (x1) 0  ?   1 : 0 : 0;
		? (x1) 1  0   1 : 1 : 1;
		? (x1) ?  ?   x : ? : -;
		? (bx) 0  ?   ? : 0 : -;
		? (bx) 1  0   ? : 1 : -;
		? (x0) 0  ?   ? : ? : -;
		? (x0) 1  0   ? : ? : -;
		? (x0) ?  0   x : ? : -;
		? (01) 0  ?   ? : ? : 0;
		? (01) 1  0   ? : ? : 1;
		? (10) ?  ?   ? : ? : -;
		?  b   *  ?   ? : ? : -;
		?  ?   ?  ?   * : ? : -;
	endtable
endprimitive
`endif

// type: sdfrbpq
`timescale 1ns/10ps
`celldefine
module sg13g2_sdfrbpq_1 (Q, D, SCD, SCE, RESET_B, CLK);
	output Q;
	input D, SCD, SCE, RESET_B, CLK;
	reg notifier;

	// Function
	wire int_fwire_d, int_fwire_IQ, int_fwire_r;
	wire xcr_0;

	ihp_mux2 (int_fwire_d, D, SCD, SCE);
	not (int_fwire_r, RESET_B);
	ihp_dff_r_err (xcr_0, CLK, int_fwire_d, int_fwire_r);
	ihp_dff_r (int_fwire_IQ, notifier, CLK, int_fwire_d, int_fwire_r, xcr_0);
	buf (Q, int_fwire_IQ);

endmodule
`endcelldefine
