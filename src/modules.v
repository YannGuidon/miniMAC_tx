/*
  modules.v
  ©2026 Yann Guidon
  A dumb collection of recurring gates structures.
  Just because I don't want to learn Verilog.
*/

module mux2_x18(
  input wire sel,
  input wire [17:0] if0,
  input wire [17:0] if1,
  output wire [17:0] res
);
  wire sel0, sel1, sel2, sel3, sel4;
  (* keep *) sg13g2_inv_4 boost0(.Y(sel0),  .A(sel));
  (* keep *) sg13g2_inv_4 boost1(.Y(sel1),  .A(sel0));
  (* keep *) sg13g2_inv_4 boost2(.Y(sel2),  .A(sel0));
  (* keep *) sg13g2_inv_4 boost3(.Y(sel3),  .A(sel0));
  (* keep *) sg13g2_inv_4 boost4(.Y(sel4),  .A(sel0));

  (* keep *) sg13g2_mux2_2 mux_00(.A0(if0[ 0]), .A1(if1[ 0]), .S(sel1), .X(res[ 0]));
  (* keep *) sg13g2_mux2_2 mux_01(.A0(if0[ 1]), .A1(if1[ 1]), .S(sel1), .X(res[ 1]));
  (* keep *) sg13g2_mux2_2 mux_02(.A0(if0[ 2]), .A1(if1[ 2]), .S(sel1), .X(res[ 2]));
  (* keep *) sg13g2_mux2_2 mux_03(.A0(if0[ 3]), .A1(if1[ 3]), .S(sel1), .X(res[ 3]));
  (* keep *) sg13g2_mux2_2 mux_04(.A0(if0[ 4]), .A1(if1[ 4]), .S(sel2), .X(res[ 4]));
  (* keep *) sg13g2_mux2_2 mux_05(.A0(if0[ 5]), .A1(if1[ 5]), .S(sel2), .X(res[ 5]));
  (* keep *) sg13g2_mux2_2 mux_06(.A0(if0[ 6]), .A1(if1[ 6]), .S(sel2), .X(res[ 6]));
  (* keep *) sg13g2_mux2_2 mux_07(.A0(if0[ 7]), .A1(if1[ 7]), .S(sel2), .X(res[ 7]));
  (* keep *) sg13g2_mux2_2 mux_08(.A0(if0[ 8]), .A1(if1[ 8]), .S(sel2), .X(res[ 8]));
  (* keep *) sg13g2_mux2_2 mux_09(.A0(if0[ 9]), .A1(if1[ 9]), .S(sel3), .X(res[ 9]));
  (* keep *) sg13g2_mux2_2 mux_10(.A0(if0[10]), .A1(if1[10]), .S(sel3), .X(res[10]));
  (* keep *) sg13g2_mux2_2 mux_11(.A0(if0[11]), .A1(if1[11]), .S(sel3), .X(res[11]));
  (* keep *) sg13g2_mux2_2 mux_12(.A0(if0[12]), .A1(if1[12]), .S(sel3), .X(res[12]));
  (* keep *) sg13g2_mux2_2 mux_13(.A0(if0[13]), .A1(if1[13]), .S(sel4), .X(res[13]));
  (* keep *) sg13g2_mux2_2 mux_14(.A0(if0[14]), .A1(if1[14]), .S(sel4), .X(res[14]));
  (* keep *) sg13g2_mux2_2 mux_15(.A0(if0[15]), .A1(if1[15]), .S(sel4), .X(res[15]));
  (* keep *) sg13g2_mux2_2 mux_16(.A0(if0[16]), .A1(if1[16]), .S(sel4), .X(res[16]));
  (* keep *) sg13g2_mux2_2 mux_17(.A0(if0[17]), .A1(if1[17]), .S(sel4), .X(res[17]));
  
endmodule
