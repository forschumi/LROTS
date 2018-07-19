module video_check(
	input clk_148,
	input clk_pixel,
	input vs,
	input hs,
	input de,
	output reg[15:0] H_ACTIVE,
	output reg[15:0] V_ACTIVE,
	output video_lost
);
reg[23:0] time_cnt;
reg vs_d1;
reg vs_d2;

reg vs_d3;
reg vs_d4;

reg de_d1;
reg de_d2;
reg de_d3;
reg[15:0] v_cnt;
reg[15:0] h_cnt;
wire vs_posedge = ~vs_d2 & vs_d1;
wire vs_edge = vs_d4 & ~vs_d3;

wire de_posedge = ~de_d2 & de_d1;
reg vs_edge_d1;
reg de_posedge_d1;
assign video_lost = ~(time_cnt < 24'hC1_5C00);
always@(posedge clk_148)
begin
	vs_d1 <= vs;
	vs_d2 <= vs_d1;
	if(vs_posedge)
		begin
			time_cnt <= 24'd0;
		end
	else if(time_cnt < 24'hC1_5C00)
		begin
			time_cnt <= time_cnt + 24'd1;
		end
	else
		begin
			time_cnt <= time_cnt;
		end
end

always@(posedge clk_pixel)
begin
	vs_d3 <= vs;
	vs_d4 <= vs_d3;
	if(vs_edge)
		begin
			V_ACTIVE <= v_cnt;
		end
	else
		begin
			V_ACTIVE <= V_ACTIVE;
		end
	
end

always@(posedge clk_pixel)
begin
	de_d1 <= de;
	de_d2 <= de_d1;
	vs_edge_d1 <= vs_edge;
	if(de_posedge)
		begin
			v_cnt <= v_cnt + 16'd1;
		end
	else if(vs_edge_d1)
		begin
			v_cnt <= 16'd0;
		end
	else 
		begin
			v_cnt <= v_cnt;
		end
	
end

always@(posedge clk_pixel)
begin
	if(de_posedge)
		H_ACTIVE <= h_cnt;
	else
		H_ACTIVE <= H_ACTIVE; 
end
always@(posedge clk_pixel)
begin
	de_posedge_d1 <= de_posedge;
	de_d3 <= de_d2;
	if(de_posedge_d1)
		h_cnt <= 16'd0;
	else if(de_d3)
		h_cnt <= h_cnt + 16'd1;
	else
		h_cnt <= h_cnt; 
end
endmodule