/*******************************************************/
/****                                                  */
/****	���������Ե������������ο������𴫲�������*****/
/****                                                  */
/*******************************************************/
/*��ģ����� YCbCr422��YCbCr444��ת�������ü����ظ��Ƶķ�ʽ*/
module YUV422_2YUV444(
	input clk,//ϵͳʱ��
	input[7:0] y_i,//������Ƶ�����ź�y
	input[7:0] cbcr_i,//������Ƶɫ���ź�cbcr
	input de_i,//������Ƶ��Ч
	input hs_i,//������Ƶ��ͬ��
	input vs_i,//������Ƶ��ͬ��
	output reg[7:0] y_o,//�����Ƶ���ȷ���y
	output[7:0] cb_o,//�����ƵCb����
	output[7:0] cr_o,//�����ƵCr����
	output reg de_o,//�����Ƶ��Ч
	output reg hs_o,//�����Ƶ��ͬ��
	output reg  vs_o//�����Ƶ��ͬ��
);

reg flag;//CbCr����ʱ����ź�
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
			flag <= ~flag;//de��Чʱ��ת,��ΪCbCr�ǽ�����ֵģ���һ�����ֵ���Cb
		end
end
//��CbCr�ֿ���������
//�磺CbYCrYCbYCrY  --> CbCrYCbCrYCbCrYCbCrY
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