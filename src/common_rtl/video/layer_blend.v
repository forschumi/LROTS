/*******************************************************/
/****                                                  */
/****	���������Ե������������ο������𴫲�������*****/
/****                                                  */
/*******************************************************/
/*
  ������Ƶalpha��ϴ���ĺ��ģ�
  һ����Ƶ��Ϊ�������ɫ
  һ����Ƶ��Ϊǰ��
  ������Ƶ��һ����������Ƶ��ǰ����Ƶ�Ǹ����ڣ�������ڵĴ�С���Ե���
  �����Ժͱ���һ����С����ȫ���Ǳ�����
  ��Ϻ�����ݿ�����Ϊ�µı�����Ƶ��������Ƶ������ϣ������Ϳ�����ɶ����Ƶ���ڵ���ʾ
*/
module layer_blend(
	input rst_n,                  /*��λ*/
	input clk,                    /*ʱ��*/
	input i_hs,                   /*��Ƶ������ͬ��*/
	input i_vs,                   /*��Ƶ���볡ͬ��*/
	input i_de,                   /*��Ƶ����DE*/
	input[23:0] i_ycbcr,          /*ǰ����Ƶ����*/
	input[23:0] i_back_ycbcr,     /*������Ƶ���ݣ��п�����һ���̶�ֵ������ڵ׻�����*/
	input[11:0] top,              /*ǰ����Ƶ����*/
	input[11:0] left,             /*ǰ����Ƶ����*/
	input[11:0] width,            /*ǰ����Ƶ����*/
	input[11:0] height,           /*ǰ����Ƶ����*/
	input[7:0] i_alpha,           /*ǰ����Ƶ��ϵ�͸����*/
	output rdreq,                 /*��ȡǰ����Ƶ����*/
	output o_hs,                  /*��Ϻ���Ƶ����ͬ��*/
	output o_vs,                  /*��Ϻ���Ƶ�ĳ�ͬ��*/
	output o_de,                  /*��Ϻ���Ƶ��DE*/
	input[11:0] i_x,              /*��Ƶ���������*/
	input[11:0] i_y,              /*��Ƶ���������*/
	output[11:0] o_x,             /*��Ƶ���������*/
	output[11:0] o_y,             /*��Ƶ���������*/
	output[23:0] o_ycbcr          /*��Ƶ�������*/
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
/*����ǰ����Ƶ���ݶ�ȡ����ģ��*/
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
/*alpha��ϵļ���ģ��*/
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