module vin_matrix
(
	input rst,
	input[2:0] sel_ch0,
	input[2:0] sel_ch1,	
	input[2:0] sel_ch2,
	input[2:0] sel_ch3,	
	input vin_clk_ch0,
	input vin_vs_ch0,
	input vin_hs_ch0,
	input vin_de_ch0,
	input[15:0] vin_yc_ch0,
	
	input vin_clk_ch1,
	input vin_vs_ch1,
	input vin_hs_ch1,
	input vin_de_ch1,
	input[15:0] vin_yc_ch1,

	input vin_clk_ch2,
	input vin_vs_ch2,
	input vin_hs_ch2,
	input vin_de_ch2,
	input[15:0] vin_yc_ch2,

	input vin_clk_ch3,
	input vin_vs_ch3,
	input vin_hs_ch3,
	input vin_de_ch3,
	input[15:0] vin_yc_ch3,

	input vin_clk_ch4,
	input vin_vs_ch4,
	input vin_hs_ch4,
	input vin_de_ch4,
	input[15:0] vin_yc_ch4,
	
	input local_vclk,
	output local_de_ch0,
	output local_vs_ch0,
	output local_hs_ch0,
	output[15:0] local_yc_ch0,
	
	output local_de_ch1,
	output local_vs_ch1,
	output local_hs_ch1,
	output[15:0] local_yc_ch1,

	output local_de_ch2,
	output local_vs_ch2,
	output local_hs_ch2,
	output[15:0] local_yc_ch2,

	output local_de_ch3,
	output local_vs_ch3,
	output local_hs_ch3,
	output[15:0] local_yc_ch3
);
wire sync_de_ch0;
wire sync_vs_ch0;
wire sync_hs_ch0;
wire[15:0] sync_yc_ch0;

wire sync_de_ch1;
wire sync_vs_ch1;
wire sync_hs_ch1;
wire[15:0] sync_yc_ch1;

wire sync_de_ch2;
wire sync_vs_ch2;
wire sync_hs_ch2;
wire[15:0] sync_yc_ch2;

wire sync_de_ch3;
wire sync_vs_ch3;
wire sync_hs_ch3;
wire[15:0] sync_yc_ch3;

wire sync_de_ch4;
wire sync_vs_ch4;
wire sync_hs_ch4;
wire[15:0] sync_yc_ch4;
video_sync video_sync_m0(
	.rst(rst),
	.vin_clk(vin_clk_ch0),
	.vin_vs(vin_vs_ch0),
	.vin_hs(vin_hs_ch0),
	.vin_de(vin_de_ch0),
	.vin_yc(vin_yc_ch0),
	
	.sync_vclk(local_vclk),
	.sync_de(sync_de_ch0),
	.sync_vs(sync_vs_ch0),
	.sync_hs(sync_hs_ch0),
	.sync_yc(sync_yc_ch0)
	);
video_sync video_sync_m1(
	.rst(rst),
	.vin_clk(vin_clk_ch1),
	.vin_vs(vin_vs_ch1),
	.vin_hs(vin_hs_ch1),
	.vin_de(vin_de_ch1),
	.vin_yc(vin_yc_ch1),
	
	.sync_vclk(local_vclk),
	.sync_de(sync_de_ch1),
	.sync_vs(sync_vs_ch1),
	.sync_hs(sync_hs_ch1),
	.sync_yc(sync_yc_ch1)
	);
video_sync video_sync_m2(
	.rst(rst),
	.vin_clk(vin_clk_ch2),
	.vin_vs(vin_vs_ch2),
	.vin_hs(vin_hs_ch2),
	.vin_de(vin_de_ch2),
	.vin_yc(vin_yc_ch2),
	
	.sync_vclk(local_vclk),
	.sync_de(sync_de_ch2),
	.sync_vs(sync_vs_ch2),
	.sync_hs(sync_hs_ch2),
	.sync_yc(sync_yc_ch2)
	);
video_sync video_sync_m3(
	.rst(rst),
	.vin_clk(vin_clk_ch3),
	.vin_vs(vin_vs_ch3),
	.vin_hs(vin_hs_ch3),
	.vin_de(vin_de_ch3),
	.vin_yc(vin_yc_ch3),
	
	.sync_vclk(local_vclk),
	.sync_de(sync_de_ch3),
	.sync_vs(sync_vs_ch3),
	.sync_hs(sync_hs_ch3),
	.sync_yc(sync_yc_ch3)
	);
video_sync video_sync_m4(
	.rst(rst),
	.vin_clk(vin_clk_ch4),
	.vin_vs(vin_vs_ch4),
	.vin_hs(vin_hs_ch4),
	.vin_de(vin_de_ch4),
	.vin_yc(vin_yc_ch4),
	
	.sync_vclk(local_vclk),
	.sync_de(sync_de_ch4),
	.sync_vs(sync_vs_ch4),
	.sync_hs(sync_hs_ch4),
	.sync_yc(sync_yc_ch4)
	);
video_mux video_mux_m0(
	.clk(local_vclk),
	.sel(sel_ch0),
	.vin_vs_ch0(sync_vs_ch0),
	.vin_hs_ch0(sync_hs_ch0),
	.vin_de_ch0(sync_de_ch0),
	.vin_yc_ch0(sync_yc_ch0),
	
	.vin_vs_ch1(sync_vs_ch1),
	.vin_hs_ch1(sync_hs_ch1),
	.vin_de_ch1(sync_de_ch1),
	.vin_yc_ch1(sync_yc_ch1),

	.vin_vs_ch2(sync_vs_ch2),
	.vin_hs_ch2(sync_hs_ch2),
	.vin_de_ch2(sync_de_ch2),
	.vin_yc_ch2(sync_yc_ch2),

	.vin_vs_ch3(sync_vs_ch3),
	.vin_hs_ch3(sync_hs_ch3),
	.vin_de_ch3(sync_de_ch3),
	.vin_yc_ch3(sync_yc_ch3),

	.vin_vs_ch4(sync_vs_ch4),
	.vin_hs_ch4(sync_hs_ch4),
	.vin_de_ch4(sync_de_ch4),
	.vin_yc_ch4(sync_yc_ch4),
	
	.vout_vs(local_vs_ch0),
	.vout_hs(local_hs_ch0),
	.vout_de(local_de_ch0),
	.vout_yc(local_yc_ch0)
);

video_mux video_mux_m1(
	.clk(local_vclk),
	.sel(sel_ch1),
	.vin_vs_ch0(sync_vs_ch0),
	.vin_hs_ch0(sync_hs_ch0),
	.vin_de_ch0(sync_de_ch0),
	.vin_yc_ch0(sync_yc_ch0),
	
	.vin_vs_ch1(sync_vs_ch1),
	.vin_hs_ch1(sync_hs_ch1),
	.vin_de_ch1(sync_de_ch1),
	.vin_yc_ch1(sync_yc_ch1),

	.vin_vs_ch2(sync_vs_ch2),
	.vin_hs_ch2(sync_hs_ch2),
	.vin_de_ch2(sync_de_ch2),
	.vin_yc_ch2(sync_yc_ch2),

	.vin_vs_ch3(sync_vs_ch3),
	.vin_hs_ch3(sync_hs_ch3),
	.vin_de_ch3(sync_de_ch3),
	.vin_yc_ch3(sync_yc_ch3),

	.vin_vs_ch4(sync_vs_ch4),
	.vin_hs_ch4(sync_hs_ch4),
	.vin_de_ch4(sync_de_ch4),
	.vin_yc_ch4(sync_yc_ch4),
	
	.vout_vs(local_vs_ch1),
	.vout_hs(local_hs_ch1),
	.vout_de(local_de_ch1),
	.vout_yc(local_yc_ch1)
);
video_mux video_mux_m2(
	.clk(local_vclk),
	.sel(sel_ch2),
	.vin_vs_ch0(sync_vs_ch0),
	.vin_hs_ch0(sync_hs_ch0),
	.vin_de_ch0(sync_de_ch0),
	.vin_yc_ch0(sync_yc_ch0),
	
	.vin_vs_ch1(sync_vs_ch1),
	.vin_hs_ch1(sync_hs_ch1),
	.vin_de_ch1(sync_de_ch1),
	.vin_yc_ch1(sync_yc_ch1),

	.vin_vs_ch2(sync_vs_ch2),
	.vin_hs_ch2(sync_hs_ch2),
	.vin_de_ch2(sync_de_ch2),
	.vin_yc_ch2(sync_yc_ch2),

	.vin_vs_ch3(sync_vs_ch3),
	.vin_hs_ch3(sync_hs_ch3),
	.vin_de_ch3(sync_de_ch3),
	.vin_yc_ch3(sync_yc_ch3),

	.vin_vs_ch4(sync_vs_ch4),
	.vin_hs_ch4(sync_hs_ch4),
	.vin_de_ch4(sync_de_ch4),
	.vin_yc_ch4(sync_yc_ch4),
	
	.vout_vs(local_vs_ch2),
	.vout_hs(local_hs_ch2),
	.vout_de(local_de_ch2),
	.vout_yc(local_yc_ch2)
);	
video_mux video_mux_m3(
	.clk(local_vclk),
	.sel(sel_ch3),
	.vin_vs_ch0(sync_vs_ch0),
	.vin_hs_ch0(sync_hs_ch0),
	.vin_de_ch0(sync_de_ch0),
	.vin_yc_ch0(sync_yc_ch0),
	
	.vin_vs_ch1(sync_vs_ch1),
	.vin_hs_ch1(sync_hs_ch1),
	.vin_de_ch1(sync_de_ch1),
	.vin_yc_ch1(sync_yc_ch1),

	.vin_vs_ch2(sync_vs_ch2),
	.vin_hs_ch2(sync_hs_ch2),
	.vin_de_ch2(sync_de_ch2),
	.vin_yc_ch2(sync_yc_ch2),

	.vin_vs_ch3(sync_vs_ch3),
	.vin_hs_ch3(sync_hs_ch3),
	.vin_de_ch3(sync_de_ch3),
	.vin_yc_ch3(sync_yc_ch3),

	.vin_vs_ch4(sync_vs_ch4),
	.vin_hs_ch4(sync_hs_ch4),
	.vin_de_ch4(sync_de_ch4),
	.vin_yc_ch4(sync_yc_ch4),
	
	.vout_vs(local_vs_ch3),
	.vout_hs(local_hs_ch3),
	.vout_de(local_de_ch3),
	.vout_yc(local_yc_ch3)
);
endmodule 