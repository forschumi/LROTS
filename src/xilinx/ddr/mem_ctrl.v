/*模块包含读写仲裁，相当于将DDR2扩展为多个接口*/
module mem_ctrl#(
	parameter MEM_DATA_BITS = 32,
	parameter C3_NUM_DQ_PINS          = 16,       
                                       // External memory data width
	parameter C3_MEM_ADDR_WIDTH       = 14,       
                                       // External memory address width
	parameter C3_MEM_BANKADDR_WIDTH   = 3        
                                       // External memory bank address width
)
(
	input rst_n,
	input source_clk,
	output phy_clk,

	input ch0_rd_burst_req,
	input[9:0] ch0_rd_burst_len,
	//input[23:0] ch0_rd_burst_addr,
	input[26:0] ch0_rd_burst_addr,
	output ch0_rd_burst_data_valid,
	output[MEM_DATA_BITS - 1:0] ch0_rd_burst_data,
	output ch0_rd_burst_finish,
	
	input ch1_rd_burst_req,
	input[9:0] ch1_rd_burst_len,
	//input[23:0] ch1_rd_burst_addr,
	input[26:0] ch1_rd_burst_addr,
	output ch1_rd_burst_data_valid,
	output[MEM_DATA_BITS - 1:0] ch1_rd_burst_data,
	output ch1_rd_burst_finish,
	
	input ch2_rd_burst_req,
	input[9:0] ch2_rd_burst_len,
	//input[23:0] ch2_rd_burst_addr,
	input[26:0] ch2_rd_burst_addr,
	output ch2_rd_burst_data_valid,
	output[MEM_DATA_BITS - 1:0] ch2_rd_burst_data,
	output ch2_rd_burst_finish,
	
	input ch3_rd_burst_req,
	input[9:0] ch3_rd_burst_len,
	//input[23:0] ch3_rd_burst_addr,
	input[26:0] ch3_rd_burst_addr,
	output ch3_rd_burst_data_valid,
	output[MEM_DATA_BITS - 1:0] ch3_rd_burst_data,
	output ch3_rd_burst_finish,
	///////////////////////////////////////////
	input ch0_wr_burst_req,
	input[9:0] ch0_wr_burst_len,
	//input[23:0] ch0_wr_burst_addr,
	input[26:0] ch0_wr_burst_addr,
	output ch0_wr_burst_data_req,
	input[MEM_DATA_BITS - 1:0] ch0_wr_burst_data,
	output ch0_wr_burst_finish,
	
	input ch1_wr_burst_req,
	input[9:0] ch1_wr_burst_len,
	//input[23:0] ch1_wr_burst_addr,
	input[26:0] ch1_wr_burst_addr,
	output ch1_wr_burst_data_req,
	input[MEM_DATA_BITS - 1:0] ch1_wr_burst_data,
	output ch1_wr_burst_finish,
	
	input ch2_wr_burst_req,
	input[9:0] ch2_wr_burst_len,
	//input[23:0] ch2_wr_burst_addr,
	input[26:0] ch2_wr_burst_addr,
	output ch2_wr_burst_data_req,
	input[MEM_DATA_BITS - 1:0] ch2_wr_burst_data,
	output ch2_wr_burst_finish,
	
	input ch3_wr_burst_req,
	input[9:0] ch3_wr_burst_len,
	//input[23:0] ch3_wr_burst_addr,
	input[26:0] ch3_wr_burst_addr,
	output ch3_wr_burst_data_req,
	input[MEM_DATA_BITS - 1:0] ch3_wr_burst_data,
	output ch3_wr_burst_finish,
	
	
	/////////////////////////////////////
	output                                           calib_done,
	inout  [C3_NUM_DQ_PINS-1:0]                      mcb3_dram_dq,
	output [C3_MEM_ADDR_WIDTH-1:0]                   mcb3_dram_a,
	output [C3_MEM_BANKADDR_WIDTH-1:0]               mcb3_dram_ba,
	output                                           mcb3_dram_ras_n,
	output                                           mcb3_dram_cas_n,
	output                                           mcb3_dram_we_n,
	output                                           mcb3_dram_odt,
	output                                           mcb3_dram_reset_n,
	output                                           mcb3_dram_cke,
	output                                           mcb3_dram_dm,
	inout                                            mcb3_dram_udqs,
	inout                                            mcb3_dram_udqs_n,
	inout                                            mcb3_rzq,
	inout                                            mcb3_zio,
	output                                           mcb3_dram_udm,
	inout                                            mcb3_dram_dqs,
	inout                                            mcb3_dram_dqs_n,
	output                                           mcb3_dram_ck,
	output                                           mcb3_dram_ck_n
);
wire	            cmd_clk;
wire 	            cmd_en;
wire [2:0] 	        cmd_instr;
wire [5:0]		    cmd_bl;
wire [29:0]	        cmd_byte_addr;
wire				cmd_empty;
wire				cmd_full;

wire				wr_clk;
wire  			    wr_en;
wire[7:0]	        wr_mask;
wire[63:0]	        wr_data;
wire				wr_full;
wire				wr_empty;
wire[6:0]			wr_count;
wire				wr_underrun;
wire				wr_error;

wire				rd_clk;
wire  			    rd_en;
wire[63:0]	        rd_data;
wire				rd_full;
wire				rd_empty;
wire[6:0]			rd_count;
wire				rd_overflow;
wire				rd_error;


wire rd_burst_finish;
wire wr_burst_finish;
//wire[23:0] wr_burst_addr;
wire[26:0] wr_burst_addr;
//wire[23:0] rd_burst_addr;
wire[26:0] rd_burst_addr;
wire wr_burst_data_req;
wire rd_burst_data_valid;
wire[9:0] wr_burst_len;
wire[9:0] rd_burst_len;
wire wr_burst_req;
wire rd_burst_req;
wire[MEM_DATA_BITS - 1:0] wr_burst_data;
wire[MEM_DATA_BITS - 1:0] rd_burst_data;
wire ddr_rst_n;
mem_burst_v2
#(
	.MEM_DATA_BITS(MEM_DATA_BITS)
)
mem_burst_m0(
	.rst(~rst_n),
	.mem_clk(phy_clk),
	.rd_burst_req(rd_burst_req),
	.wr_burst_req(wr_burst_req),
	.rd_burst_len(rd_burst_len),
	.wr_burst_len(wr_burst_len),
	.rd_burst_addr(rd_burst_addr),
	.wr_burst_addr(wr_burst_addr),
	.rd_burst_data_valid(rd_burst_data_valid),
	.wr_burst_data_req(wr_burst_data_req),
	.rd_burst_data(rd_burst_data),
	.wr_burst_data(wr_burst_data),
	.rd_burst_finish(rd_burst_finish),
	.wr_burst_finish(wr_burst_finish),
	///////////////////
	.calib_done(calib_done),
	.cmd_clk(cmd_clk),
	.cmd_en(cmd_en),
	.cmd_instr(cmd_instr),
	.cmd_bl(cmd_bl),
	.cmd_byte_addr(cmd_byte_addr),
	.cmd_empty(cmd_empty),
	.cmd_full(cmd_full),

	.wr_clk(wr_clk),
	.wr_en(wr_en),
	.wr_mask(wr_mask),
	.wr_data(wr_data),
	.wr_full(wr_full),
	.wr_empty(wr_empty),
	.wr_count(wr_count),
	.wr_underrun(wr_underrun),
	.wr_error(wr_error),

	.rd_clk(rd_clk),
	.rd_en(rd_en),
	.rd_data(rd_data),
	.rd_full(rd_full),
	.rd_empty(rd_empty),
	.rd_count(rd_count),
	.rd_overflow(rd_overflow),
	.rd_error(rd_error)
);

mem_read_arbi 
#(
	.MEM_DATA_BITS(MEM_DATA_BITS)
)
mem_read_arbi_m0
(
	.rst_n(rst_n),
	.mem_clk(phy_clk),
	.ch0_rd_burst_req(ch0_rd_burst_req),
	.ch0_rd_burst_len(ch0_rd_burst_len),
	.ch0_rd_burst_addr(ch0_rd_burst_addr),
	.ch0_rd_burst_data_valid(ch0_rd_burst_data_valid),
	.ch0_rd_burst_data(ch0_rd_burst_data),
	.ch0_rd_burst_finish(ch0_rd_burst_finish),
	
	.ch1_rd_burst_req(ch1_rd_burst_req),
	.ch1_rd_burst_len(ch1_rd_burst_len),
	.ch1_rd_burst_addr(ch1_rd_burst_addr),
	.ch1_rd_burst_data_valid(ch1_rd_burst_data_valid),
	.ch1_rd_burst_data(ch1_rd_burst_data),
	.ch1_rd_burst_finish(ch1_rd_burst_finish),
	
	.ch2_rd_burst_req(ch2_rd_burst_req),
	.ch2_rd_burst_len(ch2_rd_burst_len),
	.ch2_rd_burst_addr(ch2_rd_burst_addr),
	.ch2_rd_burst_data_valid(ch2_rd_burst_data_valid),
	.ch2_rd_burst_data(ch2_rd_burst_data),
	.ch2_rd_burst_finish(ch2_rd_burst_finish),
	
	.ch3_rd_burst_req(ch3_rd_burst_req),
	.ch3_rd_burst_len(ch3_rd_burst_len),
	.ch3_rd_burst_addr(ch3_rd_burst_addr),
	.ch3_rd_burst_data_valid(ch3_rd_burst_data_valid),
	.ch3_rd_burst_data(ch3_rd_burst_data),
	.ch3_rd_burst_finish(ch3_rd_burst_finish),
	
	///////////////////////////////////////////
	.rd_burst_req(rd_burst_req),
	.rd_burst_len(rd_burst_len),
	.rd_burst_addr(rd_burst_addr),
	.rd_burst_data_valid(rd_burst_data_valid),
	.rd_burst_data(rd_burst_data),
	.rd_burst_finish(rd_burst_finish)	
);

mem_write_arbi
#(
	.MEM_DATA_BITS(MEM_DATA_BITS)
)
mem_write_arbi_m0(
	.rst_n(rst_n),
	.mem_clk(phy_clk),
	
	.ch0_wr_burst_req(ch0_wr_burst_req),
	.ch0_wr_burst_len(ch0_wr_burst_len),
	.ch0_wr_burst_addr(ch0_wr_burst_addr),
	.ch0_wr_burst_data_req(ch0_wr_burst_data_req),
	.ch0_wr_burst_data(ch0_wr_burst_data),
	.ch0_wr_burst_finish(ch0_wr_burst_finish),
	
	.ch1_wr_burst_req(ch1_wr_burst_req),
	.ch1_wr_burst_len(ch1_wr_burst_len),
	.ch1_wr_burst_addr(ch1_wr_burst_addr),
	.ch1_wr_burst_data_req(ch1_wr_burst_data_req),
	.ch1_wr_burst_data(ch1_wr_burst_data),
	.ch1_wr_burst_finish(ch1_wr_burst_finish),
	
	.ch2_wr_burst_req(ch2_wr_burst_req),
	.ch2_wr_burst_len(ch2_wr_burst_len),
	.ch2_wr_burst_addr(ch2_wr_burst_addr),
	.ch2_wr_burst_data_req(ch2_wr_burst_data_req),
	.ch2_wr_burst_data(ch2_wr_burst_data),
	.ch2_wr_burst_finish(ch2_wr_burst_finish),
	
	.ch3_wr_burst_req(ch3_wr_burst_req),
	.ch3_wr_burst_len(ch3_wr_burst_len),
	.ch3_wr_burst_addr(ch3_wr_burst_addr),
	.ch3_wr_burst_data_req(ch3_wr_burst_data_req),
	.ch3_wr_burst_data(ch3_wr_burst_data),
	.ch3_wr_burst_finish(ch3_wr_burst_finish),
	
	.wr_burst_req(wr_burst_req),
	.wr_burst_len(wr_burst_len),
	.wr_burst_addr(wr_burst_addr),
	.wr_burst_data_req(wr_burst_data_req),
	.wr_burst_data(wr_burst_data),
	.wr_burst_finish(wr_burst_finish)	
);
localparam C3_MEM_ADDR_ORDER     = "ROW_BANK_COLUMN"; 
   
ddr3_top #(
.C3_MEM_ADDR_ORDER     (C3_MEM_ADDR_ORDER    ),
.C3_NUM_DQ_PINS        (C3_NUM_DQ_PINS       ),
.C3_MEM_ADDR_WIDTH     (C3_MEM_ADDR_WIDTH    ),
.C3_MEM_BANKADDR_WIDTH (C3_MEM_BANKADDR_WIDTH)
)
ddr3_m0 (

    .c3_sys_clk           (source_clk),
	.c3_sys_rst_i        (~rst_n),                        
	.c3_clk0(phy_clk),
	.c3_p1_cmd_en(1'b0),
	.c3_p0_cmd_clk(cmd_clk),
	.c3_p0_cmd_en(cmd_en),
	.c3_p0_cmd_instr(cmd_instr),
	.c3_p0_cmd_bl(cmd_bl),
	.c3_p0_cmd_byte_addr(cmd_byte_addr),
	.c3_p0_cmd_empty(cmd_empty),
	.c3_p0_cmd_full(cmd_full),
	.c3_p0_wr_clk(wr_clk),
	.c3_p0_wr_en(wr_en),
	.c3_p0_wr_mask(wr_mask),
	.c3_p0_wr_data(wr_data),
	.c3_p0_wr_full(wr_full),
	.c3_p0_wr_empty(wr_empty),
	.c3_p0_wr_count(wr_count),
	.c3_p0_wr_underrun(wr_underrun),
	.c3_p0_wr_error(wr_error),
	.c3_p0_rd_clk(rd_clk),
	.c3_p0_rd_en(rd_en),
	.c3_p0_rd_data(rd_data),
	.c3_p0_rd_full(rd_full),
	.c3_p0_rd_empty(rd_empty),
	.c3_p0_rd_count(rd_count),
	.c3_p0_rd_overflow(rd_overflow),
	.c3_p0_rd_error(rd_error),
	
	.calib_done             (calib_done),	
	
	.mcb3_dram_dq           (mcb3_dram_dq),  
	.mcb3_dram_a            (mcb3_dram_a),  
	.mcb3_dram_ba           (mcb3_dram_ba),
	.mcb3_dram_ras_n        (mcb3_dram_ras_n),                        
	.mcb3_dram_cas_n        (mcb3_dram_cas_n),                        
	.mcb3_dram_we_n         (mcb3_dram_we_n),                          
	.mcb3_dram_odt          (mcb3_dram_odt),
	.mcb3_dram_cke          (mcb3_dram_cke),                          
	.mcb3_dram_ck           (mcb3_dram_ck),                          
	.mcb3_dram_ck_n         (mcb3_dram_ck_n),       
	.mcb3_dram_dqs          (mcb3_dram_dqs),                          
	.mcb3_dram_dqs_n        (mcb3_dram_dqs_n),
	.mcb3_dram_udqs         (mcb3_dram_udqs),    // for X16 parts                        
	.mcb3_dram_udqs_n       (mcb3_dram_udqs_n),  // for X16 parts
	.mcb3_dram_udm          (mcb3_dram_udm),     // for X16 parts
	.mcb3_dram_dm           (mcb3_dram_dm),
	.mcb3_rzq               (mcb3_rzq),  
        
	.mcb3_zio               (mcb3_zio),
	
	.mcb3_dram_reset_n      (mcb3_dram_reset_n)
); 
endmodule 