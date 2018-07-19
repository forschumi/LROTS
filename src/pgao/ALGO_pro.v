`timescale 1 ns / 1 ps
module ALGO_pro
#(
	parameter H_HSV_THRE_MIN = 32'h0,
	parameter H_HSV_THRE_MAX = 32'h3DCCCCCD,
	parameter S_HSV_THRE_MIN = 0,
	parameter S_HSV_THRE_MAX = 32'h3DCCCCCD,
	parameter V_HSV_THRE_MIN = 0,
	parameter V_HSV_THRE_MAX = 32'h3DCCCCCD
)
(
	i_cmos_rst_n,
	i_cmos_d_pclk,
	i_cmos_d,
	i_cmos_de,
	i_cmos_href,
	i_cmos_vsys,
	o_hue,
	o_href,
	o_vsys,
	o_data_en
);
input i_cmos_rst_n;
input i_cmos_d_pclk;
input [15:0] i_cmos_d;
input i_cmos_de;
input i_cmos_href;
input i_cmos_vsys;
output [7:0] o_hue;
output o_href;
output o_vsys;
output o_data_en;

wire [7:0] o_y_8b;
wire [7:0] o_cb_8b;
wire [7:0] o_cr_8b;
wire o_hs_422_444;
wire o_vs_422_444;
wire o_data_en_422_444;

ALGO_yuv422_2yuv444 u1(
	.clk       (i_cmos_d_pclk),
	.rst_n     (i_cmos_rst_n),
	.i_vs      (i_cmos_vsys),
	.i_hs      (i_cmos_href),
	.i_q_16b   (i_cmos_d),
	.i_data_en (i_cmos_de),
	.o_y_8b    (o_y_8b),
	.o_cb_8b   (o_cb_8b),
	.o_cr_8b   (o_cr_8b),
	.o_vs      (o_vs_422_444),
	.o_hs      (o_hs_422_444),
	.o_data_en (o_data_en_422_444)
);

wire [7:0] o_r_8b;
wire [7:0] o_g_8b;
wire [7:0] o_b_8b;
wire o_hs_444_888;
wire o_vs_444_888;
wire o_data_en_444_888;

ALGO_yuv444_2rgb888_1 u2(
	.clk        (i_cmos_d_pclk),
	//.rst_n      (i_cmos_rst_n),
	.i_y_8b     (o_y_8b),
	.i_cb_8b    (o_cb_8b),
	.i_cr_8b	(o_cr_8b),
	.i_hs       (o_hs_422_444),
	.i_vs       (o_vs_422_444),
	.i_data_en  (o_data_en_422_444),
	.o_r_8b     (o_r_8b),
	.o_g_8b     (o_g_8b),
	.o_b_8b     (o_b_8b),
	.o_vs       (o_vs_444_888),
	.o_hs       (o_hs_444_888),
	.o_data_en  (o_data_en_444_888)                                                                                                
);


ALGO_rgb888_2hue8 #(
	.H_HSV_THRE_MIN(H_HSV_THRE_MIN),
	.H_HSV_THRE_MAX(H_HSV_THRE_MAX),
	.S_HSV_THRE_MIN(S_HSV_THRE_MIN),
	.S_HSV_THRE_MAX(S_HSV_THRE_MAX),
	.V_HSV_THRE_MIN(V_HSV_THRE_MIN),
	.V_HSV_THRE_MAX(V_HSV_THRE_MAX)
)  u3(
	.clk       (i_cmos_d_pclk),
	.rst_n     (i_cmos_rst_n),
	.i_vs      (o_vs_444_888),
	.i_hs      (o_hs_444_888),
	.i_data_en (o_data_en_444_888),
	.i_r_8b    (o_b_8b),
	.i_g_8b    (o_g_8b),
	.i_b_8b    (o_r_8b),
	.o_vs      (o_vsys),
	.o_hs      (o_href),
	.o_hue     (o_hue),
	.o_data_en (o_data_en)
);

endmodule
