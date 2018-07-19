/////*模块将ddr2中的视频数据读出，主要完成读取地址的计算，位宽的转换，因为ddr2接口是64bit的，
//  而ddr2中的视频数据是16bit的。
////*/
//`include "define.v"

module vout_frame_buffer_ctrl
#(
	parameter MEM_DATA_BITS = 64,
	parameter WITDH_2K = 0
)
(
	input rst_n,                                      /////*复位*/
	input vout_clk,                                   /////*下级（缩放模块）的时钟*/
	input vout_vs,                                    /////*视频输出场同步*/
	input vout_rd_req,                                /////*视频输出数据读取请求*/
	output[15:0] vout_data,                           /////*视频输出读取的数据*/
	input[11:0] vout_width,                           /////*视频输出的宽度，指的是存在存储器内的视频宽度*/
	input[11:0] vout_height,                          /////*视频输出的高度*/
	output fifo_rdempty,//内部fifo快满
	input mem_clk,                                    /////*存储器接口时钟*/
	output reg rd_burst_req,                          /////*存储器接口读取请求*/
	output reg[9:0] rd_burst_len,                     /////*存储器接口读取长度*/
	//output reg[23:0] rd_burst_addr,                   /////*存储器接口读取首地址*/
	output reg[26:0] rd_burst_addr,                   /////*存储器接口读取首地址*/
	input rd_burst_data_valid,                        /////*存储器接口返回读取数据有效*/
	input[MEM_DATA_BITS - 1:0] rd_burst_data,         /////*存储器接口返回的读取数据*/
	input burst_finish,                               /////*本次读取完成*/
	input[11:0] wr_max_line,                          /////*辅助信号*/
	input[1:0] base_addr,                             /////*帧地址控制参数之一*/
	input[1:0] wr_frame_addr,                          /////*视频写入模块当前写入的地址*/
	//zclin 2016.12.30
	input s_wr_done
);
localparam BURST_LEN = 10'd128;                       /////*定义突发读取的长度，如果数据达不到这个长度则按数据实际长度读取 */
//localparam BURST_LEN = 10'd1024;                       /////*定义突发读取的长度，如果数据达不到这个长度则按数据实际长度读取 */
localparam BURST_IDLE = 3'd0;                         /////*读取控制状态机：空闲状态*/
localparam BURST_ONE_LINE_START = 3'd1;               /////*读取控制状态机：开始读取一行视频 */
localparam BURSTING = 3'd2;                           /////*读取控制状态机：正在完成一次突发读取 */
localparam BURST_END = 3'd3;                          /////*读取控制状态机：一次突发读取操作完成 */
localparam BURST_ONE_LINE_END = 3'd4;                 /////*读取控制状态机：一行视频数据读取完成*/
localparam WAIT = 3'd5;                               /////*读取控制状态机：辅助状态 */
reg[2:0] burst_state = 3'd0;                          /////*读取控制状态机：当前状态 */
reg[2:0] burst_state_next = 3'd0;                     /////*读取控制状态机：下一个状态 */
reg[11:0] burst_line = 12'd0;                         /////*本轮（每场一轮）已经读取的总行数 */
reg[9:0] byte_per_line = 10'd0;                       /////*由于视频数据是16bit，ddr2接口是64bit，需要字节对齐操作，这个寄存器用来计算每行视频换算为ddr2接口后的数据长度 *//////*如：视频宽度是200，换算后是50，视频宽度是199，换算后长度也是50，视频宽度是201，换算后长度是51*/
//reg[11:0] byte_per_line = 12'd0; // ry, 2016.11.7 1280/16bit=2560/8bit
reg[9:0] byte_per_line_at_vout_clk = 10'd0;           /////*同上*/
//reg[11:0] byte_per_line_at_vout_clk = 12'd0;           /////*同上*/
reg[9:0] remain_len = 10'd0;
//reg[11:0] remain_len = 12'd0;
reg[1:0] rd_frame_addr = 2'd0;                        /////*读取帧地址 */
wire[15:0] mem_buf_q;                                 
wire mem_buf_rd_req;                                  
reg mem_buf_rd_req_d0 = 1'b0;                         
wire mem_buf_rdempty;                                 
reg[11:0] rd_cnt = 12'd0;                             /////*每行已经读取的像素数，主要用来抛弃从ddr读取出来的无用数据，如：每行201个像素，读取ddr2长度是51，换算成16bit像素应该是204个，要抛弃3个*/
reg data_dirty = 1'd0;                                /////*也是用来抛弃多余数据，指示当前数据是不是多余的*/
reg data_dirty_flag = 1'd0;                           /////*也是用来抛弃多余数据，指示每行会不会有多余数据*/
reg frame_flag = 1'b0;                                /////*每一帧结束或下一帧开始的信号 ，判断VS（场同步）的上升沿或下降沿产生，这个信号往往用来复位状态机、FIFO，已经读取地址的变动*/
reg vout_vs_mem_clk_d0 = 1'b0;                    
reg vout_vs_mem_clk_d1 = 1'b0;                    
reg vout_vs_d0 = 1'b0;                            
reg vout_vs_d1 = 1'b0;                            
reg frame_flag_at_vout_clk = 1'b0;                
wire[7:0] wrusedw;                                
wire[8:0] fif0_8_16_wrusedw;                               
reg[11:0] wait_time = 12'd0;
//reg[21:0] wait_time = 22'd0;
reg data_fifo_full_d0;
assign mem_buf_rd_req = ~mem_buf_rdempty & ~data_fifo_full_d0;
wire[11:0] vout_width_rec_at_vout_clk;
assign vout_width_rec_at_vout_clk = {1'b0,byte_per_line_at_vout_clk,1'd0};
reg data_fifo_full;

reg mem_rd_buf_wren = 1'b0;

/////*从ddr2读取数据后放入一个64bit写，16bit读的fifo*/

`ifdef Xilinx
fifo_256_64i_16o vout_frame_buffer_ctrlfifo_256_64i_16o_m0(
	.rst(frame_flag),
	.wr_clk(mem_clk),
	.rd_clk(vout_clk),
	.din(rd_burst_data),
	.wr_en(rd_burst_data_valid && mem_rd_buf_wren),
	.rd_en(mem_buf_rd_req),
	.dout(mem_buf_q),
	.full(),
	.empty(mem_buf_rdempty),
	.rd_data_count(),
	.wr_data_count(wrusedw)
);
`else
fifo_256_64i_16o vout_frame_buffer_ctrlfifo_256_64i_16o_m0(
	.aclr(frame_flag),
	.data(rd_burst_data),
	.rdclk(vout_clk),
	.rdreq(mem_buf_rd_req),
	.wrclk(mem_clk),
	.wrreq(rd_burst_data_valid && mem_rd_buf_wren),
	.q(mem_buf_q),
	.rdempty(mem_buf_rdempty),
	.rdusedw(),
	.wrfull(),
	.wrusedw(wrusedw));
`endif
/////*如果有多余数据产生，将多余数据去除后写入fifo*/
lite_fifo#
(
	.COMMON_CLOCK(1),
	.ADDR_WIDTH(8),
	.DATA_WIDTH(16)
)  vout_frame_buffer_ctrl_fifo_256_16_m1(
	.aclr(frame_flag),
	.data(mem_buf_q),
	.rdclk(vout_clk),
	.rdreq(vout_rd_req),
	.wrclk(vout_clk),
	.wrreq(mem_buf_rd_req_d0 && ~data_dirty),
	.q(vout_data),
	.rdempty(fifo_rdempty),
	.rdusedw(),
	.wrfull(),
	.wrusedw(fif0_8_16_wrusedw)); 
	
always@(posedge vout_clk)
begin
	mem_buf_rd_req_d0 <= mem_buf_rd_req;
	data_fifo_full <= (fif0_8_16_wrusedw > 240);/////*fifo快满产生*/
	data_fifo_full_d0 <= data_fifo_full;
end
always@(posedge vout_clk)
begin
	vout_vs_d0 <= vout_vs;
	vout_vs_d1 <= vout_vs_d0;
	frame_flag_at_vout_clk <= vout_vs_d0 && ~vout_vs_d1;
end

///////计算每行像素数换算成ddr接口的长度
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		byte_per_line <= 10'd0;
	else if(frame_flag)
		if(vout_width[1:0] == 2'd0)
			byte_per_line <= vout_width[11:2];
		else
			byte_per_line <= vout_width[11:2] + 10'd1;
	else
		byte_per_line <= byte_per_line;
end

///////计算每行像素数换算成ddr接口的长度
always@(posedge vout_clk or negedge rst_n)
begin
	if(!rst_n)
		byte_per_line_at_vout_clk <= 10'd0;
	else if(frame_flag_at_vout_clk)
		if(vout_width[1:0] == 2'd0)//判断宽度是否能被4整除
			byte_per_line_at_vout_clk <= vout_width[11:2];
		else
			byte_per_line_at_vout_clk <= vout_width[11:2] + 10'd1;
	else
		byte_per_line_at_vout_clk <= byte_per_line_at_vout_clk;
end
/////*判断会不会有多余的数据*/
always@(posedge vout_clk or negedge rst_n)
begin
	if(!rst_n)
		data_dirty <= 1'd0;
	else if(frame_flag_at_vout_clk || ~data_dirty_flag)
		data_dirty <= 1'd0;
	else if(mem_buf_rd_req_d0)
		if(rd_cnt == vout_width_rec_at_vout_clk - 12'd1)
			data_dirty <= 1'd0;
		else if(rd_cnt == vout_width - 12'd1)
			data_dirty <= 1'd1;
	else
		data_dirty <= data_dirty;
end
/////*ddr2读取首地址计算，需要注意的是视频并不是连续读取的，而是按照“行”为单元存取*/
/*突发写首地址的产生*/
//wire[23:0] ddr_rd_base;
wire[26:0] ddr_rd_base;
generate
	if(WITDH_2K)
		//assign ddr_rd_base = {base_addr,rd_frame_addr[1:0],burst_line[10:0],9'd0};//24bit ddr addr
		assign ddr_rd_base = {base_addr,rd_frame_addr[1:0],burst_line[10:0],9'd0,3'd0};//24bit ddr addr
	else
		//assign ddr_rd_base = {2'b00,base_addr,rd_frame_addr[1:0],burst_line[9:0],8'd0};
		assign ddr_rd_base = {2'b00,base_addr,rd_frame_addr[1:0],burst_line[9:0],8'd0,3'd0};
endgenerate
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		//rd_burst_addr <= 24'd0;
		rd_burst_addr <= 27'd0;
	else if(burst_state_next == BURST_ONE_LINE_START)
		rd_burst_addr <= ddr_rd_base;
	else if(burst_state_next == BURST_END && burst_state != BURST_END)
		//rd_burst_addr <= rd_burst_addr + {16'd0,BURST_LEN[8:0]};
		rd_burst_addr <= rd_burst_addr + {15'd0,BURST_LEN[8:0],3'd0};
	else
		rd_burst_addr <= rd_burst_addr;
end	




///*判断会不会有多余的数据*/
always@(posedge vout_clk)
begin
	data_dirty_flag <= (vout_width[0] != 1'd0);
end
///*计算已经读取像素数，以“行”为单元，每行都重新开始*/
always@(posedge vout_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_cnt <= 12'd0;
	else if(frame_flag_at_vout_clk)///////////////////////////////////
		rd_cnt <= 12'd0;
	else if(mem_buf_rd_req_d0)
		if(rd_cnt == vout_width_rec_at_vout_clk - 12'd1)
			rd_cnt <= 12'd0;
		else
			rd_cnt <= rd_cnt + 12'd1;
	else
		rd_cnt <= rd_cnt;
end


/////////////////////////////////////////////////////

always@(posedge mem_clk)
begin
	vout_vs_mem_clk_d0 <= vout_vs;
	vout_vs_mem_clk_d1 <= vout_vs_mem_clk_d0;
	frame_flag <= vout_vs_mem_clk_d0 && ~vout_vs_mem_clk_d1;
end
always@(posedge mem_clk or posedge frame_flag)
begin
	if(frame_flag)
		mem_rd_buf_wren <= 1'b0;
	else if(burst_state == BURST_IDLE)
		mem_rd_buf_wren <= 1'b1;
	else
		mem_rd_buf_wren <= mem_rd_buf_wren;
end
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_state <= BURST_IDLE;
	else if(frame_flag)
		burst_state <= WAIT;
	else
		burst_state <= burst_state_next;
end
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wait_time <= 12'd0;
		//wait_time <= 22'd0;
	else if(frame_flag)
		wait_time <= 12'd0;
		//wait_time <= 22'd0;
	else if(burst_state == WAIT)
		wait_time <= wait_time + 12'd1;
		//wait_time <= wait_time + 22'd1;
	else
		wait_time <= 12'd0;
		//wait_time <= 22'd0;
end


always@(*)
begin
	case(burst_state)
		WAIT: ///*每帧数据处理前等待一段时间*/
			if(wait_time > 12'd2000)
				burst_state_next <= BURST_IDLE;
			else
				burst_state_next <= WAIT;
		BURST_IDLE:///*如果fifo空间够写入一次突然地数据，就完成一行数据的第一次突发*/
			if(wrusedw < 8'hff - BURST_LEN[7:0])///*判断fifo空间*/
				burst_state_next <= BURST_ONE_LINE_START;
			else
				burst_state_next <= BURST_IDLE;
		BURST_ONE_LINE_START:
			burst_state_next <= BURSTING;
		BURSTING:///*完成一次突发读操作*/
			if(burst_finish)
				burst_state_next <= BURST_END;
			else
				burst_state_next <= BURSTING;
		BURST_END:
			if(remain_len == 10'd0)///*判断一行数据是否读完，没有读完则等待fifo以完成下次读*/
				burst_state_next <= BURST_ONE_LINE_END;
			else if(wrusedw < 8'hff - BURST_LEN[7:0])///*判断fifo空间*/
				burst_state_next <= BURSTING;
			else
				burst_state_next <= BURST_END;
		BURST_ONE_LINE_END:///*完成一行数据的读取*/
				burst_state_next <= BURST_IDLE;
		default:
			burst_state_next <= BURST_IDLE;
	endcase
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_line <= 12'd0;
	else if(frame_flag)
		burst_line <= 12'd0;
	else if(burst_state_next == BURST_ONE_LINE_END && burst_state == BURST_END)
		burst_line <= burst_line + 12'd1;///*每次完成一行数据的读取burst_line加1*/
	else
		burst_line <= burst_line;
end

//always@(posedge mem_clk or negedge rst_n)
//begin
//	if(!rst_n)
//		rd_frame_addr <= 2'd0;
//	else if(frame_flag)
//		rd_frame_addr <= wr_frame_addr - 2'd2;///*读地址更随写地址*/ // ry, wr_frame_addr = frame_addr
//	else
//		rd_frame_addr <= rd_frame_addr;
//end	
//2016.12.30 zclin
reg [1:0] rd_frame_addr_d0;
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_frame_addr_d0 <= 0;
	else if(s_wr_done)
		rd_frame_addr_d0 <= wr_frame_addr;
	else
		rd_frame_addr_d0 <= rd_frame_addr_d0;
end
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_frame_addr <= 0;
	else if(frame_flag)
		rd_frame_addr <= rd_frame_addr_d0;
	else
		rd_frame_addr <= rd_frame_addr;
end
///*计算每行剩余数据*/
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

///*计算突发读取的长度*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_burst_len <= 10'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		if(remain_len > BURST_LEN)
			rd_burst_len <= BURST_LEN;
		else
			rd_burst_len <= remain_len;
	else
		rd_burst_len <=  rd_burst_len;
end

///*读请求信号的发出与撤销*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_burst_req <= 1'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		rd_burst_req <= 1'b1;
	else if(burst_finish || burst_state == BURST_IDLE || rd_burst_data_valid )
		rd_burst_req <= 1'b0;
	else
		rd_burst_req <= rd_burst_req; 
end

endmodule 