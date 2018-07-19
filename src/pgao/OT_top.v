`timescale 1 ns / 1 ps
module OT_top(
	i_rst_n,
	i_cmos_pclk_gbuf,
	i_cmos_vsync_delay,
	i_cmos_href_delay,
	i_cmos_d_delay,
	o_vsys,
	o_href,
	o_hue,
	o_data_en	
);

input i_rst_n;
input i_cmos_pclk_gbuf;
input i_cmos_vsync_delay;
input i_cmos_href_delay;
input [7:0] i_cmos_d_delay;
output o_vsys;
output o_href;
output [7:0]o_hue;
output o_data_en;	 

wire [15:0] ch0_yc_data;
wire ch0_de;
wire ch0_cmos_vsync;
wire ch0_cmos_href;
ALGO_cmos_8_16bit u0(
	.rst(~i_rst_n),
	.pclk(i_cmos_pclk_gbuf),
	.pdata_i(i_cmos_d_delay),
	.de_i(i_cmos_href_delay),
	.fe_i(i_cmos_vsync_delay),
	.pdata_o(ch0_yc_data),
	.de_o(ch0_de),
	.cmos_vsync(ch0_cmos_vsync),
	.cmos_href(ch0_cmos_href)
);

ALGO_pro u1(
	.i_cmos_rst_n  (i_rst_n),
	.i_cmos_d_pclk (i_cmos_pclk_gbuf),
	.i_cmos_d      (ch0_yc_data),
	.i_cmos_de     (ch0_de),
	.i_cmos_href   (ch0_cmos_href),
	.i_cmos_vsys   (ch0_cmos_vsync),
	.o_hue         (o_hue),
	.o_href        (o_href),
	.o_vsys        (o_vsys),
	.o_data_en     (o_data_en)
);

endmodule
