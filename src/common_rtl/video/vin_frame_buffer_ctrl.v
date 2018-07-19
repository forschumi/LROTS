`timescale 1ps/1ps
/*
ģ�����16bit��YC���ݵ�64bit�����ݶ��룬Ȼ��д��FIFO��
��֡д��״̬�����64bit����д��ddr2
*/
module vin_frame_buffer_ctrl
 #(
	parameter MEM_DATA_BITS = 64,
	parameter INTERLACE = 1
) 
(
	input rst_n,                                    /*��λ */
	input vin_clk,                                  /*��Ƶ����ʱ�� */
	input vin_vs,                                   /*��Ƶ���볡ͬ�� */
	input vin_f,                                    /*��Ƶ������ż����־ */
	input vin_de,                                   /*��Ƶ����������Ч */
	input[15:0] vin_data,                           /*��Ƶ��������YC */
	input[11:0] vin_width,                          /*��Ƶ������*/
	input[11:0] vin_height,                         /*��Ƶ����߶�*/
	output reg fifo_afull,                          /*����fifo����*/
	input mem_clk,                                  /*�洢���ӿڣ�ʱ��*/
	output reg wr_burst_req,                        /*�洢���ӿڣ�д����*/
	output reg[9:0] wr_burst_len,                   /*�洢���ӿڣ�д����*/
	//output reg[23:0] wr_burst_addr,                 /*�洢���ӿڣ�д�׵�ַ */
	output reg[26:0] wr_burst_addr,                 /*�洢���ӿڣ�д�׵�ַ */
	input wr_burst_data_req,                        /*�洢���ӿڣ�д�������ݶ�ָʾ */
	output[MEM_DATA_BITS - 1:0] wr_burst_data,      /*�洢���ӿڣ�д����*/
	input burst_finish,                             /*�洢���ӿڣ�����д��� */
	output reg[11:0] wr_max_line,                   /*�����źţ������� */
	input[1:0] base_addr,                           /*֡��ַ����*/
	output reg[1:0] frame_addr                      /*��ǰд��֡��ַ*/
);                                                   
initial                                              
begin
	frame_addr <= 2'd0;
end
localparam BURST_LEN = 10'd128;               /*һ��д�������ݳ��� */
localparam BURST_IDLE = 3'd0;                 /*״̬��״̬������ */
localparam BURST_ONE_LINE_START = 3'd1;       /*״̬��״̬����Ƶ����һ��д��ʼ */
localparam BURSTING = 3'd2;                   /*״̬��״̬�����ڴ���һ��ddr2д���� */
localparam BURST_END = 3'd3;                  /*״̬��״̬��һ��ddr2д�������*/
localparam BURST_ONE_LINE_END = 3'd4;         /*״̬��״̬����Ƶ����һ��д���*/
reg[2:0] burst_state = 3'd0;                  /*״̬��״̬����ǰ״̬ */
reg[2:0] burst_state_next = 3'd0;             /*״̬��״̬����һ��״̬*/
reg[10:0] burst_line = 12'd0;/*�Ѿ�д��ddr2���м���*/
reg[9:0] byte_per_line = 10'd0;/*����Ƶ��Ȼ����д��ddr2�����ݸ���*/
 /*������Ƶ������16bit��ddr2�ӿ���64bit����Ҫ�ֽڶ������������Ĵ�����������ÿ����Ƶ����Ϊddr2�ӿں�����ݳ��� */
 /*�磺��Ƶ�����200���������50����Ƶ�����199������󳤶�Ҳ��50����Ƶ�����201������󳤶���51*/
reg[9:0] remain_len = 10'd0;/*��ǰ��Ƶһ�����ݵ�ʣ�����ݸ���*/
wire[MEM_DATA_BITS - 1:0] data;/*��д��fifo�����ݣ���pixel0��pixel1��pixel2��pixel3ƴ�Ӷ���*/
reg[15:0] pixel0 = 16'd0;
reg[15:0] pixel1 = 16'd0;
reg[15:0] pixel2 = 16'd0;
reg[15:0] pixel3 = 16'd0;
reg[11:0] data_cnt  = 12'd0;
reg vin_vs_mem_clk_d0 = 1'b0;
reg vin_vs_mem_clk_d1 = 1'b0;
reg vin_vs_d0 = 1'b0;
reg vin_vs_d1 = 1'b0;
reg frame_flag = 1'b0;
reg frame_flag_vin = 1'b0;
reg fifo_wr_req = 1'b0;
wire[7:0] rdusedw;
wire[7:0] wrusedw;
always@(posedge vin_clk)
begin
	fifo_afull <= (wrusedw > 8'd245);
end
/*��д��fifo�����ݣ���pixel0��pixel1��pixel2��pixel3ƴ�Ӷ���*/
`ifdef Xilinx
assign data = {pixel0,pixel1,pixel2,pixel3};
`else
assign data = {pixel3,pixel2,pixel1,pixel0};
`endif
lite_fifo#
(
	.COMMON_CLOCK(0),
	.ADDR_WIDTH(8),
	.DATA_WIDTH(64)
)  vin_frame_buffer_ctrl_fifo_m0(
	.aclr(frame_flag),
	.data(data),
	.rdclk(mem_clk),
	.rdreq(wr_burst_data_req),
	.wrclk(vin_clk),
	.wrreq(fifo_wr_req),
	.q(wr_burst_data),
	.rdempty(),
	.rdusedw(rdusedw),
	.wrfull(),
	.wrusedw(wrusedw)); 
		
always@(posedge vin_clk)
begin
	vin_vs_d0 <= vin_vs;
	vin_vs_d1 <= vin_vs_d0;
	frame_flag_vin <= vin_vs_d0 && ~vin_vs_d1;
end
/*���ݼ���*/
always@(posedge vin_clk)
begin
	if(!rst_n)
		data_cnt <= 12'd0;
	else if(frame_flag_vin)
		data_cnt <= 12'd0;
	else if(vin_de)
		begin
			if(data_cnt == vin_width - 12'd1)
				data_cnt <= 12'd0;
			else
				data_cnt <= data_cnt + 12'd1;
		end
	else
		data_cnt <= data_cnt;
end
/*��data_cnt[1:0] == 0 ʱ��pixel0ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(vin_de && (data_cnt[1:0] == 2'd0))
		pixel0 <= vin_data;
	else
		pixel0 <= pixel0;		
end
/*��data_cnt[1:0] == 1 ʱ��pixel1ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(vin_de && (data_cnt[1:0] == 2'd1))
		pixel1 <= vin_data;
	else
		pixel1 <= pixel1;		
end
/*��data_cnt[1:0] == 2 ʱ��pixel2ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(vin_de && (data_cnt[1:0] == 2'd2))
		pixel2 <= vin_data;
	else
		pixel2 <= pixel2;
end
/*��data_cnt[1:0] == 3 ʱ��pixel3ȡ��ǰ����ֵ*/
always@(posedge vin_clk)
begin
	if(vin_de && (data_cnt[1:0] == 2'd3))
		pixel3 <= vin_data;
	else
		pixel3 <= pixel3;
end
/*��data_cnt[1:0] == 3 ʱ��pixel0��pixel1��pixel2��pixel3����ֵ����ƴ��Ϊһ��64bit�����һ��д��FIFO����*/
always@(posedge vin_clk)
begin
	if(vin_de &&(data_cnt[1:0] == 2'd3 || data_cnt == vin_width - 12'd1))
		fifo_wr_req <= 1'b1;
	else
		fifo_wr_req <= 1'b0;
end
/*����Ƶ��Ȼ����д��ddr2�����ݸ���*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		byte_per_line <= 10'd0;
	else if(frame_flag)
		if(vin_width[1:0] == 2'd0)
			byte_per_line <= vin_width[11:2];
		else
			byte_per_line <= vin_width[11:2] + 10'd1;
	else
		byte_per_line <= byte_per_line;
end
/*ͻ��д�׵�ַ�Ĳ���*/
//wire[23:0] ddr_wr_base;
wire[26:0] ddr_wr_base;
generate
	if(INTERLACE)
		//assign ddr_wr_base = {1'b0,base_addr,frame_addr[1:0],burst_line[8:0],vin_f,8'd0};//24bit ddr addr
		assign ddr_wr_base = {1'b0,base_addr,frame_addr[1:0],burst_line[9:0],vin_f,8'd0,3'd0};//24bit ddr addr
	else
		//assign ddr_wr_base =  {base_addr,frame_addr[1:0],burst_line[10:0],9'd0};//24bit ddr addr
		assign ddr_wr_base =  {base_addr,frame_addr[1:0],burst_line[10:0],9'd0,3'd0};//24bit ddr addr
endgenerate	
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		//wr_burst_addr <= 24'd0;
		wr_burst_addr <= 27'd0;
	else if(burst_state_next == BURST_ONE_LINE_START)
		wr_burst_addr <= ddr_wr_base;
	else if(burst_state_next == BURST_END  && burst_state != BURST_END)
		wr_burst_addr <= wr_burst_addr + {15'd0,BURST_LEN[8:0],3'd0};
	else
		wr_burst_addr <= wr_burst_addr;
end

always@(posedge mem_clk)
begin
	vin_vs_mem_clk_d0 <= vin_vs;
	vin_vs_mem_clk_d1 <= vin_vs_mem_clk_d0;
	frame_flag <= vin_vs_mem_clk_d0 && ~vin_vs_mem_clk_d1;
end
/*ÿһ֡����״̬��ǿ�н���BURST_IDLE״̬*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_state <= BURST_IDLE;
	else if(frame_flag)
		burst_state <= BURST_IDLE;
	else
		burst_state <= burst_state_next;
end
always@(*)
begin
	case(burst_state)
		BURST_IDLE:/*���FIFO���㹻�����������һ�е�һ��д����*/
			if(rdusedw > BURST_LEN[7:0])
				burst_state_next <= BURST_ONE_LINE_START;
			else
				burst_state_next <= BURST_IDLE;
		BURST_ONE_LINE_START:/*һ�е�д������ʼ*/
			burst_state_next <= BURSTING;
		BURSTING:/*д����*/
			if(burst_finish)
				burst_state_next <= BURST_END;
			else
				burst_state_next <= BURSTING;
		BURST_END:/*д�������ʱ�ж�һ�������Ƿ��Ѿ���ȫд��ddr2����������������״̬���ȴ��ڶ�������*/
			if(remain_len == 10'd0)
				burst_state_next <= BURST_ONE_LINE_END;
			else if((rdusedw >= BURST_LEN[7:0]) || (remain_len <= BURST_LEN && rdusedw >= remain_len - 10'd1))
				burst_state_next <= BURSTING;
			else
				burst_state_next <= BURST_END;
		BURST_ONE_LINE_END:
			burst_state_next <= BURST_IDLE;
		default:
			burst_state_next <= BURST_IDLE;
	endcase
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_max_line <= 12'd0;
	else if(frame_flag)
		wr_max_line <= burst_line;
	else
		wr_max_line <= wr_max_line;
end
/*burst_line����*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_line <= 12'd0;
	else if(frame_flag)
		burst_line <= 12'd0;
	else if(burst_state == BURST_ONE_LINE_END)//ÿ��һ��д��burst_line��1
		burst_line <= burst_line + 12'd1;
	else
		burst_line <= burst_line;
end
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		frame_addr <= 2'd0;
	else if(frame_flag && vin_f)//ûд��һ֡����frame_addr��1
	//else if(frame_flag)
		frame_addr <= frame_addr + 2'd1;
	else
		frame_addr <= frame_addr;
end	

/*remain_len������ÿһ��д��ʼʱ����byte_per_line�����һ������С��һ��д����󳤶ȣ�
һ��д�꣬��remain_len = 0�������ȥ���д����*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		remain_len <= 10'd0;
	else if(burst_state_next == BURST_ONE_LINE_START)
		remain_len <= byte_per_line;
	else if(burst_state_next == BURST_END && burst_state != BURST_END)
		if(remain_len < BURST_LEN)
			remain_len <= 10'd0;
		else
			remain_len <= remain_len - BURST_LEN;	
	else
		remain_len <= remain_len;
end
/*ͻ�����Ȳ��������һ�е�ʣ�����ݴ������д���ȣ���ͻ��������BURST_LEN������͵���ʣ�����ݳ���*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_burst_len <= 10'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		if(remain_len > BURST_LEN)
			wr_burst_len <= BURST_LEN;
		else
			wr_burst_len <= remain_len;
	else
		wr_burst_len <=  wr_burst_len;
end
/*ddr2д�����źŵĲ����ڳ���*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wr_burst_req <= 1'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		wr_burst_req <= 1'b1;
	else if(burst_finish  || wr_burst_data_req || burst_state == BURST_IDLE)
		wr_burst_req <= 1'b0;
	else
		wr_burst_req <= wr_burst_req;
end

endmodule 