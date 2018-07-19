/*
	ģ�������Ƶ���У�Ȼ��д��ddr2��
*/
module vin_pro
#(
	parameter MEM_DATA_BITS = 32,
	parameter INTERLACE = 1
)
(
	input rst_n,                                  /*��λ */
	input pixel_clk,                              /*��Ƶ����ʱ�� */
	input vs,                                     /*��Ƶ���볡ͬ�� */
	input f,                                      /*��Ƶ������ż����־ */
	input pixel_de,                               /*��Ƶ����������Ч */
	input[15:0] pixel_yc,                         /*��Ƶ��������YC */
	input[11:0] clipper_top,                      /*��Ƶ���в�����top */
	input[11:0] clipper_left,                     /*��Ƶ���в�����left */
	input[11:0] clipper_width,                    /*��Ƶ���в�����width */
	input[11:0] clipper_height,                   /*��Ƶ���в�����height  */
	input mem_clk,                                /*�洢���ӿڣ�ʱ��*/
	output  wr_burst_req,                         /*�洢���ӿڣ�д����*/
	output[9:0] wr_burst_len,                     /*�洢���ӿڣ�д����*/
	//output[23:0] wr_burst_addr,                   /*�洢���ӿڣ�д�׵�ַ */
	output[26:0] wr_burst_addr,                   /*�洢���ӿڣ�д�׵�ַ */
	input wr_burst_data_req,                      /*�洢���ӿڣ�д�������ݶ�ָʾ */
	output[MEM_DATA_BITS - 1:0] wr_burst_data,    /*�洢���ӿڣ�д����*/
	input burst_finish,                           /*�洢���ӿڣ�����д��� */
	input[11:0] s_width,                          /*��Ƶ������*/
	input[11:0] s_height,                         /*��Ƶ����߶�*/
	output[11:0] wr_max_line,                     /*�����źţ������� */
	input[1:0] base_addr,                         /*֡��ַ����*/
	(* keep = "true" *)output[1:0] frame_addr                        /*��ǰд��֡��ַ*/
);
reg frame_flag = 1'b0;
reg vs_d0 = 1'b0;
reg vs_d1 = 1'b0;
reg vs_vclk_d0 = 1'b0;
reg vs_vclk_d1 = 1'b0;
wire[15:0] vfb_vin_data;
reg vfb_vin_de = 1'b0;
reg[11:0] vin_x_cnt = 12'd0;
reg[11:0] vin_y_cnt = 12'd0;
wire vfb_fifo_afull;
wire clipper_wr_en;

always@(posedge pixel_clk)
begin
	vs_d0 <= vs;
	vs_d1 <= vs_d0;
	frame_flag <= vs_d0 && ~vs_d1;
end

always@(posedge pixel_clk)
begin
	vs_vclk_d0 <= vs;
	vs_vclk_d1 <= vs_vclk_d0;
end
/*��Ƶ���ݵ������ؼ���������������Ƶ*/
always@(posedge pixel_clk)
begin
	if(vs_vclk_d0 && ~vs_vclk_d1)
		vin_x_cnt <= 12'd1;
	else if(pixel_de)
		if(vin_x_cnt == s_width)
			vin_x_cnt <= 12'd1;
		else
			vin_x_cnt <= vin_x_cnt + 12'd1;
	else
		vin_x_cnt <= vin_x_cnt;		
end
/*��Ƶ���ݵ��м���������������Ƶ*/
always@(posedge pixel_clk)
begin
	if(vs_vclk_d0 && ~vs_vclk_d1)
		vin_y_cnt <= 12'd1;
	else if(pixel_de)
		if(vin_x_cnt == s_width)
			if(vin_y_cnt == s_height)
				vin_y_cnt <= 12'd1;
			else
				vin_y_cnt <= vin_y_cnt + 12'd1;
		else
			vin_y_cnt <= vin_y_cnt;	
	else
		vin_y_cnt <= vin_y_cnt;		
end
/*�����߼�*/
assign clipper_wr_en = (vin_x_cnt > clipper_left) && (vin_x_cnt <= clipper_left + clipper_width) && 
						(vin_y_cnt > clipper_top) && (vin_y_cnt <= clipper_top + clipper_height);
localparam buffer_f_depth_bits = 9;
reg[15:0] buffer_f_data;
wire buffer_f_rdclk;
wire buffer_f_rdreq;
wire buffer_f_wrclk;
reg buffer_f_wrreq;
wire[15:0] buffer_f_q;
wire buffer_f_rdempty;
wire[buffer_f_depth_bits - 1 : 0] buffer_f_rdusedw;
wire buffer_f_wrfull;
wire[buffer_f_depth_bits - 1 : 0] buffer_f_wrusedw;
assign buffer_f_rdreq = ~buffer_f_rdempty & ~vfb_fifo_afull;
assign buffer_f_rdclk = pixel_clk;
assign buffer_f_wrclk = pixel_clk;
/*Ϊ��������ܣ���һ�Ĵ���*/
always@(posedge buffer_f_wrclk)
begin
	buffer_f_wrreq <= pixel_de && clipper_wr_en;
	buffer_f_data <= pixel_yc;
end
/*���к����Ƶ����д��FIFO��vin_frame_buffer_ctrl��FIFO��ȡ����*/
lite_fifo#
(
	.COMMON_CLOCK(1),
	.ADDR_WIDTH(9),
	.DATA_WIDTH(16)
) buffer_f(
	.aclr(frame_flag),
	.data(buffer_f_data),
	.rdclk(buffer_f_rdclk),
	.rdreq(buffer_f_rdreq),
	.wrclk(buffer_f_wrclk),
	.wrreq(buffer_f_wrreq),
	.q(buffer_f_q),
	.rdempty(buffer_f_rdempty),
	.rdusedw(buffer_f_rdusedw),
	.wrfull(buffer_f_wrfull),
	.wrusedw(buffer_f_wrusedw));
/*FIFO �������1��clock������Ч*/	
always@(posedge buffer_f_rdclk)
begin
	vfb_vin_de <= buffer_f_rdreq;
end	

assign vfb_vin_data = buffer_f_q;
/*�����к����Ƶ����д��ddr2*/
vin_frame_buffer_ctrl 
#
(
	.MEM_DATA_BITS(MEM_DATA_BITS),
	.INTERLACE(INTERLACE)
)
vin_frame_buffer_ctrl_m0(
	.rst_n(rst_n),
	.vin_clk(buffer_f_rdclk),
	.vin_vs(vs),
	.vin_f(f),
	.vin_de(vfb_vin_de),
	.vin_data(vfb_vin_data),
	.vin_width(clipper_width),
	.vin_height(clipper_height),
	.fifo_afull(vfb_fifo_afull),
	.mem_clk(mem_clk),
	.wr_burst_req(wr_burst_req),
	.wr_burst_len(wr_burst_len),
	.wr_burst_addr(wr_burst_addr),
	.wr_burst_data_req(wr_burst_data_req),
	.wr_burst_data(wr_burst_data),
	.burst_finish(burst_finish),
	.wr_max_line(wr_max_line),
	.base_addr(base_addr),
	.frame_addr(frame_addr)
);

endmodule 