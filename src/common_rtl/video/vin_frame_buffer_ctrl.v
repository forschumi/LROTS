`timescale 1ps/1ps
/*
模块完成16bit的YC数据的64bit的数据对齐，然后写入FIFO，
有帧写入状态机完成64bit数据写入ddr2
*/
module vin_frame_buffer_ctrl
 #(
	parameter MEM_DATA_BITS = 64,
	parameter INTERLACE = 1
) 
(
	input rst_n,                                    /*复位 */
	input vin_clk,                                  /*视频输入时钟 */
	input vin_vs,                                   /*视频输入场同步 */
	input vin_f,                                    /*视频输入奇偶场标志 */
	input vin_de,                                   /*视频输入数据有效 */
	input[15:0] vin_data,                           /*视频输入数据YC */
	input[11:0] vin_width,                          /*视频输入宽度*/
	input[11:0] vin_height,                         /*视频输入高度*/
	output reg fifo_afull,                          /*输入fifo快满*/
	input mem_clk,                                  /*存储器接口：时钟*/
	output reg wr_burst_req,                        /*存储器接口：写请求*/
	output reg[9:0] wr_burst_len,                   /*存储器接口：写长度*/
	//output reg[23:0] wr_burst_addr,                 /*存储器接口：写首地址 */
	output reg[26:0] wr_burst_addr,                 /*存储器接口：写首地址 */
	input wr_burst_data_req,                        /*存储器接口：写数据数据读指示 */
	output[MEM_DATA_BITS - 1:0] wr_burst_data,      /*存储器接口：写数据*/
	input burst_finish,                             /*存储器接口：本次写完成 */
	output reg[11:0] wr_max_line,                   /*辅助信号，测试用 */
	input[1:0] base_addr,                           /*帧地址参数*/
	output reg[1:0] frame_addr                      /*当前写入帧地址*/
);                                                   
initial                                              
begin
	frame_addr <= 2'd0;
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
 /*由于视频数据是16bit，ddr2接口是64bit，需要字节对齐操作，这个寄存器用来计算每行视频换算为ddr2接口后的数据长度 */
 /*如：视频宽度是200，换算后是50，视频宽度是199，换算后长度也是50，视频宽度是201，换算后长度是51*/
reg[9:0] remain_len = 10'd0;/*当前视频一行数据的剩余数据个数*/
wire[MEM_DATA_BITS - 1:0] data;/*待写入fifo的数据，由pixel0，pixel1，pixel2，pixel3拼接而来*/
reg[15:0] pixel0 = 16'd0;
reg[15:0] pixel1 = 16'd0;
reg[15:0] pixel2 = 16'd0;
reg[15:0] pixel3 = 16'd0;
reg[11:0] data_cnt  = 12'd0;
reg vin_vs_mem_clk_d0 = 1'b0;
reg vin_vs_mem_clk_d1 = 1'b0;
reg vin_vs_d0 = 1'b0;
reg vin_vs_d1 = 1'b0;
reg frame_flag = 1'b0;
reg frame_flag_vin = 1'b0;
reg fifo_wr_req = 1'b0;
wire[7:0] rdusedw;
wire[7:0] wrusedw;
always@(posedge vin_clk)
begin
	fifo_afull <= (wrusedw > 8'd245);
end
/*待写入fifo的数据，由pixel0，pixel1，pixel2，pixel3拼接而来*/
`ifdef Xilinx
assign data = {pixel0,pixel1,pixel2,pixel3};
`else
assign data = {pixel3,pixel2,pixel1,pixel0};
`endif
lite_fifo#
(
	.COMMON_CLOCK(0),
	.ADDR_WIDTH(8),
	.DATA_WIDTH(64)
)  vin_frame_buffer_ctrl_fifo_m0(
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
	vin_vs_d0 <= vin_vs;
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
	else if(vin_de)
		begin
			if(data_cnt == vin_width - 12'd1)
				data_cnt <= 12'd0;
			else
				data_cnt <= data_cnt + 12'd1;
		end
	else
		data_cnt <= data_cnt;
end
/*当data_cnt[1:0] == 0 时，pixel0取当前像素值*/
always@(posedge vin_clk)
begin
	if(vin_de && (data_cnt[1:0] == 2'd0))
		pixel0 <= vin_data;
	else
		pixel0 <= pixel0;		
end
/*当data_cnt[1:0] == 1 时，pixel1取当前像素值*/
always@(posedge vin_clk)
begin
	if(vin_de && (data_cnt[1:0] == 2'd1))
		pixel1 <= vin_data;
	else
		pixel1 <= pixel1;		
end
/*当data_cnt[1:0] == 2 时，pixel2取当前像素值*/
always@(posedge vin_clk)
begin
	if(vin_de && (data_cnt[1:0] == 2'd2))
		pixel2 <= vin_data;
	else
		pixel2 <= pixel2;
end
/*当data_cnt[1:0] == 3 时，pixel3取当前像素值*/
always@(posedge vin_clk)
begin
	if(vin_de && (data_cnt[1:0] == 2'd3))
		pixel3 <= vin_data;
	else
		pixel3 <= pixel3;
end
/*当data_cnt[1:0] == 3 时，pixel0，pixel1，pixel2，pixel3都有值，可拼接为一个64bit，完成一次写入FIFO操作*/
always@(posedge vin_clk)
begin
	if(vin_de &&(data_cnt[1:0] == 2'd3 || data_cnt == vin_width - 12'd1))
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
		if(vin_width[1:0] == 2'd0)
			byte_per_line <= vin_width[11:2];
		else
			byte_per_line <= vin_width[11:2] + 10'd1;
	else
		byte_per_line <= byte_per_line;
end
/*突发写首地址的产生*/
//wire[23:0] ddr_wr_base;
wire[26:0] ddr_wr_base;
generate
	if(INTERLACE)
		//assign ddr_wr_base = {1'b0,base_addr,frame_addr[1:0],burst_line[8:0],vin_f,8'd0};//24bit ddr addr
		assign ddr_wr_base = {1'b0,base_addr,frame_addr[1:0],burst_line[9:0],vin_f,8'd0,3'd0};//24bit ddr addr
	else
		//assign ddr_wr_base =  {base_addr,frame_addr[1:0],burst_line[10:0],9'd0};//24bit ddr addr
		assign ddr_wr_base =  {base_addr,frame_addr[1:0],burst_line[10:0],9'd0,3'd0};//24bit ddr addr
endgenerate	
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		//wr_burst_addr <= 24'd0;
		wr_burst_addr <= 27'd0;
	else if(burst_state_next == BURST_ONE_LINE_START)
		wr_burst_addr <= ddr_wr_base;
	else if(burst_state_next == BURST_END  && burst_state != BURST_END)
		wr_burst_addr <= wr_burst_addr + {15'd0,BURST_LEN[8:0],3'd0};
	else
		wr_burst_addr <= wr_burst_addr;
end

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
always@(*)
begin
	case(burst_state)
		BURST_IDLE:/*如果FIFO有足够的数据则完成一行第一次写操作*/
			if(rdusedw > BURST_LEN[7:0])
				burst_state_next <= BURST_ONE_LINE_START;
			else
				burst_state_next <= BURST_IDLE;
		BURST_ONE_LINE_START:/*一行的写操作开始*/
			burst_state_next <= BURSTING;
		BURSTING:/*写操作*/
			if(burst_finish)
				burst_state_next <= BURST_END;
			else
				burst_state_next <= BURSTING;
		BURST_END:/*写操作完成时判断一行数据是否已经完全写入ddr2，如果完成则进入空闲状态，等待第二行数据*/
			if(remain_len == 10'd0)
				burst_state_next <= BURST_ONE_LINE_END;
			else if((rdusedw >= BURST_LEN[7:0]) || (remain_len <= BURST_LEN && rdusedw >= remain_len - 10'd1))
				burst_state_next <= BURSTING;
			else
				burst_state_next <= BURST_END;
		BURST_ONE_LINE_END:
			burst_state_next <= BURST_IDLE;
		default:
			burst_state_next <= BURST_IDLE;
	endcase
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_max_line <= 12'd0;
	else if(frame_flag)
		wr_max_line <= burst_line;
	else
		wr_max_line <= wr_max_line;
end
/*burst_line产生*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_line <= 12'd0;
	else if(frame_flag)
		burst_line <= 12'd0;
	else if(burst_state == BURST_ONE_LINE_END)//每次一行写完burst_line加1
		burst_line <= burst_line + 12'd1;
	else
		burst_line <= burst_line;
end
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		frame_addr <= 2'd0;
	else if(frame_flag && vin_f)//没写入一帧数据frame_addr加1
	//else if(frame_flag)
		frame_addr <= frame_addr + 2'd1;
	else
		frame_addr <= frame_addr;
end	

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
	else
		wr_burst_req <= wr_burst_req;
end

endmodule 