/*
模块封装了时序发生模块，和alpha混合模块，Ycbcr转RGB模块
完成多个视频输出的时序产生，和多个视频的alpha混合
*/
module vout_display_pro(
	input rst_n,                      /*复位 */
	input dp_clk,                     /*时钟*/
	input[11:0] h_fp,                 /*行同步前�*/
	input[11:0] h_sync,               /*行同�*/
	input[11:0] h_bp,                 /*行同步后�*/
	input[11:0] h_active,             /*行有效像�*/
	input[11:0] h_total,              /*行总周期（像素时钟�*/
	input[11:0] v_fp,                 /*场同步前肩（行）*/
	input[11:0] v_sync,               /*场同步（行）*/
	input[11:0] v_bp,                 /*场同步后肩（行） */
	input[11:0] v_active,             /*场有效行 */
	input[11:0] v_total,              /*场总行 */
	output hs,                        /*行同步输�*/
	output vs,                        /*场同步输�*/
	output de,                        /*视频有效输出*/
	output[7:0] rgb_r,                /*视频输出R分量 */
	output[7:0] rgb_g,                /*视频输出G分量 */
	output[7:0] rgb_b,                /*视频输出B分量 */

	input[11:0] layer0_top,           /*视频0在显示器中的位置top*/
	input[11:0] layer0_left,          /*视频0在显示器中的位置left*/
	input[11:0] layer0_width,         /*视频0在显示器中显示的画面宽度*/
	input[11:0] layer0_height,        /*视频0在显示器中显示的画面高度 */
	input[7:0] layer0_alpha,          /*视频0在显示器中显示的透明度，如果�x00完全显示《底色�0xff则完全显示当前视�*/
	output layer0_rdreq,              /*视频0读数据请�*/
	input[23:0] layer0_ycbcr         /*视频0的数�*/
);
parameter BLUE_Y = 8'h10;/*底色Y分量*/
parameter BLUE_CB = 8'h80;/*底色Cb分量*/
parameter BLUE_CR = 8'h80;/*底色Cr分量*/
wire timing_gen_hs;
wire timing_gen_vs;
wire timing_gen_de;
reg timing_gen_hs_d0;
reg timing_gen_vs_d0;
reg timing_gen_de_d0;
reg timing_gen_hs_d1;
reg timing_gen_vs_d1;
reg timing_gen_de_d1;
assign layer0_rdreq = timing_gen_de;

always@(posedge dp_clk)
begin
	timing_gen_hs_d0 <= timing_gen_hs;
	timing_gen_vs_d0 <= timing_gen_vs;
	timing_gen_de_d0 <= timing_gen_de;
	timing_gen_hs_d1 <= timing_gen_hs_d0;
	timing_gen_vs_d1 <= timing_gen_vs_d0;
	timing_gen_de_d1 <= timing_gen_de_d0;
end
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
/*转化为RGB分量后送到显示�*/
ycbcr_to_rgb ycbcr_to_rgb_m0(
	.clk(dp_clk),
	.i_y_8b(layer0_ycbcr[23:16]),
	.i_cb_8b(layer0_ycbcr[15:8]),
	.i_cr_8b(layer0_ycbcr[7:0]),
	.i_h_sync(timing_gen_hs_d1),
	.i_v_sync(timing_gen_vs_d1),
	.i_data_en(timing_gen_de_d1),
						
	.o_r_8b(rgb_r),
	.o_g_8b(rgb_g),
	.o_b_8b(rgb_b),
						
	.o_h_sync(hs),
	.o_v_sync(vs),                                                                                                    
	.o_data_en(de) 	
);

endmodule 