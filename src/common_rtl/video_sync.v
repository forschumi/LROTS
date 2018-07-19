module video_sync(
	input rst,
	input vin_clk,
	input vin_vs,
	input vin_hs,
	input vin_de,
	input[15:0] vin_yc,
	
	input sync_vclk,
	output sync_de,
	output sync_vs,
	output sync_hs,
	output[15:0] sync_yc
	
	/* input vin_clk,
	input vin_vs,
	input vin_hs,
	input vin_de,
	input[15:0] vin_yc,
	
	input vin_clk_ch1,
	input vin_vs_ch1,
	input vin_hs_ch1,
	input vin_de_ch1,
	input[15:0] vin_yc_ch1,

	input vin_clk_ch2,
	input vin_vs_ch2,
	input vin_hs_ch2,
	input vin_de_ch2,
	input[15:0] vin_yc_ch2,

	input vin_clk_ch3,
	input vin_vs_ch3,
	input vin_hs_ch3,
	input vin_de_ch3,
	input[15:0] vin_yc_ch3,

	input vin_clk_ch4,
	input vin_vs_ch4,
	input vin_hs_ch4,
	input vin_de_ch4,
	input[15:0] vin_yc_ch4,
	
	input sync_vclk,
	output sync_de,
	output sync_vs,
	output sync_hs,
	output[15:0] sync_yc,
	
	output sync_de_ch1,
	output sync_vs_ch1,
	output sync_hs_ch1,
	output[15:0] sync_yc_ch1,

	output sync_de_ch2,
	output sync_vs_ch2,
	output sync_hs_ch2,
	output[15:0] sync_yc_ch2,

	output sync_de_ch3,
	output sync_vs_ch3,
	output sync_hs_ch3,
	output[15:0] sync_yc_ch3	 */
);
wire rdempty;
wire rdreq;
reg rdreq_d0;
reg rdreq_d1;
wire[15:0] q;
reg[15:0] q_d0;
reg vin_vs_d0;
reg vin_vs_d1;
reg vin_hs_d0;
reg vin_hs_d1;
assign rdreq = ~rdempty;
assign sync_de = rdreq_d1;
assign sync_yc = q_d0;
assign sync_vs = vin_vs_d1;
assign sync_hs = vin_hs_d1;
always@(posedge sync_vclk or posedge rst)
begin
	if(rst)
		begin
			rdreq_d0 <= 1'b0;
			rdreq_d1 <= 1'b0;
			q_d0 <= 16'd0;
			vin_vs_d0 <= 1'b0;
			vin_vs_d1 <= 1'b0;
			vin_hs_d0 <= 1'b0;
			vin_hs_d1 <= 1'b0;
		end
	else
		begin
			rdreq_d0 <= rdreq;
			rdreq_d1 <= rdreq_d0;
			q_d0 <= q;
			vin_vs_d0 <= ~vin_vs;
			vin_vs_d1 <= vin_vs_d0;
			vin_hs_d0 <= vin_hs;
			vin_hs_d1 <= vin_hs_d0;
		end
end
lite_fifo#
(
	.COMMON_CLOCK(0),
	.ADDR_WIDTH(7),
	.DATA_WIDTH(16)
)  fifo_8_16_m0(
	.aclr(vin_vs_d0 & ~vin_vs_d1),
	.data(vin_yc),
	.rdclk(sync_vclk),
	.rdreq(rdreq),
	.wrclk(vin_clk),
	.wrreq(vin_de),
	.q(q),
	.rdempty(rdempty),
	.rdusedw(),
	.wrfull(),
	.wrusedw()
	);
endmodule 