/*******************************************************/
/****                                                  */
/****	本程序来自第三方，仅供参考，请勿传播、商用*****/
/****                                                  */
/*******************************************************/
/*模块根据top，left，width，height和视频坐标信息产生一个数据读取信号，并产生一个alpha混合值
该模块是实现一个视频窗口显示的一个关键
*/
module layer_rdreq_gen(
	input rst_n,               /*复位*/
	input clk,                 /*时钟*/
	input[11:0] top,           /*窗口产生参数*/
	input[11:0] left,          /*窗口产生参数*/
	input[11:0] width,         /*窗口产生参数*/
	input[11:0] height,        /*窗口产生参数*/
	input[11:0] x,             /*当前视频时序坐标*/
	input[11:0] y,             /*当前视频时序坐标*/
	input[7:0] i_alpha,        /*当前窗口的alpha值*/
	output reg[7:0] o_alpha,   /*整个视频的alpha值*/
	output rdreq               /*数据读请求*/
);
//数据和alpha值延迟2个时钟产生
reg rdreq_d0;
/*读请求逻辑，显而易见，是一个窗口区域*/
assign rdreq = (y > top) && (y <= top + height) && (x > left) && (x <= left + width);
always@(posedge clk)
begin
	rdreq_d0 <= rdreq;
end
/*在窗口区域的alpha值来自输入alpha，其他区域为0，即其他区域完全显示底色（背景）视频*/
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		o_alpha <= 8'd0;
	else if(rdreq_d0)
		o_alpha <= i_alpha;
	else
		o_alpha <= 8'd0;
end
endmodule 