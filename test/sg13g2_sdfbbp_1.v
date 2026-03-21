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

`ifdef _udp_def_ihp_dff_sr_err_
`else
`define _udp_def_ihp_dff_sr_err_
primitive ihp_dff_sr_err (q, clk, d, s, r);
	output q;
	reg q;
	input clk, d, s, r;
	table
		 ?   1 (0x)  ?   : ? : -;
		 ?   0  ?   (0x) : ? : -;
		 ?   0  ?   (x0) : ? : -;
		(0x) ?  0    0   : ? : 0;
		(0x) 1  x    0   : ? : 0;
		(0x) 0  0    x   : ? : 0;
		(1x) ?  0    0   : ? : 1;
		(1x) 1  x    0   : ? : 1;
		(1x) 0  0    x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_ihp_dff_sr_1
`else
`define _udp_def_ihp_dff_sr_1
primitive ihp_dff_sr_1 (q, v, clk, d, s, r, xcr);
	output q;
	reg q;
	input v, clk, d, s, r, xcr;
	table
		*  ?   ?   ?   ?   ? : ? : x;
		?  ?   ?   0   1   ? : ? : 0;
		?  ?   ?   1   ?   ? : ? : 1;
		?  b   ? (1?)  0   ? : 1 : -;
		?  x   1 (1?)  0   ? : 1 : -;
		?  ?   ? (10)  0   ? : ? : -;
		?  ?   ? (x0)  0   ? : ? : -;
		?  ?   ? (0x)  0   ? : 1 : -;
		?  b   ?  0   (1?) ? : 0 : -;
		?  x   0  0   (1?) ? : 0 : -;
		?  ?   ?  0   (10) ? : ? : -;
		?  ?   ?  0   (x0) ? : ? : -;
		?  ?   ?  0   (0x) ? : 0 : -;
		? (x1) 0  0    ?   0 : ? : 0;
		? (x1) 1  ?    0   0 : ? : 1;
		? (x1) 0  0    ?   1 : 0 : 0;
		? (x1) 1  ?    0   1 : 1 : 1;
		? (x1) ?  ?    0   x : ? : -;
		? (x1) ?  0    ?   x : ? : -;
		? (1x) 0  0    ?   ? : 0 : -;
		? (1x) 1  ?    0   ? : 1 : -;
		? (x0) 0  0    ?   ? : ? : -;
		? (x0) 1  ?    0   ? : ? : -;
		? (x0) ?  0    0   x : ? : -;
		? (0x) 0  0    ?   ? : 0 : -;
		? (0x) 1  ?    0   ? : 1 : -;
		? (01) 0  0    ?   ? : ? : 0;
		? (01) 1  ?    0   ? : ? : 1;
		? (10) ?  0    ?   ? : ? : -;
		? (10) ?  ?    0   ? : ? : -;
		?  b   *  0    ?   ? : ? : -;
		?  b   *  ?    0   ? : ? : -;
		?  ?   ?  ?    ?   * : ? : -;
	endtable
endprimitive
`endif

// type: sdfrrs
`timescale 1ns/10ps
`celldefine
module sg13g2_sdfbbp_1 (Q, Q_N, D, SCD, SCE, RESET_B, SET_B, CLK);
	output Q, Q_N;
	input D, SCD, SCE, RESET_B, SET_B, CLK;
	reg notifier;

	// Function
	wire int_fwire_d, int_fwire_IQ, int_fwire_IQN;
	wire int_fwire_r, int_fwire_s, xcr_0;

	ihp_mux2 (int_fwire_d, D, SCD, SCE);
	not (int_fwire_s, SET_B);
	not (int_fwire_r, RESET_B);
	ihp_dff_sr_err (xcr_0, CLK, int_fwire_d, int_fwire_s, int_fwire_r);
	ihp_dff_sr_1 (int_fwire_IQ, notifier, CLK, int_fwire_d, int_fwire_s, int_fwire_r, xcr_0);
	buf (Q, int_fwire_IQ);
	not (int_fwire_IQN, int_fwire_IQ);
	buf (Q_N, int_fwire_IQN);

endmodule
`endcelldefine
