/*
模块封装了时序发生模块，和alpha混合模块，Ycbcr转RGB模块
完成多个视频输出的时序产生，和多个视频的alpha混合
*/
module vout_display_pro(
	input rst_n,                      /*复位 */
	input dp_clk,                     /*时钟*/
	input[11:0] h_fp,                 /*行同步前肩 */
	input[11:0] h_sync,               /*行同步 */
	input[11:0] h_bp,                 /*行同步后肩 */
	input[11:0] h_active,             /*行有效像素 */
	input[11:0] h_total,              /*行总周期（像素时钟） */
	input[11:0] v_fp,                 /*场同步前肩（行）*/
	input[11:0] v_sync,               /*场同步（行）*/
	input[11:0] v_bp,                 /*场同步后肩（行） */
	input[11:0] v_active,             /*场有效行 */
	input[11:0] v_total,              /*场总行 */
	output hs,                        /*行同步输出 */
	output vs,                        /*场同步输出 */
	output de,                        /*视频有效输出*/
	output[7:0] rgb_r,                /*视频输出R分量 */
	output[7:0] rgb_g,                /*视频输出G分量 */
	output[7:0] rgb_b,                /*视频输出B分量 */

	input[11:0] layer0_top,           /*视频0在显示器中的位置top*/
	input[11:0] layer0_left,          /*视频0在显示器中的位置left*/
	input[11:0] layer0_width,         /*视频0在显示器中显示的画面宽度*/
	input[11:0] layer0_height,        /*视频0在显示器中显示的画面高度 */
	input[7:0] layer0_alpha,          /*视频0在显示器中显示的透明度，如果是0x00完全显示《底色》,0xff则完全显示当前视频*/
	output layer0_rdreq,              /*视频0读数据请求*/
	input[23:0] layer0_ycbcr,         /*视频0的数据*/
	input[11:0] layer1_top,           /*视频1在显示器中的位置top*/
	input[11:0] layer1_left,          /*视频1在显示器中的位置left*/
	input[11:0] layer1_width,         /*视频1在显示器中显示的画面宽度*/
	input[11:0] layer1_height,        /*视频1在显示器中显示的画面高度 */
	input[7:0] layer1_alpha,          /*视频1在显示器中显示的透明度，如果是0x00完全显示《视频0》,0xff则完全显示当前视频*/
	output layer1_rdreq,              /*视频1读数据请求*/
	input[23:0] layer1_ycbcr,         /*视频1的数据*/
	input[11:0] layer2_top,           /*视频2在显示器中的位置top*/
	input[11:0] layer2_left,          /*视频2在显示器中的位置left*/
	input[11:0] layer2_width,         /*视频2在显示器中显示的画面宽度*/
	input[11:0] layer2_height,        /*视频2在显示器中显示的画面高度 */
	input[7:0] layer2_alpha,          /*视频2在显示器中显示的透明度，如果是0x00完全显示《视频1》,0xff则完全显示当前视频*/
	output layer2_rdreq,              /*视频2读数据请求*/
	input[23:0] layer2_ycbcr,         /*视频2的数据*/
	input[11:0] layer3_top,           /*视频3在显示器中的位置top*/
	input[11:0] layer3_left,          /*视频3在显示器中的位置left*/
	input[11:0] layer3_width,         /*视频3在显示器中显示的画面宽度*/
	input[11:0] layer3_height,        /*视频3在显示器中显示的画面高度 */
	input[7:0] layer3_alpha,          /*视频3在显示器中显示的透明度，如果是0x00完全显示《视频2》,0xff则完全显示当前视频*/
	output layer3_rdreq,              /*视频3读数据请求*/
	input[23:0] layer3_ycbcr          /*视频3的数据*/
);
parameter BLUE_Y = 8'h10;/*底色Y分量*/
parameter BLUE_CB = 8'h80;/*底色Cb分量*/
parameter BLUE_CR = 8'h80;/*底色Cr分量*/
wire timing_gen_hs;
wire timing_gen_vs;
wire timing_gen_de;
/*例化时序发生模块，参数行场同步，DE*/
vout_display_timing vout_display_timing_m0(
	.rst_n(rst_n),
	.dp_clk(dp_clk),
	.h_fp(h_fp),
	.h_sync(h_sync),
	.h_bp(h_bp),
	.h_active(h_active),
	.h_total(h_total),
	
	.v_fp(v_fp),
	.v_sync(v_sync),
	.v_bp(v_bp),
	.v_active(v_active),
	.v_total(v_total),
	
	.hs(timing_gen_hs),
	.vs(timing_gen_vs),
	.de(timing_gen_de)
);
wire xy_gen_hs;
wire xy_gen_vs;
wire xy_gen_de;
wire[11:0] xy_gen_x;
wire[11:0] xy_gen_y;
/*例化坐标生成模块，有时序发生模块的行场同步DE产生x、y坐标*/
timing_gen_xy timing_gen_xy_m0(
	.rst_n(rst_n),
	.clk(dp_clk),
	.i_hs(timing_gen_hs),
	.i_vs(timing_gen_vs),
	.i_de(timing_gen_de),
	.i_data(),
	.o_hs(xy_gen_hs),
	.o_vs(xy_gen_vs),
	.o_de(xy_gen_de),
	.o_data(),
	.x(xy_gen_x),
	.y(xy_gen_y)
);
wire layer0_hs;
wire layer0_vs;
wire layer0_de;
wire[11:0] layer0_x;
wire[11:0] layer0_y;
wire[23:0] layer0_blend_ycbcr;
/*视频0的透明混合处理，在要求的区域按照视频0的alpha值和底色混合，其他区域显示底色，从而产生新的视频0*/
layer_blend layer_blend_m0(
	.rst_n(rst_n),
	.clk(dp_clk),
	.i_hs(xy_gen_hs),
	.i_vs(xy_gen_vs),
	.i_de(xy_gen_de),
	.i_ycbcr(layer0_ycbcr),
	.i_back_ycbcr({BLUE_Y,BLUE_CB,BLUE_CR}),
	.top(layer0_top),
	.left(layer0_left),
	.width(layer0_width),
	.height(layer0_height),
	.i_alpha(layer0_alpha),
	.rdreq(layer0_rdreq),
	.o_hs(layer0_hs),
	.o_vs(layer0_vs),
	.o_de(layer0_de),
	.i_x(xy_gen_x),
	.i_y(xy_gen_y),
	.o_x(layer0_x),
	.o_y(layer0_y),
	.o_ycbcr(layer0_blend_ycbcr)
);

wire layer1_hs;
wire layer1_vs;
wire layer1_de;
wire[11:0] layer1_x;
wire[11:0] layer1_y;
wire[23:0] layer1_blend_ycbcr;
/*视频1的透明混合处理，在要求的区域按照视频1的alpha值和新的视频0混合，其他区域显示新的视频0，从而产生新的视频1*/
layer_blend layer_blend_m1(
	.rst_n(rst_n),
	.clk(dp_clk),
	.i_hs(layer0_hs),
	.i_vs(layer0_vs),
	.i_de(layer0_de),
	.i_ycbcr(layer1_ycbcr),
	.i_back_ycbcr(layer0_blend_ycbcr),
	.top(layer1_top),
	.left(layer1_left),
	.width(layer1_width),
	.height(layer1_height),
	.i_alpha(layer1_alpha),
	.rdreq(layer1_rdreq),
	.o_hs(layer1_hs),
	.o_vs(layer1_vs),
	.o_de(layer1_de),
	.i_x(layer0_x),
	.i_y(layer0_y),
	.o_x(layer1_x),
	.o_y(layer1_y),
	.o_ycbcr(layer1_blend_ycbcr)
);
wire layer2_hs;
wire layer2_vs;
wire layer2_de;
wire[11:0] layer2_x;
wire[11:0] layer2_y;
wire[23:0] layer2_blend_ycbcr;
/*视频2的透明混合处理，在要求的区域按照视频2的alpha值和新的视频1混合，其他区域显示新的视频1，从而产生新的视频2*/
layer_blend layer_blend_m2(
	.rst_n(rst_n),
	.clk(dp_clk),
	.i_hs(layer1_hs),
	.i_vs(layer1_vs),
	.i_de(layer1_de),
	.i_ycbcr(layer2_ycbcr),
	.i_back_ycbcr(layer1_blend_ycbcr),
	.top(layer2_top),
	.left(layer2_left),
	.width(layer2_width),
	.height(layer2_height),
	.i_alpha(layer2_alpha),
	.rdreq(layer2_rdreq),
	.o_hs(layer2_hs),
	.o_vs(layer2_vs),
	.o_de(layer2_de),
	.i_x(layer1_x),
	.i_y(layer1_y),
	.o_x(layer2_x),
	.o_y(layer2_y),
	.o_ycbcr(layer2_blend_ycbcr)
);

wire layer3_hs;
wire layer3_vs;
wire layer3_de;
wire[11:0] layer3_x;
wire[11:0] layer3_y;
wire[23:0] layer3_blend_ycbcr;
/*视频3的透明混合处理，在要求的区域按照视频3的alpha值和新的视频2混合，其他区域显示新的视频2，从而产生新的视频3*/
layer_blend layer_blend_m3(
	.rst_n(rst_n),
	.clk(dp_clk),
	.i_hs(layer2_hs),
	.i_vs(layer2_vs),
	.i_de(layer2_de),
	.i_ycbcr(layer3_ycbcr),
	.i_back_ycbcr(layer2_blend_ycbcr),
	.top(layer3_top),
	.left(layer3_left),
	.width(layer3_width),
	.height(layer3_height),
	.i_alpha(layer3_alpha),
	.rdreq(layer3_rdreq),
	.o_hs(layer3_hs),
	.o_vs(layer3_vs),
	.o_de(layer3_de),
	.i_x(layer2_x),
	.i_y(layer2_y),
	.o_x(layer3_x),
	.o_y(layer3_y),
	.o_ycbcr(layer3_blend_ycbcr)
);

 wire[23:0] ycbcr;
 wire ycbcr_hs;
 wire ycbcr_vs;
 wire ycbcr_de;
 assign ycbcr = layer3_blend_ycbcr;
 assign ycbcr_hs = layer3_hs;
 assign ycbcr_vs = layer3_vs;
 assign ycbcr_de = layer3_de;
/*混合后视频3已经包含了视频0，视频1，视频2，视频3的内容，转化为RGB分量后送到显示器*/
 ycbcr_to_rgb ycbcr_to_rgb_m0(
	.clk(dp_clk),
	.i_y_8b(ycbcr[23:16]),
	.i_cb_8b(ycbcr[15:8]),
	.i_cr_8b(ycbcr[7:0]),
	.i_h_sync(ycbcr_hs),
	.i_v_sync(ycbcr_vs),
	.i_data_en(ycbcr_de),
						
	.o_r_8b(rgb_r),
	.o_g_8b(rgb_g),
	.o_b_8b(rgb_b),
						
	.o_h_sync(hs),
	.o_v_sync(vs),                                                                                                    
	.o_data_en(de)                                                                                                   
 );
endmodule 