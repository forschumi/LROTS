/*******************************************************/
/****                                                  */
/****	���������Ե������������ο������𴫲�������*****/
/****                                                  */
/*******************************************************/
/*
	BT656����ģ�飬
	ͨ������BT656��������Ƶ��������ĳ�ͬ������ż����־��
	��ͬ����DE����ָʾ�ǲ���PAL��ʽ����Ƶ
*/
module bt656_decode(
	input clk,                    /*ʱ�ӣ�27Mhz*/
	input[7:0] bt656_in,          /*BT656����*/
	output[15:0] yc_data_out,     /*YC�������*/
	output vs,                    /*��ͬ�����*/
	output hs,                    /*��ͬ�����*/
	output field,                 /*��ż����־*/
	output de,                    /*������Ч*/
	output reg is_pal             /*PAL��־*/
);
reg[7:0] bt656_in_d0;
reg[7:0] bt656_in_d1;
reg[7:0] bt656_in_d2;
reg[7:0] bt656_in_d3;
reg[7:0] bt656_in_d4;
reg[11:0] x_cnt;
reg[11:0] y_cnt;
wire trs;
wire H;
wire V;
wire F;
reg de_p;

wire  de_t;
reg de_t_d0;
reg de_t_d1;
reg de_t_d2;
reg de_t_d3;
reg hs_reg;
reg vs_reg;
reg vs_reg_d0;
reg field_reg;
wire[15:0] yc_data_tmp;
reg[15:0] yc_data_tmp_d0;
reg[15:0] yc_data_tmp_d1;
reg[15:0] yc_data_tmp_d2;
reg[15:0] yc_data_tmp_d3;

reg[11:0] pixel_cnt = 12'd0;
assign H = bt656_in_d1[4];
assign V = bt656_in_d1[5];
assign F = bt656_in_d1[6];

assign hs = hs_reg;
assign field = field_reg;
assign de_t = de_p && pixel_cnt[0];
assign yc_data_tmp = {bt656_in_d1,bt656_in_d2};
always@(posedge clk)
begin
	bt656_in_d0 <= bt656_in;
	bt656_in_d1 <= bt656_in_d0;
	bt656_in_d2 <= bt656_in_d1;
	bt656_in_d3 <= bt656_in_d2;
	bt656_in_d4 <= bt656_in_d3;
end
always@(posedge clk)
begin
	yc_data_tmp_d0 <= yc_data_tmp;
	yc_data_tmp_d1 <= yc_data_tmp_d0;
	yc_data_tmp_d2 <= yc_data_tmp_d1;
	yc_data_tmp_d3 <= yc_data_tmp_d2;
	de_t_d0 <= de_t;
	de_t_d1 <= de_t_d0;
	de_t_d2 <= de_t_d1;
	de_t_d3 <= de_t_d2;
end
assign de = de_t_d3;
/*bt656ͬ��ͷ���*/
assign	trs = (bt656_in_d2 == 8'h00) && (bt656_in_d3 == 8'h00) && (bt656_in_d4 == 8'hff);
assign yc_data_out = yc_data_tmp_d3;
/*��������*/
always@(posedge clk)
begin
	if(trs && ~H && ~V)
		de_p <= 1'b1;
	else if(pixel_cnt == 12'd1439)
		de_p <= 1'b0;
	else
		de_p <= de_p;
end
always@(posedge clk)
begin
	if(de_p)
		pixel_cnt <= pixel_cnt + 12'd1;
	else
		pixel_cnt <= 12'd0;
end
/*������ͬ��*/
always@(posedge clk)
begin
	if(trs)
		hs_reg <= H;
	else
		hs_reg <= hs_reg;
end
/*���볡ͬ��*/
always@(posedge clk)
begin
	if(trs)
		vs_reg <= V;
	else
		vs_reg <= vs_reg;
		
	vs_reg_d0 <= vs_reg;
end
assign vs = ~vs_reg && vs_reg_d0;
/*������ż����־*/
always@(posedge clk)
begin
	if(trs)
		field_reg <= F;
	else
		field_reg <= field_reg;
end
/*�м���*/
always@(posedge clk)
begin
	if(vs)
		y_cnt <= 12'd0;
	else if(de_p && pixel_cnt == 12'd1439)
		y_cnt <= y_cnt + 12'd1;
	else
		y_cnt <= y_cnt;
end
/*�����PAL��ʽ��ÿ����288�У�NTSC��ʽ����280��*/
always@(posedge clk)
begin
	if(vs)
		if(y_cnt > 12'd280)
			is_pal <= 1'b1;
		else
			is_pal <= 1'b0;
	else
		is_pal <= is_pal;
end
endmodule 