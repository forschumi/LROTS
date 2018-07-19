module vga_out_io
(
	input vga_clk,
	input vga_hs,
	input vga_vs,
	input vga_de,
	input[23:0] vga_rgb,
	
	output vga_out_clk,
	output vga_out_hs,
	output vga_out_de,
	output vga_out_vs,
	output[11:0]  vga_out_data
);

ODDR2_group
#(
	.DATA_BITS(12)
)
ODDR2_group_m0
(
	.clk(vga_clk),
	.din_h(vga_rgb[11:0]),
	.din_l(vga_rgb[23:12]),
	.dout(vga_out_data)
);

ODDR2_group
#(
	.DATA_BITS(3)
)
ODDR2_group_m1
(
	.clk(vga_clk),
	.din_h({vga_hs,vga_vs,vga_de}),
	.din_l({vga_hs,vga_vs,vga_de}),
	.dout({vga_out_hs,vga_out_vs,vga_out_de})
);
clock_out clock_out_m0
(
	.clk_in(vga_clk),
	.clk_out(vga_out_clk)
);
endmodule 