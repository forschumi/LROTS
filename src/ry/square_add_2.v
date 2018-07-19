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
	(* keep = "ture" *)input track_done,
	(* keep = "ture" *)input[1:0] track_frame_addr,
	(* keep = "ture" *)output reg wr_burst_req,
	(* keep = "ture" *)input wr_burst_data_req,
	(* keep = "ture" *)output reg[26:0] wr_burst_addr,
    (* keep = "ture" *)output [63:0] wr_burst_data,
	(* keep = "ture" *)output reg[9:0] wr_burst_len,
	(* keep = "ture" *)input burst_finish
    );
(* keep = "ture" *)reg [11:0] column; //for基地址
(* keep = "ture" *)reg [10:0] line; // for基地址

localparam BURST_LEN = 10'd128;
localparam BURST_IDLE = 3'd0;           
localparam BURST_ONE_LINE_START = 3'd1; 
localparam BURSTING = 3'd2;             
localparam BURST_END = 3'd3;            
localparam BURST_ONE_LINE_END = 3'd4;  
localparam WAIT = 3'd5; 
(* keep = "ture" *)reg[2:0] burst_state = 3'd0;            
(* keep = "ture" *)reg[2:0] burst_state_next = 3'd0;       
(* keep = "ture" *)reg[9:0] remain_len = 10'd0;    // 64bit
(* keep = "ture" *)reg[9:0] byte_per_line = 10'd0; // 64bit

wire[45:0] fifo_in;
wire[45:0] fifo_out;
(* keep = "ture" *)wire fifo_afull;
(* keep = "ture" *)wire fifo_aempty;
assign fifo_in = {track_frame_addr[1:0],algo_x1[10:0],algo_y1[10:0],algo_x2[10:0],algo_y2[10:0]};
(* keep = "ture" *)wire[10:0] x1;
(* keep = "ture" *)wire[10:0] y1;
(* keep = "ture" *)wire[10:0] x2;
(* keep = "ture" *)wire[10:0] y2;
(* keep = "ture" *)wire[1:0]  frame_addr;
(* keep = "ture" *)wire rd_en;
(* keep = "ture" *)reg rd_en_d0 = 1'b0;
(* keep = "ture" *)reg fifo_aempty_d0 = 1'b0;
(* keep = "ture" *)reg fifo_aempty_d1 = 1'b0;
(* keep = "ture" *)reg fifo_aempty_d2 = 1'b0;
assign rd_en = !fifo_aempty && (burst_state == BURST_IDLE); // 一行结束
fifo_16_46i_46o square_add_fifo(
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
assign frame_addr = fifo_out[45:44];
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
/* always@(posedge mem_clk or negedge rst_n) begin
    if(!rst_n)
	    wr_burst_data <= 64'd0;
	//else if(track_done)
	else if(wr_burst_data_req)
	    wr_burst_data <= 64'hffff_ffff_ffff_ffff;
	else
		wr_burst_data <= 64'd0;
end	 */
assign wr_burst_data = 64'hffff_ffff_ffff_ffff;
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
/* always@(posedge mem_clk or negedge rst_n)
begin
    if(!rst_n)
	    column <= {vin_f,11'd0};
	else if(burst_state == BURST_IDLE || 
			((column == {vin_f,x2}) && (burst_state_next == WAIT)) )
	    column <= {vin_f,x1};
	else if ((burst_state_next == WAIT) && (column == {vin_f,x1}))
		column <= {vin_f,x2};
end */
always@(posedge mem_clk or negedge rst_n)
begin
    if(!rst_n)
	    column <= 12'd0;
	else if(burst_state == BURST_IDLE || ((column == x2) && (burst_state_next == WAIT)) )
	    column <= x1;
	else if ((burst_state_next == WAIT) && (column == x1))
		column <= x2;
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
(* keep = "ture" *)reg frame_flag = 1'b0;
(* keep = "ture" *)reg vin_vs_mem_clk_d0 = 1'b0;
(* keep = "ture" *)reg vin_vs_mem_clk_d1 = 1'b0;
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
// lszhang, 2016.11.26 跨时钟域处理
/*wire [1:0] frame_addr_graycode;
assign frame_addr_graycode = (track_frame_addr == 2'b00) ? 2'b00 
							 : (track_frame_addr == 2'b01) ? 2'b01
							 : (track_frame_addr == 2'b10) ? 2'b11
							 : (track_frame_addr == 2'b11) ? 2'b10;
reg[1:0] frame_addr_d1;
reg[1:0] frame_addr_d2;  // double synced frame_addr_graycode
always@(posedge mem_clk or negedge rst_n) begin
	if(!rst_n) begin
		frame_addr_d1 <= 2'd0;
		frame_addr_d2 <= 2'd0;	
    end
	else begin
		frame_addr_d1 <= frame_addr_graycode;
		frame_addr_d2 <= frame_addr_d1;
    end
end

reg track_done_d1;
reg track_done_d2;
reg track_done_d3;
reg track_done_d2_sp;// single pulse
always@(posedge mem_clk or negedge rst_n) begin
	if(!rst_n) begin
		track_done_d1 <= 1'd0;
		track_done_d2 <= 1'd0;	
		track_done_d3 <= 1'd0;	
    end
	else begin
		track_done_d1 <= track_done;
		track_done_d2 <= track_done_d1;
		track_done_d3 <= track_done_d2;
    end
end
assign track_done_d2_sp = track_done_d2 && (!track_done_d3);
reg[1:0] frame_addr; // frame_addr is locked addr
always@(posedge mem_clk or negedge rst_n) begin
	if(!rst_n) begin
		frame_addr <= 2'd0;
    end
	else if (track_done_d2_sp) begin
		case (frame_addr_d2)
			2'b00: frame_addr <= 2'b00;
			2'b01: frame_addr <= 2'b01;
			2'b11: frame_addr <= 2'b10;
			2'b10: frame_addr <= 2'b11;	
		endcase
    end
end
*/
endmodule
