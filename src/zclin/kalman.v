module kalman
	(
		input				clk,
		input				rst_n,
		input				i_en,
		input				t_en,
		input		[10:0]	h_i,
		input 		[10:0] 	w_i,
		input 		[10:0] 	r_min_i,
		input 		[10:0] 	r_max_i,
		input 		[10:0] 	c_min_i,
		input 		[10:0] 	c_max_i,
		(* keep = "true" *)input 		[10:0] 	cam_c_min_i,
		(* keep = "true" *)input 		[10:0] 	cam_r_min_i,
		(* keep = "true" *)input 		[10:0] 	cam_c_max_i,
		(* keep = "true" *)input 		[10:0] 	cam_r_max_i,
		input		[10:0]  cam_x_i,
		input		[10:0]  cam_y_i,
		
		input 		[21:0] 	cam_s,
		(* keep = "true" *)input 		 		cam_done,
		(* keep = "true" *)input 		[1:0]	wr_frame_addr,
		
		(* keep = "true" *)output reg 	 	 	cam_en,
		output 	 	[10:0]	c_min_o,
		output 	 	[10:0]	c_max_o,
		output 	 	[10:0]	r_min_o,
		output 	 	[10:0]	r_max_o,
		output reg 	[10:0]	cam_c_max_o,
		output reg 	[10:0]	cam_c_min_o,
		output reg 	[10:0]	cam_r_max_o,
		output reg 	[10:0]	cam_r_min_o,
		(* keep = "true" *)output reg 			t_done,
		(* keep = "true" *)output reg 	[1:0]	frame_addr,
		(* keep = "true" *)output				frame_false 
	);
	//--------------------------------------------------
		reg  				i_en_d0;
		reg 				i_en_d1;
		reg					i_en_d2;
		reg 				t_en_d0;
		reg 				t_en_d1;
		reg 				t_en_d2;
		reg 	[10:0] 		l_c;
		reg 	[10:0] 		l_r;
		
		reg 	[10:0]		x_post_1_fix_d0;
		reg 	[10:0]      x_post_2_fix_d0;
		
		(* keep = "true" *)reg 	[6:0]		c_state;
		(* keep = "true" *)reg 				comp_done;					
		(* keep = "true" *)reg 				cor_done;			
		(* keep = "true" *)reg 				pre_done;
		reg 				k_i;
		reg 	[10:0]		u1_i;					
		reg 				u1_op;					
		reg 	[10:0]		u2_i_1;					
		reg 	[10:0]		u2_i_2;				
		reg 	[31:0]		u3_i_1;					
		reg 	[31:0]		u3_i_2;
		reg 				u3_sel;
		reg 				u3_op;					
		reg 	[31:0]		u4_i;					
		reg 				u4_op;					
		reg 	[31:0]		u5_i_1;					
		reg 	[31:0]		u5_i_2;					
		reg 				u5_op;					
		reg 	[31:0]		u6_i_1;					
		reg 	[31:0]		u6_i_2;
		reg 				u6_op;          
		reg 	[21:0]		s_l;
		(* keep = "true" *)reg		[10:0]		x_pre_1_o;
		(* keep = "true" *)reg		[10:0]		x_pre_2_o;
		reg 	[31:0]		x_post_1;                
		reg 	[31:0]		x_post_2;                
		reg 	[31:0]		x_post_3;                
		reg 	[31:0]		x_post_4;                
		reg 	[31:0]		p_post_1_1;              
		reg 	[31:0]		p_post_3_1;              
		reg 	[31:0]		p_post_2_2;              
		reg 	[31:0]		p_post_4_2;              
		reg 	[31:0]		p_post_1_3;              
		reg 	[31:0]		p_post_3_3;              
		reg 	[31:0]		p_post_2_4;              
		reg 	[31:0]		p_post_4_4; 
		reg 	[31:0]		x_pre_1;                 
		reg 	[31:0]		x_pre_2; 
		reg 	[31:0]		x_pre_3;                 
		reg 	[31:0]		x_pre_4;                 
		reg 	[31:0]		p_pre_4_4;               
		reg 	[31:0]		p_pre_3_3;               
		reg 	[31:0]		p_pre_3_1;               
		reg 	[31:0]		p_pre_4_2;               
		reg 	[31:0]		p_pre_1_3;               
		reg 	[31:0]		p_pre_2_4;               
		reg 	[31:0]		p_pre_1_1_1;             
		reg 	[31:0]		p_pre_1_1_2;             
		reg 	[31:0]		p_pre_1_1;               
		reg 	[31:0]		p_pre_2_2_1;             
		reg 	[31:0]		p_pre_2_2_2;             
		reg 	[31:0]		p_pre_2_2;
		reg 	[25:0]		remain_s;
		reg 	[31:0]		r_1;                     
		reg 	[31:0]		r_2;                    
		(* keep = "true" *)reg 				comp_alpha;               
		(* keep = "true" *)reg 				comp_r;               
		reg 	[31:0]		temp_1_1_1;              
		reg 	[31:0]		temp_1_2_2;              
		reg 	[31:0]		k_1_1;                   
		reg 	[31:0]		k_2_2;                   
		reg 	[31:0]		k_3_1;                   
		reg 	[31:0]		k_4_2;                   
		reg 	[31:0]		temp_2_1;                
		reg 	[31:0]		temp_2_2;               
		reg 	[31:0]		k_temp_2_1;              
		reg 	[31:0]		k_temp_2_2;              
		reg 	[31:0]		k_temp_2_3;             
		reg 	[31:0]		k_temp_2_4;              
		reg 	[31:0]		k_p_1_1;                 
		reg 	[31:0]		k_p_3_1;                 
		reg 	[31:0]		k_p_2_2;                 
		reg 	[31:0]		k_p_4_2;                 
		reg 	[31:0]		k_p_1_3;                 
		reg 	[31:0]		k_p_3_3;                 
		reg 	[31:0]		k_p_2_4;                 
		reg 	[31:0]		k_p_4_4;
		reg 	[31:0]		z_k_1;
		reg 	[31:0]		z_k_2;
		(* keep = "true" *)reg					cor_en;
		reg		[2:0]		u2_cnt;
		reg		[31:0]		x_flo_d0;
		reg		[31:0]		y_flo_d0;
		reg 				full_img;
		(* keep = "true" *)reg 	[10:0]		c_min_d0;
		(* keep = "true" *)reg 	[10:0]		c_max_d0;
		(* keep = "true" *)reg 	[10:0]		r_min_d0;
		(* keep = "true" *)reg 	[10:0]		r_max_d0;
		(* keep = "true" *)reg 				fix2flo_done;
		(* keep = "true" *)reg 				comp_done_d0;
		wire 	[11:0]		r_add_d0;
		wire 	[11:0]		c_add_d0;
		
		wire 	[31:0]		u1_o;
		wire 				u1_rdy;
		wire 	[21:0]		u2_o;
		wire 	[31:0]		u3_o;
		wire 				u3_rdy;
		wire				u3_op_1;
		wire 	[10:0]		u4_o;
		wire 				u4_rdy;
		wire 	[31:0]		u5_o;
		wire 				u5_rdy;
		wire 	[31:0]		u6_o;
		wire 				u6_rdy;
		
		wire 	[10:0]		l_c_h;         
		wire 	[10:0]		l_r_h; 
		wire 	[11:0]		c_add;
		wire	[11:0] 		r_add;
		
		(* keep = "true" *)wire 	[10:0] 		new_x_i;
		(* keep = "true" *)wire 	[10:0] 		new_y_i;
	//------------------parameter----------------------
	parameter 	IDLE_INIT			=7'd0,		
	            IDLE			    =7'd1,
	            X_POST_1_I	        =7'd2,
	            X_POST_1_I_RDY	    =7'd3,
	            X_POST_2_I		    =7'd4,
	            X_POST_2_I_RDY      =7'd5,
	            SIZE_LAST	        =7'd6,
	            SIZE_LAST_RDY	    =7'd7,
	            KAL_INI			    =7'd8,
	            KAL_T			    =7'd9,
	            X_PRE_1		        =7'd10,
	            X_PRE_1_RDY		    =7'd11,
	            X_PRE_2			    =7'd12,
	            X_PRE_2_RDY		    =7'd13,
	            X_PRE_3		        =7'd14,
	            X_PRE_4			    =7'd15,
	            P_PRE_4_4		    =7'd16,
	            P_PRE_4_4_RDY	    =7'd17,
	            P_PRE_3_3		    =7'd18,
	            P_PRE_3_3_RDY	    =7'd19,
	            P_PRE_3_1	        =7'd20,
	            P_PRE_3_1_RDY	    =7'd21,
	            P_PRE_4_2	        =7'd22,
	            P_PRE_4_2_RDY	    =7'd23,
	            P_PRE_1_3		    =7'd24,
	            P_PRE_1_3_RDY	    =7'd25,
	            P_PRE_2_4	        =7'd26,
	            P_PRE_2_4_RDY	    =7'd27,
	            P_PRE_1_1_1		    =7'd28,
	            P_PRE_1_1_1_RDY	    =7'd29,
	            P_PRE_1_1_2	        =7'd30,
	            P_PRE_1_1_2_RDY     =7'd31,
	            P_PRE_1_1	        =7'd32,
	            P_PRE_1_1_RDY	    =7'd33,
	            P_PRE_2_2_1	        =7'd34,
	            P_PRE_2_2_1_RDY     =7'd35,
	            P_PRE_2_2_2	        =7'd36,
	            P_PRE_2_2_2_RDY	    =7'd37,
	            P_PRE_2_2	        =7'd38,
	            P_PRE_2_2_RDY	    =7'd39,
	            X_PRE_1_O	        =7'd40,
	            X_PRE_1_O_RDY	    =7'd41,
	            X_PRE_2_O	        =7'd42,
	            X_PRE_2_O_RDY	    =7'd43,
	            CAM_S		        =7'd44,
	            CAM_S_RDY	        =7'd45,
	            COM_ALPHA	        =7'd46,
	            ALPHA_RDY		    =7'd47,
	            CAM_ADD		        =7'd48,
	            CEN			        =7'd49,
	            CEN2FLO_X	        =7'd50,
	            CEN2FLO_X_RDY	    =7'd51,
	            CEN2FLO_Y		    =7'd52,
	            CEN2FLO_Y_RDY	    =7'd53,
	            CALC_R		        =7'd54,
	            COMPARE_R		    =7'd55,
	            TEMP_1_1_1	        =7'd56,
	            TEMP_1_1_1_RDY      =7'd57,
	            TEMP_1_2_2	        =7'd58,
	            TEMP_1_2_2_RDY	    =7'd59,
	            K_1_1		        =7'd60,
	            K_1_1_RDY	        =7'd61,
	            K_2_2		        =7'd62,
	            K_2_2_RDY	        =7'd63,
	            K_3_1		        =7'd64,
	            K_3_1_RDY	        =7'd65,
	            K_4_2			    =7'd66,
	            K_4_2_RDY		    =7'd67,
	            TEMP_2_1		    =7'd68,
	            TEMP_2_1_RDY	    =7'd69,
	            TEMP_2_2		    =7'd70,
	            TEMP_2_2_RDY	    =7'd71,
	            K_TEMP_2_1		    =7'd72,
	            K_TEMP_2_1_RDY      =7'd73,
	            K_TEMP_2_2		    =7'd74,
	            K_TEMP_2_2_RDY	    =7'd75,
	            K_TEMP_2_3		    =7'd76,
	            K_TEMP_2_3_RDY	    =7'd77,
	            K_TEMP_2_4	        =7'd78,
	            K_TEMP_2_4_RDY      =7'd79,
	            X_POST_1	        =7'd80,
	            X_POST_1_RDY	    =7'd81,
	            X_POST_2	        =7'd82,
	            X_POST_2_RDY	    =7'd83,
	            X_POST_3	        =7'd84,
	            X_POST_3_RDY	    =7'd85,
	            X_POST_4	        =7'd86,
	            X_POST_4_RDY	    =7'd87,
	            K_P_1_1			    =7'd88,
	            K_P_1_1_RDY	        =7'd89,
	            K_P_3_1			    =7'd90,
	            K_P_3_1_RDY	        =7'd91,
	            K_P_2_2			    =7'd92,
	            K_P_2_2_RDY		    =7'd93,
	            K_P_4_2			    =7'd94,
	            K_P_4_2_RDY	        =7'd95,
	            K_P_1_3			    =7'd96,
	            K_P_1_3_RDY		    =7'd97,
	            K_P_3_3			    =7'd98,
	            K_P_3_3_RDY	        =7'd99,
	            K_P_2_4		        =7'd100,
	            K_P_2_4_RDY	        =7'd101,
	            K_P_4_4			    =7'd102,
	            K_P_4_4_RDY	        =7'd103,
	            P_POST_1_1	        =7'd104,
	            P_POST_1_1_RDY      =7'd105,
	            P_POST_3_1	        =7'd106,
	            P_POST_3_1_RDY      =7'd107,
	            P_POST_2_2	        =7'd108,
	            P_POST_2_2_RDY      =7'd109,
	            P_POST_4_2	        =7'd110,
	            P_POST_4_2_RDY	    =7'd111,
	            P_POST_1_3	        =7'd112,
	            P_POST_1_3_RDY      =7'd113,
	            P_POST_3_3	        =7'd114,
	            P_POST_3_3_RDY      =7'd115,
	            P_POST_2_4	        =7'd116,
	            P_POST_2_4_RDY	    =7'd117,
	            P_POST_4_4	        =7'd118,
	            P_POST_4_4_RDY      =7'd119;
	parameter   para_2 			=32'h40000000,
				para_q			=32'h3727C5AC,
				para_r			=32'h3DCCCCCD;
	//---------------i_en &t_en----------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				i_en_d0 <= 0;
				i_en_d1 <= 0;
			end
		else if(i_en && t_en)
			i_en_d1 <= 1;
		else if(i_en && ~t_en)
			i_en_d0 <= 1;
		else if(i_en_d0 & t_en)
			begin
				i_en_d0 <= 0;
				i_en_d1 <= 1;
			end
		else
			i_en_d1 <= 0;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			i_en_d2 <= 0;
		else 
			i_en_d2 <= i_en_d1;
	end
	//----------------t_en delay---------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				t_en_d0 <= 0;
				t_en_d1 <= 0;
				t_en_d2 <= 0;
			end
		else
			begin
				t_en_d0 <= t_en;
				t_en_d1 <= t_en_d0;
				t_en_d2 <= t_en_d1;
			end
	end
	//-----------------frame false-------------------------
	assign frame_false = (cam_s <= 8'd255) ? 1'b1 : 1'b0;
	//-----------------half length-------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				l_c <= 0;
				l_r <= 0;
			end
		else if(i_en)
			begin
				l_c <= c_max_i - c_min_i;
				l_r <= r_max_i - r_min_i;
			end
		else if(t_done & ~i_en_d0)
			begin
				l_c <= c_max_o - c_min_o;
				l_r <= r_max_o - r_min_o;
			end
		else
			begin
				l_c <= l_c;
				l_r <= l_r;
			end
	end
	
	assign l_c_h = {1'b0,l_c[10:1]};
	assign l_r_h = {1'b0,l_r[10:1]};
	//-----------------initial x_post_d0-------------------
	assign c_add = c_max_i + c_min_i;
	assign r_add = r_max_i + r_min_i;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				x_post_1_fix_d0 <= 0;
				x_post_2_fix_d0 <= 0;
			end
		else 
			case({i_en,c_add[0],r_add[0]})
				3'b111	:begin
							x_post_1_fix_d0 <= c_add[11:1] + 1'b1;
							x_post_2_fix_d0 <= r_add[11:1] + 1'b1;
						end
		        3'b110	:begin
							x_post_1_fix_d0 <= c_add[11:1] + 1'b1;	
							x_post_2_fix_d0 <= r_add[11:1];
						end
		        3'b101	:begin
							x_post_1_fix_d0 <= c_add[11:1];
							x_post_2_fix_d0 <= r_add[11:1] + 1'b1;
						end
		        3'b100	:begin
							x_post_1_fix_d0 <= c_add[11:1];
							x_post_2_fix_d0 <= r_add[11:1];
						end
		        3'b011,3'b010,3'b001,3'b000	:begin
							x_post_1_fix_d0 <= x_post_1_fix_d0;
							x_post_2_fix_d0 <= x_post_2_fix_d0;
						end
				default	:begin
							x_post_1_fix_d0 <= x_post_1_fix_d0;
							x_post_2_fix_d0 <= x_post_2_fix_d0;
						end
			endcase
	end
	//-----------------Kalman predict&correct--------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				c_state 	<= IDLE_INIT;
				comp_done	<= 0;
				cor_done	<= 0;
				pre_done	<= 0;
				k_i			<= 0;
				u1_i		<= 0;
				u1_op		<= 0;
				u2_i_1		<= 0;
				u2_i_2		<= 0;
				u2_cnt		<= 0;
				u3_i_1		<= 0;
				u3_i_2		<= 0;
				u3_op		<= 0;
				u3_sel		<= 0;
				u4_i		<= 0;
				u4_op		<= 0;
				u5_i_1		<= 0;
				u5_i_2		<= 0;
				u5_op		<= 0;
				u6_i_1		<= 0;
				u6_i_2		<= 0;
				u6_op		<= 0;
				s_l         <= 0;
				remain_s	<= 0;
				x_flo_d0	<= 0;
				y_flo_d0	<= 0;
				x_post_1    <= 0;
				x_post_2    <= 0;
				x_post_3    <= 0;
				x_post_4    <= 0;
				p_post_1_1  <= 0;
				p_post_3_1  <= 0;
				p_post_2_2  <= 0;
				p_post_4_2  <= 0;
				p_post_1_3  <= 0;
				p_post_3_3  <= 0;
				p_post_2_4  <= 0;
				p_post_4_4  <= 0;
				x_pre_1     <= 0;
				x_pre_2     <= 0;
				x_pre_3     <= 0;
				x_pre_4     <= 0;
				p_pre_4_4   <= 0;
				p_pre_3_3   <= 0;
				p_pre_3_1   <= 0;
				p_pre_4_2   <= 0;
				p_pre_1_3   <= 0;
				p_pre_2_4   <= 0;
				p_pre_1_1_1 <= 0;
				p_pre_1_1_2 <= 0;
				p_pre_1_1   <= 0;
				p_pre_2_2_1 <= 0;
				p_pre_2_2_2 <= 0;
				p_pre_2_2   <= 0;
				r_1         <= 0;
				r_2         <= 0;
				comp_alpha  <= 0;
				comp_r      <= 0;
				temp_1_1_1  <= 0;
				temp_1_2_2  <= 0;
				k_1_1       <= 0;
				k_2_2       <= 0;
				k_3_1       <= 0;
				k_4_2       <= 0;
				temp_2_1    <= 0;
				temp_2_2    <= 0;
				k_temp_2_1  <= 0;
				k_temp_2_2  <= 0;
				k_temp_2_3  <= 0;
				k_temp_2_4  <= 0;
				k_p_1_1     <= 0;
				k_p_3_1     <= 0;
				k_p_2_2     <= 0;
				k_p_4_2     <= 0;
				k_p_1_3     <= 0;
				k_p_3_3     <= 0;
				k_p_2_4     <= 0;
				k_p_4_4     <= 0;
				x_pre_1_o	<= 0;
				x_pre_2_o	<= 0;
				fix2flo_done<= 0;
			end
		else 
			case(c_state)
				IDLE_INIT 				:begin
											if(i_en_d1)
												c_state <= IDLE;
											else
												c_state <= IDLE_INIT;
										end
				IDLE					:begin
											pre_done  <= 0;
											comp_done <= 0;
											cor_done  <= 0;
											fix2flo_done <= 0;
											full_img <= 0;
											
											if(i_en_d2)
												begin
													k_i <= 1;
													c_state <= X_POST_1_I;
												end
											else if(t_en_d2)
												c_state <= SIZE_LAST;
											else if(cam_done)
												c_state <= COM_ALPHA;
											else if(comp_done_d0)
												c_state <= CEN2FLO_X;
											else if(cor_en)
												c_state <= TEMP_1_1_1;
											else
												c_state <= IDLE;
										end
				X_POST_1_I				:begin								//u1 fix2flo
											u1_i 	<= x_post_1_fix_d0;
											u1_op 	<= 1;
											c_state <= X_POST_1_I_RDY;
										end
				X_POST_1_I_RDY			:begin
											u1_op <= 0;
											if(u1_rdy)
												begin
													x_post_1 <= u1_o;
													c_state	 <= X_POST_2_I;
												end
											else
												c_state <= X_POST_1_I_RDY;
										end		
				X_POST_2_I				:begin
											u1_i 	<= x_post_2_fix_d0;
											u1_op	<= 1;
											c_state <= X_POST_2_I_RDY;
										end
				X_POST_2_I_RDY			:begin
											u1_op <= 0;
											if(u1_rdy)
												begin
													x_post_2 <= u1_o;
													c_state  <= SIZE_LAST;
												end
											else
												c_state <= X_POST_2_I_RDY;
										end
				SIZE_LAST				:begin								//u2 fix mul
											u2_i_1  <= {l_c_h[9:0],1'b0};
											u2_i_2  <= {l_r_h[9:0],1'b0};
											u2_cnt	<= 0;
											c_state <= SIZE_LAST_RDY;
										end
				SIZE_LAST_RDY			:begin
											u2_cnt <= u2_cnt + 1'b1;
											if(u2_cnt == 3'd4 && k_i)
												begin
													s_l <= u2_o;
													c_state <= KAL_INI;
												end
											else if(u2_cnt == 3'd4 && ~k_i)
												begin
													s_l <= u2_o;
													c_state <= KAL_T;
												end
											else
												c_state <= SIZE_LAST_RDY;
										end
				KAL_INI					:begin
											k_i <= 0;
												
											x_post_1 <= x_post_1;
											x_post_2 <= x_post_2;
											x_post_3 <= 32'h0;
											x_post_4 <= 32'h0;
											
											p_post_1_1 <= 32'h3F800000;
											p_post_3_1 <= 32'h0;
											p_post_2_2 <= 32'h3F800000;
											p_post_4_2 <= 32'h0;
											p_post_1_3 <= 32'h0;
											p_post_3_3 <= 32'h3F800000;
											p_post_2_4 <= 32'h0;
											p_post_4_4 <= 32'h3F800000;
											
											c_state <= X_PRE_1;
										end
				KAL_T					:begin
											c_state <= X_PRE_1;
										end
				X_PRE_1					:begin								//u3  prog add&sub
											u3_i_1  <= x_post_1;
											u3_i_2  <= x_post_3;
											u3_op   <= 1;
											u3_sel  <= 0;
											c_state <= X_PRE_1_RDY;
										end
				X_PRE_1_RDY				:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													x_pre_1 <= u3_o;
													c_state <= X_PRE_2;
												end
											else
												c_state <= X_PRE_1_RDY;
										end
				X_PRE_2					:begin
											u3_i_1  <= x_post_2;
											u3_i_2  <= x_post_4;
											u3_op   <= 1;
											u3_sel  <= 0;
											c_state <= X_PRE_2_RDY;
										end
				X_PRE_2_RDY				:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													x_pre_2 <= u3_o;
													c_state <= X_PRE_3;
												end
											else
												c_state <= X_PRE_2_RDY;
										end
				X_PRE_3					:begin
											x_pre_3 <= x_post_3;
											c_state <= X_PRE_4;
										end
				X_PRE_4					:begin
											x_pre_4 <= x_post_4;
											c_state <= P_PRE_4_4;
										end	
				P_PRE_4_4				:begin
											u3_i_1  <= p_post_4_4;
											u3_i_2  <= para_q;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_4_4_RDY;
										end
				P_PRE_4_4_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_pre_4_4 <= u3_o;
													c_state   <= P_PRE_3_3;
												end
											else
												c_state <= P_PRE_4_4_RDY;
										end
				P_PRE_3_3				:begin
											u3_i_1  <= p_post_3_3;
											u3_i_2  <= para_q;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_3_3_RDY;
										end
				P_PRE_3_3_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_pre_3_3 <= u3_o;
													c_state   <= P_PRE_3_1;
												end
											else
												c_state <= P_PRE_3_3_RDY;
										end
				P_PRE_3_1				:begin
											u3_i_1  <= p_post_3_1;
											u3_i_2  <= p_post_3_3;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_3_1_RDY;
										end
				P_PRE_3_1_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_pre_3_1 <= u3_o;
													c_state   <= P_PRE_4_2;
												end
											else
												c_state <= P_PRE_3_1_RDY;
										end
				P_PRE_4_2				:begin
											u3_i_1  <= p_post_4_2;
											u3_i_2  <= p_post_4_4;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_4_2_RDY;
										end
				P_PRE_4_2_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_pre_4_2 <= u3_o;
													c_state   <=P_PRE_1_3;
												end
											else
												c_state <= P_PRE_4_2_RDY;
										end
				P_PRE_1_3				:begin
											u3_i_1  <= p_post_1_3;
											u3_i_2  <= p_post_3_3;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_1_3_RDY;
										end
				P_PRE_1_3_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_pre_1_3 <= u3_o;
													c_state   <= P_PRE_2_4;
												end
											else
												c_state <= P_PRE_1_3_RDY;
										end
				P_PRE_2_4				:begin
											u3_i_1  <= p_post_2_4;
											u3_i_2  <= p_post_4_4;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_2_4_RDY;
										end
				P_PRE_2_4_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_pre_2_4 <= u3_o;
													c_state   <= P_PRE_1_1_1;
												end
											else
												c_state <= P_PRE_2_4_RDY;
										end
				P_PRE_1_1_1				:begin
											u3_i_1  <= p_pre_3_1;
											u3_i_2  <= p_post_1_3;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_1_1_1_RDY;
										end
				P_PRE_1_1_1_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_pre_1_1_1 <= u3_o;
													c_state     <= P_PRE_1_1_2;
												end
											else
												c_state<=P_PRE_1_1_1_RDY;
										end
				P_PRE_1_1_2				:begin
											u3_i_1	<= p_pre_1_1_1;
											u3_i_2	<= p_post_1_1;
											u3_sel	<= 0;
											u3_op   <= 1;
											c_state <= P_PRE_1_1_2_RDY;
										end
				P_PRE_1_1_2_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_pre_1_1_2 <= u3_o;
													c_state     <= P_PRE_1_1;
												end
											else
												c_state <= P_PRE_1_1_2_RDY;
										end
				P_PRE_1_1				:begin
											u3_i_1  <= p_pre_1_1_2;
											u3_i_2  <= para_q;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_1_1_RDY;
										end
				P_PRE_1_1_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_pre_1_1 <= u3_o;
													c_state   <= P_PRE_2_2_1;
												end
											else
												c_state <= P_PRE_1_1_RDY;
										end
				P_PRE_2_2_1				:begin
											u3_i_1  <= p_pre_4_2;
											u3_i_2  <= p_post_4_2;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_2_2_1_RDY;
										end
				P_PRE_2_2_1_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_pre_2_2_1 <= u3_o;
													c_state     <= P_PRE_2_2_2;
												end
											else
												c_state <= P_PRE_2_2_1_RDY;
										end
				P_PRE_2_2_2				:begin
											u3_i_1  <= p_pre_2_2_1;
											u3_i_2  <= p_post_2_2;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_2_2_2_RDY;
										end
				P_PRE_2_2_2_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_pre_2_2_2 <= u3_o;
													c_state     <= P_PRE_2_2;
												end
											else
												c_state <= P_PRE_2_2_2_RDY;
										end
				P_PRE_2_2				:begin
											u3_i_1  <= p_pre_2_2_2;
											u3_i_2  <= para_q;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= P_PRE_2_2_RDY;
										end
				P_PRE_2_2_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_pre_2_2 <= u3_o;
													c_state   <= X_PRE_1_O;
												end
											else
												c_state <= P_PRE_2_2_RDY;
										end							
				X_PRE_1_O				:begin								//u4 flo2fix
											u4_i    <= x_pre_1;
											u4_op   <= 1;
											c_state <= X_PRE_1_O_RDY;
										end
				X_PRE_1_O_RDY			:begin
											u4_op <= 0;
											if(u4_rdy)
												begin
													x_pre_1_o <= u4_o;
													c_state   <= X_PRE_2_O;
												end
											else
												c_state <= X_PRE_1_O_RDY;
										end
				X_PRE_2_O				:begin
											u4_i    <= x_pre_2;
											u4_op   <= 1;
											c_state <= X_PRE_2_O_RDY;
										end
				X_PRE_2_O_RDY			:begin
											u4_op <= 0;
											if(u4_rdy)
												begin
													x_pre_2_o <= u4_o;
													c_state   <= IDLE;
													pre_done  <= 1;
												end
											else
												c_state <= X_PRE_2_O_RDY;
										end
				COM_ALPHA				:begin
											if(cam_s > s_l)
												begin
													remain_s <= {1'b0,cam_s,3'b0} + {3'b0,cam_s,1'b0} - {1'b0,s_l,3'b0} - {3'b0,s_l,1'b0};
													c_state <= ALPHA_RDY;
												end
											//zclin 2017.01.09
											else if(cam_s < 8'd255)
												begin
													full_img <= 1;
													c_state <= IDLE;
												end
											else
												begin
													comp_alpha <= 0;
													c_state    <= CALC_R;
												end
										end
				ALPHA_RDY				:begin
											if(cam_s > 22'd10000 && remain_s >= {4'd0,s_l})
												comp_alpha <= 1;
											else if(cam_s > 22'd2500 && remain_s >= {2'b0,s_l,2'b00} + {4'd0,s_l})
												comp_alpha <= 1;
											else if(cam_s > 22'd900 && remain_s >= {1'b0,s_l,3'b0} + {3'b0,s_l,1'b0})
												comp_alpha <= 1;
											else if(cam_s <= 22'd900 && remain_s >= {1'b0,s_l,3'b0} + {2'b0,s_l,2'b0} + {3'b0,s_l,1'b0} + {4'b0,s_l})
												comp_alpha <= 1;
											else
												comp_alpha <= 0;
												
											c_state <= CALC_R;
										end
				CALC_R					:begin
											if(cam_x_i >= x_pre_1_o)
												r_1 <= cam_x_i - x_pre_1_o;
											else
												r_1 <= x_pre_1_o - cam_x_i;
											
											if(cam_y_i >= x_pre_2_o)
												r_2 <= cam_y_i - x_pre_2_o;
											else
												r_2 <= x_pre_2_o - cam_y_i;
											
											c_state <= COMPARE_R;
										end
				COMPARE_R				:begin
											if(r_1 > 4'd8 || r_2 > 4'd8 || (r_1 > 4'd7 && r_2 > 4'd0) || (r_1 > 4'd0 && r_2 > 4'd7) || (r_1 > 4'd6 && r_2 > 4'd3) || (r_1 > 4'd3 && r_2 > 4'd6) || (r_1 > 4'd5 && r_2 > 4'd5))
												comp_r <= 1;
											else
												comp_r <= 0;
											
											comp_done <= 1;
											c_state   <= IDLE;
										end
				CEN2FLO_X				:begin
											u1_i 	<= new_x_i;
											u1_op 	<= 1;
											c_state <= CEN2FLO_X_RDY;
										end
				CEN2FLO_X_RDY			:begin
											u1_op <= 0;
											if(u1_rdy)
												begin
													x_flo_d0 <= u1_o;
													c_state  <= CEN2FLO_Y;
												end
											else
												c_state <= CEN2FLO_X_RDY;
										end
				CEN2FLO_Y				:begin
											u1_i    <= new_y_i;
											u1_op   <= 1;
											c_state <= CEN2FLO_Y_RDY;
										end
				CEN2FLO_Y_RDY			:begin
											u1_op <= 0;
											if(u1_rdy) 
												begin
													y_flo_d0 <= u1_o;
													c_state  <= IDLE;
													fix2flo_done <= 1;
												end
											else
												c_state <= CEN2FLO_Y_RDY;
										end	
				TEMP_1_1_1				:begin
											u3_i_1  <= p_pre_1_1;
											u3_i_2  <= para_r;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= TEMP_1_1_1_RDY;
										end
				TEMP_1_1_1_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													temp_1_1_1 <= u3_o;
													c_state    <= TEMP_1_2_2;
												end
											else
												c_state <= TEMP_1_1_1_RDY;
										end
				TEMP_1_2_2				:begin
											u3_i_1   <= p_pre_2_2;
											u3_i_2   <= para_r;
											u3_sel   <= 0;
											u3_op    <= 1;
											c_state  <= TEMP_1_2_2_RDY;
										end
				TEMP_1_2_2_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													temp_1_2_2 <= u3_o;
													c_state    <= K_1_1;
												end
											else
												c_state <= TEMP_1_2_2_RDY;
										end
				K_1_1					:begin									//u5 flo div
											u5_i_1  <= p_pre_1_1;
											u5_i_2  <= temp_1_2_2;
											u5_op   <= 1;
											c_state <= K_1_1_RDY;
										end
				K_1_1_RDY				:begin
											u5_op <= 0;
											if(u5_rdy)
												begin
													k_1_1   <= u5_o;
													c_state <= K_2_2;
												end
											else
												c_state <= K_1_1_RDY;
										end
				K_2_2					:begin
											u5_i_1  <= p_pre_2_2;
											u5_i_2  <= temp_1_1_1;
											u5_op   <= 1;
											c_state <= K_2_2_RDY;
										end
				K_2_2_RDY				:begin
											u5_op<=0;
											if(u5_rdy)
												begin
													k_2_2   <= u5_o;
													c_state <= K_3_1;
												end
											else
												c_state <= K_2_2_RDY;
										end
				K_3_1					:begin
											u5_i_1  <= p_pre_3_1;
											u5_i_2  <= temp_1_2_2;
											u5_op   <= 1;
											c_state <= K_3_1_RDY;
										end
				K_3_1_RDY				:begin
											u5_op <= 0;
											if(u5_rdy)
												begin
													k_3_1   <= u5_o;
													c_state <= K_4_2;
												end
											else
												c_state <= K_3_1_RDY;
										end
				K_4_2					:begin
											u5_i_1  <= p_pre_4_2;
											u5_i_2  <= temp_1_1_1;
											u5_op   <= 1;
											c_state <= K_4_2_RDY;
										end
				K_4_2_RDY				:begin
											u5_op<=0;
											if(u5_rdy)
												begin
													k_4_2   <= u5_o;
													c_state <= TEMP_2_1;
												end
											else
												c_state <= K_4_2_RDY;
										end							
				TEMP_2_1				:begin
											u3_i_1  <= z_k_1;
											u3_i_2  <= x_pre_1;
											u3_sel  <= 1;
											u3_op   <= 1;
											c_state <= TEMP_2_1_RDY;
										end
				TEMP_2_1_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													temp_2_1 <= u3_o;
													c_state  <= TEMP_2_2;
												end
											else
												c_state <= TEMP_2_1_RDY;
										end
				TEMP_2_2				:begin
											u3_i_1  <= z_k_2;
											u3_i_2  <= x_pre_2;
											u3_sel  <= 1;
											u3_op   <= 1;
											c_state <= TEMP_2_2_RDY;
										end
				TEMP_2_2_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													temp_2_2 <= u3_o;
													c_state  <= K_TEMP_2_1;
												end
											else
												c_state <= TEMP_2_2_RDY;
										end
				K_TEMP_2_1				:begin										//u6 flo mul 
											u6_i_1  <= k_1_1;
											u6_i_2  <= temp_2_1;
											u6_op   <= 1;
											c_state <= K_TEMP_2_1_RDY;
										end
				K_TEMP_2_1_RDY			:begin
											u6_op <= 0;
											if(u6_rdy)
												begin
													k_temp_2_1 <= u6_o;
													c_state    <= K_TEMP_2_2;
												end
											else	
												c_state <= K_TEMP_2_1_RDY;
										end
				K_TEMP_2_2				:begin
											u6_i_1  <= k_2_2;
											u6_i_2  <= temp_2_2;
											u6_op   <= 1;
											c_state <= K_TEMP_2_2_RDY;
										end
				K_TEMP_2_2_RDY			:begin
											u6_op<=0;
											if(u6_rdy)
												begin
													k_temp_2_2 <= u6_o;
													c_state    <= K_TEMP_2_3;
												end
											else
												c_state <= K_TEMP_2_2_RDY;
										end
				K_TEMP_2_3				:begin
											u6_i_1  <= k_3_1;
											u6_i_2  <= temp_2_1;
											u6_op   <= 1;
											c_state <= K_TEMP_2_3_RDY;
										end
				K_TEMP_2_3_RDY			:begin
											u6_op<=0;
											if(u6_rdy)
												begin
													k_temp_2_3 <= u6_o;
													c_state    <= K_TEMP_2_4;
												end
											else
												c_state <= K_TEMP_2_3_RDY;
										end
				K_TEMP_2_4				:begin
											u6_i_1  <= k_4_2;
											u6_i_2  <= temp_2_2;
											u6_op   <= 1;
											c_state <= K_TEMP_2_4_RDY;
										end
				K_TEMP_2_4_RDY			:begin
											u6_op <= 0;
											if(u6_rdy)
												begin
													k_temp_2_4 <= u6_o;
													c_state    <= X_POST_1;
												end
											else
												c_state <= K_TEMP_2_4_RDY;
										end
				X_POST_1				:begin
											u3_i_1   <= x_pre_1;
											u3_i_2   <= k_temp_2_1;
											u3_sel   <= 0;
											u3_op    <= 1;
											c_state  <= X_POST_1_RDY;
										end
				X_POST_1_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin	
													x_post_1 <= u3_o;
													c_state  <= X_POST_2;
												end
											else
												c_state <= X_POST_1_RDY;
										end
				X_POST_2				:begin
											u3_i_1  <= x_pre_2;
											u3_i_2  <= k_temp_2_2;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= X_POST_2_RDY;
										end
				X_POST_2_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													x_post_2 <= u3_o;
													c_state  <= X_POST_3;
												end
											else
												c_state <= X_POST_2_RDY;
										end
				X_POST_3				:begin
											u3_i_1  <= x_pre_3;
											u3_i_2  <= k_temp_2_3;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= X_POST_3_RDY;
										end
				X_POST_3_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													x_post_3 <= u3_o;
													c_state  <= X_POST_4;
												end
											else	
												c_state<=X_POST_3_RDY;
										end
				X_POST_4				:begin
											u3_i_1  <= x_pre_4;
											u3_i_2  <= k_temp_2_4;
											u3_sel  <= 0;
											u3_op   <= 1;
											c_state <= X_POST_4_RDY;
										end
				X_POST_4_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													x_post_4 <= u3_o;
													c_state  <= K_P_1_1;
												end
											else
												c_state <= X_POST_4_RDY;
										end
				K_P_1_1					:begin
											u6_i_1  <= k_1_1;
											u6_i_2  <= p_pre_1_1;
											u6_op   <= 1;
											c_state <= K_P_1_1_RDY;
										end
				K_P_1_1_RDY				:begin
											u6_op <= 0;
											if(u6_rdy)
												begin	
													k_p_1_1 <= u6_o;
													c_state <= K_P_3_1;
												end
											else
												c_state <= K_P_1_1_RDY;
										end
				K_P_3_1					:begin
											u6_i_1  <= k_3_1;
											u6_i_2  <= p_pre_1_1;
											u6_op   <= 1;
											c_state <= K_P_3_1_RDY;
										end
				K_P_3_1_RDY				:begin
											u6_op<=0;
											if(u6_rdy)
												begin
													k_p_3_1 <=u6_o;
													c_state <= K_P_2_2;
												end
											else
												c_state <= K_P_3_1_RDY;
										end
				K_P_2_2					:begin
											u6_i_1  <= k_2_2;
											u6_i_2  <= p_pre_2_2;
											u6_op   <= 1;
											c_state <= K_P_2_2_RDY;
										end
				K_P_2_2_RDY				:begin
											u6_op<=0;
											if(u6_rdy)
												begin
													k_p_2_2 <= u6_o;
													c_state <= K_P_4_2;
												end
											else
												c_state <= K_P_2_2_RDY;
										end
				K_P_4_2					:begin
											u6_i_1  <= k_4_2;
											u6_i_2  <= p_pre_2_2;
											u6_op   <= 1;
											c_state <= K_P_4_2_RDY;
										end
				K_P_4_2_RDY				:begin
											u6_op <= 0;
											if(u6_rdy)
												begin
													k_p_4_2 <= u6_o;
													c_state <= K_P_1_3;
												end
											else
												c_state <= K_P_4_2_RDY;
										end
				K_P_1_3					:begin
											u6_i_1  <= k_1_1;
											u6_i_2  <= p_pre_1_3;
											u6_op   <= 1;
											c_state <= K_P_1_3_RDY;
										end
				K_P_1_3_RDY				:begin
											u6_op <= 0;
											if(u6_rdy)
												begin
													k_p_1_3 <= u6_o;
													c_state <= K_P_3_3;
												end
											else
												c_state <= K_P_1_3_RDY;
										end								
				K_P_3_3					:begin
											u6_i_1  <= k_3_1;
											u6_i_2  <= p_pre_1_3;
											u6_op   <= 1;
											c_state <= K_P_3_3_RDY;
										end
				K_P_3_3_RDY				:begin
											u6_op <= 0;
											if(u6_rdy)
												begin
													k_p_3_3 <= u6_o;
													c_state <= K_P_2_4;
												end
											else
												c_state <= K_P_3_3_RDY;
										end							
				K_P_2_4					:begin
											u6_i_1   <= k_2_2;
											u6_i_2   <= p_pre_2_4;
											u6_op    <= 1;
											c_state  <= K_P_2_4_RDY;
										end
				K_P_2_4_RDY				:begin
											u6_op<=0;
											if(u6_rdy)
												begin
													k_p_2_4 <= u6_o;
													c_state <= K_P_4_4;
												end
											else
												c_state <= K_P_2_4_RDY;
										end							
				K_P_4_4					:begin
											u6_i_1  <= k_4_2;
											u6_i_2  <= p_pre_2_4;
											u6_op   <= 1;
											c_state <= K_P_4_4_RDY;
										end
				K_P_4_4_RDY				:begin
											u6_op <= 0;
											if(u6_rdy)
												begin
													k_p_4_4 <= u6_o;
													c_state <= P_POST_1_1;
												end
											else
												c_state <= K_P_4_4_RDY;
										end							
				P_POST_1_1				:begin
											u3_i_1   <= p_pre_1_1;
											u3_i_2   <= k_p_1_1;
											u3_sel   <= 1;
											u3_op    <= 1;
											c_state  <= P_POST_1_1_RDY;
										end
				P_POST_1_1_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_post_1_1 <= u3_o;
													c_state    <= P_POST_3_1;
												end
											else
												c_state <= P_POST_1_1_RDY;
										end
				P_POST_3_1				:begin
											u3_i_1  <= p_pre_3_1;
											u3_i_2  <= k_p_3_1;
											u3_sel  <= 1;
											u3_op   <= 1;
											c_state <=P_POST_3_1_RDY;
										end
				P_POST_3_1_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_post_3_1 <= u3_o;
													c_state    <= P_POST_2_2;
												end
											else
												c_state <= P_POST_3_1_RDY;
										end							
				P_POST_2_2				:begin
											u3_i_1  <= p_pre_2_2;
											u3_i_2  <= k_p_2_2;
											u3_sel  <= 1;
											u3_op   <= 1;
											c_state <= P_POST_2_2_RDY;
										end
				P_POST_2_2_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_post_2_2 <= u3_o;
													c_state    <= P_POST_4_2;
												end
											else
												c_state<=P_POST_2_2_RDY;
										end							
				P_POST_4_2				:begin
											u3_i_1  <= p_pre_4_2;
											u3_i_2  <= k_p_4_2;
											u3_sel  <= 1;
											u3_op   <= 1;
											c_state <=P_POST_4_2_RDY;
										end
				P_POST_4_2_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_post_4_2 <= u3_o;
													c_state    <= P_POST_1_3;
												end
											else
												c_state <= P_POST_4_2_RDY;
										end							
				P_POST_1_3				:begin
											u3_i_1  <= p_pre_1_3;
											u3_i_2  <= k_p_1_3;
											u3_sel  <= 1;
											u3_op   <= 1;
											c_state <= P_POST_1_3_RDY;
										end
				P_POST_1_3_RDY			:begin
											u3_op<=0;
											if(u3_rdy)
												begin
													p_post_1_3 <= u3_o;
													c_state    <= P_POST_3_3;
												end
											else
												c_state <= P_POST_1_3_RDY;
										end							
				P_POST_3_3				:begin
											u3_i_1  <= p_pre_3_3;
											u3_i_2  <= k_p_3_3;
											u3_sel  <= 1;
											u3_op   <= 1;
											c_state <= P_POST_3_3_RDY;
										end
				P_POST_3_3_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_post_3_3 <= u3_o;
													c_state    <= P_POST_2_4;
												end
											else
												c_state <= P_POST_3_3_RDY;
										end							
				P_POST_2_4				:begin
											u3_i_1  <= p_pre_2_4;
											u3_i_2  <= k_p_2_4;
											u3_sel  <= 1;
											u3_op   <= 1;
											c_state <= P_POST_2_4_RDY;
										end
				P_POST_2_4_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_post_2_4 <= u3_o;
													c_state    <= P_POST_4_4;
												end
											else
												c_state <= P_POST_2_4_RDY;
										end	
				P_POST_4_4				:begin
											u3_i_1   <= p_pre_4_4;
											u3_i_2   <= k_p_4_4;
											u3_sel   <= 1;
											u3_op    <= 1;
											c_state  <= P_POST_4_4_RDY;
										end
				P_POST_4_4_RDY			:begin
											u3_op <= 0;
											if(u3_rdy)
												begin
													p_post_4_4   <= u3_o;
													cor_done 	 <= 1;
													c_state      <= IDLE;
												end
											else
												c_state <= P_POST_4_4_RDY;
										end
				default					:c_state<=IDLE;
				endcase	
		
	end	
	//------------------2camshift--------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				cam_c_min_o <= 11'd0;
				cam_c_max_o <= 11'd0;
				cam_r_min_o <= 11'd0;
				cam_r_max_o <= 11'd0;
				
				cam_en 		<= 0;
			end
		else if(pre_done)
			begin	
				cam_c_min_o <= c_min_o;
				cam_c_max_o <= c_max_o;
				cam_r_min_o <= r_min_o;
				cam_r_max_o <= r_max_o;
				
				cam_en 		<= 1;
			end
		else
			cam_en <=0;
	end
	//-------------------t_o-------------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				c_min_d0 <= 0;
				c_max_d0 <= 0;
				r_min_d0 <= 0;
				r_max_d0 <= 0;
				
				z_k_1 	<= 0;
				z_k_2	<= 0;
				
				cor_en 	<= 0;
			end
		else if(i_en)
			begin
				c_min_d0 <= c_min_i;
				c_max_d0 <= c_max_i;
				r_min_d0 <= r_min_i;
				r_max_d0 <= r_max_i;
				comp_done_d0 <= 0;
				cor_en <= 0;
			end
		else if(full_img)
			begin
				c_min_d0 <= 11'd0;
				c_max_d0 <= 11'd1279;
				r_min_d0 <= 11'd0;
				r_max_d0 <= 11'd719;
				comp_done_d0 <= 1;
				cor_en <= 0;
			end
		else if(comp_done)
			begin
				//if(comp_alpha == 1 && comp_r == 1)
				if(comp_alpha == 1 && comp_r == 1)
					begin
						if(x_pre_1_o >= l_c_h && x_pre_1_o < w_i)
							c_min_d0 <= x_pre_1_o - l_c_h;
						else if(x_pre_1_o >= w_i)
							c_min_d0 <= w_i - 5'd17;
						else 
							c_min_d0 <= 0;
						
						if(x_pre_1_o < w_i && x_pre_1_o + l_c_h < w_i)
							c_max_d0 <= x_pre_1_o + l_c_h;
						else
							c_max_d0 <= w_i - 1'd1;
							
						if(x_pre_2_o >= l_r_h)
							r_min_d0 <= x_pre_2_o - l_r_h;
						else if(x_pre_2_o >= h_i)
							r_min_d0 <= h_i - 5'd17;
						else
							r_min_d0 <= 0;
						
						if(x_pre_2_o < h_i && x_pre_2_o + l_r_h < h_i)	
							r_max_d0 <= x_pre_2_o + l_r_h;
						else 
							r_max_d0 <= h_i - 1'd1;
						
						comp_done_d0 <= 1;
						cor_en  <= 0;
					end
				else
					begin
						c_min_d0 <= cam_c_min_i;
						c_max_d0 <= cam_c_max_i;
						r_min_d0 <= cam_r_min_i;
						r_max_d0 <= cam_r_max_i;
						cor_en <= 0;
						comp_done_d0  <= 1;
					end
			end
		else if(fix2flo_done)
			begin
				z_k_1   <= x_flo_d0;
				z_k_2   <= y_flo_d0;
				cor_en  <= 1;
				comp_done_d0 <= 0;
			end
		else
			begin
				comp_done_d0 <= 0;
				cor_en		 <= 0;
			end
	end
	//-------------------t_done----------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			t_done <= 0;
		else if(cor_done)
			t_done <= 1;
		else	
			t_done <= 0;
	end
	//-------------------frame_addr------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			frame_addr <= 2'd0;
		else if(t_en)
			frame_addr <= wr_frame_addr - 1'b1;
		else
			frame_addr <= frame_addr;
	end
	//-------------------t_o-------------------------------
	assign r_add_d0 = r_min_o + r_max_o;
	assign c_add_d0 = c_min_o + c_max_o;
	assign new_x_i = c_add_d0[11:1];
	assign new_y_i = r_add_d0[11:1];
	
	
	assign c_min_o = ((c_min_d0 + 5'd16 >= c_max_d0) && (c_max_d0 + 5'd16 <= w_i - 1'b1)) ? c_min_d0 :
					 ((c_min_d0 + 5'd16 >= c_max_d0) && (c_max_d0 + 5'd16 >= w_i - 1'b1)) ? c_max_d0 - 11'd16 : c_min_d0;
	assign c_max_o = ((c_min_d0 + 5'd16 >= c_max_d0) && (c_max_d0 + 5'd16 <= w_i - 1'b1)) ? c_min_d0 + 11'd16 : 
					 ((c_min_d0 + 5'd16 >= c_max_d0) && (c_max_d0 + 5'd16 >= w_i - 1'b1)) ? c_max_d0 : c_max_d0;
	assign r_min_o = ((r_min_d0 + 5'd16 >= r_max_d0) && (r_max_d0 + 5'd16 <= h_i - 1'b1)) ? r_min_d0 :
					 ((r_min_d0 + 5'd16 >= r_max_d0) && (r_max_d0 + 5'd16 >= h_i - 1'b1)) ? r_max_d0 - 11'd16 : r_min_d0;
	assign r_max_o = ((r_min_d0 + 5'd16 >= r_max_d0) && (r_max_d0 + 5'd16 <= h_i - 1'b1)) ? r_min_d0 + 11'd16 : 
					 ((r_min_d0 + 5'd16 >= r_max_d0) && (r_max_d0 + 5'd16 >= h_i - 1'b1)) ? r_max_d0 : r_max_d0;										
	
	//------------------IP core----------------------------
	assign u3_op_1 = u3_op;
	 en_fix2flo 	u1_fix2flo 
						(
							.a(u1_i), // input [10 : 0] a
							.operation_nd(u1_op), // input operation_nd
							.clk(clk), // input clk
							.result(u1_o), // output [31 : 0] result
							.rdy(u1_rdy) // output rdy
						);										
	en_mul_fix 	u2_mul_fix 
						(
							.clk(clk), // input clk
							.a(u2_i_1), // input [10 : 0] a
							.b(u2_i_2), // input [10 : 0] b
							.p(u2_o) // output [21 : 0] p
						);
	en_add 		u3_add 
						(
							.a(u3_i_1), // input [31 : 0] a
							.b(u3_i_2), // input [31 : 0] b
							.operation_nd(u3_op_1), // input operation_nd
							.operation({5'd0,u3_sel}),
							.operation_rfd(), // output operation_rfd
							.clk(clk), // input clk
							.result(u3_o), // output [31 : 0] result
							.rdy(u3_rdy) // output rdy
						);									
	en_flo2fix 	u4_flo2fix 
						(
							.a(u4_i), // input [31 : 0] a
							.operation_nd(u4_op), // input operation_nd
							.clk(clk), // input clk
							.result(u4_o), // output [10 : 0] result
							.rdy(u4_rdy) // output rdy
						);												
	en_div 		u5_div 
						(
							.a(u5_i_1), // input [31 : 0] a
							.b(u5_i_2), // input [31 : 0] b
							.operation_nd(u5_op), // input operation_nd
							.operation_rfd(), // output operation_rfd
							.clk(clk), // input clk
							.result(u5_o), // output [31 : 0] result
							.rdy(u5_rdy) // output rdy
						);										
	en_mul 		u6_mul 
						(
							.a(u6_i_1), // input [31 : 0] a
							.b(u6_i_2), // input [31 : 0] b
							.operation_nd(u6_op), // input operation_nd
							.operation_rfd(), // output operation_rfd
							.clk(clk), // input clk
							.result(u6_o), // output [31 : 0] result
							.rdy(u6_rdy) // output rdy
						); 									
	endmodule										
											
											
											
											
				