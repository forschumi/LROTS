// Y1U1Y2V1Y3U3Y4V3 --> Y1U1V1 Y2U1V1 Y3U3V3 Y4U3V3 
`timescale 1 ns / 1 ps
module ALGO_yuv422_2yuv444(
	clk,
	rst_n,
	i_vs,
	i_hs,
	i_q_16b,
	i_data_en,
	o_y_8b,
	o_cb_8b,
	o_cr_8b,
	o_vs,
	o_hs,
	o_data_en
);

input clk;
(* keep = "true" *)input rst_n;
(* keep = "true" *)input[15:0] i_q_16b;
(* keep = "true" *)input i_vs;
(* keep = "true" *)input i_hs;
(* keep = "true" *)input i_data_en;
output reg [7:0] o_y_8b;
output reg [7:0] o_cb_8b;
output reg [7:0] o_cr_8b;
(* keep = "true" *)output o_vs;
(* keep = "true" *)output o_hs;
(* keep = "true" *)output o_data_en;

reg [7:0] o_data_en_temp;
wire pro_data_en = o_data_en_temp[2] || o_data_en_temp[6];
reg [7:0] i_y1, i_y2, i_y3, i_y4;
reg [7:0] i_cb_1, i_cb_3;
reg [7:0] i_cr_1, i_cr_3;
reg [2:0] pro_state;
reg [15:0] i_q_16b_temp1;
reg [15:0] i_q_16b_temp2;

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
		i_q_16b_temp1 <= 0;
	else begin
		i_q_16b_temp1 <= i_q_16b;
	end
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
		i_q_16b_temp2 <= 0;
	else if(o_data_en_temp[0])
		i_q_16b_temp2 <= i_q_16b_temp1;
	else
		i_q_16b_temp2 <= i_q_16b_temp2;
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		pro_state <= 0;
		{i_y1, i_cb_1, i_cr_1} <= {8'h0, 8'h0, 8'h0};
		i_y2 <= 0;
		{i_y3, i_cb_3, i_cr_3} <= {8'h0, 8'h0, 8'h0};
		i_y4 <= 0;
		{o_y_8b, o_cb_8b, o_cr_8b} <= {8'h0, 8'h0, 8'h0};
	end
	else if(pro_data_en) begin
		case(pro_state)
			3'd0:	begin
						pro_state <= 3'd1;
						{i_y1, i_cb_1} <= i_q_16b_temp2;
					end
			3'd1:	begin
						pro_state <= 3'd2;
						{i_y2, i_cr_1} <= i_q_16b_temp2;
					end
			3'd2:	begin
						pro_state <= 3'd3;
						{i_y3, i_cb_3} <= i_q_16b_temp2;
						{o_y_8b, o_cb_8b, o_cr_8b} <= {i_y1, i_cb_1, i_cr_1};
					end
			3'd3:	begin
						pro_state <= 3'd4;
						{i_y4, i_cr_3} <= i_q_16b_temp2;
						{o_y_8b, o_cb_8b, o_cr_8b} <= {i_y2, i_cb_1, i_cr_1};
					end
			3'd4:	begin
						pro_state <= 3'd5;
						{i_y1, i_cb_1} <= i_q_16b_temp2;
						{o_y_8b, o_cb_8b, o_cr_8b} <= {i_y3, i_cb_3, i_cr_3};
					end
			3'd5:	begin
						pro_state <= 3'd2;
						{i_y2, i_cr_1} <= i_q_16b_temp2;
						{o_y_8b, o_cb_8b, o_cr_8b} <= {i_y4, i_cb_3, i_cr_3};
					end
			default:begin
						pro_state <= pro_state;
						{i_y1, i_cb_1, i_cr_1} <= {i_y1, i_cb_1, i_cr_1};
						i_y2 <= i_y2;
						{i_y3, i_cb_3, i_cr_3} <= {i_y3, i_cb_3, i_cr_3};
						i_y4 <= i_y4;
						{o_y_8b, o_cb_8b, o_cr_8b} <= {o_y_8b, o_cb_8b, o_cr_8b};
					end
		endcase
	end
	else begin
		pro_state <= pro_state;
		{i_y1, i_cb_1, i_cr_1} <= {i_y1, i_cb_1, i_cr_1};
		i_y2 <= i_y2;
		{i_y3, i_cb_3, i_cr_3} <= {i_y3, i_cb_3, i_cr_3};
		i_y4 <= i_y4;
		{o_y_8b, o_cb_8b, o_cr_8b} <= {o_y_8b, o_cb_8b, o_cr_8b};
	end
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
		o_data_en_temp <= 0;
	else
		o_data_en_temp	<= {o_data_en_temp[6:0], i_data_en};		
end

assign o_data_en = o_data_en_temp[7];
//**************************************************************************************************************************************************************
reg [7:0] o_vs_temp;
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		o_vs_temp <= 0;
	end
	else begin
		o_vs_temp <= {o_vs_temp[6:0], i_vs};
	end               
end
assign o_vs = o_vs_temp[7]; 
//**************************************************************************************************************************************************************
reg [7:0] o_hs_temp;
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		o_hs_temp <= 0;
	end
	else begin
		o_hs_temp <= {o_hs_temp[6:0], i_hs};
	end               
end
assign o_hs = o_hs_temp[7]; 

endmodule
