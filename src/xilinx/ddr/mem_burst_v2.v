/*本模块完成对ddr2 IP的包装，方便后续模块使用，也方便程序的移植，如果更换平台，更新这个文件即可
*/
module mem_burst_v2
#(
	parameter MEM_DATA_BITS = 64,
	//parameter ADDR_BITS = 24
	parameter ADDR_BITS = 27
)
(
	input rst,                                 /*复位*/
	input mem_clk,                               /*接口时钟*/
	input rd_burst_req,                          /*读请求*/
	input wr_burst_req,                          /*写请求*/
	input[9:0] rd_burst_len,                     /*读数据长度*/
	input[9:0] wr_burst_len,                     /*写数据长度*/
	input[ADDR_BITS - 1:0] rd_burst_addr,        /*读首地址*/
	input[ADDR_BITS - 1:0] wr_burst_addr,        /*写首地址*/
	output rd_burst_data_valid,                  /*读出数据有效*/
	output wr_burst_data_req,                    /*写数据信号*/
	output[MEM_DATA_BITS - 1:0] rd_burst_data,   /*读出的数据*/
	input[MEM_DATA_BITS - 1:0] wr_burst_data,    /*写入的数据*/
	output rd_burst_finish,                      /*读完成*/
	output wr_burst_finish,                      /*写完成*/
	output burst_finish,                         /*读或写完成*/
	
	///////////////////
	input               calib_done,
	output				cmd_clk,
	output reg			cmd_en,
	output reg[2:0] 	cmd_instr,
	output reg[5:0]		cmd_bl,
	output reg[29:0]	cmd_byte_addr,
	input				cmd_empty,
	input				cmd_full,

	output				wr_clk,
	output  			wr_en,
	output[MEM_DATA_BITS/8-1:0]	wr_mask,
	output[MEM_DATA_BITS-1:0]	wr_data,
	input				wr_full,
	input				wr_empty,
	input[6:0]			wr_count,
	input				wr_underrun,
	input				wr_error,

	output				rd_clk,
	output  			rd_en,
	input[MEM_DATA_BITS-1:0]	rd_data,
	input				rd_full,
	input				rd_empty,
	input[6:0]			rd_count,
	input				rd_overflow,
	input				rd_error
);

assign wr_mask = {MEM_DATA_BITS/8{1'b0}};
assign cmd_clk = mem_clk;
assign wr_clk = mem_clk;
assign rd_clk = mem_clk;

localparam IDLE   =  'd0;
localparam READ_CMD   =  'd1;
localparam READ_DATA  =  'd2;
localparam WRITE_DATA = 'd3;
localparam WRITE_CMD = 'd4;
localparam WRITE_WAIT = 'd5;
localparam READ_END   = 'd6;
localparam WRITE_END   = 'd7;
localparam READ_CHEAK   = 'd8;
localparam WRITE_CHEAK   = 'd9;
reg[3:0] state;

reg data_req;
reg wr_en_tmp;
reg[MEM_DATA_BITS-1:0] rd_data_d0;
reg read_data_finish;
reg write_data_finish;
reg rd_en_d0;
reg[9:0] rd_data_cnt;
reg[9:0] wr_data_cnt;
reg[9:0] rd_data_remain;
reg[9:0] wr_data_remain;
reg[9:0] rd_burst_len_latch;
reg[9:0] wr_burst_len_latch;

assign wr_burst_data_req = ~wr_full & data_req;
assign wr_data = wr_burst_data;
assign wr_en = wr_en_tmp & ~wr_full;// & data_req;
assign rd_en = ~rd_empty;
assign rd_burst_data_valid = rd_en_d0;
assign rd_burst_finish = (state == READ_END);
assign wr_burst_finish = (state == WRITE_END);
assign burst_finish = rd_burst_finish | wr_burst_finish;
assign rd_burst_data = rd_data_d0;
always@(posedge mem_clk or posedge rst)
begin
	if(rst)
		wr_en_tmp <= 1'b0;
	else if(~wr_full)
		wr_en_tmp <= wr_burst_data_req;
end



always@(posedge mem_clk or posedge rst)
begin
	if(rst)
		data_req <= 1'b0;
	else if(state == WRITE_DATA)
		data_req <= 1'b1;
	else if(wr_burst_data_req && (wr_data_cnt == wr_burst_len - 'd1))
		data_req <= 1'b0;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
		rd_en_d0 <= 1'b0;
	else 
		rd_en_d0 <= rd_en;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
		rd_data_d0 <= {MEM_DATA_BITS{1'b0}};
	else 
		rd_data_d0 <= rd_data;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
		rd_data_cnt <= 10'd0;
	else if(state == READ_CMD)
		rd_data_cnt <= 10'd0;
	else if(rd_en_d0)
		rd_data_cnt <= rd_data_cnt + 10'd1;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
		wr_data_cnt <= 10'd0;
	else if(state == IDLE)
		wr_data_cnt <= 10'd0;
	else if(wr_burst_data_req)
		wr_data_cnt <= wr_data_cnt + 10'd1;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
		read_data_finish <= 1'd0;
	else if(state == READ_CMD)
		read_data_finish <= 1'd0;
	else if(rd_en_d0 && (rd_data_cnt == rd_burst_len_latch - 'd1))
		read_data_finish <= 1'd1;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
		write_data_finish <= 1'd0;
	else if(state == IDLE)
		write_data_finish <= 1'd0;
	else if(wr_en && (wr_data_cnt == wr_burst_len_latch - 'd1))
		write_data_finish <= 1'd1;
end

always@(posedge mem_clk or posedge rst)
begin
	if(rst)
	begin
		state <= IDLE;
		cmd_en <= 1'b0;
		cmd_instr <= 3'b000;
		cmd_bl <= 'd0;
		cmd_byte_addr <= 'd0;
		rd_data_remain <= 'd0;
		wr_data_remain <= 'd0;
		rd_burst_len_latch <= 10'd0;
		wr_burst_len_latch <= 10'd0;
	end
	else if(calib_done ===  1'b1)
	begin
		case(state)
			IDLE:
			begin
				if(!cmd_full && rd_burst_req)
				begin
					state <= READ_CMD;
					//cmd_byte_addr <= {rd_burst_addr,3'd0};
					cmd_byte_addr <= rd_burst_addr;
					rd_data_remain <= rd_burst_len;
					rd_burst_len_latch <= rd_burst_len;
				end
				else if(!cmd_full && wr_burst_req)
				begin
					state <= WRITE_DATA;
					//cmd_byte_addr <= {wr_burst_addr,3'd0};
					cmd_byte_addr <= wr_burst_addr;
					wr_data_remain <= wr_burst_len;
					wr_burst_len_latch <= wr_burst_len;
				end
			end
			READ_CMD:
			begin
				cmd_en <= 1'b1;
				cmd_instr <= 3'b001;
				if(rd_data_remain >= 64)
				begin
					cmd_bl <= 6'd63;
					rd_data_remain <= rd_data_remain - 'd64;
				end
				else
				begin
					cmd_bl <= rd_data_remain - 'd1;
					rd_data_remain <= 'd0;
				end
				state <= READ_CHEAK;	
			end
			READ_CHEAK:
			begin
				cmd_en <= 1'b0;
				cmd_byte_addr <= cmd_byte_addr + {26'd64,3'd0};
				if(rd_data_remain == 'd0)
				begin
					state <= READ_DATA;
				end
				else if(!cmd_full)
				begin
					state <= READ_CMD;
				end
			end
			READ_DATA:
			begin
				cmd_en <= 1'b0;
				if(read_data_finish)
				begin
					state <= READ_END;
				end
			end
			WRITE_DATA:
			begin
				state <= WRITE_CMD;
			end
			WRITE_CMD:
			begin
				cmd_en <= 1'b1;
				cmd_instr <= 3'b000;
				if(wr_data_remain >= 'd64)
				begin
					cmd_bl <= 6'd63;
					wr_data_remain <= wr_data_remain - 'd64;
				end
				else
				begin
					cmd_bl <= wr_data_remain - 'd1;
					wr_data_remain <= 'd0;
				end
				state <= WRITE_CHEAK;
			end
			WRITE_CHEAK:
			begin
				cmd_en <= 1'b0;
				cmd_byte_addr <= cmd_byte_addr + {26'd64,3'd0};
				if(wr_data_remain == 'd0)
				begin
					state <= WRITE_WAIT;
				end
				else if(!cmd_full)
				begin
					state <= WRITE_CMD;
				end
			end
			WRITE_WAIT:
			begin
				cmd_en <= 1'b0;
				if(write_data_finish)
					state <= WRITE_END;
			end
			READ_END:
			begin
				state <= IDLE;
			end
			WRITE_END:
			begin
				state <= IDLE;
			end
			default:
				state <= IDLE;
		endcase
	end
end
endmodule 