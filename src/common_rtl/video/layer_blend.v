/*******************************************************/
/****                                                  */
/****	本程序来自第三方，仅供参考，请勿传播、商用*****/
/****                                                  */
/*******************************************************/
/*
  两个视频alpha混合处理的核心，
  一个视频称为背景或底色
  一个视频称为前景
  背景视频是一个完整的视频，前景视频是个窗口，这个窗口的大小可以调节
  即可以和背景一样大小，完全覆盖背景。
  混合后的数据可以作为新的背景视频与其他视频继续混合，这样就可以完成多个视频窗口的显示
*/
module layer_blend(
	input rst_n,                  /*复位*/
	input clk,                    /*时钟*/
	input i_hs,                   /*视频输入行同步*/
	input i_vs,                   /*视频输入场同步*/
	input i_de,                   /*视频输入DE*/
	input[23:0] i_ycbcr,          /*前景视频数据*/
	input[23:0] i_back_ycbcr,     /*背景视频数据，有可能是一个固定值，比如黑底或蓝底*/
	input[11:0] top,              /*前景视频参数*/
	input[11:0] left,             /*前景视频参数*/
	input[11:0] width,            /*前景视频参数*/
	input[11:0] height,           /*前景视频参数*/
	input[7:0] i_alpha,           /*前景视频混合的透明度*/
	output rdreq,                 /*读取前景视频数据*/
	output o_hs,                  /*混合后视频的行同步*/
	output o_vs,                  /*混合后视频的场同步*/
	output o_de,                  /*混合后视频的DE*/
	input[11:0] i_x,              /*视频输入的坐标*/
	input[11:0] i_y,              /*视频输入的坐标*/
	output[11:0] o_x,             /*视频输出的坐标*/
	output[11:0] o_y,             /*视频输出的坐标*/
	output[23:0] o_ycbcr          /*视频输出数据*/
);

wire[7:0] alpha;
reg i_hs_d0;
reg i_hs_d1;
reg i_vs_d0;
reg i_vs_d1;
reg i_de_d0;
reg i_de_d1;
reg[23:0] i_back_ycbcr_d0;
reg[23:0] i_back_ycbcr_d1;
/*例化前景视频数据读取产生模块*/
layer_rdreq_gen layer_rdreq_gen_m0(
	.rst_n(rst_n),
	.clk(clk),
	.top(top),
	.left(left),
	.width(width),
	.height(height),
	.x(i_x),
	.y(i_y),
	.i_alpha(i_alpha),
	.o_alpha(alpha),
	.rdreq(rdreq)
);
always@(posedge clk)
begin
	i_hs_d0 <= i_hs;
	i_hs_d1 <= i_hs_d0;
	i_vs_d0 <= i_vs;
	i_vs_d1 <= i_vs_d0;
	i_de_d0 <= i_de;
	i_de_d1 <= i_de_d0;
	i_back_ycbcr_d0 <= i_back_ycbcr;
	i_back_ycbcr_d1 <= i_back_ycbcr_d0;
end
/*alpha混合的计算模块*/
alpha_blend alpha_blend_m0(
	.sys_clk(clk),
	.i_h_sync(i_hs_d1),
	.i_v_sync(i_vs_d1),
	.i_de(i_de_d1),
	.i_back_ground_0_8b(i_back_ycbcr_d1[23:16]),
	.i_back_ground_1_8b(i_back_ycbcr_d1[15:8]),
	.i_back_ground_2_8b(i_back_ycbcr_d1[7:0]),
	.i_alpha_8b(alpha),	
	.i_front_ground_0_8b(i_ycbcr[23:16]),
	.i_front_ground_1_8b(i_ycbcr[15:8]),
	.i_front_ground_2_8b(i_ycbcr[7:0]),
	//output
	.o_h_sync(o_hs),
	.o_v_sync(o_vs),
	.o_de(o_de),	
	.o_data_0_8b(o_ycbcr[23:16]),
	.o_data_1_8b(o_ycbcr[15:8]),
	.o_data_2_8b(o_ycbcr[7:0]),
	.o_x(o_x),
	.o_y(o_y)
);
endmodule 