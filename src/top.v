module top(
	//key input
	input sys_key0,

	//led output
	output [3:0] led,
	
	//i2c
	input scl,
	inout sda,
	
	output cmos_xclk,
	input cmos_vsync,
	inout cmos_sda,
	output cmos_scl,
	output cmos_reset,
	output cmos_pwdn,
	input cmos_pclk,
	input cmos_href,
	input[7:0] cmos_d,
		
	//hdmi output
	output hdmi_out_clk,
	output hdmi_out_hs,
	output hdmi_out_vs,
	output hdmi_out_de,
	output[7:0]  hdmi_out_rgb_b,
	output[7:0]  hdmi_out_rgb_g,
	output[7:0]  hdmi_out_rgb_r,
	
	//vga output
	output vga_out_clk,         
	output vga_out_hs,          
	output vga_out_vs,          
	output vga_out_de,           
	output[11:0]  vga_out_data,
	 

	//ddr3
`ifdef Xilinx	
	inout  [15:0]             mcb3_dram_dq,
	output [13:0]             mcb3_dram_a,
	output [2:0]              mcb3_dram_ba,
	output                    mcb3_dram_ras_n,
	output                    mcb3_dram_cas_n,
	output                    mcb3_dram_we_n,
	output                    mcb3_dram_odt,
	output                    mcb3_dram_reset_n,
	output                    mcb3_dram_cke,
	output                    mcb3_dram_dm,
	inout                     mcb3_dram_udqs,
	inout                     mcb3_dram_udqs_n,
	inout                     mcb3_rzq,
	inout                     mcb3_zio,
	output                    mcb3_dram_udm,
	inout                     mcb3_dram_dqs,
	inout                     mcb3_dram_dqs_n,
	output                    mcb3_dram_ck,
	output                    mcb3_dram_ck_n,
`else
	output  wire[0 : 0]  mem_cs_n,
	output  wire[0 : 0]  mem_cke,
	output  wire[12: 0]  mem_addr,
	output  wire[2 : 0]  mem_ba,
	output  wire  mem_ras_n,
	output  wire  mem_cas_n,
	output  wire  mem_we_n,
	inout  wire[0 : 0]  mem_clk,
	inout  wire[0 : 0]  mem_clk_n,
	output  wire[3 : 0]  mem_dm,
	inout  wire[31: 0]  mem_dq,
	inout  wire[3 : 0]  mem_dqs,
	output[0:0]	mem_odt,
`endif	
	//clock input
	input clk_50m,
	input clk_27m
);
assign sda = 1'bz;
assign led = 4'd2;

parameter H_ACTIVE = 16'd1920;
parameter H_FP = 16'd88;
parameter H_SYNC = 16'd44;
parameter H_BP = 16'd148; 
parameter V_ACTIVE = 16'd1080;
parameter V_FP 	= 16'd4;
parameter V_SYNC  = 16'd5;
parameter V_BP	= 16'd36;


parameter H_TOTAL = H_ACTIVE + H_FP + H_SYNC + H_BP;
parameter V_TOTAL = V_ACTIVE + V_FP + V_SYNC + V_BP;
parameter VCH_NUM = 2;
parameter CH0 = 1;
parameter CH1 = 1;
parameter MEM_DATA_BITS = 64;


wire rst_n;
wire phy_clk;
wire ch0_rd_burst_req;
wire[9:0] ch0_rd_burst_len;
//wire[23:0] ch0_rd_burst_addr;
wire[26:0] ch0_rd_burst_addr;
wire  ch0_rd_burst_data_valid;
wire[63:0] ch0_rd_burst_data;
wire ch0_rd_burst_finish;

wire ch0_wr_burst_req;
wire[9:0] ch0_wr_burst_len;
//wire[23:0] ch0_wr_burst_addr;
wire[26:0] ch0_wr_burst_addr;
wire ch0_wr_burst_data_req;
wire[63:0] ch0_wr_burst_data;
wire ch0_wr_burst_finish;

wire ch1_rd_burst_req;
wire[9:0] ch1_rd_burst_len;
//wire[23:0] ch1_rd_burst_addr;
wire[26:0] ch1_rd_burst_addr;
wire  ch1_rd_burst_data_valid;
wire[63:0] ch1_rd_burst_data;
wire ch1_rd_burst_finish;

wire ch1_wr_burst_req;
wire[9:0] ch1_wr_burst_len;
//wire[23:0] ch1_wr_burst_addr;
wire[26:0] ch1_wr_burst_addr;
wire ch1_wr_burst_data_req;
wire[63:0] ch1_wr_burst_data;
wire ch1_wr_burst_finish;

wire ch2_rd_burst_req;
wire[9:0] ch2_rd_burst_len;
//wire[23:0] ch2_rd_burst_addr;
wire[26:0] ch2_rd_burst_addr;
wire  ch2_rd_burst_data_valid;
wire[63:0] ch2_rd_burst_data;
wire ch2_rd_burst_finish;

wire ch2_wr_burst_req;
wire[9:0] ch2_wr_burst_len;
//wire[23:0] ch2_wr_burst_addr;
wire[26:0] ch2_wr_burst_addr;
wire ch2_wr_burst_data_req;
wire[63:0] ch2_wr_burst_data;
wire ch2_wr_burst_finish;

wire video_clk;

wire ch0_de;
wire ch0_vs;
wire[15:0] ch0_yc_data;
wire ch0_f;


wire video_hs;
wire video_vs;
wire video_de;
wire[7:0] video_r;
wire[7:0] video_g;
wire[7:0] video_b;

wire vga_hs;
wire vga_vs;
wire vga_de;
wire[7:0] vga_r;
wire[7:0] vga_g;
wire[7:0] vga_b;

wire hdmi_hs;
wire hdmi_vs;
wire hdmi_de;
wire[7:0] hdmi_r;
wire[7:0] hdmi_g;
wire[7:0] hdmi_b;

wire hdmi_in_hs_delay;
wire hdmi_in_vs_delay;
wire hdmi_in_de_delay;
wire[23:0] hdmi_in_data_delay;
wire sys_clk;
// ry, 2016.12.26
/*
reset reset_m0(
	.clk(video_clk),
	.rst_n(rst_n)
);
*/
assign rst_n = sys_key0;

wire clk_27m_buf;
wire cmos_clk;
clock_in clock_in_27m
(
	.clk_in(clk_27m),
	.clk_out(clk_27m_buf)
);
`ifdef Xilinx
pll_cmos pll_m1(
	.CLK_IN1(clk_27m_buf),
	.CLK_OUT1(cmos_clk));
`else
pll_cmos pll_m1(
	.inclk0(clk_50m),
	.c0(cmos_clk));
`endif
`ifdef Xilinx
pll pll_m0(
	.inclk0(clk_27m_buf),
	.c0(sys_clk),
	.c1(video_clk));
`else
pll pll_m0(
	.inclk0(clk_50m),
	.c0(sys_clk),
	.c1(video_clk));
`endif
clock_out clock_out_m0
(
	.clk_in(video_clk),
	.clk_out(hdmi_out_clk)
);
clock_out clock_out_m1
(
	.clk_in(cmos_clk),
	.clk_out(cmos_xclk)
);
wire cmos_pclk_gbuf;
clock_in clock_in_cmos_pclk
(
	.clk_in(cmos_pclk),
	.clk_out(cmos_pclk_gbuf)
);
wire initial_en;	
power_on_delay	power_on_delay_inst(
	.clk_50M                 (cmos_clk),
	.reset_n                 (rst_n),	
	.camera_rstn             (cmos_reset),
	.camera_pwnd             (cmos_pwdn),
	.initial_en              (initial_en)		
);

reg_config	reg_config_inst(
	.clk_25M                 (cmos_clk),
	.camera_rstn             (cmos_reset),
	.initial_en              (initial_en),		
	.i2c_sclk                (cmos_scl),
	.i2c_sdat                (cmos_sda),
	.reg_conf_done           (),
	.strobe_flash            (),
	.reg_index               (),
	.clock_20k               (),
	// ry, 2016.12.26
	//.key1                    (sys_key0)
	.key1                    (1'b0)
);
wire cmos_vsync_delay;
wire cmos_href_delay;
wire[7:0] cmos_d_delay;
common_std_logic_vector_delay#
(
	.WIDTH(10),
	.DELAY(4)
)
common_std_logic_vector_delay_m2
(
	.clock(cmos_pclk_gbuf),
	.reset(1'b0),
	.ena(1'b1),
	.data({cmos_vsync,cmos_href,cmos_d}),
	.q({cmos_vsync_delay,cmos_href_delay,cmos_d_delay})
);
wire[11:0] in_width,in_height;
wire[15:0] h_scale_K,v_scale_K;
assign in_width = 12'd1280;
assign in_height = 12'd720;
scaler_K_gen scaler_K_gen_m0(
	.clk(sys_clk),
	.s_width(in_width),
	.s_height(in_height),
	.t_width(H_ACTIVE[11:0]),
	.t_height(V_ACTIVE[11:0]),
	.h_scale_K(h_scale_K),
	.v_scale_K(v_scale_K)
);
	
cmos_8_16bit cmos_8_16bit_m0(
	.rst(1'b0),
	.pclk(cmos_pclk_gbuf),
	.pdata_i(cmos_d_delay),
	.de_i(cmos_href_delay),
	.pdata_o(ch0_yc_data),
	.de_o(ch0_de)
);

wire ch0_vout_rd_req;
wire[23:0] ch0_vout_ycbcr;
wire  s_wr_done;
wire [1:0] s_frame_addr;
wire [1:0] wr_frame_addr;
video_pro#
(
	.MEM_DATA_BITS(MEM_DATA_BITS),
	.INTERLACE(0)
) video_pro_m0(
	// lszhang, 2017.01.09
	//.rst_n(1'b1),
	.rst_n(rst_n),
	.vin_pixel_clk(cmos_pclk_gbuf),
	.vin_vs(cmos_vsync_delay),
	.vin_f(1'b1),
	.vin_pixel_de(ch0_de),
	.vin_pixel_yc({ch0_yc_data[15:8],ch0_yc_data[7:0]}),
	.vin_s_width(in_width),
	.vin_s_height(in_height),
	.clipper_left(12'd0),
	.clipper_width(in_width),
	.clipper_top(12'd0),
	.clipper_height(in_height),
	.vout_pixel_clk(video_clk),
	.vout_vs(video_vs),
	.vout_pixel_rd_req(ch0_vout_rd_req),
	.vout_pixel_ycbcr(ch0_vout_ycbcr),
	.vout_scaler_clk(video_clk),
	.vout_t_width(H_ACTIVE[11:0]),
	.vout_t_height(V_ACTIVE[11:0]),
	.vout_K_h(h_scale_K),
	.vout_K_v(v_scale_K),
	.mem_clk(phy_clk),
	.wr_burst_req(ch0_wr_burst_req),
	.wr_burst_len(ch0_wr_burst_len),
	.wr_burst_addr(ch0_wr_burst_addr),
	.wr_burst_data_req(ch0_wr_burst_data_req),
	.wr_burst_data(ch0_wr_burst_data),
	.wr_burst_finish(ch0_wr_burst_finish),
	.rd_burst_req(ch0_rd_burst_req),
	.rd_burst_len(ch0_rd_burst_len),
	.rd_burst_addr(ch0_rd_burst_addr),
	.rd_burst_data_valid(ch0_rd_burst_data_valid),
	.rd_burst_data(ch0_rd_burst_data),
	.rd_burst_finish(ch0_rd_burst_finish),
	.base_addr(2'd0),
	//zclin 2016.12.30
	.s_wr_done(s_wr_done),
	.s_frame_addr(s_frame_addr),
	.frame_addr(wr_frame_addr)
);
/*pgao*/
wire o_vsys;
wire o_href;
wire o_data_en;
wire [7:0] o_hue;
OT_top OT_u1(
	.i_rst_n(rst_n),
	.i_cmos_pclk_gbuf(cmos_pclk_gbuf),
	.i_cmos_vsync_delay(cmos_vsync_delay),
	.i_cmos_href_delay(cmos_href_delay),
	.i_cmos_d_delay(cmos_d_delay),
	.o_vsys(o_vsys),
	.o_href(o_href),
	.o_hue(o_hue),
	.o_data_en(o_data_en)	
);
/*ry*/
wire[10:0] track_out_col_min;
wire[10:0] track_out_row_min;
wire[10:0] track_out_col_max;
wire[10:0] track_out_row_max;
wire[1:0] track_frame_addr;
wire track_done;
wire[32:0] cmd_data_in;
wire[7:0] vout_data;
wire cmd_wr_en;
wire data_rd_en;
wire cmd_fifo_afull;
wire data_fifo_aempty;
wire start;

reg init_en_door_close;
always@(posedge cmos_pclk_gbuf or negedge rst_n)

    if(!rst_n)
	     init_en_door_close <= 1'b0;
    else if(start)
        init_en_door_close <= 1'b1;

(* keep = "true" *)wire t_frame_false;
wire init_en;
assign init_en = (start && (!init_en_door_close));

square_add square_add_inst(
    .rst_n(rst_n),
	.vin_vs(cmos_vsync_delay),
    .vin_clk(cmos_pclk_gbuf),
	.mem_clk(phy_clk),
	.algo_x1(track_out_col_min),
	.algo_y1(track_out_row_min),
	.algo_x2(track_out_col_max),
	.algo_y2(track_out_row_max),
	.track_done(track_done),
   .track_frame_addr(track_frame_addr),
	.wr_burst_req(ch2_wr_burst_req),
	.wr_burst_data_req(ch2_wr_burst_data_req),
	.wr_burst_addr(ch2_wr_burst_addr),
    .wr_burst_data(ch2_wr_burst_data),
	.wr_burst_len(ch2_wr_burst_len),
	.burst_finish(ch2_wr_burst_finish),
	//zclin 2016.12.30
	.wr_done(s_wr_done),
	.s_frame_addr(s_frame_addr),
	.frame_false(t_frame_false)
);
algo_wr_interface algo_wr_interface_inst(
    .rst_n(rst_n),
	.vin_clk(cmos_pclk_gbuf),
	.mem_clk(phy_clk),
	.o_hue(o_hue),
	.o_vs(o_vsys),
	.o_hs(o_href),
	.o_data_en(o_data_en),
	.vin_width(in_width),
	.wr_burst_req(ch1_wr_burst_req),
	.wr_burst_data_req(ch1_wr_burst_data_req),
	.wr_burst_len(ch1_wr_burst_len),
	.wr_burst_addr(ch1_wr_burst_addr),
	.wr_burst_data(ch1_wr_burst_data),
	.burst_finish(ch1_wr_burst_finish),
	.frame_addr(wr_frame_addr)
);
algo_rd_interface algo_rd_interface_inst(
    .rst_n(rst_n),
	.mem_clk(phy_clk),
	.vout_clk(cmos_pclk_gbuf),
	.vin_clk(cmos_pclk_gbuf),
	.vin_vs(cmos_vsync_delay),
	.cmos_href(cmos_href),
	.rd_burst_req(ch1_rd_burst_req),
	.rd_burst_data_valid(ch1_rd_burst_data_valid),
	.rd_burst_len(ch1_rd_burst_len), 
	.rd_burst_addr(ch1_rd_burst_addr),
	.rd_burst_data(ch1_rd_burst_data),
	.burst_finish(ch1_rd_burst_finish),
	.vout_data(vout_data),
	.cmd_data_in(cmd_data_in),
	.cmd_wr_en(cmd_wr_en),
	.data_rd_en(data_rd_en),
	.cmd_fifo_afull(cmd_fifo_afull),
	.data_fifo_aempty(data_fifo_aempty), 
	.frame_addr(track_frame_addr),
	.start(start),
	.track_done(track_done)
);
//////////////////////////////////////////////////////
tracking 	calc_tracking
				(
					.clk(cmos_pclk_gbuf),
					.rst_n(rst_n),
					.t_en(start),
					.i_en(init_en),
					.c_min_i(11'd200),
					.c_max_i(11'd400),
					.r_min_i(11'd200),
					.r_max_i(11'd400),
					.cmd_full(cmd_fifo_afull),
					.data_empty(data_fifo_aempty),
					.h_i(11'd720),
					.w_i(11'd1280),
					.h_value(vout_data),
					
					.data_rd(data_rd_en),
					.cmd_wr(cmd_wr_en),
					.cam_addr(cmd_data_in),
					.c_min_o(track_out_col_min),
					.r_min_o(track_out_row_min),
					.c_max_o(track_out_col_max),
					.r_max_o(track_out_row_max),
					.t_done(track_done),
					.frame_addr(track_frame_addr),
					.wr_frame_addr(wr_frame_addr),
					.frame_false(t_frame_false)
				);
// /*zc*/
// tracking_1  tracking(
					// .clk(cmos_pclk_gbuf),
					// .nrst(rst_n),
					// .track_en(start),
					// .init_en(init_en),
					// .track_col_in_min(11'd278),
					// .track_col_in_max(11'd380),
					// .track_row_in_min(11'd590),
					// .track_row_in_max(11'd682),
					// .almost_full(cmd_fifo_afull),
					// .almost_empty(data_fifo_aempty),
					// .camshift_rd(data_rd_en),
					// .camshift_wr(cmd_wr_en),
					// .size_height_in(11'd720),
					// .size_width_in(11'd1280),
					// .h_value(vout_data),
					// .camshift_address(cmd_data_in),
					// .track_out_col_min(track_out_col_min),
					// .track_out_row_min(track_out_row_min),
					// .track_out_col_max(track_out_col_max),
					// .track_out_row_max(track_out_row_max),
					// .track_done(track_done),
					// .frame_addr(track_frame_addr)
					// );
//////////////////////////////////////////////////////////
vout_display_pro vout_display_pro_m0(
	.rst_n(rst_n),
	.dp_clk(video_clk),
	.h_fp(H_FP[11:0]),
	.h_sync(H_SYNC[11:0]),
	.h_bp(H_BP[11:0]),
	.h_active(H_ACTIVE[11:0]),
	.h_total(H_TOTAL[11:0]),
	
	.v_fp(V_FP[11:0]),
	.v_sync(V_SYNC[11:0]),
	.v_bp(V_BP[11:0]), 
	.v_active(V_ACTIVE[11:0]),
	.v_total(V_TOTAL[11:0]),
	
	.hs(video_hs),
	.vs(video_vs),
	.de(video_de),
	
	.rgb_r(video_r),
	.rgb_g(video_g),
	.rgb_b(video_b),
	
	.layer0_top(12'd0),
	.layer0_left(12'd0),
	.layer0_width(H_ACTIVE[11:0]),
	.layer0_height(V_ACTIVE[11:0]),
	.layer0_alpha(8'hff),
	.layer0_rdreq(ch0_vout_rd_req),
	.layer0_ycbcr(ch0_vout_ycbcr)
);
mem_ctrl
#(
	.MEM_DATA_BITS(MEM_DATA_BITS)
)
mem_ctrl_m0(
	.rst_n(rst_n),
	.source_clk(clk_50m),
	.phy_clk(phy_clk),
	.ch0_rd_burst_req(ch0_rd_burst_req),
	.ch0_rd_burst_len(ch0_rd_burst_len),
	.ch0_rd_burst_addr(ch0_rd_burst_addr),
	.ch0_rd_burst_data_valid(ch0_rd_burst_data_valid),
	.ch0_rd_burst_data(ch0_rd_burst_data),
	.ch0_rd_burst_finish(ch0_rd_burst_finish),
		   
	.ch0_wr_burst_req(ch0_wr_burst_req),
	.ch0_wr_burst_len(ch0_wr_burst_len),
	.ch0_wr_burst_addr(ch0_wr_burst_addr),
	.ch0_wr_burst_data_req(ch0_wr_burst_data_req),
	.ch0_wr_burst_data(ch0_wr_burst_data),
	.ch0_wr_burst_finish(ch0_wr_burst_finish),
	
	.ch1_rd_burst_req(ch1_rd_burst_req),
	.ch1_rd_burst_len(ch1_rd_burst_len),
	.ch1_rd_burst_addr(ch1_rd_burst_addr),
	.ch1_rd_burst_data_valid(ch1_rd_burst_data_valid),
	.ch1_rd_burst_data(ch1_rd_burst_data),
	.ch1_rd_burst_finish(ch1_rd_burst_finish),
		   
	.ch1_wr_burst_req(ch1_wr_burst_req),
	.ch1_wr_burst_len(ch1_wr_burst_len),
	.ch1_wr_burst_addr(ch1_wr_burst_addr),
	.ch1_wr_burst_data_req(ch1_wr_burst_data_req),
	.ch1_wr_burst_data(ch1_wr_burst_data),
	.ch1_wr_burst_finish(ch1_wr_burst_finish),
	
	.ch2_rd_burst_req(ch2_rd_burst_req),
	.ch2_rd_burst_len(ch2_rd_burst_len),
	.ch2_rd_burst_addr(ch2_rd_burst_addr),
	.ch2_rd_burst_data_valid(ch2_rd_burst_data_valid),
	.ch2_rd_burst_data(ch2_rd_burst_data),
	.ch2_rd_burst_finish(ch2_rd_burst_finish),
		   
	.ch2_wr_burst_req(ch2_wr_burst_req),
	.ch2_wr_burst_len(ch2_wr_burst_len),
	.ch2_wr_burst_addr(ch2_wr_burst_addr),
	.ch2_wr_burst_data_req(ch2_wr_burst_data_req),
	.ch2_wr_burst_data(ch2_wr_burst_data),
	.ch2_wr_burst_finish(ch2_wr_burst_finish),
	

`ifdef Xilinx	
	.mcb3_dram_dq         (mcb3_dram_dq       ),
	.mcb3_dram_a          (mcb3_dram_a        ),
	.mcb3_dram_ba         (mcb3_dram_ba       ),
	.mcb3_dram_ras_n      (mcb3_dram_ras_n    ),
	.mcb3_dram_cas_n      (mcb3_dram_cas_n    ),
	.mcb3_dram_we_n       (mcb3_dram_we_n     ),
	.mcb3_dram_odt        (mcb3_dram_odt      ),
	.mcb3_dram_reset_n    (mcb3_dram_reset_n  ),
	.mcb3_dram_cke        (mcb3_dram_cke      ),
	.mcb3_dram_dm         (mcb3_dram_dm       ),
	.mcb3_dram_udqs       (mcb3_dram_udqs     ),
	.mcb3_dram_udqs_n     (mcb3_dram_udqs_n   ),
	.mcb3_rzq             (mcb3_rzq           ),
	.mcb3_zio             (mcb3_zio           ),
	.mcb3_dram_udm        (mcb3_dram_udm      ),
	.mcb3_dram_dqs        (mcb3_dram_dqs      ),
	.mcb3_dram_dqs_n      (mcb3_dram_dqs_n    ),
	.mcb3_dram_ck         (mcb3_dram_ck       ),
	.mcb3_dram_ck_n       (mcb3_dram_ck_n     )
`else
	.mem_cs_n(mem_cs_n),
	.mem_cke(mem_cke),
	.mem_addr(mem_addr),
	.mem_ba(mem_ba),
	.mem_ras_n(mem_ras_n),
	.mem_cas_n(mem_cas_n),
	.mem_we_n(mem_we_n),
	.mem_clk(mem_clk),
	.mem_clk_n(mem_clk_n),
	.mem_dm(mem_dm),
	.mem_dq(mem_dq),
	.mem_dqs(mem_dqs),
	.mem_odt(mem_odt)
`endif
);

common_std_logic_vector_delay#
(
	.WIDTH(27),
	.DELAY(1)
)
common_std_logic_vector_delay_m0
(
	.clock(video_clk),
	.reset(1'b0),
	.ena(1'b1),
	.data({video_hs,video_vs,video_de,video_r,video_g,video_b}),
	.q({hdmi_out_hs,hdmi_out_vs,hdmi_out_de,hdmi_out_rgb_r,hdmi_out_rgb_g,hdmi_out_rgb_b})
);

common_std_logic_vector_delay#
(
	.WIDTH(27),
	.DELAY(1)
)
common_std_logic_vector_delay_m1
(
	.clock(video_clk),
	.reset(1'b0),
	.ena(1'b1),
	.data({video_hs,video_vs,video_de,video_r,video_g,video_b}),
	.q({vga_hs,vga_vs,vga_de,vga_r,vga_g,vga_b})
);

vga_out_io vga_out_io_m0
(
	.vga_clk      (video_clk    ),
	.vga_hs       (vga_hs       ),
	.vga_vs       (vga_vs       ),
	.vga_de       (vga_de       ),
	.vga_rgb      ({vga_r,vga_g,vga_b}),
	.vga_out_clk  (vga_out_clk  ),
	.vga_out_hs   (vga_out_hs   ),
	.vga_out_de   (vga_out_de   ),
	.vga_out_vs   (vga_out_vs   ),
	.vga_out_data (vga_out_data )
);

endmodule 