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
localparam BURST_LEN = 10'd128;               /*一次写操作数据长度 */
localparam BURST_IDLE = 3'd0;                 /*状态机状态：空闲 */
localparam BURST_ONE_LINE_START = 3'd1;       /*状态机状态：视频数据一行写开始 */
localparam BURSTING = 3'd2;                   /*状态机状态：正在处理一次ddr2写操作 */
localparam BURST_END = 3'd3;                  /*状态机状态：一次ddr2写操作完成*/
localparam BURST_ONE_LINE_END = 3'd4;         /*状态机状态：视频数据一行写完成*/
reg[2:0] burst_state = 3'd0;                  /*状态机状态：当前状态 */
reg[2:0] burst_state_next = 3'd0;             /*状态机状态：下一个状态*/
reg[10:0] burst_line = 12'd0;/*已经写入ddr2的行计数*/
reg[9:0] byte_per_line = 10'd0;/*将视频宽度换算成写入ddr2的数据个数*/
reg[9:0] remain_len = 10'd0;/*当前视频一行数据的剩余数据个数*/
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
/*待写入fifo的数据，由pixel0，pixel1，pixel2，pixel3, pixel4, pixel5, pixel6, pixel7拼接而来*/
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
/*数据计数*/
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
/*当data_cnt[2:0] == 0 时，pixel0取当前像素值*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd0))
		pixel0 <= o_hue;
	else
		pixel0 <= pixel0;		
end
/*当data_cnt[2:0] == 1 时，pixel1取当前像素值*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd1))
		pixel1 <= o_hue;
	else
		pixel1 <= pixel1;		
end
/*当data_cnt[2:0] == 2 时，pixel2取当前像素值*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd2))
		pixel2 <= o_hue;
	else
		pixel2 <= pixel2;		
end
/*当data_cnt[2:0] == 3 时，pixel3取当前像素值*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd3))
		pixel3 <= o_hue;
	else
		pixel3 <= pixel3;		
end
/*当data_cnt[2:0] == 4 时，pixel4取当前像素值*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd4))
		pixel4 <= o_hue;
	else
		pixel4 <= pixel4;		
end
/*当data_cnt[2:0] == 5 时，pixel5取当前像素值*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd5))
		pixel5 <= o_hue;
	else
		pixel5 <= pixel5;		
end
/*当data_cnt[2:0] == 6 时，pixel6取当前像素值*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd6))
		pixel6 <= o_hue;
	else
		pixel6 <= pixel6;		
end
/*当data_cnt[2:0] == 7 时，pixel7取当前像素值*/
always@(posedge vin_clk)
begin
	if(o_data_en && (data_cnt[2:0] == 3'd7))
		pixel7 <= o_hue;
	else
		pixel7 <= pixel7;		
end
/*当data_cnt[2:0] == 7 时，pixel0，pixel1，pixel2，pixel3, pixel4, pixel5, pixel6, pixel7都有值，可拼接为一个64bit，完成一次写入FIFO操作*/
always@(posedge vin_clk)
begin
	if(o_data_en &&(data_cnt[2:0] == 3'd7 || data_cnt == vin_width - 12'd1))
		fifo_wr_req <= 1'b1;
	else
		fifo_wr_req <= 1'b0;
end
/*将视频宽度换算成写入ddr2的数据个数*/
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
/*突发写首地址的产生*/
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
/*每一帧都将状态机强行进入BURST_IDLE状态*/
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
		BURST_IDLE:/*0如果FIFO有足够的数据则完成一行第一次写操作*/
			if(rdusedw > BURST_LEN[7:0])
				burst_state_next <= BURST_ONE_LINE_START;
			else
				burst_state_next <= BURST_IDLE;
		BURST_ONE_LINE_START:/*1一行的写操作开始*/
			burst_state_next <= BURSTING;
		BURSTING:/*2写操作*/
			if(burst_finish)
				burst_state_next <= BURST_END;
			else
				burst_state_next <= BURSTING;
		BURST_END:/*3写操作完成时判断一行数据是否已经完全写入ddr2，如果完成则进入空闲状态，等待第二行数据*/
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

/*burst_line产生*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_line <= 11'd0;
	else if(frame_flag)
		burst_line <= 11'd0;
	else if(burst_state == BURST_ONE_LINE_END)//每次一行写完burst_line加1
		burst_line <= burst_line + 11'd1;
	else
		burst_line <= burst_line;
end
//always@(posedge mem_clk or negedge rst_n)
//begin
//	if(!rst_n)
//		frame_addr <= 2'd0;
//	else if(frame_flag)//没写入一帧数据frame_addr加1
//		frame_addr <= frame_addr + 2'd1;
//	else
//		frame_addr <= frame_addr;
//end	

/*remain_len产生，每一行写开始时等于byte_per_line，如果一行数据小于一次写的最大长度，
一次写完，则remain_len = 0，否则减去最大写长度*/
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
/*突发长度产生，如果一行的剩余数据大于最大写长度，则突发长度是BURST_LEN，否则就等于剩余数据长度*/
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
/*ddr2写请求信号的产生于撤销*/
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
