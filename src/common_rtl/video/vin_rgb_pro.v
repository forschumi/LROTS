module vin_rgb_pro(
	input rgb_pixel_clk,
	input rgb_hs,
	input rgb_vs,
	input rgb_de,
	input[7:0] rgb_r,
	input[7:0] rgb_g,
	input[7:0] rgb_b,
	
	output yc_de,
	output yc_hs,
	output yc_vs,
	output[7:0] yc_y,
	output[7:0] yc_c
);
wire ycbcr_hs;
wire ycbcr_vs;
wire ycbcr_de;
wire[7:0] ycbcr_y;
wire[7:0] ycbcr_cb;
wire[7:0] ycbcr_cr;
assign yc_hs = ycbcr_hs;
assign yc_vs = ycbcr_vs;
rgb_to_ycbcr rgb_to_ycbcr_m0(
	.clk(rgb_pixel_clk),
	.i_r_8b(rgb_r),
	.i_g_8b(rgb_g),
	.i_b_8b(rgb_b),
 					
	.i_h_sync(rgb_hs),
	.i_v_sync(rgb_vs),
	.i_data_en(rgb_de),
						
	.o_y_8b(ycbcr_y),
	.o_cb_8b(ycbcr_cb),
	.o_cr_8b(ycbcr_cr),
						
	.o_h_sync(ycbcr_hs),
	.o_v_sync(ycbcr_vs), 
	.o_data_en(ycbcr_de)
);

yuv444_yuv422 yuv444_yuv422_m0(
	.sys_clk(rgb_pixel_clk),
	.i_hs(ycbcr_hs),
	//.i_vs(ycbcr_vs),
	.i_de(ycbcr_de),
	.i_y(ycbcr_y),
	.i_cb(ycbcr_cb),
	.i_cr(ycbcr_cr),
	// output o_hs,
	// output o_vs,
	.o_de(yc_de),
	.o_y(yc_y),
	.o_c(yc_c)
);
endmodule 