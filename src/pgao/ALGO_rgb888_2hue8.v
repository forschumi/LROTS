`timescale 1 ns / 1 ps
module ALGO_rgb888_2hue8
#(
	parameter H_HSV_THRE_MIN = 0,
	parameter H_HSV_THRE_MAX = 32'h3DCCCCCD,
	parameter S_HSV_THRE_MIN = 0,
	parameter S_HSV_THRE_MAX = 32'h3DCCCCCD,
	parameter V_HSV_THRE_MIN = 0,
	parameter V_HSV_THRE_MAX = 32'h3DCCCCCD
)
(
	clk,
	rst_n,
	i_vs,
	i_hs,
	i_data_en,
	i_r_8b,
	i_g_8b,
	i_b_8b,
	o_vs,
	o_hs,
	o_hue,
	o_data_en
);

input clk;
input rst_n;
input i_vs;
input i_hs;
input i_data_en;
input [7:0] i_r_8b;
input [7:0] i_g_8b;
input [7:0] i_b_8b;
output o_vs;
output o_hs;
output reg [7:0] o_hue;
output o_data_en;

reg [90:0] o_data_en_temp;
reg [90:0] o_vs_temp;
reg [90:0] o_hs_temp;

parameter	zero				= 0,
			one					= 32'h3F800000,
			two					= 32'h40000000,
			four				= 32'h40800000,
			six					= 32'h40C00000,
			twofivefive			= 32'h437F0000;
parameter 	Add					= 6'd0,
			Subtract			= 6'b000001,
			LessThan			= 6'b001100,
			Equal				= 6'b010100,
			LessThanOrEqual		= 6'b011100,
			GreaterThan			= 6'b100100,
			NotEqual			= 6'b101100,
			GreaterThanOrEqual	= 6'b110100;
			
reg [7:0] 	i_r_8b_temp;	
reg [7:0] 	i_g_8b_temp;
reg [7:0] 	i_b_8b_temp;
always @ (posedge clk) begin
	if(!rst_n) begin
		i_r_8b_temp <= 0;
		i_g_8b_temp <= 0;
		i_b_8b_temp <= 0;
	end
	else begin
		i_r_8b_temp <= i_r_8b;
		i_g_8b_temp <= i_g_8b;
		i_b_8b_temp <= i_b_8b;	
	end
end
//LV1 pipeline: int8 to floating32*******************************************************************************
wire [31:0] rgb_r_f32_n_p1_0;
wire [31:0] rgb_g_f32_n_p1_0;
wire [31:0] rgb_b_f32_n_p1_0;
int8tofloat32 u1_R(
  // .ce(o_data_en_temp[0] ||  o_data_en_temp[2]), 
  .clk(clk),
  .sclr(~rst_n),  
  .a({1'b0, i_r_8b_temp}), 
  .result(rgb_r_f32_n_p1_0)
);
int8tofloat32 u2_G(
  // .ce(o_data_en_temp[0] ||  o_data_en_temp[2]), 
  .clk(clk), 
  .sclr(~rst_n),   
  .a({1'b0, i_g_8b_temp}), 
  .result(rgb_g_f32_n_p1_0)
);
int8tofloat32 u3_B(
  // .ce(o_data_en_temp[0] ||  o_data_en_temp[2]), 
  .clk(clk),
  .sclr(~rst_n),   
  .a({1'b0, i_b_8b_temp}), 
  .result(rgb_b_f32_n_p1_0)
);
reg [31:0] rgb_r_f32_n_p1;
reg [31:0] rgb_g_f32_n_p1;
reg [31:0] rgb_b_f32_n_p1; 
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_n_p1 <= 0;
		rgb_g_f32_n_p1 <= 0;
		rgb_b_f32_n_p1 <= 0;
	end
	else if(o_data_en_temp[2]) begin
		rgb_r_f32_n_p1 <= rgb_r_f32_n_p1_0;
		rgb_g_f32_n_p1 <= rgb_g_f32_n_p1_0;
		rgb_b_f32_n_p1 <= rgb_b_f32_n_p1_0;	
	end
end
//LV2 pipeline: normalize r g b*******************************************************************************
wire [31:0] rgb_r_f32_p2_0;
wire [31:0] rgb_g_f32_p2_0;
wire [31:0] rgb_b_f32_p2_0;
float32_Div u4_R_N(
  // .ce(o_data_en_temp[4] || o_data_en_temp[14] || o_data_en_temp[24] || o_data_en_temp[34]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(rgb_r_f32_n_p1), 
  .b(twofivefive), 
  .result(rgb_r_f32_p2_0)
);
float32_Div u5_G_N(
  // .ce(o_data_en_temp[4] || o_data_en_temp[14] || o_data_en_temp[24] || o_data_en_temp[34]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(rgb_g_f32_n_p1), 
  .b(twofivefive), 
  .result(rgb_g_f32_p2_0)
);
float32_Div u6_B_N(
  // .ce(o_data_en_temp[4] || o_data_en_temp[14] || o_data_en_temp[24] || o_data_en_temp[34]), 
  .clk(clk), 
  .sclr(~rst_n),  
  .a(rgb_b_f32_n_p1), 
  .b(twofivefive), 
  .result(rgb_b_f32_p2_0)
);
reg [31:0] rgb_r_f32_p2;
reg [31:0] rgb_g_f32_p2;
reg [31:0] rgb_b_f32_p2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p2 <= 0;
	    rgb_g_f32_p2 <= 0;
	    rgb_b_f32_p2 <= 0;
	end
	else if(o_data_en_temp[19]) begin
		rgb_r_f32_p2 <= rgb_r_f32_p2_0;
	    rgb_g_f32_p2 <= rgb_g_f32_p2_0;
	    rgb_b_f32_p2 <= rgb_b_f32_p2_0;
	end
end
//LV3 pipeline: compare r g b*******************************************************************************
wire [31:0] gSb_p3_0;
wire [31:0] bSr_p3_0;
wire [31:0] rSg_p3_0;
float32_Add_Sub u7_G_B(
  // .ce(o_data_en_temp[28] || o_data_en_temp[34]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(rgb_g_f32_p2), 
  .b(rgb_b_f32_p2), 
  .operation(Subtract), 
  .result(gSb_p3_0)
);
float32_Add_Sub u8_B_R(
  // .ce(o_data_en_temp[28] || o_data_en_temp[34]), 
  .clk(clk),
  .sclr(~rst_n),   
  .a(rgb_b_f32_p2), 
  .b(rgb_r_f32_p2), 
  .operation(Subtract), 
  .result(bSr_p3_0)
);
float32_Add_Sub u9_R_G(
  // .ce(o_data_en_temp[28] || o_data_en_temp[34]), 
  .clk(clk),
  .sclr(~rst_n), 
  .a(rgb_r_f32_p2), 
  .b(rgb_g_f32_p2), 
  .operation(Subtract), 
  .result(rSg_p3_0)
);
reg [2:0] rgb_compare_p3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_compare_p3 <= 0;
	end
	else begin
		rgb_compare_p3 <= {rSg_p3_0[31], gSb_p3_0[31], bSr_p3_0[31]};
	end
end
reg [31:0] gSb_p3;
reg [31:0] bSr_p3;
reg [31:0] rSg_p3;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p3 <= 0;
		bSr_p3 <= 0;
		rSg_p3 <= 0;
	end
	else begin
		gSb_p3 <= gSb_p3_0;
		bSr_p3 <= bSr_p3_0;
		rSg_p3 <= rSg_p3_0;	
	end
end

reg [31:0] rgb_r_f32_p2_1;
reg [31:0] rgb_g_f32_p2_1;
reg [31:0] rgb_b_f32_p2_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p2_1 <= 0;
		rgb_g_f32_p2_1 <= 0;
		rgb_b_f32_p2_1 <= 0;
	end
	else begin
		rgb_r_f32_p2_1 <= rgb_r_f32_p2;
		rgb_g_f32_p2_1 <= rgb_g_f32_p2;
		rgb_b_f32_p2_1 <= rgb_b_f32_p2;
	end
end	
reg [31:0] rgb_r_f32_p2_2;
reg [31:0] rgb_g_f32_p2_2;
reg [31:0] rgb_b_f32_p2_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p2_2 <= 0;
		rgb_g_f32_p2_2 <= 0;
		rgb_b_f32_p2_2 <= 0;
	end
	else begin
		rgb_r_f32_p2_2 <= rgb_r_f32_p2_1;
		rgb_g_f32_p2_2 <= rgb_g_f32_p2_1;
		rgb_b_f32_p2_2 <= rgb_b_f32_p2_1;
	end
end
reg [31:0] rgb_r_f32_p2_3;
reg [31:0] rgb_g_f32_p2_3;
reg [31:0] rgb_b_f32_p2_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p2_3 <= 0;
		rgb_g_f32_p2_3 <= 0;
		rgb_b_f32_p2_3 <= 0;
	end
	else begin
		rgb_r_f32_p2_3 <= rgb_r_f32_p2_2;
		rgb_g_f32_p2_3 <= rgb_g_f32_p2_2;
		rgb_b_f32_p2_3 <= rgb_b_f32_p2_2;
	end
end	
reg [31:0] rgb_r_f32_p2_4;
reg [31:0] rgb_g_f32_p2_4;
reg [31:0] rgb_b_f32_p2_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p2_4 <= 0;
		rgb_g_f32_p2_4 <= 0;
		rgb_b_f32_p2_4 <= 0;
	end
	else begin
		rgb_r_f32_p2_4 <= rgb_r_f32_p2_3;
		rgb_g_f32_p2_4 <= rgb_g_f32_p2_3;
		rgb_b_f32_p2_4 <= rgb_b_f32_p2_3;
	end
end	
reg [31:0] rgb_r_f32_p2_5;
reg [31:0] rgb_g_f32_p2_5;
reg [31:0] rgb_b_f32_p2_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p2_5 <= 0;
		rgb_g_f32_p2_5 <= 0;
		rgb_b_f32_p2_5 <= 0;
	end
	else begin
		rgb_r_f32_p2_5 <= rgb_r_f32_p2_4;
		rgb_g_f32_p2_5 <= rgb_g_f32_p2_4;
		rgb_b_f32_p2_5 <= rgb_b_f32_p2_4;
	end
end	
// reg [31:0] rgb_r_f32_p2_6;
// reg [31:0] rgb_g_f32_p2_6;
// reg [31:0] rgb_b_f32_p2_6;
// always @ (posedge clk) begin
	// if(!rst_n) begin
		// rgb_r_f32_p2_6 <= 0;
		// rgb_g_f32_p2_6 <= 0;
		// rgb_b_f32_p2_6 <= 0;
	// end
	// else begin
		// rgb_r_f32_p2_6 <= rgb_r_f32_p2_5;
		// rgb_g_f32_p2_6 <= rgb_g_f32_p2_5;
		// rgb_b_f32_p2_6 <= rgb_b_f32_p2_5;
	// end
// end	
// reg [31:0] rgb_r_f32_p2_7;
// reg [31:0] rgb_g_f32_p2_7;
// reg [31:0] rgb_b_f32_p2_7;
// always @ (posedge clk) begin
	// if(!rst_n) begin
		// rgb_r_f32_p2_7 <= 0;
		// rgb_g_f32_p2_7 <= 0;
		// rgb_b_f32_p2_7 <= 0;
	// end
	// else begin
		// rgb_r_f32_p2_7 <= rgb_r_f32_p2_6;
		// rgb_g_f32_p2_7 <= rgb_g_f32_p2_6;
		// rgb_b_f32_p2_7 <= rgb_b_f32_p2_6;
	// end
// end	
reg [31:0] rgb_r_f32_p3;
reg [31:0] rgb_g_f32_p3;
reg [31:0] rgb_b_f32_p3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p3 <= 0;
		rgb_g_f32_p3 <= 0;
		rgb_b_f32_p3 <= 0;
	end
	else begin
		rgb_r_f32_p3 <= rgb_r_f32_p2_5;
		rgb_g_f32_p3 <= rgb_g_f32_p2_5;
		rgb_b_f32_p3 <= rgb_b_f32_p2_5;
	end
end
//LV4 pipeline: calculate rgb_max and rgb_min*******************************************************************************
reg [31:0] rgb_max_p4_0;
reg [31:0] rgb_min_p4_0;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_0 <= 0;
		rgb_min_p4_0 <= 0;
	end
	else begin
		case(rgb_compare_p3)
			3'b001: begin
						rgb_max_p4_0 <= rgb_r_f32_p3;
						rgb_min_p4_0 <= rgb_b_f32_p3;
					end
			3'b011: begin
						rgb_max_p4_0 <= rgb_r_f32_p3;
						rgb_min_p4_0 <= rgb_g_f32_p3;
					end
			3'b010: begin
						rgb_max_p4_0 <= rgb_b_f32_p3;
						rgb_min_p4_0 <= rgb_g_f32_p3;
					end
			3'b101: begin
						rgb_max_p4_0 <= rgb_g_f32_p3;
						rgb_min_p4_0 <= rgb_b_f32_p3;
					end
			3'b100: begin
						rgb_max_p4_0 <= rgb_g_f32_p3;
						rgb_min_p4_0 <= rgb_r_f32_p3;
					end
			3'b110: begin
						rgb_max_p4_0 <= rgb_b_f32_p3;
						rgb_min_p4_0 <= rgb_r_f32_p3;
					end
			default: begin
						rgb_max_p4_0 <= 0;
						rgb_min_p4_0 <= 0;
					end
		endcase
	end
end
reg [31:0] rgb_max_p4;
reg [31:0] rgb_min_p4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4 <= 0;
		rgb_min_p4 <= 0;
	end
	else begin
		rgb_max_p4 <= rgb_max_p4_0;
		rgb_min_p4 <= rgb_min_p4_0;
	end
end

reg [31:0] rgb_r_f32_p3_1;
reg [31:0] rgb_g_f32_p3_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p3_1 <= 0;
		rgb_g_f32_p3_1 <= 0;
	end
	else begin
		rgb_r_f32_p3_1 <= rgb_r_f32_p3;
		rgb_g_f32_p3_1 <= rgb_g_f32_p3;
	end
end	
reg [31:0] rgb_r_f32_p4;
reg [31:0] rgb_g_f32_p4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4 <= 0;
		rgb_g_f32_p4 <= 0;
	end
	else begin
		rgb_r_f32_p4 <= rgb_r_f32_p3_1;
		rgb_g_f32_p4 <= rgb_g_f32_p3_1;
	end
end	

reg [31:0] gSb_p3_1;
reg [31:0] bSr_p3_1;
reg [31:0] rSg_p3_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p3_1 <= 0;
		bSr_p3_1 <= 0;
		rSg_p3_1 <= 0;
	end
	else begin
		gSb_p3_1 <= gSb_p3;
		bSr_p3_1 <= bSr_p3;
		rSg_p3_1 <= rSg_p3;
	end
end
reg [31:0] gSb_p4;
reg [31:0] bSr_p4;
reg [31:0] rSg_p4;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4 <= 0;
		bSr_p4 <= 0;
		rSg_p4 <= 0;
	end
	else begin
		gSb_p4 <= gSb_p3_1;
		bSr_p4 <= bSr_p3_1;
		rSg_p4 <= rSg_p3_1;
	end
end
//LV5 pipeline: calculate s_hsv_f32*******************************************************************************
wire [31:0] s_hsv_tmp_p4_0;
float32_Add_Sub u10_S(
  // .ce(o_data_en_temp[38] || o_data_en_temp[44]), 
  .clk(clk),
  .sclr(~rst_n),   
  .a(rgb_max_p4), 
  .b(rgb_min_p4), 
  .operation(Subtract), 
  .result(s_hsv_tmp_p4_0)
);
reg [31:0] s_hsv_tmp_p4;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p4 <= 0;
	end
	else begin
		s_hsv_tmp_p4 <= s_hsv_tmp_p4_0;
	end
end
reg [31:0] s_hsv_tmp_p4_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p4_1 <= 0;
	end
	else begin
		s_hsv_tmp_p4_1 <= s_hsv_tmp_p4;
	end
end
reg [31:0] s_hsv_tmp_p4_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p4_2 <= 0;
	end
	else begin
		s_hsv_tmp_p4_2 <= s_hsv_tmp_p4_1;
	end
end
reg [31:0] s_hsv_tmp_p4_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p4_3 <= 0;
	end
	else begin
		s_hsv_tmp_p4_3 <= s_hsv_tmp_p4_2;
	end
end
reg [31:0] s_hsv_tmp_p4_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p4_4 <= 0;
	end
	else begin
		s_hsv_tmp_p4_4 <= s_hsv_tmp_p4_3;
	end
end
reg [31:0] s_hsv_tmp_p4_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p4_5 <= 0;
	end
	else begin
		s_hsv_tmp_p4_5 <= s_hsv_tmp_p4_4;
	end
end
reg [31:0] s_hsv_tmp_p5;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5 <= 0;
	end
	else begin
		s_hsv_tmp_p5 <= s_hsv_tmp_p4_5;
	end
end
reg [31:0] s_hsv_f32_p4_1; 
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_f32_p4_1 <= one;
	end
	else begin
		s_hsv_f32_p4_1 <= (|s_hsv_tmp_p4) ? s_hsv_tmp_p4 : one;
	end
end
reg [31:0] s_hsv_f32_p4_2; 
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_f32_p4_2 <= one;
	end
	else begin
		s_hsv_f32_p4_2 <= s_hsv_f32_p4_1;
	end
end
reg [31:0] s_hsv_f32_p4_3; 
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_f32_p4_3 <= one;
	end
	else begin
		s_hsv_f32_p4_3 <= s_hsv_f32_p4_2;
	end
end
reg [31:0] s_hsv_f32_p4_4; 
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_f32_p4_4 <= one;
	end
	else begin
		s_hsv_f32_p4_4 <= s_hsv_f32_p4_3;
	end
end
reg [31:0] s_hsv_f32_p4_5; 
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_f32_p4_5 <= one;
	end
	else begin
		s_hsv_f32_p4_5 <= s_hsv_f32_p4_4;
	end
end
reg [31:0] s_hsv_f32_p5; 
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_f32_p5 <= one;
	end
	else begin
		s_hsv_f32_p5 <= s_hsv_f32_p4_5;
	end
end

reg [31:0] rgb_r_f32_p4_1;
reg [31:0] rgb_g_f32_p4_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_1 <= 0;
		rgb_g_f32_p4_1 <= 0;
	end
	else begin
		rgb_r_f32_p4_1 <= rgb_r_f32_p4;
		rgb_g_f32_p4_1 <= rgb_g_f32_p4;
	end
end
reg [31:0] rgb_r_f32_p4_2;
reg [31:0] rgb_g_f32_p4_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_2 <= 0;
		rgb_g_f32_p4_2 <= 0;
	end
	else begin
		rgb_r_f32_p4_2 <= rgb_r_f32_p4_1;
		rgb_g_f32_p4_2 <= rgb_g_f32_p4_1;
	end
end
reg [31:0] rgb_r_f32_p4_3;
reg [31:0] rgb_g_f32_p4_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_3 <= 0;
		rgb_g_f32_p4_3 <= 0;
	end
	else begin
		rgb_r_f32_p4_3 <= rgb_r_f32_p4_2;
		rgb_g_f32_p4_3 <= rgb_g_f32_p4_2;
	end
end
reg [31:0] rgb_r_f32_p4_4;
reg [31:0] rgb_g_f32_p4_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_4 <= 0;
		rgb_g_f32_p4_4 <= 0;
	end
	else begin
		rgb_r_f32_p4_4 <= rgb_r_f32_p4_3;
		rgb_g_f32_p4_4 <= rgb_g_f32_p4_3;
	end
end
reg [31:0] rgb_r_f32_p4_5;
reg [31:0] rgb_g_f32_p4_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_5 <= 0;
		rgb_g_f32_p4_5 <= 0;
	end
	else begin
		rgb_r_f32_p4_5 <= rgb_r_f32_p4_4;
		rgb_g_f32_p4_5 <= rgb_g_f32_p4_4;
	end
end
reg [31:0] rgb_r_f32_p4_6;
reg [31:0] rgb_g_f32_p4_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_6 <= 0;
		rgb_g_f32_p4_6 <= 0;
	end
	else begin
		rgb_r_f32_p4_6 <= rgb_r_f32_p4_5;
		rgb_g_f32_p4_6 <= rgb_g_f32_p4_5;
	end
end
reg [31:0] rgb_r_f32_p4_7;
reg [31:0] rgb_g_f32_p4_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_7 <= 0;
		rgb_g_f32_p4_7 <= 0;
	end
	else begin
		rgb_r_f32_p4_7 <= rgb_r_f32_p4_6;
		rgb_g_f32_p4_7 <= rgb_g_f32_p4_6;
	end
end
reg [31:0] rgb_r_f32_p4_8;
reg [31:0] rgb_g_f32_p4_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_8 <= 0;
		rgb_g_f32_p4_8 <= 0;
	end
	else begin
		rgb_r_f32_p4_8 <= rgb_r_f32_p4_7;
		rgb_g_f32_p4_8 <= rgb_g_f32_p4_7;
	end
end
reg [31:0] rgb_r_f32_p4_9;
reg [31:0] rgb_g_f32_p4_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_9 <= 0;
		rgb_g_f32_p4_9 <= 0;
	end
	else begin
		rgb_r_f32_p4_9 <= rgb_r_f32_p4_8;
		rgb_g_f32_p4_9 <= rgb_g_f32_p4_8;
	end
end
reg [31:0] rgb_r_f32_p4_10;
reg [31:0] rgb_g_f32_p4_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_10 <= 0;
		rgb_g_f32_p4_10 <= 0;
	end
	else begin
		rgb_r_f32_p4_10 <= rgb_r_f32_p4_9;
		rgb_g_f32_p4_10 <= rgb_g_f32_p4_9;
	end
end
reg [31:0] rgb_r_f32_p4_11;
reg [31:0] rgb_g_f32_p4_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p4_11 <= 0;
		rgb_g_f32_p4_11 <= 0;
	end
	else begin
		rgb_r_f32_p4_11 <= rgb_r_f32_p4_10;
		rgb_g_f32_p4_11 <= rgb_g_f32_p4_10;
	end
end
reg [31:0] rgb_r_f32_p5;
reg [31:0] rgb_g_f32_p5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5 <= 0;
		rgb_g_f32_p5 <= 0;
	end
	else begin
		rgb_r_f32_p5 <= rgb_r_f32_p4_11;
		rgb_g_f32_p5 <= rgb_g_f32_p4_11;
	end
end
reg [31:0] gSb_p4_1;
reg [31:0] bSr_p4_1;
reg [31:0] rSg_p4_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_1 <= 0;
		bSr_p4_1 <= 0;
		rSg_p4_1 <= 0;
	end
	else begin
		gSb_p4_1 <= gSb_p4;
		bSr_p4_1 <= bSr_p4;
		rSg_p4_1 <= rSg_p4;
	end
end
reg [31:0] gSb_p4_2;
reg [31:0] bSr_p4_2;
reg [31:0] rSg_p4_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_2  <= 0;
		bSr_p4_2  <= 0;
		rSg_p4_2  <= 0;
	end
	else begin
		gSb_p4_2 <= gSb_p4_1;
		bSr_p4_2 <= bSr_p4_1;
		rSg_p4_2 <= rSg_p4_1;
	end
end
reg [31:0] gSb_p4_3;
reg [31:0] bSr_p4_3;
reg [31:0] rSg_p4_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_3 <= 0;
		bSr_p4_3 <= 0;
		rSg_p4_3 <= 0;
	end
	else begin
		gSb_p4_3 <= gSb_p4_2;
		bSr_p4_3 <= bSr_p4_2;
		rSg_p4_3 <= rSg_p4_2;
	end
end
reg [31:0] gSb_p4_4;
reg [31:0] bSr_p4_4;
reg [31:0] rSg_p4_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_4 <= 0;
		bSr_p4_4 <= 0;
		rSg_p4_4 <= 0;
	end
	else begin
		gSb_p4_4 <= gSb_p4_3;
		bSr_p4_4 <= bSr_p4_3;
		rSg_p4_4 <= rSg_p4_3;
	end
end
reg [31:0] gSb_p4_5;
reg [31:0] bSr_p4_5;
reg [31:0] rSg_p4_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_5 <= 0;
		bSr_p4_5 <= 0;
		rSg_p4_5 <= 0;
	end
	else begin
		gSb_p4_5 <= gSb_p4_4;
		bSr_p4_5 <= bSr_p4_4;
		rSg_p4_5 <= rSg_p4_4;
	end
end
reg [31:0] gSb_p4_6;
reg [31:0] bSr_p4_6;
reg [31:0] rSg_p4_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_6 <= 0;
		bSr_p4_6 <= 0;
		rSg_p4_6 <= 0;
	end
	else begin
		gSb_p4_6 <= gSb_p4_5;
		bSr_p4_6 <= bSr_p4_5;
		rSg_p4_6 <= rSg_p4_5;
	end
end
reg [31:0] gSb_p4_7;
reg [31:0] bSr_p4_7;
reg [31:0] rSg_p4_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_7 <= 0;
		bSr_p4_7 <= 0;
		rSg_p4_7 <= 0;
	end
	else begin
		gSb_p4_7 <= gSb_p4_6;
		bSr_p4_7 <= bSr_p4_6;
		rSg_p4_7 <= rSg_p4_6;
	end
end
reg [31:0] gSb_p4_8;
reg [31:0] bSr_p4_8;
reg [31:0] rSg_p4_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_8 <= 0;
		bSr_p4_8 <= 0;
		rSg_p4_8 <= 0;
	end
	else begin
		gSb_p4_8 <= gSb_p4_7;
		bSr_p4_8 <= bSr_p4_7;
		rSg_p4_8 <= rSg_p4_7;
	end
end
reg [31:0] gSb_p4_9;
reg [31:0] bSr_p4_9;
reg [31:0] rSg_p4_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_9 <= 0;
		bSr_p4_9 <= 0;
		rSg_p4_9 <= 0;
	end
	else begin
		gSb_p4_9 <= gSb_p4_8;
		bSr_p4_9 <= bSr_p4_8;
		rSg_p4_9 <= rSg_p4_8;
	end
end
reg [31:0] gSb_p4_10;
reg [31:0] bSr_p4_10;
reg [31:0] rSg_p4_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_10 <= 0;
		bSr_p4_10 <= 0;
		rSg_p4_10 <= 0;
	end
	else begin
		gSb_p4_10 <= gSb_p4_9;
		bSr_p4_10 <= bSr_p4_9;
		rSg_p4_10 <= rSg_p4_9;
	end
end
reg [31:0] gSb_p4_11;
reg [31:0] bSr_p4_11;
reg [31:0] rSg_p4_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p4_11 <= 0;
		bSr_p4_11 <= 0;
		rSg_p4_11 <= 0;
	end
	else begin
		gSb_p4_11 <= gSb_p4_10;
		bSr_p4_11 <= bSr_p4_10;
		rSg_p4_11 <= rSg_p4_10;
	end
end
reg [31:0] gSb_p5;
reg [31:0] bSr_p5;
reg [31:0] rSg_p5;
always @ (posedge clk) begin
	if(!rst_n) begin
		gSb_p5 <= 0;
		bSr_p5 <= 0;
		rSg_p5 <= 0;
	end
	else begin
		gSb_p5 <= gSb_p4_11;
		bSr_p5 <= bSr_p4_11;
		rSg_p5 <= rSg_p4_11;
	end
end
reg [31:0] rgb_max_p4_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_1 <= 0;
	end
	else begin
		rgb_max_p4_1 <= rgb_max_p4;
	end
end
reg [31:0] rgb_max_p4_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_2 <= 0;
	end
	else begin
		rgb_max_p4_2 <= rgb_max_p4_1;
	end
end
reg [31:0] rgb_max_p4_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_3 <= 0;
	end
	else begin
		rgb_max_p4_3 <= rgb_max_p4_2;
	end
end
reg [31:0] rgb_max_p4_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_4 <= 0;
	end
	else begin
		rgb_max_p4_4 <= rgb_max_p4_3;
	end
end
reg [31:0] rgb_max_p4_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_5 <= 0;
	end
	else begin
		rgb_max_p4_5 <= rgb_max_p4_4;
	end
end
reg [31:0] rgb_max_p4_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_6 <= 0;
	end
	else begin
		rgb_max_p4_6 <= rgb_max_p4_5;
	end
end
reg [31:0] rgb_max_p4_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_7 <= 0;
	end
	else begin
		rgb_max_p4_7 <= rgb_max_p4_6;
	end
end
reg [31:0] rgb_max_p4_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_8 <= 0;
	end
	else begin
		rgb_max_p4_8 <= rgb_max_p4_7;
	end
end
reg [31:0] rgb_max_p4_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_9 <= 0;
	end
	else begin
		rgb_max_p4_9 <= rgb_max_p4_8;
	end
end
reg [31:0] rgb_max_p4_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_10 <= 0;
	end
	else begin
		rgb_max_p4_10 <= rgb_max_p4_9;
	end
end
reg [31:0] rgb_max_p4_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p4_11 <= 0;
	end
	else begin
		rgb_max_p4_11 <= rgb_max_p4_10;
	end
end
reg [31:0] rgb_max_p5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5 <= 0;
	end
	else begin
		rgb_max_p5 <= rgb_max_p4_11;
	end
end
reg [31:0] i_rgbDs_p4_1;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_1 <= 0;
	end
	else begin
		i_rgbDs_p4_1 <= (rgb_max_p4 == rgb_r_f32_p4) ? gSb_p4 : ((rgb_max_p4 == rgb_g_f32_p4) ? bSr_p4 : rSg_p4);	
	end
end
reg [31:0] i_rgbDs_p4_2;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_2 <= 0;
	end
	else begin
		i_rgbDs_p4_2 <= i_rgbDs_p4_1;	
	end
end
reg [31:0] i_rgbDs_p4_3;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_3 <= 0;
	end
	else begin
		i_rgbDs_p4_3 <= i_rgbDs_p4_2;	
	end
end
reg [31:0] i_rgbDs_p4_4;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_4 <= 0;
	end
	else begin
		i_rgbDs_p4_4 <= i_rgbDs_p4_3;	
	end
end
reg [31:0] i_rgbDs_p4_5;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_5 <= 0;
	end
	else begin
		i_rgbDs_p4_5 <= i_rgbDs_p4_4;	
	end
end
reg [31:0] i_rgbDs_p4_6;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_6 <= 0;
	end
	else begin
		i_rgbDs_p4_6 <= i_rgbDs_p4_5;	
	end
end
reg [31:0] i_rgbDs_p4_7;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_7 <= 0;
	end
	else begin
		i_rgbDs_p4_7 <= i_rgbDs_p4_6;	
	end
end
reg [31:0] i_rgbDs_p4_8;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_8 <= 0;
	end
	else begin
		i_rgbDs_p4_8 <= i_rgbDs_p4_7;	
	end
end
reg [31:0] i_rgbDs_p4_9;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_9 <= 0;
	end
	else begin
		i_rgbDs_p4_9 <= i_rgbDs_p4_8;	
	end
end
reg [31:0] i_rgbDs_p4_10;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_10 <= 0;
	end
	else begin
		i_rgbDs_p4_10 <= i_rgbDs_p4_9;	
	end
end
reg [31:0] i_rgbDs_p4_11;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p4_11 <= 0;
	end
	else begin
		i_rgbDs_p4_11 <= i_rgbDs_p4_10;	
	end
end
reg [31:0] i_rgbDs_p5;	
always @ (posedge clk) begin
	if(!rst_n) begin
		i_rgbDs_p5 <= 0;
	end
	else begin
		i_rgbDs_p5 <= i_rgbDs_p4_11;	
	end
end
//LV6 pipeline: calculate h_hsv Divide*******************************************************************************
wire [31:0] rgbDs_f32_p6_0;
float32_Div u11_rgbDs(
  // .ce(o_data_en_temp[50] || o_data_en_temp[60] || o_data_en_temp[72]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(i_rgbDs_p5), 
  .b(s_hsv_f32_p5), 
  .result(rgbDs_f32_p6_0)
);

wire [31:0] s_hsv_trans_t_p6_0;
float32_Div u12_s_hsv(
  // .ce(o_data_en_temp[50] || o_data_en_temp[60] || o_data_en_temp[72]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(s_hsv_f32_p5), 
  .b(rgb_max_p5), 
  .result(s_hsv_trans_t_p6_0)
);

reg [31:0] rgbDs_f32_p6;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgbDs_f32_p6 <= 0;
	end
	else if(o_data_en_temp[56]) begin
		rgbDs_f32_p6 <= rgbDs_f32_p6_0;
	end
	else begin
		rgbDs_f32_p6 <= rgbDs_f32_p6;
	end
end
reg [31:0] s_hsv_trans_t_p6;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_trans_t_p6 <= 0;
	end
	else if(o_data_en_temp[56]) begin
		s_hsv_trans_t_p6 <= s_hsv_trans_t_p6_0;
	end
	else begin
		s_hsv_trans_t_p6 <= s_hsv_trans_t_p6;
	end
end
// reg [31:0] rgbDs_f32_p6;
// always @ (posedge clk) begin
	// if(!rst_n) begin
		// rgbDs_f32_p6 <= 0;
	// end
	// else begin
		// rgbDs_f32_p6 <= rgbDs_f32_p6_1;
	// end
// end

reg [31:0] rgb_r_f32_p5_1;
reg [31:0] rgb_g_f32_p5_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_1 <= 0;
		rgb_g_f32_p5_1 <= 0;
	end
	else begin
		rgb_r_f32_p5_1 <= rgb_r_f32_p5;
		rgb_g_f32_p5_1 <= rgb_g_f32_p5;
	end
end
reg [31:0] rgb_r_f32_p5_2;
reg [31:0] rgb_g_f32_p5_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_2 <= 0;
		rgb_g_f32_p5_2 <= 0;
	end
	else begin
		rgb_r_f32_p5_2 <= rgb_r_f32_p5_1;
		rgb_g_f32_p5_2 <= rgb_g_f32_p5_1;
	end
end
reg [31:0] rgb_r_f32_p5_3;
reg [31:0] rgb_g_f32_p5_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_3 <= 0;
		rgb_g_f32_p5_3 <= 0;
	end
	else begin
		rgb_r_f32_p5_3 <= rgb_r_f32_p5_2;
		rgb_g_f32_p5_3 <= rgb_g_f32_p5_2;
	end
end
reg [31:0] rgb_r_f32_p5_4;
reg [31:0] rgb_g_f32_p5_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_4 <= 0;
		rgb_g_f32_p5_4 <= 0;
	end
	else begin
		rgb_r_f32_p5_4 <= rgb_r_f32_p5_3;
		rgb_g_f32_p5_4 <= rgb_g_f32_p5_3;
	end
end
reg [31:0] rgb_r_f32_p5_5;
reg [31:0] rgb_g_f32_p5_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_5 <= 0;
		rgb_g_f32_p5_5 <= 0;
	end
	else begin
		rgb_r_f32_p5_5 <= rgb_r_f32_p5_4;
		rgb_g_f32_p5_5 <= rgb_g_f32_p5_4;
	end
end
reg [31:0] rgb_r_f32_p5_6;
reg [31:0] rgb_g_f32_p5_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_6 <= 0;
		rgb_g_f32_p5_6 <= 0;
	end
	else begin
		rgb_r_f32_p5_6 <= rgb_r_f32_p5_5;
		rgb_g_f32_p5_6 <= rgb_g_f32_p5_5;
	end
end
reg [31:0] rgb_r_f32_p5_7;
reg [31:0] rgb_g_f32_p5_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_7 <= 0;
		rgb_g_f32_p5_7 <= 0;
	end
	else begin
		rgb_r_f32_p5_7 <= rgb_r_f32_p5_6;
		rgb_g_f32_p5_7 <= rgb_g_f32_p5_6;
	end
end
reg [31:0] rgb_r_f32_p5_8;
reg [31:0] rgb_g_f32_p5_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_8 <= 0;
		rgb_g_f32_p5_8 <= 0;
	end
	else begin
		rgb_r_f32_p5_8 <= rgb_r_f32_p5_7;
		rgb_g_f32_p5_8 <= rgb_g_f32_p5_7;
	end
end
reg [31:0] rgb_r_f32_p5_9;
reg [31:0] rgb_g_f32_p5_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_9 <= 0;
		rgb_g_f32_p5_9 <= 0;
	end
	else begin
		rgb_r_f32_p5_9 <= rgb_r_f32_p5_8;
		rgb_g_f32_p5_9 <= rgb_g_f32_p5_8;
	end
end
reg [31:0] rgb_r_f32_p5_10;
reg [31:0] rgb_g_f32_p5_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_10 <= 0;
		rgb_g_f32_p5_10 <= 0;
	end
	else begin
		rgb_r_f32_p5_10 <= rgb_r_f32_p5_9;
		rgb_g_f32_p5_10 <= rgb_g_f32_p5_9;
	end
end
reg [31:0] rgb_r_f32_p5_11;
reg [31:0] rgb_g_f32_p5_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_11 <= 0;
		rgb_g_f32_p5_11 <= 0;
	end
	else begin
		rgb_r_f32_p5_11 <= rgb_r_f32_p5_10;
		rgb_g_f32_p5_11 <= rgb_g_f32_p5_10;
	end
end
reg [31:0] rgb_r_f32_p5_12;
reg [31:0] rgb_g_f32_p5_12;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_12 <= 0;
		rgb_g_f32_p5_12 <= 0;
	end
	else begin
		rgb_r_f32_p5_12 <= rgb_r_f32_p5_11;
		rgb_g_f32_p5_12 <= rgb_g_f32_p5_11;
	end
end
reg [31:0] rgb_r_f32_p5_13;
reg [31:0] rgb_g_f32_p5_13;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_13 <= 0;
		rgb_g_f32_p5_13 <= 0;
	end
	else begin
		rgb_r_f32_p5_13 <= rgb_r_f32_p5_12;
		rgb_g_f32_p5_13 <= rgb_g_f32_p5_12;
	end
end
reg [31:0] rgb_r_f32_p5_14;
reg [31:0] rgb_g_f32_p5_14;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_14 <= 0;
		rgb_g_f32_p5_14 <= 0;
	end
	else begin
		rgb_r_f32_p5_14 <= rgb_r_f32_p5_13;
		rgb_g_f32_p5_14 <= rgb_g_f32_p5_13;
	end
end
reg [31:0] rgb_r_f32_p5_15;
reg [31:0] rgb_g_f32_p5_15;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_15 <= 0;
		rgb_g_f32_p5_15 <= 0;
	end
	else begin
		rgb_r_f32_p5_15 <= rgb_r_f32_p5_14;
		rgb_g_f32_p5_15 <= rgb_g_f32_p5_14;
	end
end
reg [31:0] rgb_r_f32_p5_16;
reg [31:0] rgb_g_f32_p5_16;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_16 <= 0;
		rgb_g_f32_p5_16 <= 0;
	end
	else begin
		rgb_r_f32_p5_16 <= rgb_r_f32_p5_15;
		rgb_g_f32_p5_16 <= rgb_g_f32_p5_15;
	end
end
reg [31:0] rgb_r_f32_p5_17;
reg [31:0] rgb_g_f32_p5_17;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_17 <= 0;
		rgb_g_f32_p5_17 <= 0;
	end
	else begin
		rgb_r_f32_p5_17 <= rgb_r_f32_p5_16;
		rgb_g_f32_p5_17 <= rgb_g_f32_p5_16;
	end
end
reg [31:0] rgb_r_f32_p5_18;
reg [31:0] rgb_g_f32_p5_18;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p5_18 <= 0;
		rgb_g_f32_p5_18 <= 0;
	end
	else begin
		rgb_r_f32_p5_18 <= rgb_r_f32_p5_17;
		rgb_g_f32_p5_18 <= rgb_g_f32_p5_17;
	end
end
reg [31:0] rgb_r_f32_p6;
reg [31:0] rgb_g_f32_p6;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_r_f32_p6 <= 0;
		rgb_g_f32_p6 <= 0;
	end
	else begin
		rgb_r_f32_p6 <= rgb_r_f32_p5_18;
		rgb_g_f32_p6 <= rgb_g_f32_p5_18;
	end
end

reg [31:0] s_hsv_tmp_p5_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_1 <= 0;
	end
	else begin
		s_hsv_tmp_p5_1 <= s_hsv_tmp_p5;
	end
end
reg [31:0] s_hsv_tmp_p5_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_2 <= 0;
	end
	else begin
		s_hsv_tmp_p5_2 <= s_hsv_tmp_p5_1;
	end
end
reg [31:0] s_hsv_tmp_p5_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_3 <= 0;
	end
	else begin
		s_hsv_tmp_p5_3 <= s_hsv_tmp_p5_2;
	end
end
reg [31:0] s_hsv_tmp_p5_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_4 <= 0;
	end
	else begin
		s_hsv_tmp_p5_4 <= s_hsv_tmp_p5_3;
	end
end
reg [31:0] s_hsv_tmp_p5_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_5 <= 0;
	end
	else begin
		s_hsv_tmp_p5_5 <= s_hsv_tmp_p5_4;
	end
end
reg [31:0] s_hsv_tmp_p5_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_6 <= 0;
	end
	else begin
		s_hsv_tmp_p5_6 <= s_hsv_tmp_p5_5;
	end
end
reg [31:0] s_hsv_tmp_p5_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_7 <= 0;
	end
	else begin
		s_hsv_tmp_p5_7 <= s_hsv_tmp_p5_6;
	end
end
reg [31:0] s_hsv_tmp_p5_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_8 <= 0;
	end
	else begin
		s_hsv_tmp_p5_8 <= s_hsv_tmp_p5_7;
	end
end
reg [31:0] s_hsv_tmp_p5_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_9 <= 0;
	end
	else begin
		s_hsv_tmp_p5_9 <= s_hsv_tmp_p5_8;
	end
end
reg [31:0] s_hsv_tmp_p5_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_10 <= 0;
	end
	else begin
		s_hsv_tmp_p5_10 <= s_hsv_tmp_p5_9;
	end
end
reg [31:0] s_hsv_tmp_p5_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_11 <= 0;
	end
	else begin
		s_hsv_tmp_p5_11 <= s_hsv_tmp_p5_10;
	end
end
reg [31:0] s_hsv_tmp_p5_12;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_12 <= 0;
	end
	else begin
		s_hsv_tmp_p5_12 <= s_hsv_tmp_p5_11;
	end
end
reg [31:0] s_hsv_tmp_p5_13;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_13 <= 0;
	end
	else begin
		s_hsv_tmp_p5_13 <= s_hsv_tmp_p5_12;
	end
end
reg [31:0] s_hsv_tmp_p5_14;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_14 <= 0;
	end
	else begin
		s_hsv_tmp_p5_14 <= s_hsv_tmp_p5_13;
	end
end
reg [31:0] s_hsv_tmp_p5_15;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_15 <= 0;
	end
	else begin
		s_hsv_tmp_p5_15 <= s_hsv_tmp_p5_14;
	end
end
reg [31:0] s_hsv_tmp_p5_16;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_16 <= 0;
	end
	else begin
		s_hsv_tmp_p5_16 <= s_hsv_tmp_p5_15;
	end
end
reg [31:0] s_hsv_tmp_p5_17;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_17 <= 0;
	end
	else begin
		s_hsv_tmp_p5_17 <= s_hsv_tmp_p5_16;
	end
end
reg [31:0] s_hsv_tmp_p5_18;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p5_18 <= 0;
	end
	else begin
		s_hsv_tmp_p5_18 <= s_hsv_tmp_p5_17;
	end
end
reg [31:0] s_hsv_tmp_p6;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p6 <= 0;
	end
	else begin
		s_hsv_tmp_p6 <= s_hsv_tmp_p5_18;
	end
end

reg [31:0] rgb_max_p5_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_1 <= 0;
	end
	else begin
		rgb_max_p5_1 <= rgb_max_p5;
	end
end
reg [31:0] rgb_max_p5_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_2 <= 0;
	end
	else begin
		rgb_max_p5_2 <= rgb_max_p5_1;
	end
end
reg [31:0] rgb_max_p5_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_3 <= 0;
	end
	else begin
		rgb_max_p5_3 <= rgb_max_p5_2;
	end
end
reg [31:0] rgb_max_p5_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_4 <= 0;
	end
	else begin
		rgb_max_p5_4 <= rgb_max_p5_3;
	end
end
reg [31:0] rgb_max_p5_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_5 <= 0;
	end
	else begin
		rgb_max_p5_5 <= rgb_max_p5_4;
	end
end
reg [31:0] rgb_max_p5_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_6 <= 0;
	end
	else begin
		rgb_max_p5_6 <= rgb_max_p5_5;
	end
end
reg [31:0] rgb_max_p5_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_7 <= 0;
	end
	else begin
		rgb_max_p5_7 <= rgb_max_p5_6;
	end
end
reg [31:0] rgb_max_p5_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_8 <= 0;
	end
	else begin
		rgb_max_p5_8 <= rgb_max_p5_7;
	end
end
reg [31:0] rgb_max_p5_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_9 <= 0;
	end
	else begin
		rgb_max_p5_9 <= rgb_max_p5_8;
	end
end
reg [31:0] rgb_max_p5_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_10 <= 0;
	end
	else begin
		rgb_max_p5_10 <= rgb_max_p5_9;
	end
end
reg [31:0] rgb_max_p5_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_11 <= 0;
	end
	else begin
		rgb_max_p5_11 <= rgb_max_p5_10;
	end
end
reg [31:0] rgb_max_p5_12;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_12 <= 0;
	end
	else begin
		rgb_max_p5_12 <= rgb_max_p5_11;
	end
end
reg [31:0] rgb_max_p5_13;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_13 <= 0;
	end
	else begin
		rgb_max_p5_13 <= rgb_max_p5_12;
	end
end
reg [31:0] rgb_max_p5_14;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_14 <= 0;
	end
	else begin
		rgb_max_p5_14 <= rgb_max_p5_13;
	end
end
reg [31:0] rgb_max_p5_15;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_15 <= 0;
	end
	else begin
		rgb_max_p5_15 <= rgb_max_p5_14;
	end
end
reg [31:0] rgb_max_p5_16;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_16 <= 0;
	end
	else begin
		rgb_max_p5_16 <= rgb_max_p5_15;
	end
end
reg [31:0] rgb_max_p5_17;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_17 <= 0;
	end
	else begin
		rgb_max_p5_17 <= rgb_max_p5_16;
	end
end
reg [31:0] rgb_max_p5_18;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p5_18 <= 0;
	end
	else begin
		rgb_max_p5_18 <= rgb_max_p5_17;
	end
end
reg [31:0] rgb_max_p6;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p6 <= 0;
	end
	else begin
		rgb_max_p6 <= rgb_max_p5_18;
	end
end
reg [31:0] s_hsv_trans_p6;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_trans_p6 <= 0;
	end
	else begin
		s_hsv_trans_p6 <= rgb_max_p5_17 ? s_hsv_trans_t_p6 : 0;
	end
end

reg [31:0] s_hsv_p6;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p6 <= 0;
	end
	else begin
		s_hsv_p6 <= rgb_max_p5_18[31] ? zero : (|s_hsv_tmp_p5_18 ? s_hsv_trans_p6 : zero);
	end
end

reg [31:0] i_c_p6;
always @ (posedge clk) begin
	if(!rst_n) begin
		i_c_p6 <= 0;
	end
	else begin
		i_c_p6 <= (rgb_max_p5_18 == rgb_r_f32_p5_18) ? zero : ((rgb_max_p5_18 == rgb_g_f32_p5_18)? two : four);
	end
end
//LV7 pipeline: calculate h_hsv Add*******************************************************************************
reg [31:0] rgb_max_p6_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p6_1 <= 0;
	end
	else begin
		rgb_max_p6_1 <= rgb_max_p6;
	end
end
reg [31:0] rgb_max_p6_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p6_2 <= 0;
	end
	else begin
		rgb_max_p6_2 <= rgb_max_p6_1;
	end
end
reg [31:0] rgb_max_p7;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7 <= 0;
	end
	else begin
		rgb_max_p7 <= rgb_max_p6_2;
	end
end

reg [31:0] s_hsv_tmp_p6_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p6_1 <= 0;
	end
	else begin
		s_hsv_tmp_p6_1 <= s_hsv_tmp_p6;
	end
end
reg [31:0] s_hsv_tmp_p6_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p6_2 <= 0;
	end
	else begin
		s_hsv_tmp_p6_2 <= s_hsv_tmp_p6_1;
	end
end
reg [31:0] s_hsv_tmp_p7;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7 <= 0;
	end
	else begin
		s_hsv_tmp_p7 <= s_hsv_tmp_p6_2;
	end
end

reg [31:0] s_hsv_p6_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p6_1 <= 0;
	end
	else begin
		s_hsv_p6_1 <= s_hsv_p6;
	end
end
reg [31:0] s_hsv_p6_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p6_2 <= 0;
	end
	else begin
		s_hsv_p6_2 <= s_hsv_p6_1;
	end
end
reg [31:0] s_hsv_p7;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7 <= 0;
	end
	else begin
		s_hsv_p7 <= s_hsv_p6_2;
	end
end

wire [31:0] h_hsv_temp_p7;
float32_Add_Sub u13_R_G(
  // .ce(o_data_en_temp[40] || o_data_en_temp[44]), 
  .clk(clk),
  .sclr(~rst_n),    
  .a(rgbDs_f32_p6), 
  .b(i_c_p6), 
  .operation(Add), 
  .result(h_hsv_temp_p7)
);
//LV8 pipeline: Divide Six*******************************************************************************
reg [31:0] rgb_max_p7_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_1 <= 0;
	end
	else begin
		rgb_max_p7_1 <= rgb_max_p7;
	end
end
reg [31:0] rgb_max_p7_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_2 <= 0;
	end
	else begin
		rgb_max_p7_2 <= rgb_max_p7_1;
	end
end
reg [31:0] rgb_max_p7_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_3 <= 0;
	end
	else begin
		rgb_max_p7_3 <= rgb_max_p7_2;
	end
end
reg [31:0] rgb_max_p7_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_4 <= 0;
	end
	else begin
		rgb_max_p7_4 <= rgb_max_p7_3;
	end
end
reg [31:0] rgb_max_p7_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_5 <= 0;
	end
	else begin
		rgb_max_p7_5 <= rgb_max_p7_4;
	end
end
reg [31:0] rgb_max_p7_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_6 <= 0;
	end
	else begin
		rgb_max_p7_6 <= rgb_max_p7_5;
	end
end
reg [31:0] rgb_max_p7_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_7 <= 0;
	end
	else begin
		rgb_max_p7_7 <= rgb_max_p7_6;
	end
end
reg [31:0] rgb_max_p7_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_8 <= 0;
	end
	else begin
		rgb_max_p7_8 <= rgb_max_p7_7;
	end
end
reg [31:0] rgb_max_p7_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_9 <= 0;
	end
	else begin
		rgb_max_p7_9 <= rgb_max_p7_8;
	end
end
reg [31:0] rgb_max_p7_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_10 <= 0;
	end
	else begin
		rgb_max_p7_10 <= rgb_max_p7_9;
	end
end
reg [31:0] rgb_max_p7_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_11 <= 0;
	end
	else begin
		rgb_max_p7_11 <= rgb_max_p7_10;
	end
end
reg [31:0] rgb_max_p7_12;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_12 <= 0;
	end
	else begin
		rgb_max_p7_12 <= rgb_max_p7_11;
	end
end
reg [31:0] rgb_max_p7_13;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_13 <= 0;
	end
	else begin
		rgb_max_p7_13 <= rgb_max_p7_12;
	end
end
reg [31:0] rgb_max_p7_14;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_14 <= 0;
	end
	else begin
		rgb_max_p7_14 <= rgb_max_p7_13;
	end
end
reg [31:0] rgb_max_p7_15;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_15 <= 0;
	end
	else begin
		rgb_max_p7_15 <= rgb_max_p7_14;
	end
end
reg [31:0] rgb_max_p7_16;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p7_16 <= 0;
	end
	else begin
		rgb_max_p7_16 <= rgb_max_p7_15;
	end
end
reg [31:0] rgb_max_p8;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p8 <= 0;
	end
	else begin
		rgb_max_p8 <= rgb_max_p7_16;
	end
end

reg [31:0] s_hsv_tmp_p7_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_1 <= 0;
	end
	else begin
		s_hsv_tmp_p7_1 <= s_hsv_tmp_p7;
	end
end
reg [31:0] s_hsv_tmp_p7_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_2 <= 0;
	end
	else begin
		s_hsv_tmp_p7_2 <= s_hsv_tmp_p7_1;
	end
end
reg [31:0] s_hsv_tmp_p7_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_3 <= 0;
	end
	else begin
		s_hsv_tmp_p7_3 <= s_hsv_tmp_p7_2;
	end
end
reg [31:0] s_hsv_tmp_p7_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_4 <= 0;
	end
	else begin
		s_hsv_tmp_p7_4 <= s_hsv_tmp_p7_3;
	end
end
reg [31:0] s_hsv_tmp_p7_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_5 <= 0;
	end
	else begin
		s_hsv_tmp_p7_5 <= s_hsv_tmp_p7_4;
	end
end
reg [31:0] s_hsv_tmp_p7_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_6 <= 0;
	end
	else begin
		s_hsv_tmp_p7_6 <= s_hsv_tmp_p7_5;
	end
end
reg [31:0] s_hsv_tmp_p7_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_7 <= 0;
	end
	else begin
		s_hsv_tmp_p7_7 <= s_hsv_tmp_p7_6;
	end
end
reg [31:0] s_hsv_tmp_p7_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_8 <= 0;
	end
	else begin
		s_hsv_tmp_p7_8 <= s_hsv_tmp_p7_7;
	end
end
reg [31:0] s_hsv_tmp_p7_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_9 <= 0;
	end
	else begin
		s_hsv_tmp_p7_9 <= s_hsv_tmp_p7_8;
	end
end
reg [31:0] s_hsv_tmp_p7_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_10 <= 0;
	end
	else begin
		s_hsv_tmp_p7_10 <= s_hsv_tmp_p7_9;
	end
end
reg [31:0] s_hsv_tmp_p7_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_11 <= 0;
	end
	else begin
		s_hsv_tmp_p7_11 <= s_hsv_tmp_p7_10;
	end
end
reg [31:0] s_hsv_tmp_p7_12;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_12 <= 0;
	end
	else begin
		s_hsv_tmp_p7_12 <= s_hsv_tmp_p7_11;
	end
end
reg [31:0] s_hsv_tmp_p7_13;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_13 <= 0;
	end
	else begin
		s_hsv_tmp_p7_13 <= s_hsv_tmp_p7_12;
	end
end
reg [31:0] s_hsv_tmp_p7_14;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_14 <= 0;
	end
	else begin
		s_hsv_tmp_p7_14 <= s_hsv_tmp_p7_13;
	end
end
reg [31:0] s_hsv_tmp_p7_15;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_15 <= 0;
	end
	else begin
		s_hsv_tmp_p7_15 <= s_hsv_tmp_p7_14;
	end
end
reg [31:0] s_hsv_tmp_p7_16;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p7_16 <= 0;
	end
	else begin
		s_hsv_tmp_p7_16 <= s_hsv_tmp_p7_15;
	end
end
reg [31:0] s_hsv_tmp_p8;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p8 <= 0;
	end
	else begin
		s_hsv_tmp_p8 <= s_hsv_tmp_p7_16;
	end
end

reg [31:0] s_hsv_p7_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_1 <= 0;
	end
	else begin
		s_hsv_p7_1 <= s_hsv_p7;
	end
end
reg [31:0] s_hsv_p7_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_2 <= 0;
	end
	else begin
		s_hsv_p7_2 <= s_hsv_p7_1;
	end
end
reg [31:0] s_hsv_p7_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_3 <= 0;
	end
	else begin
		s_hsv_p7_3 <= s_hsv_p7_2;
	end
end
reg [31:0] s_hsv_p7_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_4 <= 0;
	end
	else begin
		s_hsv_p7_4 <= s_hsv_p7_3;
	end
end
reg [31:0] s_hsv_p7_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_5 <= 0;
	end
	else begin
		s_hsv_p7_5 <= s_hsv_p7_4;
	end
end
reg [31:0] s_hsv_p7_6;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_6 <= 0;
	end
	else begin
		s_hsv_p7_6 <= s_hsv_p7_5;
	end
end
reg [31:0] s_hsv_p7_7;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_7 <= 0;
	end
	else begin
		s_hsv_p7_7 <= s_hsv_p7_6;
	end
end
reg [31:0] s_hsv_p7_8;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_8 <= 0;
	end
	else begin
		s_hsv_p7_8 <= s_hsv_p7_7;
	end
end
reg [31:0] s_hsv_p7_9;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_9 <= 0;
	end
	else begin
		s_hsv_p7_9 <= s_hsv_p7_8;
	end
end
reg [31:0] s_hsv_p7_10;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_10 <= 0;
	end
	else begin
		s_hsv_p7_10 <= s_hsv_p7_9;
	end
end
reg [31:0] s_hsv_p7_11;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_11 <= 0;
	end
	else begin
		s_hsv_p7_11 <= s_hsv_p7_10;
	end
end
reg [31:0] s_hsv_p7_12;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_12 <= 0;
	end
	else begin
		s_hsv_p7_12 <= s_hsv_p7_11;
	end
end
reg [31:0] s_hsv_p7_13;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_13 <= 0;
	end
	else begin
		s_hsv_p7_13 <= s_hsv_p7_12;
	end
end
reg [31:0] s_hsv_p7_14;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_14 <= 0;
	end
	else begin
		s_hsv_p7_14 <= s_hsv_p7_13;
	end
end
reg [31:0] s_hsv_p7_15;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_15 <= 0;
	end
	else begin
		s_hsv_p7_15 <= s_hsv_p7_14;
	end
end
reg [31:0] s_hsv_p7_16;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p7_16 <= 0;
	end
	else begin
		s_hsv_p7_16 <= s_hsv_p7_15;
	end
end
reg [31:0] s_hsv_p8;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p8 <= 0;
	end
	else begin
		s_hsv_p8 <= s_hsv_p7_16;
	end
end

wire [31:0] h_hsv_f32_p8_0;
float32_Div u14_hDsix(
  // .ce(o_data_en_temp[43] || o_data_en_temp[57]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(h_hsv_temp_p7), 
  .b(six), 
  .result(h_hsv_f32_p8_0)
);
reg [31:0] h_hsv_f32_p8;
always @ (posedge clk) begin
	if(!rst_n) begin
		h_hsv_f32_p8 <= 0;
	end
	else begin
		h_hsv_f32_p8 <= h_hsv_f32_p8_0;
	end
end
reg [31:0] h_hsv_add_p8;
always @ (posedge clk) begin
	if(!rst_n) begin
		h_hsv_add_p8 <= 0;
	end
	else begin
		h_hsv_add_p8 <= (h_hsv_f32_p8_0[31]) ? one : zero;
	end
end

//LV9 pipeline: Add one if h_hsv_f32 < 0 *******************************************************************************
reg [31:0] s_hsv_tmp_p8_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p8_1 <= 0;
	end
	else begin
		s_hsv_tmp_p8_1 <= s_hsv_tmp_p8;
	end
end
reg [31:0] s_hsv_tmp_p8_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p8_2 <= 0;
	end
	else begin
		s_hsv_tmp_p8_2 <= s_hsv_tmp_p8_1;
	end
end
reg [31:0] s_hsv_tmp_p8_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p8_3 <= 0;
	end
	else begin
		s_hsv_tmp_p8_3 <= s_hsv_tmp_p8_2;
	end
end
reg [31:0] s_hsv_tmp_p8_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p8_4 <= 0;
	end
	else begin
		s_hsv_tmp_p8_4 <= s_hsv_tmp_p8_3;
	end
end
reg [31:0] s_hsv_tmp_p9;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_tmp_p9 <= 0;
	end
	else begin
		s_hsv_tmp_p9 <= s_hsv_tmp_p8_4;
	end
end

reg [31:0] rgb_max_p8_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p8_1 <= 0;
	end
	else begin
		rgb_max_p8_1 <= rgb_max_p8;
	end
end
reg [31:0] rgb_max_p8_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p8_2 <= 0;
	end
	else begin
		rgb_max_p8_2 <= rgb_max_p8_1;
	end
end
reg [31:0] rgb_max_p8_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p8_3 <= 0;
	end
	else begin
		rgb_max_p8_3 <= rgb_max_p8_2;
	end
end
reg [31:0] rgb_max_p8_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p8_4 <= 0;
	end
	else begin
		rgb_max_p8_4 <= rgb_max_p8_3;
	end
end
reg [31:0] rgb_max_p8_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p8_5 <= 0;
	end
	else begin
		rgb_max_p8_5 <= rgb_max_p8_4;
	end
end
reg [31:0] rgb_max_p9;
always @ (posedge clk) begin
	if(!rst_n) begin
		rgb_max_p9 <= 0;
	end
	else begin
		rgb_max_p9 <= rgb_max_p8_5;
	end
end

reg [31:0] s_hsv_p8_1;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p8_1 <= 0;
	end
	else begin
		s_hsv_p8_1 <= s_hsv_p8;
	end
end
reg [31:0] s_hsv_p8_2;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p8_2 <= 0;
	end
	else begin
		s_hsv_p8_2 <= s_hsv_p8_1;
	end
end
reg [31:0] s_hsv_p8_3;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p8_3 <= 0;
	end
	else begin
		s_hsv_p8_3 <= s_hsv_p8_2;
	end
end
reg [31:0] s_hsv_p8_4;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p8_4 <= 0;
	end
	else begin
		s_hsv_p8_4 <= s_hsv_p8_3;
	end
end
reg [31:0] s_hsv_p8_5;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p8_5 <= 0;
	end
	else begin
		s_hsv_p8_5 <= s_hsv_p8_4;
	end
end
reg [31:0] s_hsv_p9;
always @ (posedge clk) begin
	if(!rst_n) begin
		s_hsv_p9 <= 0;
	end
	else begin
		s_hsv_p9 <= s_hsv_p8_5;
	end
end

wire [31:0] h_hsv_e_p9_0;
float32_Add_Sub u15_h_add(
  // .ce(o_data_en_temp[55] || o_data_en_temp[59]), 
  .clk(clk),
  .sclr(~rst_n),   
  .a(h_hsv_f32_p8), 
  .b(h_hsv_add_p8), 
  .operation(Add), 
  .result(h_hsv_e_p9_0)
);
reg [31:0] h_hsv_p9;
always @ (posedge clk) begin
	if(!rst_n) begin
		h_hsv_p9 <= 0;
	end
	else begin
		h_hsv_p9 <= (|s_hsv_tmp_p9) ? h_hsv_e_p9_0 : zero;
	end
end
//LV10 pipeline: compare v and h *******************************************************************************
wire v_comp_great_p10;
wire s_comp_great_p10;
wire h_comp_great_p10;
wire v_comp_less_p10;
wire s_comp_less_p10;
wire h_comp_less_p10;
float32compare u16_v_comp(
  // .ce(o_data_en_temp[59]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(rgb_max_p9), 
  .b(V_HSV_THRE_MAX), 
  .operation(LessThanOrEqual), 
  .result(v_comp_less_p10)
);
/* float32compare u17_v_comp(
  // .ce(o_data_en_temp[59]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(rgb_max_p9), 
  .b(V_HSV_THRE_MIN), 
  .operation(GreaterThanOrEqual), 
  .result(v_comp_great_p10)
);
float32compare u18_s_comp(
  // .ce(o_data_en_temp[59]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(s_hsv_p9), 
  .b(S_HSV_THRE_MAX), 
  .operation(LessThanOrEqual), 
  .result(s_comp_less_p10)
);
float32compare u19_s_comp(
  // .ce(o_data_en_temp[59]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(s_hsv_p9), 
  .b(S_HSV_THRE_MIN), 
  .operation(GreaterThanOrEqual), 
  .result(s_comp_great_p10)
);
float32compare u20_h_comp(
  // .ce(o_data_en_temp[59]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(h_hsv_p9), 
  .b(H_HSV_THRE_MAX), 
  .operation(LessThanOrEqual), 
  .result(h_comp_less_p10)
);
float32compare u21_h_comp(
  // .ce(o_data_en_temp[59]), 
  .clk(clk), 
  .sclr(~rst_n), 
  .a(h_hsv_p9), 
  .b(H_HSV_THRE_MIN), 
  .operation(GreaterThanOrEqual), 
  .result(h_comp_great_p10)
); */
/* reg v_comp_p10;
reg s_comp_p10;
reg h_comp_p10;
always @ (posedge clk) begin
	if(!rst_n) begin
		v_comp_p10 <= 0;
		s_comp_p10 <= 0;
		h_comp_p10 <= 0;
	end
	else begin
		v_comp_p10 <= v_comp_great_p10 & v_comp_less_p10;
		s_comp_p10 <= s_comp_great_p10 & s_comp_less_p10;
		h_comp_p10 <= h_comp_great_p10 & h_comp_less_p10;
	end
end */
//LV11 pipeline: calculate o_hue *******************************************************************************
// reg [7:0] o_hue_temp;
always @ (posedge clk) begin
	if(!rst_n) begin
		o_hue <= 0;
	end
	else begin
		if(v_comp_less_p10) 
			o_hue <= 8'hff;
		else
			o_hue <= 0;
	end		
end
// always @ (posedge clk) begin
	// if(!rst_n) begin
		// o_hue <= 0;
	// end
	// else if(o_data_en_temp[88]) begin
		// o_hue <= o_hue_temp;
	// end	
	// else begin
		// o_hue <= o_hue;
	// end
// end
// assign o_hue = {o_hue_temp, o_hue_temp, o_hue_temp, o_hue_temp, o_hue_temp, o_hue_temp, o_hue_temp, o_hue_temp};
//**************************************************************************************************************************************************************
//always @ (posedge clk or negedge rst_n) begin
always @ (posedge clk) begin
	if(!rst_n) begin
		o_data_en_temp <= 0;
	end
	else begin
		o_data_en_temp <= {o_data_en_temp[88:0], i_data_en};
	end               
end
assign o_data_en = o_data_en_temp[89]; 
//**************************************************************************************************************************************************************
//always @ (posedge clk or negedge rst_n) begin
always @ (posedge clk) begin
	if(!rst_n) begin
		o_vs_temp <= 0;
	end
	else begin
		o_vs_temp <= {o_vs_temp[88:0], i_vs};
	end               
end
assign o_vs = o_vs_temp[89]; 
//**************************************************************************************************************************************************************
//always @ (posedge clk or negedge rst_n) begin
always @ (posedge clk) begin
	if(!rst_n) begin
		o_hs_temp <= 0;
	end
	else begin
		o_hs_temp <= {o_hs_temp[88:0], i_hs};
	end               
end
assign o_hs = o_hs_temp[89]; 

endmodule
