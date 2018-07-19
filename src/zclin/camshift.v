module 	camshift
	(  		
		input        	clk,
		input        	rst_n,
		input        	cam_en,
		input  [10:0]   c_min_i,
		input  [10:0]   c_max_i,
		input  [10:0]   r_min_i,
		input  [10:0]   r_max_i,
		input  [10:0]   h_i,
		input  [10:0]   w_i,
		input  [7:0]    h_value,
		input			fifo_e,
		input			fifo_f,
		
		output 		 [32:0]	 addr_length,
		output  	 [10:0]  cam_x_o,
		output  	 [10:0]  cam_y_o,
		output   [10:0]  c_max_o,
		output   [10:0]  c_min_o,
		output   [10:0]  r_max_o,
		output   [10:0]  r_min_o,
		output  reg  [21:0]  cam_s,
		output  reg  	 	 cam_done,
		output  	  	     data_rd,
		output  	  	     cmd_wr
				
	);
		reg		[3:0]  		i;
		reg		[10:0]		o_x;
		reg		[10:0]		o_y;
		reg		[10:0]		n_x;
		reg		[10:0]		n_y;
		reg		[10:0]		n_o_x;
		reg		[10:0]		n_o_y;
		reg		[10:0]		c_min;
		reg		[10:0]		c_max;
		reg		[10:0]		r_min;
		reg		[10:0]		r_max;
		(* keep = "true" *)reg		[5:0]		c_state;
		(* keep = "true" *)reg		[8:0]		n_state;
		(* keep = "true" *)reg					s_done; 
		(* keep = "true" *)reg					m_en;
		reg 				cam_en_d0;
		(* keep = "true" *)wire				m_done;
		wire 	[3:0]		i_d;
		wire	[10:0]		m_x;
		wire	[10:0]		m_y;
		wire	[21:0]		m_00;
		reg		[10:0]		sqrt_m00;
		reg		[16:0]		l_c_d0;
		reg		[16:0]		l_r_d0;
		reg		[10:0]		l_c_d1;
		reg		[10:0]		l_r_d1;
		reg		[9:0]		l_c_h;
		reg		[9:0]		l_r_h;
		(* keep = "true" *)reg 				comp_en;
		reg		[21:0]		u1_i;
		reg					u1_op;
		reg		[10:0]		u2_i_1;
		reg		[10:0]		u2_i_2;
		reg		[2:0]		u2_cnt;
		wire 	[11:0]	 	u1_o;
		wire				u1_rdy;
		wire	[21:0]		u2_o;
		wire	[11:0]		c_add;
		wire	[11:0]		r_add;
		wire	[11:0]		c_add_d0;
		wire	[11:0]		r_add_d0;
		reg		[10:0] 		c_max_o_d0;
		reg    	[10:0] 		c_min_o_d0;
		reg    	[10:0]  	r_max_o_d0;
		reg     [10:0]  	r_min_o_d0;
		parameter 	IDLE		=6'b000001,
					CIRCLE      =6'b000010,
					COMPARE     =6'b000100,
					START       =6'b001000,
					RESULT      =6'b010000,
					END         =6'b100000;
		parameter	N_IDLE			=9'b000000001,
					SQRT_M00        =9'b000000010,
					SQRT_M00_RDY    =9'b000000100,
					LENGTH_D0       =9'b000001000,
					LENGTH_D1       =9'b000010000,
					LENGTH_HALF     =9'b000100000,
					SIZE_RECT       =9'b001000000,
					SIZE_RECT_RDY   =9'b010000000,
					CAM_O           =9'b100000000;
		//-------------------------record new&old cen----------------
		assign c_add = c_max_i + c_min_i;
		assign r_add = r_max_i + r_min_i;
		always@(posedge clk or negedge	rst_n)
		begin	
			if(!rst_n)
				begin
					o_x <= 0;
					o_y <= 0;
					n_x <= 0;
					n_y <= 0;
				end
			else if(cam_en_d0)
				begin
					o_x 	<= 0;
					o_y 	<= 0;
					n_x 	<= c_add[11:1];
					n_y 	<= r_add[11:1];
					comp_en <= 1;
				end
			else if(m_done)
				begin
					n_x 	<= m_x;
					n_y 	<= m_y;
					o_x 	<= n_x;
					o_y 	<= n_y;
					comp_en <= 1;
				end
			else
				comp_en <= 0;
		end
		//-----------------------------i_d---------------------------
		assign i_d = i + 1'd1;
		//assign i_d = i;
		//------------------------------iteration--------------------
		always@(posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				begin
					c_state <= IDLE;
					m_en 	<= 0;
					c_min 	<= 0;
					c_max 	<= 0;
					r_min 	<= 0;
					r_max 	<= 0;
					s_done	<= 0;
					i      	<= 0;
					n_o_x	<= 0;
					n_o_y	<= 0;
					cam_en_d0 <= 0;
				end
				//zclin 2016.12.30
			else if(cam_en)
				begin
					c_state <= IDLE;
					m_en 	<= 0;
					c_min 	<= 0;
					c_max 	<= 0;
					r_min 	<= 0;
					r_max 	<= 0;
					s_done	<= 0;
					i      	<= 0;
					n_o_x	<= 0;
					n_o_y	<= 0;
					cam_en_d0 <= 1;
				end
			else
				case(c_state)
					IDLE 		:begin
									
									
									if(cam_en_d0)
										begin
											c_state <= CIRCLE;
											cam_en_d0 <= 0;
										end
									else
										c_state	<= IDLE;
								end
					CIRCLE		:begin
									
									if(comp_en)
										begin
											if(n_x >= o_x)
												n_o_x <= n_x - o_x;
											else
												n_o_x <= o_x - n_x;
												
											if(n_y >= o_y)
												n_o_y <= n_y - o_y;
											else
												n_o_y <= o_y - n_y;
												
											c_state <= COMPARE;
										end
									else 
										c_state <= CIRCLE;
								end
					COMPARE		:begin
									if(n_o_x > 1 && n_o_y > 1)
										begin
											c_state <= START;
											s_done 	<= 0;
										end
									else
										begin
											c_state <= END;
											s_done 	<= 1;
										end
								end
					START 		:begin
									if(i == 0)
										begin
											if(c_min_i >= i_d)
												c_min <= c_min_i - i_d;
											else
												c_min <= 11'd0;
											
											if(r_min_i >= i_d)
												r_min <= r_min_i - i_d;
											else
												r_min <= 11'd0;
											
											if(c_max_i < w_i - i_d)
												c_max <= c_max_i + i_d;
											else
												c_max <= w_i - 1'd1;
											
											if(r_max_i < h_i - i_d)
												r_max <= r_max_i+i_d;
											else
												r_max <= h_i - 1'd1;
											
											c_state <= RESULT;
											m_en 	<= 1;
										end
									else if(i < 4'd14)
										begin
											if(c_min >= i_d)
												c_min <= c_min - i_d;
											else
												c_min <= 11'd0;
											
											if(r_min >= i_d)
												r_min <= r_min - i_d;
											else
												r_min <= 11'd0;
											
											if(c_max < w_i - i_d)
												c_max <= c_max + i_d;
											else
												c_max <= w_i - 1'd1;
											
											if(r_max_i <h_i - i_d)
												r_max <= r_max + i_d;
											else
												r_max <= h_i - 1'd1;
											
											c_state <= RESULT;
											m_en 	<= 1;
										end
									else
										begin
											m_en 	<= 0;
											c_state <= END;
										end
								end
					RESULT		:begin
									m_en <= 0;
									if(m_done)
										begin
											if(i < 4'd14)
												begin
													i  		<= i+1'd1;
													c_state <= CIRCLE;
													s_done  <= 0;
												end
											else
												begin
													i 		<= 0;
													c_state <= END;
													s_done  <= 1;
												end
										end
									else
										begin
											c_state <= RESULT;
											s_done  <= 0;
										end
								end
					END			:begin
									c_state <= IDLE;
									s_done 	<= 0;
									i 		<= 0;
								end
					default		:c_state <= IDLE;
				endcase
		end
		//------------------------------cam_cen----------------------
		assign c_add_d0 = c_max_o + c_min_o;
		assign r_add_d0 = r_max_o + r_min_o;
		assign cam_x_o = c_add_d0[11:1];
		assign cam_y_o = r_add_d0[11:1];
		/* always@(posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				begin
					cam_x_o <= 0;
					cam_y_o <= 0;
				end
			else if(s_done == 1)
				begin
					cam_x_o <= n_x;
					cam_y_o <= n_y;
				end
		end */
		//------------------------------calc-------------------------
		always@(posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				begin
				n_state  <= N_IDLE;
				cam_done <= 0;
				u1_i 	 <= 0;
				u1_op 	 <= 0;
				u2_i_1 	 <= 0;
				u2_i_2 	 <= 0;
				u2_cnt	 <= 0;
				sqrt_m00 <= 0;
				l_c_d0 	 <= 0;
				l_r_d0 	 <= 0;
				l_c_d1 	 <= 0;
				l_r_d1 	 <= 0;
				l_c_h 	 <= 0;
				l_r_h 	 <= 0;
				cam_s	 <= 0;
				r_min_o_d0  <= 0;
				r_max_o_d0  <= 0;
				c_min_o_d0  <= 0;
				c_max_o_d0  <= 0;
				
				end
			else
				case(n_state)
					N_IDLE			:begin
										cam_done <= 0;
										if(s_done)
											n_state <= SQRT_M00;
										else 
											n_state <= N_IDLE;
									end
					SQRT_M00		:begin
										u1_i  	<= m_00;
										u1_op 	<= 1;
										n_state <= SQRT_M00_RDY;
									end
					SQRT_M00_RDY	:begin	
										u1_op <= 0;
										if(u1_rdy)
											begin
												sqrt_m00 <= u1_o[10:0];
												n_state  <= LENGTH_D0;
											end
										else n_state <= SQRT_M00_RDY;
									end
					LENGTH_D0		:begin
										l_r_d0 	<= {sqrt_m00,6'd0} + {sqrt_m00,4'd0} + {sqrt_m00,3'd0} + {sqrt_m00,2'd0};
										l_c_d0 	<= {sqrt_m00,6'd0} + {sqrt_m00,3'd0} + {sqrt_m00,2'd0} + sqrt_m00;
										//l_r_d0 	<= {sqrt_m00,6'd0};
										//l_c_d0 	<= {sqrt_m00,6'd0};
										n_state	<= LENGTH_D1;
									end
					LENGTH_D1		:begin
										l_c_d1	<= l_c_d0[16:6];
										l_r_d1	<= l_r_d0[16:6];
										n_state <= LENGTH_HALF;
									end
					LENGTH_HALF		:begin
										l_c_h   <= l_c_d1[10:1];
										l_r_h   <= l_r_d1[10:1];
										n_state <= SIZE_RECT;
									end
					SIZE_RECT		:begin
										u2_i_1  <= {l_c_h,1'd0};
										u2_i_2  <= {l_r_h,1'd0};
										u2_cnt  <= 0;
										n_state <= SIZE_RECT_RDY;
									end
					SIZE_RECT_RDY	:begin
										u2_cnt <= u2_cnt + 1'd1;
										if(u2_cnt == 3'd4)
											begin
												cam_s   <= u2_o;
												n_state <= CAM_O;
											end
										else
											n_state <= SIZE_RECT_RDY;
									end
					CAM_O			:begin
										r_min_o_d0  <= m_y - l_r_h;
										r_max_o_d0  <= m_y + l_r_h;
										c_min_o_d0  <= m_x - l_c_h;
										c_max_o_d0  <= m_x + l_c_h;
										n_state  <= N_IDLE;
										cam_done <= 1;
									end
					default			:n_state <= N_IDLE;
				endcase
		end
		assign  r_min_o = (m_y >= l_r_h) ? r_min_o_d0 : 11'd0;
		assign	r_max_o = (r_max_o_d0 < h_i) ? 	r_max_o_d0 : h_i - 1'd1;
		assign	c_min_o = (m_x >= l_c_h) ? c_min_o_d0 : 11'd0;
		assign	c_max_o = (c_max_o_d0 < w_i) ? c_max_o_d0 : w_i - 1'd1;
		meanshift_1	meanshift_calc
					(
						.clk(clk),
						.rst_n(rst_n),
						.wr_en(cmd_wr),
						.almost_full(fifo_f),
						.h_data(h_value),
						.c_min_i(c_min),
						.c_max_i(c_max),
						.r_min_i(r_min),
						.r_max_i(r_max),
						.almost_empty(fifo_e),
						.m_en(m_en),
						
						.cen_x(m_x),
						.cen_y(m_y),
						.m_00(m_00),
						.m_done(m_done),
						.addr_length(addr_length),
						.rd_en(data_rd)
    );								
		en_sqrt_fix u1_sqrt_fix 
						(
							.x_in(u1_i), // input [21 : 0] x_in
							.nd(u1_op), // input nd
							.x_out(u1_o), // output [11 : 0] x_out
							.rdy(u1_rdy), // output rdy
							.clk(clk) // input clk
						);
		en_mul_fix 	u2_mul_fix 
						(
							.clk(clk), // input clk
							.a(u2_i_1), // input [10 : 0] a
							.b(u2_i_2), // input [10 : 0] b
							.p(u2_o) // output [21 : 0] p
						);
		
		
		endmodule												
										