/**************************************************************************\
视频缩放模块，采用双线性插值算法
主要思路是先将数据写入2个线（一行）缓存中，在写入的同时插值计算，先进行垂直插值
然后进行水平插值，由于算法相对复杂点，在处理流水线操作时很多环节都是凑数据，所
以现在的程序已经不能讲解的很清楚了，只能说说大致的思路，详细的算法可参考Altera的
VIP开发IP的datasheet。
//*************************************************************************/
 
`timescale 1ps/1ps
module scaler
#(
	parameter WITDH_2K = 0
)
(
	input sys_clk,                  /*系统时钟*/
	input rst_n,                    /*复位 */
	input fifo_aempty,              /*前端fifo空 */
	output  rd_req,                 /*读取前端数据 */
	input[15:0] yc_data_in,         /*前端数据输入 */
	input frame_flag,               /*帧开始或帧结束信号 */
	input fifo_afull,               /*后端fifo快满 */
	output wr_req,                  /*写后端fifo */
	output[15:0] yc_data_out,       /*写后端fifo数据 */
	input[11:0] s_width,            /*缩放前视频的宽度*/
	input[11:0] s_height,           /*缩放前视频的高度*/
	input[11:0] t_width,            /*缩放后视频的宽度*/
	input[11:0] t_height,           /*缩放后视频的高度 */
	input[15:0] K_h,                /*水平缩放系数 = s_width * 256 / t_width*/
	input[15:0] K_v                 /*垂直缩放系数 = s_height * 256 / t_height*/
);
reg[15:0] K_h_reg;
reg[15:0] K_v_reg;
reg[3:0] wr_state;
reg[3:0] wr_state_next;
reg[3:0] scale_state;
reg[3:0] scale_state_next;
reg[11:0] wr_cnt;
reg rd_req_d0;
reg rd_req_en;
wire[10:0] wr_buf_addr;
wire wr_buf_en;
reg wr_buf_sel = 1'b0;
wire[10:0] rd_buf_addr;
wire rd_buf_req;
parameter WR_IDLE = 4'd0;
parameter WR_LINE_END = 4'd1;
parameter WR_LINE_BUF = 4'd2;
parameter WR_NEXT_LINE = 4'd3;
parameter SCL_IDLE = 4'd0;
parameter SCL_LINE_START = 4'd1;
parameter SCL_LINE = 4'd2;
parameter SCL_LINE_END = 4'd3;
parameter SCL_FINISH = 4'd4;
wire one_line_finish;
wire one_line_req_end;
reg one_line_req_end_d0;
reg one_line_req_end_d1;
reg one_line_req_end_d2;
reg one_line_req_end_d3;
reg one_line_req_end_d4;

wire rd_not_need_data;
reg[11:0] wr_lines;
reg[19:0] scale_map_line;
reg[11:0] scale_line;
wire line_data_is_ready;
wire[23:0] line_buf_q0;
wire[23:0] line_buf_q1;

reg[3:0] rd_pixel_state;/*数据读取状态机*/
reg[3:0] rd_pixel_state_next;
parameter RD_PIXEL_IDLE = 4'd0;
parameter RD_PIXEL_READ = 4'd1;
parameter RD_PIXEL_WAIT = 4'd2;
parameter RD_PIXEL_END = 4'd3;
wire pixel_data_update_en;
reg[19:0] map_col;
wire[19:0] map_col_next;
reg[3:0] col_calu_state;/*数据插值状态机*/
reg[3:0] col_calu_state_next;
reg[11:0] scale_col;
parameter COL_CALU_IDLE = 4'd0;
parameter COL_CALU_WAIT = 4'd1;
parameter COL_CALU = 4'd2;
parameter COL_END = 4'd3;
reg[23:0] line0_pixel_data;
reg[23:0] line1_pixel_data;
reg[23:0] pixel_data0;
reg[23:0] pixel_data1;
wire data_en_out_calu_V;
wire[23:0] c_V;
reg[11:0] rd_col;
wire scale_line_finish;
reg rd_buf_req_d0;//读出数据有效
reg rd_buf_req_d1;//buffer mux 数据有效
wire source_line_end;
wire col_calu_state_idle;
reg col_calu_state_idle_d0;
reg[7:0] a_coff_H;
reg[7:0] b_coff_H;
reg[7:0] a_coff_H_d0;
reg[7:0] b_coff_H_d0;
wire[7:0] a_coff_H_from_V;
wire[7:0] b_coff_H_from_V;
reg[7:0] a_coff_H_from_V_d0;
reg[7:0] b_coff_H_from_V_d0;
reg[7:0] a_coff_V;
reg[7:0] b_coff_V;
reg scale_data_en;
reg scale_data_en_d0;
wire scale_data_out_V;
reg scale_data_out_V_d0;
wire line_end;
reg[11:0] pix_cnt = 12'd0;
wire calu_H_scale_en_out;
wire [23:0] calu_H_c;

reg[8:0] h_coff_sum;//水平系数累加
wire[8:0] h_coff_sum_next;
reg H_scale_up = 1'b0;
reg H_scale_down  = 1'b0;
reg[11:0] rd_req_cnt = 12'd0;
assign h_coff_sum_next = {1'b0,h_coff_sum[7:0]} + {1'b0,K_h_reg[7:0]};
assign line_end = frame_flag || (calu_H_scale_en_out && (pix_cnt == t_width - 12'd1));
assign col_calu_state_idle = (col_calu_state == COL_END);
assign rd_not_need_data = (scale_state == SCL_LINE_START && ~line_data_is_ready); 
assign line_data_is_ready = (scale_map_line[19:8] == wr_lines - 12'd1);
assign wr_buf_addr = wr_cnt[10:0];
assign wr_buf_en = rd_req_d0;
assign one_line_req_end = (rd_req_cnt == s_width - 12'd1) && rd_req;
assign one_line_finish = one_line_req_end_d4;
assign rd_req = ~fifo_aempty & rd_req_en;
assign rd_buf_addr = rd_col[10:0];
assign rd_buf_req = (rd_pixel_state == RD_PIXEL_READ) || (rd_col == 12'd0);
assign source_line_end = (rd_col == s_width - 12'd1) & (rd_pixel_state == RD_PIXEL_READ); //缩小时有效 ，放大失效
assign map_col_next = map_col + {4'd0,K_h_reg};
always@(posedge sys_clk)
begin
	rd_req_d0 <= rd_req;
	one_line_req_end_d0 <= one_line_req_end;
	one_line_req_end_d1 <= one_line_req_end_d0;
	one_line_req_end_d2 <= one_line_req_end_d1;
	one_line_req_end_d3 <= one_line_req_end_d2;
	one_line_req_end_d4 <= one_line_req_end_d3;
	rd_buf_req_d0 <= rd_buf_req;
	rd_buf_req_d1 <= rd_buf_req_d0;
	col_calu_state_idle_d0 <= col_calu_state_idle;
end
always@(posedge sys_clk)
begin
	K_h_reg <= K_h;
	K_v_reg <= K_v;
end 
/*两个线缓存，乒乓写入*/
line_buf_scaler#(.WITDH_2K(WITDH_2K)) line_buf_scaler_m0(
	.data(yc_data_in),
	.rdaddress(rd_buf_addr),
	.rdclock(sys_clk),
	.wraddress(wr_buf_addr),
	.wrclock(sys_clk),
	.wren(wr_buf_en & wr_buf_sel),
	.q(line_buf_q0)
);
line_buf_scaler#(.WITDH_2K(WITDH_2K)) line_buf_scaler_m1(
	.data(yc_data_in),
	.rdaddress(rd_buf_addr),
	.rdclock(sys_clk),
	.wraddress(wr_buf_addr),
	.wrclock(sys_clk),
	.wren(wr_buf_en & ~wr_buf_sel),
	.q(line_buf_q1)
);
/////////////////////////////////////////////////////////////////////////
/////数据写入line buffers////////////////////////////////////
always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		wr_state <= WR_IDLE;
	else if(frame_flag)
		wr_state <= WR_IDLE;
	else
		wr_state <= wr_state_next;
end
always@(*)
begin
	case(wr_state)
		WR_IDLE:
			begin
				if(~fifo_aempty)
					begin
						wr_state_next <= WR_LINE_BUF;
					end
				else
					begin
						wr_state_next <= WR_IDLE;
					end
			end
		WR_LINE_BUF:
			begin
				if(one_line_finish)
					begin
						wr_state_next <= WR_LINE_END;
					end
				else
					begin
						wr_state_next <= WR_LINE_BUF;
					end
			end
		WR_LINE_END:
			begin
				if(rd_not_need_data)
					begin
						wr_state_next <= WR_NEXT_LINE;
					end
				else
					begin
						wr_state_next <= WR_LINE_END;
					end
			end
		WR_NEXT_LINE:
			begin
				wr_state_next <= WR_LINE_BUF;
			end
		default:
			begin
				wr_state_next <= WR_IDLE;
			end
	endcase
end
/*读取数据的逻辑*/
always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n) 
		begin
			rd_req_en <= 1'b0;
		end
	else if(frame_flag | one_line_req_end | one_line_req_end_d0 | one_line_req_end_d1 | one_line_req_end_d2 | one_line_req_end_d3 | one_line_req_end_d4)
		begin
			rd_req_en <= 1'b0;
		end
	else if(wr_state == WR_LINE_BUF)
		begin
			rd_req_en <= 1'b1;
		end
	else
		begin
			rd_req_en <= 1'b0;
		end
end 
/*乒乓写入的逻辑*/
always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			wr_buf_sel <= 1'b0;
		end
	else if(wr_state != WR_LINE_BUF && wr_state_next == WR_LINE_BUF)
		begin
			wr_buf_sel <= ~wr_buf_sel;
		end
	else
		begin
			wr_buf_sel <= wr_buf_sel;
		end
end

always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			wr_cnt <= 12'd0;
		end
	else if(frame_flag || (wr_state != WR_LINE_BUF && wr_state_next == WR_LINE_BUF))
		begin
			wr_cnt <= 12'd0;
		end
	else if(rd_req_d0)
		begin
			wr_cnt <= wr_cnt + 12'd1;
		end
	else
		begin
			wr_cnt <= wr_cnt;
		end
end

always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			rd_req_cnt <= 12'd0;
		end
	else if( frame_flag || (wr_state != WR_LINE_BUF && wr_state_next == WR_LINE_BUF))
		begin
			rd_req_cnt <= 12'd0;
		end
	else if(rd_req)
		begin
			rd_req_cnt <= rd_req_cnt + 12'd1;
		end
	else
		begin
			rd_req_cnt <= rd_req_cnt;
		end
end

always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			wr_lines <= 12'd0;
		end
	else if(frame_flag)
		begin
			wr_lines <= 12'd0;
		end
	else if(wr_state == WR_NEXT_LINE)
		begin
			wr_lines <= wr_lines + 12'd1;
		end
	else
		begin
			wr_lines <= wr_lines;
		end
end

///////////////////////////////////////////////////////////////////////
//////////////////////垂直缩放处理/////////////////////////////////////
always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		scale_state <= SCL_IDLE;
	else if(frame_flag)
		scale_state <= SCL_IDLE;
	else
		scale_state <= scale_state_next;
end
always@(*)
begin
	case(scale_state)
		SCL_IDLE:
			begin
				scale_state_next <= SCL_LINE_START;
			end
		SCL_LINE_START:
			begin
//				if(scale_line == t_height)
//					begin
//						scale_state_next <= SCL_FINISH;
//					end
//				else 
				if(line_data_is_ready)
					begin
						scale_state_next <= SCL_LINE;
					end
				else
					begin
						scale_state_next <= SCL_LINE_START;
					end
			end
		SCL_LINE:
			begin
				if(scale_line_finish)
					begin
						scale_state_next <= SCL_LINE_END;
					end
				else
					begin
						scale_state_next <= SCL_LINE;
					end
			end
		SCL_LINE_END:
			begin
				if(rd_pixel_state == RD_PIXEL_END && col_calu_state == COL_END)
					scale_state_next <= SCL_LINE_START;
				else
					scale_state_next <= SCL_LINE_END;
			end
		SCL_FINISH:
			scale_state_next <= SCL_FINISH;
		default:
			scale_state_next <= SCL_IDLE;
	endcase
end

always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			scale_map_line <= 20'd0;
		end
	else if(frame_flag || (scale_state == SCL_IDLE && scale_state_next == SCL_LINE_START))
		begin
			scale_map_line <= 20'd0;
		end
	else if(scale_state != SCL_LINE_START && scale_state_next == SCL_LINE_START)
		begin
			scale_map_line <= scale_map_line + {4'd0,K_v_reg};
		end
	else
		begin
			scale_map_line <= scale_map_line;
		end
end

always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			scale_line <= 12'd0;
		end
	else if( frame_flag || (scale_state == SCL_IDLE && scale_state_next == SCL_LINE_START))
		begin
			scale_line <= 12'd0;
		end 
	else if(scale_state != SCL_LINE_START && scale_state_next == SCL_LINE_START)
		begin
			scale_line <= scale_line + 12'd1;
		end
	else
		begin
			scale_line <= scale_line;
		end
end
////////////////////////////////////////////////////////////////////////////////////////////

////////////////////数据流入处理
always@(posedge sys_clk)
begin
	if(scale_state == SCL_LINE_START)
		begin
			H_scale_down <= ~(K_h_reg[15:8] == 8'd0);
			H_scale_up <= (K_h_reg[15:8] == 8'd0);
		end
	else
		begin
			H_scale_down <= H_scale_down;
			H_scale_up <= H_scale_up;
		end
end


always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			rd_pixel_state <= RD_PIXEL_IDLE;
		end
	else if(frame_flag)
		begin
			rd_pixel_state <= RD_PIXEL_IDLE;
		end
	else
		begin
			rd_pixel_state <= rd_pixel_state_next;
		end
end

always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			h_coff_sum <= 9'd0;
		end
	else if(frame_flag || (scale_state == SCL_LINE_START && scale_state_next == SCL_LINE))
		begin
			h_coff_sum <= 9'd0;
		end
	else if(col_calu_state == COL_CALU)
		begin
			h_coff_sum <= h_coff_sum_next;
		end
	else
		begin
			h_coff_sum <= h_coff_sum;
		end
end
							   
reg pixel_data_read_en;
reg pixel_data_read_en_d0;
always@(posedge sys_clk)
begin
	pixel_data_read_en <= (wr_buf_addr > rd_col + 12'd3 || wr_state == WR_LINE_END) && ~fifo_afull;
	pixel_data_read_en_d0 <= pixel_data_read_en;
end
						   
// assign pixel_data_update_en =  pixel_data_read_en_d0
							// && ( (col_calu_state == COL_CALU && h_coff_sum_next[8]) ||
							   // (col_calu_state != COL_CALU && rd_col <= map_col_dec));
							   
assign pixel_data_update_en = pixel_data_read_en_d0
							&& ( H_scale_down ||
							   (H_scale_up && ((col_calu_state == COL_CALU_WAIT) || (col_calu_state == COL_CALU && h_coff_sum_next[8]) )));							   
always@(*)
begin
	case(rd_pixel_state)
		RD_PIXEL_IDLE:
			begin
				if(scale_state == SCL_LINE)
					begin
						rd_pixel_state_next <= RD_PIXEL_WAIT;
					end
				else 
					begin
						rd_pixel_state_next <= RD_PIXEL_IDLE;
					end
			end
		RD_PIXEL_WAIT:
			begin
				if(source_line_end | col_calu_state_idle_d0)
					begin
						rd_pixel_state_next <= RD_PIXEL_END;
					end
				else if(pixel_data_update_en)
					begin
						rd_pixel_state_next <= RD_PIXEL_READ;
					end
				else
					begin
						rd_pixel_state_next <= RD_PIXEL_WAIT;
					end
			end
		RD_PIXEL_READ:
			begin
				if(source_line_end | col_calu_state_idle_d0)
					begin
						rd_pixel_state_next <= RD_PIXEL_END;
					end
				else if(pixel_data_update_en)
					begin
						rd_pixel_state_next <= RD_PIXEL_READ;
					end
				else
					begin
						rd_pixel_state_next <= RD_PIXEL_WAIT;
					end
			end
		RD_PIXEL_END:
			begin
				if(scale_state == SCL_LINE_START && scale_state_next == SCL_LINE)
					rd_pixel_state_next <= RD_PIXEL_IDLE;
				else
					rd_pixel_state_next <= RD_PIXEL_END;
			end
		default:
			rd_pixel_state_next <= RD_PIXEL_IDLE;
	endcase
end

always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			rd_col <= 12'd0;
		end
	else if(frame_flag   ||  (scale_state == SCL_LINE_START))
		begin
			rd_col <= 12'd0;
		end
	else if(rd_pixel_state_next == RD_PIXEL_READ)
		begin
			rd_col <= rd_col + 12'd1;
		end
	else
		begin
			rd_col <= rd_col;
		end
end
///////////////////数据流出处理
always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			col_calu_state <= COL_CALU_IDLE;
		end
	else if(frame_flag)
		begin
			col_calu_state <= COL_CALU_IDLE;
		end
	else 
		begin
			col_calu_state <= col_calu_state_next;
		end
end

always@(*)
begin
	case(col_calu_state)
		COL_CALU_IDLE:
			begin
				if(scale_state == SCL_LINE)
					begin
						col_calu_state_next <= COL_CALU_WAIT;
					end
				else
					begin
						col_calu_state_next <= COL_CALU_IDLE;
					end
			end
		COL_CALU_WAIT:
			begin
				////if((rd_col == map_col[19:8] + 12'd1) ||  rd_pixel_state == RD_PIXEL_END)////////////
				if((rd_pixel_state_next == RD_PIXEL_READ && rd_col + 12'd1 == map_col[19:8] + 12'd1) ||  rd_pixel_state == RD_PIXEL_END)
					begin
						col_calu_state_next <= COL_CALU;
					end
				else
					begin
						col_calu_state_next <= COL_CALU_WAIT;
					end
			end
		COL_CALU:
			begin
				if(scale_line_finish)
					begin
						col_calu_state_next <= COL_END;
					end
				else if((rd_col == map_col_next[19:8] + 12'd1 && rd_pixel_state_next != RD_PIXEL_READ) 
				         ||(rd_col + 12'd1 == map_col_next[19:8] + 12'd1 && rd_pixel_state_next == RD_PIXEL_READ))
					begin
						col_calu_state_next <= COL_CALU;
					end
				else
					begin
						col_calu_state_next <= COL_CALU_WAIT;
					end
			end
		COL_END:
			if(rd_pixel_state == RD_PIXEL_END)
				col_calu_state_next <= COL_CALU_IDLE;
			else
				col_calu_state_next <= COL_END;
		default:
			col_calu_state_next <= COL_CALU_IDLE;
	endcase
end
always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			scale_col <= 12'd0;
		end
	else if(frame_flag || (scale_state == SCL_LINE_START))
		begin
			scale_col <= 12'd0;
		end
	else if(col_calu_state == COL_CALU)
		begin
			scale_col <= scale_col + 12'd1;
		end
	else
		begin
			scale_col <= scale_col;
		end
end
assign scale_line_finish = scale_col == (t_width - 12'd1) && (col_calu_state == COL_CALU);
always@(posedge sys_clk or negedge rst_n)
begin
	if(~rst_n)
		begin
			map_col <= 20'd0;
		end
	else if(frame_flag || scale_state == SCL_LINE_START )
		begin
			map_col <= 20'd0;
		end
	else if(col_calu_state == COL_CALU)
		begin
			map_col <= map_col + {4'd0,K_h_reg};
		end
	else
		begin
			map_col <= map_col;
		end
end

always@(posedge sys_clk)
begin
	a_coff_V <= scale_map_line[7:0];
	b_coff_V <= ~scale_map_line[7:0];
end
calu calu_V(
	.sys_clk(sys_clk),
	.a(line0_pixel_data),
	.b(line1_pixel_data),
	.a_coff(a_coff_V),
	.b_coff(b_coff_V),
	.c(c_V),
	.a_coff_next(a_coff_H_d0),//下级系数
	.b_coff_next(b_coff_H_d0),//下级系数
	.a_coff_next_out(a_coff_H_from_V),//下级系数
	.b_coff_next_out(b_coff_H_from_V),//下级系数
	.data_en_in(rd_buf_req_d1),
	.data_en_out(data_en_out_calu_V),
	
	.scale_en_in(scale_data_en_d0),
	.scale_en_out(scale_data_out_V)
);

always@(posedge sys_clk)
begin
	if(wr_buf_sel)
		begin
			line0_pixel_data <= line_buf_q0;
			line1_pixel_data <= line_buf_q1;
		end
	else
		begin
			line0_pixel_data <= line_buf_q1;
			line1_pixel_data <= line_buf_q0;
		end
	
end

always@(posedge sys_clk)
begin
	//data_en_out_calu_V_d0 <= data_en_out_calu_V;
	scale_data_out_V_d0 <= scale_data_out_V;
end

always@(posedge sys_clk)
begin
	if(data_en_out_calu_V)
		begin
			pixel_data0 <= c_V;
			pixel_data1 <= pixel_data0;
		end
	else
		begin
			pixel_data0 <= pixel_data0;
			pixel_data1 <= pixel_data1;
		end
	a_coff_H_from_V_d0 <= a_coff_H_from_V;
	b_coff_H_from_V_d0 <= b_coff_H_from_V;
end

always@(posedge sys_clk)
begin
	scale_data_en <= (col_calu_state == COL_CALU);
	scale_data_en_d0 <= scale_data_en;
end
always@(posedge sys_clk)
begin
	if((col_calu_state == COL_CALU))
		begin
			a_coff_H <= map_col[7:0];
			b_coff_H <= ~map_col[7:0];
		end
	else
		begin
			a_coff_H <= a_coff_H;
			b_coff_H <= b_coff_H;
		end
	a_coff_H_d0 <= a_coff_H;
	b_coff_H_d0 <= b_coff_H;
end

calu calu_H(
	.sys_clk(sys_clk),
	.a(pixel_data0),
	.b(pixel_data1),
	.a_coff(a_coff_H_from_V_d0),
	.b_coff(b_coff_H_from_V_d0),
	.c(calu_H_c),
	.scale_en_in(scale_data_out_V_d0),
	.scale_en_out(calu_H_scale_en_out)
);

always@(posedge sys_clk)
begin
	if(line_end)
		pix_cnt <= 12'd0;
	else if(calu_H_scale_en_out)
		pix_cnt <= pix_cnt + 12'd1;
	else
		pix_cnt <= pix_cnt;	
end

yuv444_yuv422 yuv444_yuv422_m0(
	.sys_clk(sys_clk),
	.line_end(line_end),
	.i_de(calu_H_scale_en_out),
	.i_y(calu_H_c[23:16]),
	.i_cb(calu_H_c[15:8]),
	.i_cr(calu_H_c[7:0]),
	
	.o_de(wr_req),
	.o_y(yc_data_out[15:8]),
	.o_c(yc_data_out[7:0])
);
endmodule
