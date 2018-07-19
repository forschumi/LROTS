/*******************************************************/
/****                                                  */
/****	���������Ե������������ο������𴫲�������*****/
/****                                                  */
/*******************************************************/
/*
��Ƶʱ����ģ�飬��ģ�鲻Ҫ�������������ʵ�ֲ�ͬ�ֱ��ʵ�ʱ��
����û�п����г�ͬ����������
*/
module vout_display_timing(
	input rst_n,               /*��λ */
	input dp_clk,              /*ʱ��*/
	input[11:0] h_fp,          /*��ͬ��ǰ�� */
	input[11:0] h_sync,        /*��ͬ�� */
	input[11:0] h_bp,          /*��ͬ����� */
	input[11:0] h_active,      /*����Ч���� */
	input[11:0] h_total,       /*�������ڣ�����ʱ�ӣ� */
	input[11:0] v_fp,          /*��ͬ��ǰ�磨�У�*/
	input[11:0] v_sync,        /*��ͬ�����У�*/
	input[11:0] v_bp,          /*��ͬ����磨�У� */
	input[11:0] v_active,      /*����Ч�� */
	input[11:0] v_total,       /*������ */
	output hs,                 /*��ͬ����� */
	output vs,                 /*��ͬ����� */
	output de                  /*��Ƶ��Ч���*/
);
reg[11:0] h_cnt = 12'd0;
reg[11:0] v_cnt = 12'd0;

reg hs_reg;
reg vs_reg;
reg de_reg;

wire hs_net;
wire vs_net;
wire de_net;
wire v_video;
wire h_video;

assign hs_net = (h_cnt > h_fp - 12'd1) && (h_cnt < h_fp + h_sync);/*��ͬ������*/
assign h_video = (h_cnt >= h_fp + h_sync + h_bp) && (h_cnt < h_total);
assign v_video = (v_cnt >= v_fp + v_sync + v_bp) && (v_cnt < v_total);
assign vs_net = (v_cnt > v_fp - 12'd1) && (v_cnt < v_fp + v_sync);/*��ͬ������*/
assign de_net = h_video && v_video;/*��Ƶ��Ч���ݲ���*/
assign hs = hs_reg;
assign vs = vs_reg;
assign de = de_reg;
/*�м����������ڴ��������*/
always@(posedge dp_clk or negedge rst_n)
begin
	if(!rst_n)
		h_cnt <= 12'd0;
	else if(h_cnt == h_total - 12'd1)
		h_cnt <= 12'd0;
	else
		h_cnt <= h_cnt + 12'd1;		
end
/*�������������ڴ������*/
always@(posedge dp_clk or negedge rst_n)
begin
	if(!rst_n)
		v_cnt <= 12'd0;
	else if(h_cnt == h_total - 12'd1)
		if(v_cnt == v_total - 12'd1)
			v_cnt <= 12'd0;
		else
			v_cnt <= v_cnt + 12'd1;
	else
		v_cnt <= v_cnt;
end

/*Ϊ��������ܣ���һ�������*/
always@(posedge dp_clk or negedge rst_n)
begin
	if(!rst_n)
		hs_reg <= 1'b0;
	else
		hs_reg <= hs_net;
end
/*Ϊ��������ܣ���һ�������*/
always@(posedge dp_clk or negedge rst_n)
begin
	if(!rst_n)
		de_reg <= 1'b0;
	else
		de_reg <= de_net;
end
/*Ϊ��������ܣ���һ�������*/
always@(posedge dp_clk or negedge rst_n)
begin
	if(!rst_n)
		vs_reg <= 1'b0;
	else
		vs_reg <= vs_net;
end
endmodule 