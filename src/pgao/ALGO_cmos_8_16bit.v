module ALGO_cmos_8_16bit(
	input rst,
	input pclk,
	input [7:0] pdata_i,
	input de_i,
	input fe_i,
	
	output reg[15:0] pdata_o,
	output reg cmos_vsync,
	output reg cmos_href,
	output reg de_o
);
reg[7:0] pdata_i_d0;
reg[7:0] pdata_i_d1;
reg de_i_d0;
reg[11:0] x_cnt;
// reg cmos_vsync_t;
// reg cmos_href_t;
		
always@(posedge pclk)
begin
	de_i_d0 <= de_i;
	pdata_i_d0 <= pdata_i;
	pdata_i_d1 <= pdata_i_d0;
end

always@(posedge pclk or posedge rst)
begin
	if(rst)
		x_cnt <= 12'd0;
	else if(de_i)
		x_cnt <= x_cnt + 12'd1;
	else
		x_cnt <= 12'd0;
end

always@(posedge pclk or posedge rst)
begin
	if(rst)
		de_o <= 1'b0;
	else if(de_i && x_cnt[0])
		de_o <= 1'b1;
	else
		de_o <= 1'b0;
end

always@(posedge pclk or posedge rst)
begin
	if(rst)
		pdata_o <= 16'd0;
	else if(de_i && x_cnt[0])
		pdata_o <= {pdata_i_d0,pdata_i};
	else
		pdata_o <= 16'd0;
end

always@(posedge pclk or posedge rst)
begin
	if(rst) begin
		// cmos_vsync_t <= 0;
		// cmos_href_t <= 0;
		cmos_vsync <= 0;
		cmos_href <= 0;
	end
	else begin
		cmos_vsync <= fe_i;
		cmos_href <= de_i;
		// cmos_vsync <= cmos_vsync_t;
		// cmos_href <= cmos_href_t;
	end
end

endmodule 