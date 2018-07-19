/*******************************************************/
/****                                                  */
/****	本程序来自第三方，仅供参考，请勿传播、商用*****/
/****                                                  */
/*******************************************************/
///x, y begin from 1 
/*
	视频坐标产生模块
	
模块由视频输入的行同步，场同步，DE产生一个坐标信息供其他模块参考
*/
module timing_gen_xy(
	input rst_n,            /*复位 */
	input clk,              /*时钟 */
	input i_hs,             /*视频输入行同步 */
	input i_vs,             /*视频输入场同步 */
	input i_de,             /*视频输入DE */
	input[23:0] i_data,     /*视频输入数据 */
	output o_hs,            /*视频输出行同步 */
	output o_vs,            /*视频输出场同步 */
	output o_de,            /*视频输出DE */
	output[23:0] o_data,    /*视频输出数据 */
	output[11:0] x,         /*视频输出时坐标信息x */
	output[11:0] y          /*视频输出时坐标信息y*/
);
reg de_d0;
reg de_d1;
reg vs_d0;
reg vs_d1;
reg hs_d0;
reg hs_d1;
reg[23:0] i_data_d0;
reg[23:0] i_data_d1;
reg[11:0] x_cnt = 12'd0;
reg[11:0] y_cnt = 12'd0;
wire vs_edge;
wire de_falling;
assign vs_edge = vs_d0 && ~vs_d1;
assign de_falling = ~de_d0 && de_d1;
assign o_de = de_d1;
assign o_vs = vs_d1;
assign o_hs = hs_d1;
assign o_data = i_data_d1;
always@(posedge clk)
begin
	de_d0 <= i_de;
	de_d1 <= de_d0;
	vs_d0 <= i_vs;
	vs_d1 <= vs_d0;
	hs_d0 <= i_hs;
	hs_d1 <= hs_d0;
	i_data_d0 <= i_data;
	i_data_d1 <= i_data_d0;
end
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		x_cnt <= 12'd0;
	else if(de_d0)/*DE有效期间x坐标累加，无效期间清零*/
		x_cnt <= x_cnt + 12'd1;
	else
		x_cnt <= 12'd0;
end
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		y_cnt <= 12'd0;
	else if(vs_edge)/*场同步时y清零*/
		y_cnt <= 12'd0;
	else if(de_falling)/*每一行加1*/
		y_cnt <= y_cnt + 12'd1;
	else
		y_cnt <= y_cnt;
end
assign x = x_cnt;
assign y = y_cnt;
endmodule 