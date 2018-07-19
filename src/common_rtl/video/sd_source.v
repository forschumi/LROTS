/*
	F等于0表示偶场，1表示奇场
	模式可选，
	MODE_0 : 灰度移动斜条
	MODE_1 : 竖直彩条
	MODE_2 : 水平彩条
	MODE_3 : 棋盘格
	MODE_4 : 蓝屏
	MODE_5 : 黑屏
*/

module	sd_source(
						input		wire[7 : 0]		MODE_SELECT_8B,
						input		wire					clk_in,
						
						output	wire					o_itu_656_clk,
						output	reg [7 : 0]		o_itu_656_data_8b
						);

/******************************************************************************/
//25p or 50i
parameter		H_FP_13b 						= 13'd4;			//EAV
parameter		H_SYNC_13b 					= 13'd280;		//BLANKING
parameter		H_BP_13b 						= 13'd4;			//SAV
parameter		H_ACTIVE_13b 				= 13'd1440;		//VIDEO : 720 * 2
parameter		H_TOTAL_13b 				= 13'd1728;		//
          	                		
parameter		V_BLANK_13b 				= 13'd25;			//BLANK
parameter		V_ACTIVE_13b 				= 13'd288;		//VIDEO : 576 / 2
parameter		V_TOTAL_13b 				= 13'd313;		//
          	                  	
parameter		EVEN_BLANK_EAV_8b 	= 8'hB6;
parameter		EVEN_BLANK_SAV_8b 	= 8'hAB;
parameter		EVEN_ACTIVE_EAV_8b 	= 8'h9D; 
parameter		EVEN_ACTIVE_SAV_8b 	= 8'h80; 
          	
parameter		ODD_BLANK_EAV_8b 		= 8'hF1; 
parameter		ODD_BLANK_SAV_8b 		= 8'hEC; 
parameter		ODD_ACTIVE_EAV_8b 	= 8'hDA; 
parameter		ODD_ACTIVE_SAV_8b 	= 8'hC7;
/****************************************************************************/
//color parameter
parameter						WHITE_Y_8B 		= 8'd180;
parameter						WHITE_CB_8B 	= 8'd128;
parameter						WHITE_CR_8B 	= 8'd128;
                                	    
parameter						YELLOW_Y_8B 	= 8'd162;
parameter						YELLOW_CB_8B 	= 8'd44;
parameter						YELLOW_CR_8B 	= 8'd142;
                                	    
parameter						CYAN_Y_8B 		= 8'd131;
parameter						CYAN_CB_8B 		= 8'd156;
parameter						CYAN_CR_8B 		= 8'd44;
                                	    
parameter						GREEN_Y_8B 		= 8'd112;
parameter						GREEN_CB_8B 	= 8'd72;
parameter						GREEN_CR_8B 	= 8'd58;
                                      
parameter						MAGENTA_Y_8B 	= 8'd84;
parameter						MAGENTA_CB_8B = 8'd184;
parameter						MAGENTA_CR_8B = 8'd198;
                                      
parameter						RED_Y_8B 			= 8'd65;
parameter						RED_CB_8B 		= 8'd100;
parameter						RED_CR_8B 		= 8'd212;
                                      
parameter						BLUE_Y_8B 		= 8'd35;
parameter						BLUE_CB_8B 		= 8'd212;
parameter						BLUE_CR_8B 		= 8'd114;
                                      
parameter						BLACK_Y_8B 		= 8'd16;
parameter						BLACK_CB_8B 	= 8'd128;
parameter						BLACK_CR_8B 	= 8'd128; 
/******************************************************************************/ 
//h_cnt、v_cnt和F_flag这三个参数可以表示出所有的时序信息
reg	[12: 0]			h_cnt_13b;
reg	[12: 0]			v_cnt_13b;
reg							F_odd_even_flag;

reg	[12: 0]			h_cnt_delay_13b;
reg							F_odd_even_flag_delay;

always @ (posedge	clk_in)
begin
	if(h_cnt_13b == H_TOTAL_13b - 13'd1)
		h_cnt_13b <= 13'd0;
	else
		h_cnt_13b <= h_cnt_13b + 13'd1;
end

always @ (posedge	clk_in)
begin
	if(h_cnt_13b == H_TOTAL_13b - 11'd1)
		begin
			if(v_cnt_13b == V_TOTAL_13b - 13'd1)
				begin
					v_cnt_13b <= 13'd0;
					F_odd_even_flag <= ~F_odd_even_flag;
				end
			else
				begin
					v_cnt_13b <= v_cnt_13b + 13'd1;
					F_odd_even_flag <= F_odd_even_flag;
				end
		end
	else
		begin
			v_cnt_13b <= v_cnt_13b;
			F_odd_even_flag <= F_odd_even_flag;
		end
end

always @ (posedge	clk_in)
begin
	h_cnt_delay_13b				<= h_cnt_13b;
	F_odd_even_flag_delay	<= F_odd_even_flag;
end 
/******************************************************************************/
reg 						v_sync;				//此处的v_sync并不是真正的v_sync，只是为了产生每帧的变化
reg							v_sync_delay;
reg [10: 0]			frm_offset_11b;

always @ (posedge	clk_in)
	v_sync <= (h_cnt_13b == 13'd0) && (v_cnt_13b == 13'd0);
	
always @ (posedge	clk_in)
	v_sync_delay <= v_sync;

	
always @ (posedge	clk_in)	
begin	
	if(v_sync && ~v_sync_delay && ~F_odd_even_flag)
		frm_offset_11b <= frm_offset_11b + 11'd1;
	else
		frm_offset_11b <= frm_offset_11b;
end
/******************************************************************************/
reg 						h_fp;
reg 						h_sync;
reg 						h_bp;
reg 						v_active;

always @ (posedge	clk_in)
begin
	h_fp 		 <= 																											(h_cnt_13b < H_FP_13b);
	h_sync	 <= (h_cnt_13b >= H_FP_13b) 													&& 	(h_cnt_13b < H_FP_13b + H_SYNC_13b);
	h_bp 		 <= (h_cnt_13b >= H_FP_13b + H_SYNC_13b)	 						&& 	(h_cnt_13b < H_FP_13b + H_SYNC_13b + H_BP_13b);

	v_active <= (v_cnt_13b >= V_BLANK_13b);
end

/******************************************************************************/
//mode_0
wire[12: 0]			mode_0_x_pos_active_13b;
reg [12: 0]			mode_0_x_pos_active_temp_13b;
reg	[12: 0]			mode_0_y_pos_active_13b;
reg [12: 0]			mode_0_x_pos_active_offset_13b;
	
reg [7 : 0]			mode_0_y_8b;
reg [7 : 0]			mode_0_cb_8b;
reg [7 : 0]			mode_0_cr_8b;

always @ (posedge	clk_in)
begin			
	mode_0_x_pos_active_temp_13b 		<= h_cnt_13b + 13'd3 - 13'd288;	//add delay
	mode_0_y_pos_active_13b[12: 1]	<= v_cnt_13b[11: 0] - 12'd25;
	mode_0_y_pos_active_13b[0]			<= F_odd_even_flag; 
end

assign	mode_0_x_pos_active_13b	= {1'd0,mode_0_x_pos_active_temp_13b[12 : 1]};
//LV1
always @ (posedge	clk_in)
begin
	mode_0_x_pos_active_offset_13b <= mode_0_x_pos_active_13b + {2'd0,frm_offset_11b};
end
//LV2
always @ (posedge	clk_in)
begin
	mode_0_y_8b		<= mode_0_x_pos_active_offset_13b[7 : 0] + mode_0_y_pos_active_13b[7 : 0];
	mode_0_cb_8b	<= 8'h80;
	mode_0_cr_8b	<= 8'h80;
end
/******************************************************************************/
//mode_1
wire[12: 0]			mode_1_x_pos_active_13b;
reg [12: 0]			mode_1_x_pos_active_temp_13b;

reg [7 : 0]			mode_1_y_8b;
reg [7 : 0]			mode_1_cb_8b;
reg [7 : 0]			mode_1_cr_8b;

reg [15: 0]			h_bound_1st_16b;
reg [15: 0]			h_bound_2nd_16b;
reg [15: 0]			h_bound_3rd_16b;
reg [15: 0]			h_bound_4th_16b;
reg [15: 0]			h_bound_5th_16b;
reg [15: 0]			h_bound_6th_16b;
reg [15: 0]			h_bound_7th_16b;
reg [15: 0]			h_bound_8th_16b;
reg [7 : 0]			h_flag_8b;

always @ (posedge	clk_in)
begin
	mode_1_x_pos_active_temp_13b 		<= h_cnt_13b + 13'd3 - 13'd288;	//add delay
end

assign	mode_1_x_pos_active_13b = {1'd0,mode_1_x_pos_active_temp_13b[12 : 1]};

always @ (posedge	clk_in)
begin	
	h_bound_1st_16b <= 13'd90;
	h_bound_2nd_16b <= 13'd180;
	h_bound_3rd_16b <= 13'd270;
	h_bound_4th_16b <= 13'd360;
	h_bound_5th_16b <= 13'd450;
	h_bound_6th_16b <= 13'd540;
	h_bound_7th_16b <= 13'd630;
	h_bound_8th_16b <= 13'd720;
end

//LV1
always @ (posedge	clk_in)
begin
	h_flag_8b[0] <= (mode_1_x_pos_active_13b < h_bound_1st_16b);
	h_flag_8b[1] <= (mode_1_x_pos_active_13b < h_bound_2nd_16b) && (mode_1_x_pos_active_13b >= h_bound_1st_16b);
	h_flag_8b[2] <= (mode_1_x_pos_active_13b < h_bound_3rd_16b) && (mode_1_x_pos_active_13b >= h_bound_2nd_16b);
	h_flag_8b[3] <= (mode_1_x_pos_active_13b < h_bound_4th_16b) && (mode_1_x_pos_active_13b >= h_bound_3rd_16b);
	h_flag_8b[4] <= (mode_1_x_pos_active_13b < h_bound_5th_16b) && (mode_1_x_pos_active_13b >= h_bound_4th_16b);
	h_flag_8b[5] <= (mode_1_x_pos_active_13b < h_bound_6th_16b) && (mode_1_x_pos_active_13b >= h_bound_5th_16b);
	h_flag_8b[6] <= (mode_1_x_pos_active_13b < h_bound_7th_16b) && (mode_1_x_pos_active_13b >= h_bound_6th_16b);
	h_flag_8b[7] <= (mode_1_x_pos_active_13b < h_bound_8th_16b) && (mode_1_x_pos_active_13b >= h_bound_7th_16b);
end
//LV2				
always @ (posedge	clk_in)
	begin
		case(h_flag_8b)
			8'h01:
				begin
					mode_1_y_8b 	<= WHITE_Y_8B;
					mode_1_cb_8b 	<= WHITE_CB_8B;
					mode_1_cr_8b 	<= WHITE_CR_8B;
				end
			8'h02:
				begin
					mode_1_y_8b 	<= YELLOW_Y_8B;
					mode_1_cb_8b 	<= YELLOW_CB_8B;
					mode_1_cr_8b 	<= YELLOW_CR_8B;
				end
			8'h04:
				begin
					mode_1_y_8b 	<= CYAN_Y_8B;
					mode_1_cb_8b 	<= CYAN_CB_8B;
					mode_1_cr_8b 	<= CYAN_CR_8B;
				end
			8'h08:
				begin
					mode_1_y_8b 	<= GREEN_Y_8B;
					mode_1_cb_8b 	<= GREEN_CB_8B;
					mode_1_cr_8b 	<= GREEN_CR_8B;
				end
			8'h10:
				begin
					mode_1_y_8b 	<= MAGENTA_Y_8B;
					mode_1_cb_8b 	<= MAGENTA_CB_8B;
					mode_1_cr_8b 	<= MAGENTA_CR_8B;
				end
			8'h20:
				begin
					mode_1_y_8b 	<= RED_Y_8B;
					mode_1_cb_8b 	<= RED_CB_8B;
					mode_1_cr_8b 	<= RED_CR_8B;
				end
			8'h40:
				begin
					mode_1_y_8b 	<= BLUE_Y_8B;
					mode_1_cb_8b 	<= BLUE_CB_8B;
					mode_1_cr_8b 	<= BLUE_CR_8B;
				end
			8'h80:
				begin
					mode_1_y_8b 	<= BLACK_Y_8B;
					mode_1_cb_8b 	<= BLACK_CB_8B;
					mode_1_cr_8b 	<= BLACK_CR_8B;
				end
			default:
				begin
					mode_1_y_8b 	<= BLACK_Y_8B;
					mode_1_cb_8b 	<= BLACK_CB_8B;
					mode_1_cr_8b 	<= BLACK_CR_8B;
				end
		endcase
	end
/******************************************************************************/
//mode_2
reg [12: 0]			mode_2_y_pos_active_13b;

reg [7 : 0]			mode_2_y_8b;
reg [7 : 0]			mode_2_cb_8b;
reg [7 : 0]			mode_2_cr_8b;

reg [15: 0]			v_bound_1st_16b;
reg [15: 0]			v_bound_2nd_16b;
reg [15: 0]			v_bound_3rd_16b;
reg [15: 0]			v_bound_4th_16b;
reg [15: 0]			v_bound_5th_16b;
reg [15: 0]			v_bound_6th_16b;
reg [15: 0]			v_bound_7th_16b;
reg [15: 0]			v_bound_8th_16b;
reg [7 : 0]			v_flag_8b;

always @ (posedge	clk_in)
begin
	mode_2_y_pos_active_13b[12: 1]	<= v_cnt_13b[11: 0] - 12'd25;
	mode_2_y_pos_active_13b[0]			<= F_odd_even_flag;
end

always @ (posedge	clk_in)
begin	
	v_bound_1st_16b <= 13'd72;
	v_bound_2nd_16b <= 13'd144;
	v_bound_3rd_16b <= 13'd216;
	v_bound_4th_16b <= 13'd288;
	v_bound_5th_16b <= 13'd360;
	v_bound_6th_16b <= 13'd432;
	v_bound_7th_16b <= 13'd504;
	v_bound_8th_16b <= 13'd576;
end

//LV1
always @ (posedge	clk_in)
begin
	v_flag_8b[0] <= (mode_2_y_pos_active_13b < v_bound_1st_16b);
	v_flag_8b[1] <= (mode_2_y_pos_active_13b < v_bound_2nd_16b) && (mode_2_y_pos_active_13b >= v_bound_1st_16b);
	v_flag_8b[2] <= (mode_2_y_pos_active_13b < v_bound_3rd_16b) && (mode_2_y_pos_active_13b >= v_bound_2nd_16b);
	v_flag_8b[3] <= (mode_2_y_pos_active_13b < v_bound_4th_16b) && (mode_2_y_pos_active_13b >= v_bound_3rd_16b);
	v_flag_8b[4] <= (mode_2_y_pos_active_13b < v_bound_5th_16b) && (mode_2_y_pos_active_13b >= v_bound_4th_16b);
	v_flag_8b[5] <= (mode_2_y_pos_active_13b < v_bound_6th_16b) && (mode_2_y_pos_active_13b >= v_bound_5th_16b);
	v_flag_8b[6] <= (mode_2_y_pos_active_13b < v_bound_7th_16b) && (mode_2_y_pos_active_13b >= v_bound_6th_16b);
	v_flag_8b[7] <= (mode_2_y_pos_active_13b < v_bound_8th_16b) && (mode_2_y_pos_active_13b >= v_bound_7th_16b);
end
//LV2				
always @ (posedge	clk_in)
	begin
		case(v_flag_8b)
			8'h01:
				begin
					mode_2_y_8b 	<= WHITE_Y_8B;
					mode_2_cb_8b 	<= WHITE_CB_8B;
					mode_2_cr_8b 	<= WHITE_CR_8B;
				end
			8'h02:
				begin
					mode_2_y_8b 	<= YELLOW_Y_8B;
					mode_2_cb_8b 	<= YELLOW_CB_8B;
					mode_2_cr_8b 	<= YELLOW_CR_8B;
				end
			8'h04:
				begin
					mode_2_y_8b 	<= CYAN_Y_8B;
					mode_2_cb_8b 	<= CYAN_CB_8B;
					mode_2_cr_8b 	<= CYAN_CR_8B;
				end
			8'h08:
				begin
					mode_2_y_8b 	<= GREEN_Y_8B;
					mode_2_cb_8b 	<= GREEN_CB_8B;
					mode_2_cr_8b 	<= GREEN_CR_8B;
				end
			8'h10:
				begin
					mode_2_y_8b 	<= MAGENTA_Y_8B;
					mode_2_cb_8b 	<= MAGENTA_CB_8B;
					mode_2_cr_8b 	<= MAGENTA_CR_8B;
				end
			8'h20:
				begin
					mode_2_y_8b 	<= RED_Y_8B;
					mode_2_cb_8b 	<= RED_CB_8B;
					mode_2_cr_8b 	<= RED_CR_8B;
				end
			8'h40:
				begin
					mode_2_y_8b 	<= BLUE_Y_8B;
					mode_2_cb_8b 	<= BLUE_CB_8B;
					mode_2_cr_8b 	<= BLUE_CR_8B;
				end
			8'h80:
				begin
					mode_2_y_8b 	<= BLACK_Y_8B;
					mode_2_cb_8b 	<= BLACK_CB_8B;
					mode_2_cr_8b 	<= BLACK_CR_8B;
				end
			default:
				begin
					mode_2_y_8b 	<= BLACK_Y_8B;
					mode_2_cb_8b 	<= BLACK_CB_8B;
					mode_2_cr_8b 	<= BLACK_CR_8B;
				end
		endcase
	end
/******************************************************************************/
//mode_3
wire[12: 0]			mode_3_x_pos_active_13b;
reg [12: 0]			mode_3_x_pos_active_temp_13b;
reg [12: 0]			mode_3_y_pos_active_13b;

reg [7 : 0]			mode_3_y_8b;
reg [7 : 0]			mode_3_cb_8b;
reg [7 : 0]			mode_3_cr_8b;

reg							color_judge;

always @ (posedge	clk_in)
begin				
	mode_3_x_pos_active_temp_13b 		<= h_cnt_13b + 13'd3 - 13'd288;	//add delay
	mode_3_y_pos_active_13b[12: 1]	<= v_cnt_13b[11: 0] - 12'd25;
	mode_3_y_pos_active_13b[0]			<= F_odd_even_flag; 
end
assign	mode_3_x_pos_active_13b					= {1'd0,mode_3_x_pos_active_temp_13b[12 : 1]};

//LV1	
always @ (posedge	clk_in)
begin
	color_judge <= mode_3_x_pos_active_13b[6] + mode_3_y_pos_active_13b[6];
end
//LV2
always @ (posedge	clk_in)
begin
	mode_3_y_8b		<= color_judge ? 8'hff : 8'h00;
	mode_3_cb_8b	<= 8'h80;
	mode_3_cr_8b	<= 8'h80;
end
/******************************************************************************/
//mode_4                    
reg [7 : 0]			mode_4_y_8b;
reg [7 : 0]			mode_4_cb_8b;
reg [7 : 0]			mode_4_cr_8b;

always @ (posedge	clk_in)
begin
	mode_4_y_8b		<= BLUE_Y_8B;
	mode_4_cb_8b	<= BLUE_CB_8B;
	mode_4_cr_8b	<= BLUE_CR_8B;
end 
/******************************************************************************/
//mode_5
reg [7 : 0]			mode_5_y_8b;
reg [7 : 0]			mode_5_cb_8b;
reg [7 : 0]			mode_5_cr_8b;

always @ (posedge	clk_in)
begin
	mode_5_y_8b		<= BLACK_Y_8B;
	mode_5_cb_8b	<= BLACK_CB_8B;
	mode_5_cr_8b	<= BLACK_CR_8B;
end        	     	
/******************************************************************************/
//for data generatio             	
reg [7 : 0]			y_8b;
reg [7 : 0]			cb_8b;
reg [7 : 0]			cr_8b;

always @ (posedge	clk_in)
begin
	case(MODE_SELECT_8B)
		8'd0:
			begin
				y_8b 	<=	mode_0_y_8b;
				cb_8b	<=	mode_0_cb_8b;	
				cr_8b	<=	mode_0_cr_8b;
			end	
		8'd1:
			begin
				y_8b 	<=	mode_1_y_8b;
				cb_8b	<=	mode_1_cb_8b;	
				cr_8b	<=	mode_1_cr_8b;
			end	
		8'd2:
			begin
				y_8b 	<=	mode_2_y_8b;
				cb_8b	<=	mode_2_cb_8b;	
				cr_8b	<=	mode_2_cr_8b;
			end	
		8'd3:
			begin
				y_8b 	<=	mode_3_y_8b;
				cb_8b	<=	mode_3_cb_8b;	
				cr_8b	<=	mode_3_cr_8b;
			end	
		8'd4:
			begin
				y_8b 	<=	mode_4_y_8b;
				cb_8b	<=	mode_4_cb_8b;	
				cr_8b	<=	mode_4_cr_8b;
			end	
		8'd5:
			begin
				y_8b 	<=	mode_5_y_8b;
				cb_8b	<=	mode_5_cb_8b;	
				cr_8b	<=	mode_5_cr_8b;
			end	
		default:
			begin
				y_8b 	<=	mode_0_y_8b;
				cb_8b	<=	mode_0_cb_8b;	
				cr_8b	<=	mode_0_cr_8b;
			end
	endcase
end	
/******************************************************************************/
//Lv10 pipeline

assign	o_itu_656_clk = clk_in;

always @ (posedge	clk_in)
begin
	if(F_odd_even_flag_delay)
		begin
			if(v_active)
				begin
					if(h_fp)
						case(h_cnt_delay_13b)
							13'd0 : o_itu_656_data_8b <= 8'hFF;
							13'd1 : o_itu_656_data_8b <= 8'h00;
							13'd2 : o_itu_656_data_8b <= 8'h00;
							13'd3 : o_itu_656_data_8b <= ODD_ACTIVE_EAV_8b;
							default : o_itu_656_data_8b <= 8'h5A;
						endcase
					else	if(h_sync)
						case(h_cnt_delay_13b[0])
							1'd0 : o_itu_656_data_8b <= 8'h00;
							1'd1 : o_itu_656_data_8b <= 8'h40;
						endcase
					else	if(h_bp)
						case(h_cnt_delay_13b)
							13'd284 : o_itu_656_data_8b <= 8'hFF;
							13'd285 : o_itu_656_data_8b <= 8'h00;
							13'd286 : o_itu_656_data_8b <= 8'h00;
							13'd287 : o_itu_656_data_8b <= ODD_ACTIVE_SAV_8b;
						endcase
					else
						case(h_cnt_delay_13b[1 : 0])
							2'd0 : o_itu_656_data_8b <= cb_8b;
							2'd1 : o_itu_656_data_8b <= y_8b;
							2'd2 : o_itu_656_data_8b <= cr_8b;
							2'd3 : o_itu_656_data_8b <= y_8b;
						endcase										
				end
			else
				begin
					if(h_fp)
						case(h_cnt_delay_13b)
							13'd0 : o_itu_656_data_8b <= 8'hFF;
							13'd1 : o_itu_656_data_8b <= 8'h00;
							13'd2 : o_itu_656_data_8b <= 8'h00;
							13'd3 : o_itu_656_data_8b <= ODD_BLANK_EAV_8b;
							default : o_itu_656_data_8b <= 8'h5A;
						endcase
					else	if(h_sync)
						case(h_cnt_delay_13b[0])
							1'd0 : o_itu_656_data_8b <= 8'h00;
							1'd1 : o_itu_656_data_8b <= 8'h40;
						endcase
					else	if(h_bp)
						case(h_cnt_delay_13b)
							13'd284 : o_itu_656_data_8b <= 8'hFF;
							13'd285 : o_itu_656_data_8b <= 8'h00;
							13'd286 : o_itu_656_data_8b <= 8'h00;
							13'd287 : o_itu_656_data_8b <= ODD_BLANK_SAV_8b;
						endcase
					else
						case(h_cnt_delay_13b[1 : 0])
							2'd0 : o_itu_656_data_8b <= cb_8b;
							2'd1 : o_itu_656_data_8b <= y_8b;
							2'd2 : o_itu_656_data_8b <= cr_8b;
							2'd3 : o_itu_656_data_8b <= y_8b;
						endcase								
				end
		end
	else
		begin
			if(v_active)
				begin
					if(h_fp)
						case(h_cnt_delay_13b)
							13'd0 : o_itu_656_data_8b <= 8'hFF;
							13'd1 : o_itu_656_data_8b <= 8'h00;
							13'd2 : o_itu_656_data_8b <= 8'h00;
							13'd3 : o_itu_656_data_8b <= EVEN_ACTIVE_EAV_8b;
							default : 	o_itu_656_data_8b <= 8'h5A;
						endcase
					else	if(h_sync)
						case(h_cnt_delay_13b[0])
							1'd0 : o_itu_656_data_8b <= 8'h00;
							1'd1 : o_itu_656_data_8b <= 8'h40;
						endcase
					else	if(h_bp)
						case(h_cnt_delay_13b)
							13'd284 : o_itu_656_data_8b <= 8'hFF;
							13'd285 : o_itu_656_data_8b <= 8'h00;
							13'd286 : o_itu_656_data_8b <= 8'h00;
							13'd287 : o_itu_656_data_8b <= EVEN_ACTIVE_SAV_8b;
						endcase
					else
						case(h_cnt_delay_13b[1 : 0])
							2'd0 : o_itu_656_data_8b <= cb_8b;
							2'd1 : o_itu_656_data_8b <= y_8b;
							2'd2 : o_itu_656_data_8b <= cr_8b;
							2'd3 : o_itu_656_data_8b <= y_8b;
						endcase									
				end
			else
				begin
					if(h_fp)
						case(h_cnt_delay_13b)
							13'd0 : o_itu_656_data_8b <= 8'hFF;
							13'd1 : o_itu_656_data_8b <= 8'h00;
							13'd2 : o_itu_656_data_8b <= 8'h00;
							13'd3 : o_itu_656_data_8b <= EVEN_BLANK_EAV_8b;
							default : o_itu_656_data_8b <= 8'h5A;
						endcase
					else	if(h_sync)
						case(h_cnt_delay_13b[0])
							1'd0 : o_itu_656_data_8b <= 8'h00;
							1'd1 : o_itu_656_data_8b <= 8'h40;
						endcase	
					else	if(h_bp)
						case(h_cnt_delay_13b)
							13'd284 : o_itu_656_data_8b <= 8'hFF;
							13'd285 : o_itu_656_data_8b <= 8'h00;
							13'd286 : o_itu_656_data_8b <= 8'h00;
							13'd287 : o_itu_656_data_8b <= EVEN_BLANK_SAV_8b;
						endcase
					else
						case(h_cnt_delay_13b[1 : 0])
							2'd0 : o_itu_656_data_8b <= cb_8b;
							2'd1 : o_itu_656_data_8b <= y_8b;
							2'd2 : o_itu_656_data_8b <= cr_8b;
							2'd3 : o_itu_656_data_8b <= y_8b;
						endcase								
				end
		end
end
endmodule
						


