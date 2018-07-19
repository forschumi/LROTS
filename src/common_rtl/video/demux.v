/*
TW2866/TW2867视频分离模块
为了节约IO，TW2867可以将4个27Mhz的BT656信号复合在一个108Mhz的数据通道上传输
复合方式参考相关datasheet，这里主要是恢复4路27Mhz的BT656信号
*/
module demux(
	input clk_108m,
	input clk_27m,
	input[7:0] vin_data,
	output reg[7:0] vout_data_ch0,
	output reg[7:0] vout_data_ch1,
	output reg[7:0] vout_data_ch2,
	output reg[7:0] vout_data_ch3
);
reg[1:0] vin_cnt;
reg[1:0] vin_cnt_d0;
reg[7:0] data0,data1,data2,data3;
reg[7:0] data0_d0;
reg[7:0] data1_d0;
reg[7:0] data2_d0;
reg[7:0] data3_d0;
reg[7:0] data0_d1;
reg[7:0] data0_d2;
reg[7:0] data0_d3;
reg[7:0] data0_d4;
reg[3:0] data0_id;

reg[7:0] vin_data_d0;
always@(posedge clk_108m)
begin
	vin_cnt <= vin_cnt + 2'd1;
	vin_data_d0 <= vin_data;
	vin_cnt_d0 <= vin_cnt;
end
/*不管三七二十一，先把108Mhz数据分离到4个27Mhz上，分离后我们并不清楚通道对应情况*/
always@(posedge clk_108m)
begin
	case(vin_cnt_d0)
		2'd0:
			begin
				data0 <= vin_data_d0;
				data1 <= data1;
				data2 <= data2;
				data3 <= data3;
			end
		2'd1:
			begin
				data0 <= data0;
				data1 <= vin_data_d0;
				data2 <= data2;
				data3 <= data3;
			end
		2'd2:
			begin
				data0 <= data0;
				data1 <= data1;
				data2 <= vin_data_d0;
				data3 <= data3;
			end
		2'd3:
			begin
				data0 <= data0;
				data1 <= data1;
				data2 <= data2;
				data3 <= vin_data_d0;
			end
		default:
			begin
				data0 <= data0;
				data1 <= data1;
				data2 <= data2;
				data3 <= data3;
			end
	endcase
end

always@(posedge clk_27m)
begin
	data0_d0 <= data0;
	data1_d0 <= data1;
	data2_d0 <= data2;
	data3_d0 <= data3;
	data0_d1 <= data0_d0;
	data0_d2 <= data0_d1;
	data0_d3 <= data0_d2;
	data0_d4 <= data0_d3;
end
/*为了将分离出来的4路BT656对应4个物理通道，我们要提取分离出来的第一个27Mhz数据ID
这个ID是TW2867叠加上去的，和物理输入通道对应*/
always@(posedge clk_27m)
begin
	if(data0_d4 == 8'hff && data0_d3 == 8'h00 && data0_d2 == 8'h00)
		data0_id <= data0_d1[3:0];
	else
		data0_id <= data0_id;		
end
/*
知道了第一个数据对应的物理输入通道就可以推断出其他三个数据对应的物理输入通道
然后把不管三七二十一分离出来的4路数据顺序调整正确。
*/
always@(posedge clk_27m)
begin
	case(data0_id)
		4'd0:
			begin
				vout_data_ch0 <= data0_d0;
				vout_data_ch1 <= data1_d0;
				vout_data_ch2 <= data2_d0;
				vout_data_ch3 <= data3_d0;
			end
		4'd1:
			begin
				vout_data_ch0 <= data3_d0;
				vout_data_ch1 <= data0_d0;
				vout_data_ch2 <= data1_d0;
				vout_data_ch3 <= data2_d0;
			end
		4'd2:
			begin
				vout_data_ch0 <= data2_d0;
				vout_data_ch1 <= data3_d0;
				vout_data_ch2 <= data0_d0;
				vout_data_ch3 <= data1_d0;
			end
		4'd3:
			begin
				vout_data_ch0 <= data1_d0;
				vout_data_ch1 <= data2_d0;
				vout_data_ch2 <= data3_d0;
				vout_data_ch3 <= data0_d0;
			end
		default:
			begin
				vout_data_ch0 <= data0_d0;
				vout_data_ch1 <= data1_d0;
				vout_data_ch2 <= data2_d0;
				vout_data_ch3 <= data3_d0;
			end
	endcase
end

endmodule 