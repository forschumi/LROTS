/*******************************************************/
/****                                                  */
/****	本程序来自第三方，仅供参考，请勿传播、商用*****/
/****                                                  */
/*******************************************************/
/*
	BT656解析模块，
	通过解析BT656，产生视频处理所需的场同步，奇偶场标志，
	行同步，DE。并指示是不是PAL制式的视频
*/
module bt656_decode(
	input clk,                    /*时钟，27Mhz*/
	input[7:0] bt656_in,          /*BT656输入*/
	output[15:0] yc_data_out,     /*YC数据输出*/
	output vs,                    /*场同步输出*/
	output hs,                    /*行同步输出*/
	output field,                 /*奇偶场标志*/
	output de,                    /*数据有效*/
	output reg is_pal             /*PAL标志*/
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
/*bt656同步头检测*/
assign	trs = (bt656_in_d2 == 8'h00) && (bt656_in_d3 == 8'h00) && (bt656_in_d4 == 8'hff);
assign yc_data_out = yc_data_tmp_d3;
/*分离数据*/
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
/*分离行同步*/
always@(posedge clk)
begin
	if(trs)
		hs_reg <= H;
	else
		hs_reg <= hs_reg;
end
/*分离场同步*/
always@(posedge clk)
begin
	if(trs)
		vs_reg <= V;
	else
		vs_reg <= vs_reg;
		
	vs_reg_d0 <= vs_reg;
end
assign vs = ~vs_reg && vs_reg_d0;
/*分离奇偶场标志*/
always@(posedge clk)
begin
	if(trs)
		field_reg <= F;
	else
		field_reg <= field_reg;
end
/*行计数*/
always@(posedge clk)
begin
	if(vs)
		y_cnt <= 12'd0;
	else if(de_p && pixel_cnt == 12'd1439)
		y_cnt <= y_cnt + 12'd1;
	else
		y_cnt <= y_cnt;
end
/*如果是PAL制式，每场有288行，NTSC制式的有280行*/
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