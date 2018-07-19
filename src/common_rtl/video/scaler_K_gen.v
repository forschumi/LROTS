module scaler_K_gen(
	input clk,
	input[11:0] s_width,
	input[11:0] s_height,
	input[11:0] t_width,
	input[11:0] t_height,
	output[15:0] h_scale_K,
	output[15:0] v_scale_K
);

wire[19:0] r0;
wire[19:0] r1;
assign h_scale_K = r0[15:0];
assign v_scale_K = r1[15:0];
`ifdef Xilinx
divider divider_m0(
	.clk(clk),
	.divisor(t_width),
	.dividend({s_width,8'd0}),
	.quotient(r0),
	.fractional());
divider divider_m1(
	.clk(clk),
	.divisor(t_height),
	.dividend({s_height,8'd0}),
	.quotient(r1),
	.fractional());
`else
divider divider_m0(
	.clock(clk),
	.denom(t_width),
	.numer({s_width,8'd0}),
	.quotient(r0),
	.remain());
divider divider_m1(
	.clock(clk),
	.denom(t_height),
	.numer({s_height,8'd0}),
	.quotient(r1),
	.remain());
`endif
endmodule 