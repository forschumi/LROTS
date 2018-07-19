module calc_m01_1(nrst,clk,cnt_en,vcount,rd_done,idata,odata,m01_done);
input nrst;
input clk;
input cnt_en;
input rd_done;
input[10:0] vcount;
input[7:0] idata;
output reg[31:0] odata;
output reg m01_done;


/////////////////////////////////////
reg [10:0]	vcount_reg;
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		vcount_reg<=11'd0;
	else
		vcount_reg<=vcount;
end
reg	[10:0]	datain_0;
reg	[10:0]	datain_1;
reg	[10:0]	datain_2;
reg	[10:0]	datain_3;
reg	[10:0]	datain_4;
reg	[10:0]	datain_5;
reg	[10:0]	datain_6;
reg	[10:0]	datain_7;
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		datain_0<=0;
	else if(cnt_en)
		datain_0<=0;
	else if(idata[7])
		datain_0<=vcount_reg;
	else
		datain_0<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		datain_1<=0;
	else if(cnt_en)
		datain_1<=0;
	else if(idata[6])
		datain_1<=vcount_reg;
	else
		datain_1<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		datain_2<=0;
	else if(cnt_en)
		datain_2<=0;
	else if(idata[5])
		datain_2<=vcount_reg;
	else
		datain_2<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		datain_3<=0;
	else if(cnt_en)
		datain_3<=0;
	else if(idata[4])
		datain_3<=vcount_reg;
	else
		datain_3<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		datain_4<=0;
	else if(cnt_en)
		datain_4<=0;
	else if(idata[3])
		datain_4<=vcount_reg;
	else
		datain_4<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		datain_5<=0;
	else if(cnt_en)
		datain_5<=0;
	else if(idata[2])
		datain_5<=vcount_reg;
	else
		datain_5<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		datain_6<=0;
	else if(cnt_en)
		datain_6<=0;
	else if(idata[1])
		datain_6<=vcount_reg;
	else
		datain_6<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		datain_7<=0;
	else if(cnt_en)
		datain_7<=0;
	else if(idata[0])
		datain_7<=vcount_reg;
	else
		datain_7<=0;
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
			reg_1_2_1<=datain_0+datain_1;
			reg_1_2_2<=datain_2+datain_3;
			reg_1_2_3<=datain_4+datain_5;
			reg_1_2_4<=datain_6+datain_7;
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
			m01_done<=0;
		end
	else if (cnt_en)
		begin
			odata<=0;
			m01_done<=0;
		end
	else if(rd_done_shift[8])
		begin
			odata<=reg_4;
			m01_done<=1;
		end
	else
		m01_done<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		rd_done_shift<=0;
	else
		rd_done_shift<={rd_done_shift[7:0],rd_done};
end

endmodule
