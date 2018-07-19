/*******************************************************/
/****                                                  */
/****	���������Ե������������ο������𴫲�������*****/
/****                                                  */
/*******************************************************/
///x, y begin from 1 
/*
	��Ƶ�������ģ��
	
ģ������Ƶ�������ͬ������ͬ����DE����һ��������Ϣ������ģ��ο�
*/
module timing_gen_xy(
	input rst_n,            /*��λ */
	input clk,              /*ʱ�� */
	input i_hs,             /*��Ƶ������ͬ�� */
	input i_vs,             /*��Ƶ���볡ͬ�� */
	input i_de,             /*��Ƶ����DE */
	input[23:0] i_data,     /*��Ƶ�������� */
	output o_hs,            /*��Ƶ�����ͬ�� */
	output o_vs,            /*��Ƶ�����ͬ�� */
	output o_de,            /*��Ƶ���DE */
	output[23:0] o_data,    /*��Ƶ������� */
	output[11:0] x,         /*��Ƶ���ʱ������Ϣx */
	output[11:0] y          /*��Ƶ���ʱ������Ϣy*/
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
	else if(de_d0)/*DE��Ч�ڼ�x�����ۼӣ���Ч�ڼ�����*/
		x_cnt <= x_cnt + 12'd1;
	else
		x_cnt <= 12'd0;
end
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		y_cnt <= 12'd0;
	else if(vs_edge)/*��ͬ��ʱy����*/
		y_cnt <= 12'd0;
	else if(de_falling)/*ÿһ�м�1*/
		y_cnt <= y_cnt + 12'd1;
	else
		y_cnt <= y_cnt;
end
assign x = x_cnt;
assign y = y_cnt;
endmodule 