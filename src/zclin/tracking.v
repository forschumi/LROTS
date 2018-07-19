//不抓信号版本，只改FIFO设置
module 	tracking
	(
		input 			clk,
		input 			rst_n,
		input 			t_en,
		input 			i_en,
		input 	[10:0]	c_min_i,
		input 	[10:0]	c_max_i,
		input 	[10:0]	r_min_i,
		input 	[10:0]	r_max_i,
		input 			cmd_full,
		input 			data_empty,
		input 	[10:0]	h_i,
		input 	[10:0]	w_i,
		input 	[7:0]	h_value,
		
		output			data_rd,
		output			cmd_wr, 
		output	[32:0]	cam_addr,
		output	[10:0]	c_min_o,
		output	[10:0]	r_min_o,
		output	[10:0]	c_max_o,
		output	[10:0]	r_max_o,
		output			t_done,
		output	[1:0]	frame_addr,
		input[1:0] wr_frame_addr,
		output 		frame_false
	);
	
	 wire            [10:0]      c_min_t;
    wire            [10:0]      r_min_t;
    wire            [10:0]      c_max_t;
    wire            [10:0]      r_max_t;
    wire            [10:0]      cam_x;
    wire            [10:0]      cam_y;
    wire            [21:0]      cam_s;
    wire                      	cam_done;
    wire                     	cam_en;
    wire            [10:0]      c_max;
    wire            [10:0]      c_min;
    wire            [10:0]      r_max;
    wire            [10:0]      r_min;
//	 reg					[6:0]			t_en_cnt;
//	 reg					[6:0]			t_done_cnt;
	 //zclin 2016.12.30
//	 always@(posedge clk or negedge rst_n)
//	 begin
//		if(!rst_n)
//			t_en_cnt <= 0;
//		else if(t_en)
//			t_en_cnt <= t_en_cnt + 1'd1;
//		else
//			t_en_cnt <= t_en_cnt;
//	end
//	always@(posedge clk or negedge rst_n)
//	begin
//		if(!rst_n)
//			t_done_cnt <= 0;
//		else if(t_done)
//			t_done_cnt <= t_done_cnt + 1'd1;
//		else 
//			t_done_cnt <= t_done_cnt;
//	end
//			
	
	kalman		calc_kalman
						(
							.clk(clk),
							.rst_n(rst_n),
							.i_en(i_en),
							.t_en(t_en),
							.h_i(h_i),
							.w_i(w_i),
							.r_min_i(r_min_i),
							.r_max_i(r_max_i),
							.c_min_i(c_min_i),
							.c_max_i(c_max_i),
							.cam_c_min_i(c_min),
							.cam_r_min_i(r_min),
							.cam_c_max_i(c_max),
							.cam_r_max_i(r_max),
							.cam_x_i(cam_x),
							.cam_y_i(cam_y),
							.cam_s(cam_s),
							.cam_done(cam_done),
							
							
							.cam_en(cam_en),
							.c_min_o(c_min_o),
							.c_max_o(c_max_o),
							.r_min_o(r_min_o),
							.r_max_o(r_max_o),
							.cam_c_max_o(c_max_t),
							.cam_c_min_o(c_min_t),
							.cam_r_max_o(r_max_t),
							.cam_r_min_o(r_min_t),
							.t_done(t_done),
							.frame_addr(frame_addr),
							.wr_frame_addr(wr_frame_addr),
							.frame_false(frame_false)
						);
	camshift	calc_camshift
						(  		
							.clk(clk),
							.rst_n(rst_n),
							.cam_en(cam_en),
							.c_min_i(c_min_t),
							.c_max_i(c_max_t),
							.r_min_i(r_min_t),
							.r_max_i(r_max_t),
							.h_i(h_i),
							.w_i(w_i),
							.h_value(h_value),
							.fifo_e(data_empty),
							.fifo_f(cmd_full),
		
							.addr_length(cam_addr),
							.cam_x_o(cam_x),
							.cam_y_o(cam_y),
							.c_max_o(c_max),
							.c_min_o(c_min),
							.r_max_o(r_max),
							.r_min_o(r_min),
							.cam_s(cam_s),
							.cam_done(cam_done),
							.data_rd(data_rd),
							.cmd_wr(cmd_wr)
				
						);
	endmodule