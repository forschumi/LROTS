/*******************************************************/
/****                                                  */
/****	���������Ե������������ο������𴫲�������*****/
/****                                                  */
/*******************************************************/
/*ģ�����top��left��width��height����Ƶ������Ϣ����һ�����ݶ�ȡ�źţ�������һ��alpha���ֵ
��ģ����ʵ��һ����Ƶ������ʾ��һ���ؼ�
*/
module layer_rdreq_gen(
	input rst_n,               /*��λ*/
	input clk,                 /*ʱ��*/
	input[11:0] top,           /*���ڲ�������*/
	input[11:0] left,          /*���ڲ�������*/
	input[11:0] width,         /*���ڲ�������*/
	input[11:0] height,        /*���ڲ�������*/
	input[11:0] x,             /*��ǰ��Ƶʱ������*/
	input[11:0] y,             /*��ǰ��Ƶʱ������*/
	input[7:0] i_alpha,        /*��ǰ���ڵ�alphaֵ*/
	output reg[7:0] o_alpha,   /*������Ƶ��alphaֵ*/
	output rdreq               /*���ݶ�����*/
);
//���ݺ�alphaֵ�ӳ�2��ʱ�Ӳ���
reg rdreq_d0;
/*�������߼����Զ��׼�����һ����������*/
assign rdreq = (y > top) && (y <= top + height) && (x > left) && (x <= left + width);
always@(posedge clk)
begin
	rdreq_d0 <= rdreq;
end
/*�ڴ��������alphaֵ��������alpha����������Ϊ0��������������ȫ��ʾ��ɫ����������Ƶ*/
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