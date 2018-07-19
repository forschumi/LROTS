/*
	用于缩放模块的线缓存
	将Y分量写入ram_1024_8_m0，
	Cr分量写入ram_512_8_m0，
	Cb分量写入ram_512_8_m1
	读取的时候是24bit的YCbCr，实际完成了YCbCr422到YCbCr444的转换
*/
`timescale 1ps/1ps
module line_buf_scaler
#(
	parameter WITDH_2K = 0
)(
	data,
	rdaddress,
	rdclock,
	wraddress,
	wrclock,
	wren,
	q
);
	input	[15:0]  data;
	input	[10:0]  rdaddress;
	input	  rdclock;
	input	[10:0]  wraddress;
	input	  wrclock;
	input	  wren;
	output	[23:0]  q;
	wire [10:0] cr_rdaddress;
	assign cr_rdaddress = rdaddress;
localparam MEM_SIZE = WITDH_2K ? 2048 : 1024;
dp_ram#(.DATA_WIDTH(8),.MEM_SIZE(MEM_SIZE)) dp_ram_y
(
	.data(data[15:8]),
	.rdaddress(rdaddress),
	.rdclock(rdclock),
	.wraddress(wraddress),
	.wrclock(wrclock),
	.wren(wren),
	.q(q[23:16])
);///y 

dp_ram#(.DATA_WIDTH(8),.MEM_SIZE(MEM_SIZE/2)) dp_ram_cr
(
	.data(data[7:0]),
	.rdaddress(cr_rdaddress[10:1]),
	.rdclock(rdclock),
	.wraddress(wraddress[10:1]),
	.wrclock(wrclock),
	.wren(wren & wraddress[0]),
	.q(q[7:0])
);//cr 

dp_ram#(.DATA_WIDTH(8),.MEM_SIZE(MEM_SIZE/2)) dp_ram_cb
(
	.data(data[7:0]),
	.rdaddress(rdaddress[10:1]),
	.rdclock(rdclock),
	.wraddress(wraddress[10:1]),
	.wrclock(wrclock),
	.wren(wren & ~wraddress[0]),
	.q(q[15:8])
);///cb 
	

endmodule