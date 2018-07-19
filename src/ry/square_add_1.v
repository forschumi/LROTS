`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:20 10/19/2016 
// Design Name: 
// Module Name:    square_add 
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
/*视频加框模块*/
module square_add(
    input rst_n,
	input vin_vs,
    input vin_clk,
	input mem_clk,
	input[10:0] algo_x1,
	input[10:0] algo_y1,
	input[10:0] algo_x2,
	input[10:0] algo_y2,
	input track_done,
	input[1:0] frame_addr,
	output reg wr_burst_req,
	input wr_burst_data_req,
	output reg[26:0] wr_burst_addr,
    output reg[63:0] wr_burst_data,
	output reg[9:0] wr_burst_len,
	input burst_finish
    );
reg [11:0] column; //for基地址
reg [10:0] line; // for基地址
wire vin_f;
assign vin_f = 1'b1;

localparam BURST_LEN = 10'd128;
localparam BURST_IDLE = 3'd0;           
localparam BURST_ONE_LINE_START = 3'd1; 
localparam BURSTING = 3'd2;             
localparam BURST_END = 3'd3;            
localparam BURST_ONE_LINE_END = 3'd4;  
localparam WAIT = 3'd5; 
reg[2:0] burst_state = 3'd0;            
reg[2:0] burst_state_next = 3'd0;       
reg[9:0] remain_len = 10'd0;    // 64bit
reg[9:0] byte_per_line = 10'd0; // 64bit

wire[43:0] fifo_in;
wire[43:0] fifo_out;
wire fifo_afull;
wire fifo_aempty;
assign fifo_in = {algo_x1,algo_y1,algo_x2,algo_y2};
wire[10:0] x1;
wire[10:0] y1;
wire[10:0] x2;
wire[10:0] y2;
wire rd_en;
reg rd_en_d0 = 1'b0;
reg fifo_aempty_d0 = 1'b0;
reg fifo_aempty_d1 = 1'b0;
reg fifo_aempty_d2 = 1'b0;
assign rd_en = !fifo_aempty && (burst_state == BURST_IDLE); // 一行结束
fifo_16_44i_44o square_add_fifo(
    .rst(rst_n),
    .wr_clk(vin_clk),
    .rd_clk(mem_clk),
    .din(fifo_in),
    .wr_en(track_done),
    .rd_en(!fifo_aempty && (burst_state == BURST_IDLE)),
    .dout(fifo_out),
    .full(fifo_afull),
    .empty(fifo_aempty),
    .rd_data_count(),
    .wr_data_count(),
    .prog_full(),
    .prog_empty()  
);
assign x1 = fifo_out[43:33];
assign y1 = fifo_out[32:22];
assign x2 = fifo_out[21:11];
assign y2 = fifo_out[10:0];
/*for时序*/
always@(posedge mem_clk) begin
    rd_en_d0 <= rd_en;
	fifo_aempty_d0 <= fifo_aempty;
	fifo_aempty_d1 <= fifo_aempty_d0;
	fifo_aempty_d2 <= fifo_aempty_d1;
end
/*固定像素写入DDR*/
always@(posedge mem_clk or negedge rst_n) begin
    if(!rst_n)
	    wr_burst_data <= 64'd0;
	//else if(track_done)
	else if(wr_burst_data_req)
	    wr_burst_data <= 64'hffff_ffff_ffff_ffff;
end	
/*line产生*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		line <= 11'd0;
	else if(rd_en_d0)
		line <= y1;
	else if(line != y2 + 1'b1 && burst_state_next == BURST_ONE_LINE_END && burst_state == BURST_END)
		line <= line + 11'd1;
	else
		line <= line;
end
/*column产生*/
always@(posedge mem_clk or negedge rst_n)
begin
    if(!rst_n)
	    column <= {vin_f,11'd0};
	else if(burst_state_next == BURST_ONE_LINE_START || 
			((column == {vin_f,x2}) && (burst_state_next == WAIT)) )
	    column <= {vin_f,x1};
	else if ((burst_state_next == WAIT) && (column == {vin_f,x1}))
		column <= {vin_f,x2};
end
/*地址*/
wire[26:0] ddr_wr_base;
assign ddr_wr_base = {2'd0,frame_addr[1:0],line[10:0],column[11:0]};
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_burst_addr <= 27'd0;
	else if(burst_state_next == BURST_ONE_LINE_START) 
		wr_burst_addr <= ddr_wr_base;
	else if(burst_state_next == BURST_END  && burst_state != BURST_END)
		wr_burst_addr <= wr_burst_addr + {15'd0,wr_burst_len[8:0],3'd0};
	else
		wr_burst_addr <= wr_burst_addr;
end
reg frame_flag = 1'b0;
reg vin_vs_mem_clk_d0 = 1'b0;
reg vin_vs_mem_clk_d1 = 1'b0;
/*frame_flag产生*/
always@(posedge mem_clk)
begin
	vin_vs_mem_clk_d0 <= vin_vs;
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
/*矩形框写入DDR*/
always@(*)
begin
	case(burst_state)
		BURST_IDLE:
			if(!fifo_aempty_d2)
				burst_state_next <= BURST_ONE_LINE_START;
			else 
			    burst_state_next <= BURST_IDLE;
		BURST_ONE_LINE_START:
			burst_state_next <= BURSTING;
		BURSTING:
			if(burst_finish)
				burst_state_next <= BURST_END;
			else
				burst_state_next <= BURSTING;
		BURST_END:
			if(remain_len == 10'd0)
				burst_state_next <= BURST_ONE_LINE_END;
			else if(remain_len != 10'd0)
				burst_state_next <= BURSTING;
			else
				burst_state_next <= BURST_END;
		BURST_ONE_LINE_END:
		    if((line >= y1) && (line <= y2))
			    burst_state_next <= WAIT;
			else
			    burst_state_next <= BURST_IDLE;
		WAIT:
		    burst_state_next <= BURST_ONE_LINE_START;
		default:
			burst_state_next <= BURST_IDLE;
	endcase
end
/*byte_per_line产生*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		byte_per_line <= 10'd0;
	else if(line == y1 || line == y2)
		byte_per_line <= x2[10:2] - x1[10:2]; // 取整
	else if((y1 < line < y2) && (burst_state_next == WAIT))
		byte_per_line <= 10'd1;
	else
		byte_per_line <= byte_per_line;
end
/*remain_len产生*/
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
/*wr_burst_len产生*/
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
/*wr_burst_req产生*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_burst_req <= 1'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		wr_burst_req <= 1'b1;
	else if(burst_finish  || wr_burst_data_req || burst_state == BURST_IDLE)
		wr_burst_req <= 1'b0;
	else
		wr_burst_req <= wr_burst_req;
end

endmodule
