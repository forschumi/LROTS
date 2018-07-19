module calc_m00_1(nrst,clk,cnt_en,rd_done,data_in,data_out,m00_done);
input nrst;
input clk;
input cnt_en;
input rd_done;
input[7:0] data_in;

output reg[31:0] data_out;
output reg m00_done;
///////////////////////////////////////////////////
reg 	[1:0] 	reg_1_2_1;
reg 	[1:0] 	reg_1_2_2;
reg 	[1:0] 	reg_1_2_3;
reg 	[1:0] 	reg_1_2_4;

reg 	[2:0] 	reg_2_3_1;
reg 	[2:0] 	reg_2_3_2;

reg		[3:0]	reg_3;
reg		[31:0]	reg_4;

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
			reg_1_2_1<=data_in[0]+data_in[1];
			reg_1_2_2<=data_in[2]+data_in[3];
			reg_1_2_3<=data_in[4]+data_in[5];
			reg_1_2_4<=data_in[6]+data_in[7];
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
			data_out<=0;
			m00_done<=0;
		end
	else if (cnt_en)
		begin
			data_out<=0;
			m00_done<=0;
		end
	else if(rd_done_shift[8])
		begin
			data_out<=reg_4;
			m00_done<=1;
		end
	else
		m00_done<=0;
end
always@(posedge clk or negedge nrst)
begin
	if(!nrst)
		rd_done_shift<=0;
	else
		rd_done_shift<={rd_done_shift[7:0],rd_done};
end
endmodule		

