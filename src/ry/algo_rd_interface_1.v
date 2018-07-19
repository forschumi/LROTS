`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:47:07 10/29/2016 
// Design Name: 
// Module Name:    algo_rd_interface 
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
module algo_rd_interface(
    input rst_n,
	input mem_clk,
	input vout_clk,
	input vin_vs,
	output reg rd_burst_req,
	output reg[9:0] rd_burst_len, 
	output reg[26:0] rd_burst_addr, // byte
	input rd_burst_data_valid,
	input[63:0] rd_burst_data,
	output  reg [7:0] vout_data,
	input burst_finish,             // ddr
	input [32:0]cmd_data_in,
	input cmd_wr_en,
	input data_rd_en,
	output cmd_fifo_afull,
	output data_fifo_aempty,
	input[1:0] frame_addr,
	input cmos_href,
	input vin_clk,
	output start
    );
parameter BURST_LEN = 11'd128;
parameter BURST_IDLE = 3'd0;                /////*读取控制状态机：空闲状态*/
parameter BURST_START = 3'd1;               /////*读取控制状态机：开始读取 */
parameter BURSTING = 3'd2;                  /////*读取控制状态机：正在完成一次突发读取 */
parameter BURST_END = 3'd3;                 /////*读取控制状态机：一次突发读取操作完成 */
parameter BURST_ONE_LINE_END = 3'd4;
reg[2:0] burst_state;
reg[2:0] burst_state_next;
reg[9:0] remain_len;
wire[10:0] burst_len;                // 8bit
reg[10:0] burst_len_cnt;
wire[10:0] algo_xaddr;
wire[10:0] algo_yaddr;
wire data_fifo_afull;
reg frame_flag = 1'b0; //帧起始
//reg data_fifo_full_d0;
reg initial_rd;
wire[32:0] cmd_data_out;
wire cmd_rd_en;
wire cmd_fifo_aempty;
 //矩形框开始写入ddr标志
reg vin_vs_mem_clk_d0 = 1'b0;
reg vin_vs_mem_clk_d1 = 1'b0;
reg [9:0] href_cnt;
reg cmos_href_d1, cmos_href_d2;
wire cmos_href_pulse;
/*frame_flag产生*/
always@(posedge mem_clk)
begin
	vin_vs_mem_clk_d0 <= vin_vs;
	vin_vs_mem_clk_d1 <= vin_vs_mem_clk_d0;
	frame_flag <= vin_vs_mem_clk_d0 && ~vin_vs_mem_clk_d1;
end
always@(posedge vin_clk or negedge rst_n)
    if(!rst_n) begin
	   cmos_href_d1 <= 1'b0;
	   cmos_href_d2 <= 1'b0;
	end
	else begin
	   cmos_href_d1 <= cmos_href;
	   cmos_href_d2 <= cmos_href_d1;
	end
assign cmos_href_pulse = cmos_href_d1 && (!cmos_href_d2);
always@(posedge vin_clk or negedge rst_n)
begin
   if(!rst_n)
	   href_cnt <= 10'd0;
	else if(frame_flag)
	   href_cnt <= 10'd0;
   else if (cmos_href_pulse && href_cnt < 10'd720)
	   href_cnt <= href_cnt + 10'd1;
	else
	   href_cnt <= href_cnt;
end
//assign start = (href_cnt == 10'd720) && vin_vs_mem_clk_d0 && ~vin_vs_mem_clk_d1;
/////////////////////////////////////////////////////////////////////////
//2016.12.07
wire start_1;
reg start_d1_1;
reg start_d2_1;
reg start_d1_2;
reg start_d2_2;
assign start_1 = (href_cnt == 10'd720) && vin_vs_mem_clk_d0 && ~vin_vs_mem_clk_d1;
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			start_d1_1 <= 0;
			start_d2_1 <= 0;
		end
	else if(start_1)
		begin
			start_d1_1 <= 1;
			start_d2_1 <= start_d1_1;
		end
	else if(start_d2_1)
		begin
			start_d1_1 <= 0;
			start_d2_1 <= start_d1_1;
		end
	else
		begin
			start_d1_1 <= start_d1_1;
			start_d2_1 <= start_d1_1;
		end
end
always@(posedge vout_clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			start_d1_2 <= 0;
			start_d2_2 <= 0;
		end
	else if(start_d1_1 || start_d2_1)
		begin
			start_d1_2 <= 1;
			start_d2_2 <= start_d1_2;
		end
	else
		begin	
			start_d1_2 <= 0;
			start_d2_2 <= start_d1_2;
		end
end
assign start = ~start_d2_2 & start_d1_2;
/////////////////////////////////////////////////
			
assign cmd_rd_en = (!data_fifo_afull && !cmd_fifo_aempty && burst_state == BURST_IDLE);
//assign cmd_rd_en = (!data_fifo_afull && !cmd_fifo_aempty && burst_state == BURST_START);
/* reg [1:0] rd_burst_data_valid_shift;
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_burst_data_valid_shift <= 2'b0;
	else
		rd_burst_data_valid_shift <={rd_burst_data_valid_shift[0],rd_burst_data_valid};
end
assign cmd_rd_en = ~rd_burst_data_valid_shift[1] & rd_burst_data_valid_shift[0]; */

/*算法命令fifo*/
fifo_512_33i_33o cmd_fifo(
	.rst(rst_n),
	.wr_clk(vout_clk),
	.rd_clk(mem_clk),
	.din(cmd_data_in),
	.wr_en(cmd_wr_en),
	.rd_en(cmd_rd_en),
	.dout(cmd_data_out),
	.full(),
	.almost_full(),
	.empty(cmd_fifo_aempty),
	.almost_empty(),
	.rd_data_count(),
	.wr_data_count(),
	.prog_full(cmd_fifo_afull),
    .prog_empty()
);
wire [18:0] fifo_in;
wire [18:0] fifo_out;
assign fifo_in = {burst_len[10:0],rd_burst_data[56],rd_burst_data[48],rd_burst_data[40],rd_burst_data[32],rd_burst_data[24],rd_burst_data[16],rd_burst_data[8],rd_burst_data[0]};
reg mem_rd_buf_wren = 1'b0;
always@(posedge mem_clk or posedge frame_flag)
begin
	if(frame_flag)
		mem_rd_buf_wren <= 1'b0;
	else if(burst_state == BURST_IDLE)
		mem_rd_buf_wren <= 1'b1;
	else
		mem_rd_buf_wren <= mem_rd_buf_wren;
end
/* reg data_wr_en;
always@(posedge mem_clk or negedge rst_n) begin
    if(!rst_n)
        data_wr_en <= 1'b0;
    else
        data_wr_en <= (rd_burst_data_valid && mem_rd_buf_wren);
end */
/*从ddr2读取数据后放入一个19bit写，19bit读的fifo*/
fifo_512_19i_19o data_fifo(
    .rst(rst_n),
    .wr_clk(mem_clk),
	.rd_clk(vout_clk),
    .din(fifo_in),
    .wr_en(rd_burst_data_valid && mem_rd_buf_wren),
    .rd_en(data_rd_en), 
    .dout(fifo_out),
    .full(),
    .almost_full(),
    .empty(),
    .almost_empty(),
    .rd_data_count(),
    .wr_data_count(),
    .prog_full(data_fifo_afull),
    .prog_empty(data_fifo_aempty)
);
///////////////////////////////////////////////////
//zc//2016.11.26
/* reg data_rd_en_reg;
always@(posedge vout_clk or negedge rst_n)
begin
	if(!rst_n)
		data_rd_en_reg <= 0;
	else
		data_rd_en_reg <= data_rd_en;
end */
///////////////////////////////////////////////////////////
//assign vout_data = data_rd_en_reg ? fifo_out[7:0] : 8'd0;
///////////////////////////////////////////////////////////
//assign vout_data = fifo_out[7:0];
/* always@(posedge vout_clk or negedge rst_n) begin
    if(!rst_n)
	    vout_data <= 8'd0;
	else
	    vout_data <= fifo_out[7:0];
end */

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
		BURST_IDLE: // 0
			if(!cmd_fifo_aempty && !data_fifo_afull)
				burst_state_next <= BURST_START;
			else
				burst_state_next <= BURST_IDLE;
		BURST_START: // 1
			burst_state_next <= BURSTING;
		BURSTING: // 2
			if(burst_finish)
				burst_state_next <= BURST_END;
			else
				burst_state_next <= BURSTING;
		BURST_END: // 3
			if(remain_len == 10'd0)///*判断一行数据是否读完，没有读完则等待fifo以完成下次读*/
				burst_state_next <= BURST_ONE_LINE_END;
			else if(!cmd_fifo_aempty && !data_fifo_afull)///*判断fifo空间*/
				burst_state_next <= BURSTING;
			else
				burst_state_next <= BURST_END;
		BURST_ONE_LINE_END: // 4
				burst_state_next <= BURST_IDLE;
		default:
			    burst_state_next <= BURST_IDLE;
	endcase
end

/*突发写首地址的产生*/
/* always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n) begin
		algo_xaddr <= 11'd0;
		algo_yaddr <= 11'd0;
	end
	else begin
		algo_xaddr <= cmd_data_out[32:22];
		algo_yaddr <= cmd_data_out[21:11];
	end
end */
assign algo_yaddr = cmd_data_out[32:22];
assign algo_xaddr = cmd_data_out[21:11];
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_burst_addr <= 27'd0;
	else if(burst_state == BURST_START)
		rd_burst_addr <= {1'b1,2'd0,frame_addr[1:0],algo_xaddr[10:0],algo_yaddr[10:0]};
	else if(burst_state_next == BURST_END && burst_state != BURST_END)
		rd_burst_addr <= rd_burst_addr + {15'd0,BURST_LEN[8:0],3'd0};
	else
	    rd_burst_addr <= rd_burst_addr;
end
/*算法一次burst剩余数据*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		remain_len <= 10'd0;
	else if(burst_state == BURST_START && burst_len[2:0] == 3'd0) 
		remain_len <= burst_len[10:3]; 
	else if(burst_state == BURST_START && burst_len[2:0] != 3'd0)
		remain_len <= burst_len[10:3] + 10'd1;
	else if(burst_state_next == BURST_END && burst_state != BURST_END)
		if(remain_len < BURST_LEN)
			remain_len <= 10'd0;
		else
			remain_len <= remain_len - BURST_LEN;	
	else
		remain_len <= remain_len;
end

assign burst_len = cmd_data_out[10:0];
reg[2:0] burst_state_d1;
always@(posedge mem_clk or negedge rst_n)
	if(!rst_n)
		burst_state_d1 <= 3'd0;
	else
	    burst_state_d1 <= burst_state;
/*计算突发读取的长度*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_burst_len <= 10'd0;
	else if(burst_state == BURSTING && burst_state_d1 != BURSTING)
		if(remain_len > BURST_LEN)
			rd_burst_len <= BURST_LEN;
		else
			rd_burst_len <= remain_len;
	else
		rd_burst_len <=  rd_burst_len;
end
/*DDR读请求信号的发出与撤销*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_burst_req <= 1'd0;
	else if(burst_state == BURSTING && burst_state_d1 != BURSTING)
		rd_burst_req <= 1'b1;
	else if(burst_finish || burst_state == BURST_IDLE || rd_burst_data_valid )
		rd_burst_req <= 1'b0;
	else
		rd_burst_req <= rd_burst_req; 
end
always@(posedge vout_clk or negedge rst_n)
begin
   if(!rst_n)
      burst_len_cnt <= 11'd0;
   else if(burst_finish)
      burst_len_cnt <= 11'd0;
   else if(burst_len_cnt != burst_len - 1'd1)
      burst_len_cnt <= burst_len_cnt + 1'd1; 
end 

reg rd_en_d1;
always @ (posedge vout_clk or negedge rst_n) begin
    if(!rst_n)
        rd_en_d1 <= 1'b0;
	else
		rd_en_d1 <= data_rd_en;
end 
/*只在复位后读了一下，以后再也不读*/
always @ (posedge vout_clk or negedge rst_n)
begin
    if(!rst_n)
        initial_rd <= 1'b0;
	else if (data_rd_en)
	    initial_rd <= 1'b1;
end

always@(*)
begin
    if((burst_len_cnt == burst_len[10:3] + 1'b1) && (burst_len[2:0] != 3'b0) && rd_en_d1) begin
        case (burst_len[2:0])
            3'd1: vout_data = {7'b0,fifo_out[0]};
			3'd2: vout_data = {6'b0,fifo_out[1:0]};
			3'd3: vout_data = {5'b0,fifo_out[2:0]};
			3'd4: vout_data = {4'b0,fifo_out[3:0]};
			3'd5: vout_data = {3'b0,fifo_out[4:0]};
			3'd6: vout_data = {2'b0,fifo_out[5:0]};
		 default: vout_data = {1'b0,fifo_out[6:0]};
	    endcase
    end
    else if (rd_en_d1)
        vout_data = fifo_out[7:0];
	else
		vout_data = 8'd0;
end

endmodule
