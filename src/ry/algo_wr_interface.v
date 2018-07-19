`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:17 10/25/2016 
// Design Name: 
// Module Name:    algo_interface 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module algo_wr_interface
(
    input rst_n,
	input vin_clk,
	input mem_clk,
	input[7:0] o_hue,
	input o_vs,
	input o_hs,
	input o_data_en,
	input[11:0] vin_width,
	output reg wr_burst_req,
	input wr_burst_data_req,
	output reg[9:0] wr_burst_len,
	output reg[26:0] wr_burst_addr,
	output[63:0] wr_burst_data,
	input burst_finish,
	output reg frame_flag,
	input [1:0] frame_addr
    );
//reg[1:0] frame_addr;	 
initial                                              
begin
//	frame_addr <= 2'd0;
	frame_flag <= 1'd0;
end	 
localparam BURST_LEN = 10'd128;               /*һ��д�������ݳ��� */
localparam BURST_IDLE = 3'd0;                 /*״̬��״̬������ */
localparam BURST_ONE_LINE_START = 3'd1;       /*״̬��״̬����Ƶ����һ��д��ʼ */
localparam BURSTING = 3'd2;                   /*״̬��״̬�����ڴ���һ��ddr2д���� */
localparam BURST_END = 3'd3;                  /*״̬��״̬��һ��ddr2д�������*/
localparam BURST_ONE_LINE_END = 3'd4;         /*״̬��״̬����Ƶ����һ��д���*/
reg[2:0] burst_state = 3'd0;                  /*״̬��״̬����ǰ״̬ */
reg[2:0] burst_state_next = 3'd0;             /*״̬��״̬����һ��״̬*/
reg[10:0] burst_line = 12'd0;/*�Ѿ�д��ddr2���м���*/
reg[9:0] byte_per_line = 10'd0;/*����Ƶ��Ȼ����д��ddr2�����ݸ���*/
reg[9:0] remain_len = 10'd0;/*��ǰ��Ƶһ�����ݵ�ʣ�����ݸ���*/
reg[11:0] data_cnt  = 12'd0;
reg vin_vs_mem_clk_d0 = 1'b0;
reg vin_vs_mem_clk_d1 = 1'b0;
reg vin_vs_d0 = 1'b0;
reg vin_vs_d1 = 1'b0;
(* keep = "true" *)reg frame_flag_vin = 1'b0;
reg fifo_wr_req = 1'b0;

wire[9:0] rdusedw;
wire[9:0] wrusedw;

wire[63:0] data;
reg[7:0] pixel0 = 8'd0;
reg[7:0] pixel1 = 8'd0;
reg[7:0] pixel2 = 8'd0;
reg[7:0] pixel3 = 8'd0;
reg[7:0] pixel4 = 8'd0;
reg[7:0] pixel5 = 8'd0;
reg[7:0] pixel6 = 8'd0;
reg[7:0] pixel7 = 8'd0;
//zclin 2017.01.05
(* keep = "true" *)reg[19:0] cnt_1;
(* keep = "true" *)reg[19:0] cnt_2;
always@(posedge vin_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt_1 <= 0;
	else if(frame_flag_vin)
		cnt_1 <= 0;
	else if(o_data_en && o_hue[0])
		cnt_1 <= cnt_1 + 1'd1;
	else 
		cnt_1 <= cnt_1;
end
always@(posedge vin_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt_2 <= 0;
	else if(frame_flag_vin)
		cnt_2 <= 0;
	else if(o_data_en)
		cnt_2 <= cnt_2 + 1'd1;
	else 
		cnt_2 <= cnt_2;
end
/*��д��fifo�����ݣ���pixel0��pixel1��pixel2��pixel3, pixel4, pixel5, pixel6, pixel7ƴ�Ӷ���*/
assign data = {pixel0,pixel1,pixel2,pixel3,pixel4,pixel5,pixel6,pixel7};
lite_fifo#
(
	.COMMON_CLOCK(0),
	.ADDR_WIDTH(9),
	.DATA_WIDTH(64)
)  algo_data_fifo_m0(
	.aclr(frame_flag),
	.data(data),
	.rdclk(mem_clk),
	.rdreq(wr_burst_data_req),
	.wrclk(vin_clk),
	.wrreq(fifo_wr_req),
	.q(wr_burst_data),
	.rdempty(),
	.rdusedw(rdusedw),
	.wrfull(),
	.wrusedw(wrusedw)); 
		
always@(posedge vin_clk)
begin
	vin_vs_d0 <= o_vs;
	vin_vs_d1 <= vin_vs_d0;
	frame_flag_vin <= vin_vs_d0 && ~vin_vs_d1;
end
/*���ݼ���*/
always@(posedge vin_clk)
begin
	if(!rst_n)
		data_cnt <= 12'd0;
	else if(frame_flag_vin)
		data_cnt <= 12'd0;
	else if(o_data_en)
		begin
			if(data_cnt == vin_width - 12'd1)
				data_cnt <= 12'd0;
			else
				data_cnt <= data_cnt + 12'd1;
		end
	else
		data_cnt <= data_cnt;
end
/*��data_cnt[2:0] == 0 ʱ��pixel0ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd0))
		pixel0 <= o_hue;
	else
		pixel0 <= pixel0;		
end
/*��data_cnt[2:0] == 1 ʱ��pixel1ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd1))
		pixel1 <= o_hue;
	else
		pixel1 <= pixel1;		
end
/*��data_cnt[2:0] == 2 ʱ��pixel2ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd2))
		pixel2 <= o_hue;
	else
		pixel2 <= pixel2;		
end
/*��data_cnt[2:0] == 3 ʱ��pixel3ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd3))
		pixel3 <= o_hue;
	else
		pixel3 <= pixel3;		
end
/*��data_cnt[2:0] == 4 ʱ��pixel4ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd4))
		pixel4 <= o_hue;
	else
		pixel4 <= pixel4;		
end
/*��data_cnt[2:0] == 5 ʱ��pixel5ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd5))
		pixel5 <= o_hue;
	else
		pixel5 <= pixel5;		
end
/*��data_cnt[2:0] == 6 ʱ��pixel6ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd6))
		pixel6 <= o_hue;
	else
		pixel6 <= pixel6;		
end
/*��data_cnt[2:0] == 7 ʱ��pixel7ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd7))
		pixel7 <= o_hue;
	else
		pixel7 <= pixel7;		
end
/*��data_cnt[2:0] == 7 ʱ��pixel0��pixel1��pixel2��pixel3, pixel4, pixel5, pixel6, pixel7����ֵ����ƴ��Ϊһ��64bit�����һ��д��FIFO����*/
always@(posedge vin_clk)
begin
	if(o_data_en &&(data_cnt[2:0] == 3'd7 || data_cnt == vin_width - 12'd1))
		fifo_wr_req <= 1'b1;
	else
		fifo_wr_req <= 1'b0;
end
/*����Ƶ��Ȼ����д��ddr2�����ݸ���*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		byte_per_line <= 10'd0;
	else if(frame_flag)
		if(vin_width[2:0] == 3'd0)
			byte_per_line <= vin_width[11:3];
		else
			byte_per_line <= vin_width[11:3] + 10'd1;
	else
		byte_per_line <= byte_per_line;
end
/*ͻ��д�׵�ַ�Ĳ���*/
wire[23:0] ddr_wr_base;
assign ddr_wr_base =  {1'd1,2'd0,frame_addr[1:0],burst_line[10:0],8'd0};
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_burst_addr <= {1'd1,23'd0,3'd0};
	else if(burst_state_next == BURST_ONE_LINE_START)
		wr_burst_addr <= {ddr_wr_base,3'd0};
	else if(burst_state_next == BURST_END  && burst_state != BURST_END)
		wr_burst_addr <= wr_burst_addr + {15'd0,BURST_LEN[8:0],3'd0};
	else
		wr_burst_addr <= wr_burst_addr;
end

always@(posedge mem_clk)
begin
	vin_vs_mem_clk_d0 <= o_vs;
	vin_vs_mem_clk_d1 <= vin_vs_mem_clk_d0;
	frame_flag <= vin_vs_mem_clk_d0 && ~vin_vs_mem_clk_d1;
end
/*ÿһ֡����״̬��ǿ�н���BURST_IDLE״̬*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_state <= BURST_IDLE;
	else if(frame_flag)
		burst_state <= BURST_IDLE;
	else
		burst_state <= burst_state_next;
end
always@(*)
begin
	case(burst_state)
		BURST_IDLE:/*0���FIFO���㹻�����������һ�е�һ��д����*/
			if(rdusedw > BURST_LEN[7:0])
				burst_state_next <= BURST_ONE_LINE_START;
			else
				burst_state_next <= BURST_IDLE;
		BURST_ONE_LINE_START:/*1һ�е�д������ʼ*/
			burst_state_next <= BURSTING;
		BURSTING:/*2д����*/
			if(burst_finish)
				burst_state_next <= BURST_END;
			else
				burst_state_next <= BURSTING;
		BURST_END:/*3д�������ʱ�ж�һ�������Ƿ��Ѿ���ȫд��ddr2����������������״̬���ȴ��ڶ�������*/
			if(remain_len == 10'd0)
				burst_state_next <= BURST_ONE_LINE_END;
			else if((rdusedw >= BURST_LEN[7:0]) || (remain_len <= BURST_LEN && rdusedw >= remain_len - 10'd1))
				burst_state_next <= BURSTING;
			else
				burst_state_next <= BURST_END;
		BURST_ONE_LINE_END: // 4
			burst_state_next <= BURST_IDLE;
		default:
			burst_state_next <= BURST_IDLE;
	endcase
end

/*burst_line����*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_line <= 11'd0;
	else if(frame_flag)
		burst_line <= 11'd0;
	else if(burst_state == BURST_ONE_LINE_END)//ÿ��һ��д��burst_line��1
		burst_line <= burst_line + 11'd1;
	else
		burst_line <= burst_line;
end
//always@(posedge mem_clk or negedge rst_n)
//begin
//	if(!rst_n)
//		frame_addr <= 2'd0;
//	else if(frame_flag)//ûд��һ֡����frame_addr��1
//		frame_addr <= frame_addr + 2'd1;
//	else
//		frame_addr <= frame_addr;
//end	

/*remain_len������ÿһ��д��ʼʱ����byte_per_line�����һ������С��һ��д����󳤶ȣ�
һ��д�꣬��remain_len = 0�������ȥ���д����*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		remain_len <= 10'd0;
	else if(burst_state_next == BURST_ONE_LINE_START)
		remain_len <= byte_per_line;
	else if(burst_state_next == BURST_END && burst_state != BURST_END)
		if(remain_len < BURST_LEN)
			remain_len <= 10'd0;
		else
			remain_len <= remain_len - BURST_LEN;	
	else
		remain_len <= remain_len;
end
/*ͻ�����Ȳ��������һ�е�ʣ�����ݴ������д���ȣ���ͻ��������BURST_LEN������͵���ʣ�����ݳ���*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_burst_len <= 10'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		if(remain_len > BURST_LEN)
			wr_burst_len <= BURST_LEN;
		else
			wr_burst_len <= remain_len;
	else
		wr_burst_len <=  wr_burst_len;
end
/*ddr2д�����źŵĲ����ڳ���*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_burst_req <= 1'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		wr_burst_req <= 1'b1;
	else if(burst_finish  || wr_burst_data_req || burst_state == BURST_IDLE)
		wr_burst_req <= 1'b0;
end

endmodule
