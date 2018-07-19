module calc_m10_1(nrst,clk,/*rd_en,*/rd_done,cnt_en,idata,odata,hcount,m10_done);
input nrst;
//input rd_en;
input clk;
input rd_done;
input cnt_en;
input[10:0] hcount;
input[7:0] idata;

output reg[31:0] odata;
output	reg m10_done;
///////////////////////////////////////
reg [10:0] hcount_0;
reg [10:0] hcount_1;
reg [10:0] hcount_2;
reg [10:0] hcount_3;
reg [10:0] hcount_4;
reg [10:0] hcount_5;
reg [10:0] hcount_6;
reg [10:0] hcount_7;
reg [10:0]  hcount_reg;

always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_reg<=8'd0;
	else
		hcount_reg<=hcount;
end

always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_0<=11'd0;
	else if(idata[7])// && rd_en)
		hcount_0<=hcount_reg;
	else
		hcount_0<=11'd0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_1<=11'd0;
	else if(idata[6] )//&& rd_en)
		hcount_1<=hcount_reg+11'd1;
	else
		hcount_1<=11'd0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_2<=11'd0;
	else if(idata[5])// && rd_en)
		hcount_2<=hcount_reg+11'd2;
	else
		hcount_2<=11'd0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_3<=11'd0;
	else if(idata[4])// && rd_en)
		hcount_3<=hcount_reg+11'd3;
	else
		hcount_3<=11'd0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_4<=11'd0;
	else if(idata[3])// && rd_en)
		hcount_4<=hcount_reg+11'd4;
	else
		hcount_4<=11'd0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_5<=11'd0;
	else if(idata[2])// && rd_en)
		hcount_5<=hcount_reg+11'd5;
	else
		hcount_5<=11'd0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_6<=11'd0;
	else if(idata[1])// && rd_en)
		hcount_6<=hcount_reg+11'd6;
	else
		hcount_6<=11'd0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		hcount_7<=11'd0;
	else if(idata[0])// && rd_en)
		hcount_7<=hcount_reg+11'd7;
	else
		hcount_7<=11'd0;
end

reg[31:0] reg_1_2_1;
reg[31:0] reg_1_2_2;
reg[31:0] reg_1_2_3;
reg[31:0] reg_1_2_4;
reg[31:0] reg_2_3_1;
reg[31:0] reg_2_3_2;
reg[31:0] reg_3;
reg[31:0] reg_4;
reg 	[8:0]	rd_done_shift;
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		begin
			reg_1_2_1<=0;
			reg_1_2_2<=0;
			reg_1_2_3<=0;
			reg_1_2_4<=0;
		end
	else if(cnt_en)
		begin
			reg_1_2_1<=0;
			reg_1_2_2<=0;
			reg_1_2_3<=0;
			reg_1_2_4<=0;
		end
	else
		begin	
			reg_1_2_1<=hcount_0+hcount_1;
			reg_1_2_2<=hcount_2+hcount_3;
			reg_1_2_3<=hcount_4+hcount_5;
			reg_1_2_4<=hcount_6+hcount_7;
		end
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		begin
			reg_2_3_1<=0;
			reg_2_3_2<=0;
		end
	else if(cnt_en)
		begin
			reg_2_3_1<=0;
			reg_2_3_2<=0;
		end
	else
		begin
			reg_2_3_1<=reg_1_2_1+reg_1_2_2;
			reg_2_3_2<=reg_1_2_3+reg_1_2_4;
		end
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		reg_3<=0;
	else if(cnt_en)
		reg_3<=0;
	else
		reg_3<=reg_2_3_1+reg_2_3_2;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		reg_4<=0;
	else if(cnt_en)
		reg_4<=0;
	else
		reg_4<=reg_3+reg_4;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		begin
			odata<=0;
			m10_done<=0;
		end
	else if (cnt_en)
		begin
			odata<=0;
			m10_done<=0;
		end
	else if(rd_done_shift[8])
		begin
			odata<=reg_4;
			m10_done<=1;
		end
	else
		m10_done<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		rd_done_shift<=0;
	else
		rd_done_shift<={rd_done_shift[7:0],rd_done};
end

endmodule
