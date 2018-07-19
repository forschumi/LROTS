/*******************************************************/
/****                                                  */
/****	本程序来自第三方，仅供参考，请勿传播、商用*****/
/****                                                  */
/*******************************************************/
/*本模块完成 YCbCr422到YCbCr444的转化，采用简单像素复制的方式*/
module YUV422_2YUV444(
	input clk,//系统时钟
	input[7:0] y_i,//输入视频亮度信号y
	input[7:0] cbcr_i,//输入视频色度信号cbcr
	input de_i,//输入视频有效
	input hs_i,//输入视频行同步
	input vs_i,//输入视频场同步
	output reg[7:0] y_o,//输出视频亮度分量y
	output[7:0] cb_o,//输出视频Cb分量
	output[7:0] cr_o,//输出视频Cr分量
	output reg de_o,//输出视频有效
	output reg hs_o,//输出视频行同步
	output reg  vs_o//输出视频场同步
);

reg flag;//CbCr分离时标记信号
reg[7:0] cb = 8'd0,cr = 8'd0;
assign cb_o = cb;
assign cr_o = cr;
always@(posedge clk)
begin
	de_o <= de_i;
	hs_o <= hs_i;
	vs_o <= vs_i;
end

always@(posedge clk)
begin
	if(de_i == 1'b0)
		begin
			flag <= 1'b0;
		end
	else
		begin
			flag <= ~flag;//de有效时翻转,因为CbCr是交替出现的，第一个出现的是Cb
		end
end
//将CbCr分开，并复制
//如：CbYCrYCbYCrY  --> CbCrYCbCrYCbCrYCbCrY
always@(posedge clk)
begin
	y_o <= y_i;
	if(~flag)
		begin
			cb <= cbcr_i;
			cr <= cr;
		end
	else
		begin
			cb <= cb;
			cr <= cbcr_i;
		end
end
endmodule