/*******************************************************/
/****                                                  */
/****	本程序来自第三方，仅供参考，请勿传播、商用*****/
/****                                                  */
/*******************************************************/
/*本模块主要功能是将YUV444 转化为YUV422，使用求平均值算法*/
/* 本模块只是简单实现，存在许多不住之处*/
module yuv444_yuv422(
	input sys_clk,/*系统时钟*/
	input i_hs,/*视频输入行同步*/
	input line_end,/*在某些情况下可能没有行同步信号，只能自己生成一个行结束信号 */
	// input i_vs,
	input i_de,/*视频数据有效*/
	input[7:0] i_y,/*视频输入Y分量 */
	input[7:0] i_cb,/*视频输入Cb（U）分量 */
	input[7:0] i_cr,/*视频输入Cr(V)分量 */
	// output o_hs,
	// output o_vs,
	output o_de,/* 输出数据有效*/
	output[7:0] o_y,/* 输出视频Y分量*/
	output[7:0] o_c/*输出视频CbCr分量复合，先输出Cb，后输出Cr */
);
reg i_de_d0  = 1'b0;/*i_de 一拍的延时 */
reg i_de_d1  = 1'b0;/*i_de_d0 一怕的延时*/
reg i_hs_d0  = 1'b0;/*i_hs 一拍的延时 */
reg i_hs_d1  = 1'b0;/*i_hs_d0 一拍的延时 */
reg [7:0] i_y_d0 = 8'd0;/*i_y 一拍的延时 */
reg [7:0] i_y_d1 = 8'd0;/*i_y_d0 一拍的延时 */
reg [7:0] i_cb_d0 = 8'd0;/*i_cb 一拍的延时 */
reg [7:0] i_cr_d0 = 8'd0;/*i_cr 一拍的延时 */
reg [7:0] cb = 8'd0;
reg [7:0] cr = 8'd0;
reg [7:0] cr_d0 = 8'd0;
reg line_end_d0;
reg line_end_d1;
wire[8:0] cb_add;
wire[8:0] cr_add;
reg c_flag = 1'b0;
assign cb_add = {1'b0,i_cb} + {1'b0,i_cb_d0};/*两个像素的cb相加，待求平均值 */
assign cr_add = {1'b0,i_cr} + {1'b0,i_cr_d0};/*两个像素的cr相加，待求平均值 */

always@(posedge sys_clk)
begin
	if(i_de)
		begin
			i_y_d0 <= i_y;
			i_cb_d0 <= i_cb;
			i_cr_d0 <= i_cr;
			line_end_d0 <= line_end;
		end
	else
		begin
			i_y_d0 <= i_y_d0;
			i_cb_d0 <= i_cb_d0;
			i_cr_d0 <= i_cr_d0;
			line_end_d0 <= line_end_d0;
		end
	i_de_d0 <= i_de;
end

always@(posedge sys_clk)
begin
	if(i_de_d0)
		begin
			i_y_d1 <= i_y_d0;
			cb <= cb_add[8:1];/*cb求平均值 */
			cr <= cr_add[8:1];/*cr求平均值 */
			line_end_d1 <= line_end_d0;
		end
	else
		begin
			i_y_d1 <= i_y_d1;
			cb <= cb;
			cr <= cr;
			line_end_d1 <= line_end_d1;
		end
	i_de_d1 <= i_de_d0;
end

always@(posedge sys_clk)
begin
	i_hs_d0 <= i_hs;
	i_hs_d1 <= i_hs_d0;
end

always@(posedge sys_clk)
begin
	if((i_hs_d0 & ~i_hs_d1) | line_end_d1)
		begin
			c_flag <= 1'b0;
		end
	else if(i_de_d1)///////////////////////////
		begin
			c_flag <= ~c_flag;/*该寄存器标记C（色度信号）取Cb还是Cr */
		end
	else
		begin
			c_flag <= c_flag;
		end
end
always@(posedge sys_clk)
begin
	if(i_de_d1)
		cr_d0 <= cr;
	else
		cr_d0 <= cr_d0;
end
assign o_c = c_flag ?  cr_d0 : cb;/*C（色度信号）的选取 */
assign o_y = i_y_d1;/////////////////
assign o_de = i_de_d1;/////////////////
endmodule 