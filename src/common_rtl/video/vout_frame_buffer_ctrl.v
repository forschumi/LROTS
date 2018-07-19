/////*ģ�齫ddr2�е���Ƶ���ݶ�������Ҫ��ɶ�ȡ��ַ�ļ��㣬λ���ת������Ϊddr2�ӿ���64bit�ģ�
//  ��ddr2�е���Ƶ������16bit�ġ�
////*/
//`include "define.v"

module vout_frame_buffer_ctrl
#(
	parameter MEM_DATA_BITS = 64,
	parameter WITDH_2K = 0
)
(
	input rst_n,                                      /////*��λ*/
	input vout_clk,                                   /////*�¼�������ģ�飩��ʱ��*/
	input vout_vs,                                    /////*��Ƶ�����ͬ��*/
	input vout_rd_req,                                /////*��Ƶ������ݶ�ȡ����*/
	output[15:0] vout_data,                           /////*��Ƶ�����ȡ������*/
	input[11:0] vout_width,                           /////*��Ƶ����Ŀ�ȣ�ָ���Ǵ��ڴ洢���ڵ���Ƶ���*/
	input[11:0] vout_height,                          /////*��Ƶ����ĸ߶�*/
	output fifo_rdempty,//�ڲ�fifo����
	input mem_clk,                                    /////*�洢���ӿ�ʱ��*/
	output reg rd_burst_req,                          /////*�洢���ӿڶ�ȡ����*/
	output reg[9:0] rd_burst_len,                     /////*�洢���ӿڶ�ȡ����*/
	//output reg[23:0] rd_burst_addr,                   /////*�洢���ӿڶ�ȡ�׵�ַ*/
	output reg[26:0] rd_burst_addr,                   /////*�洢���ӿڶ�ȡ�׵�ַ*/
	input rd_burst_data_valid,                        /////*�洢���ӿڷ��ض�ȡ������Ч*/
	input[MEM_DATA_BITS - 1:0] rd_burst_data,         /////*�洢���ӿڷ��صĶ�ȡ����*/
	input burst_finish,                               /////*���ζ�ȡ���*/
	input[11:0] wr_max_line,                          /////*�����ź�*/
	input[1:0] base_addr,                             /////*֡��ַ���Ʋ���֮һ*/
	input[1:0] wr_frame_addr,                          /////*��Ƶд��ģ�鵱ǰд��ĵ�ַ*/
	//zclin 2016.12.30
	input s_wr_done
);
localparam BURST_LEN = 10'd128;                       /////*����ͻ����ȡ�ĳ��ȣ�������ݴﲻ���������������ʵ�ʳ��ȶ�ȡ */
//localparam BURST_LEN = 10'd1024;                       /////*����ͻ����ȡ�ĳ��ȣ�������ݴﲻ���������������ʵ�ʳ��ȶ�ȡ */
localparam BURST_IDLE = 3'd0;                         /////*��ȡ����״̬��������״̬*/
localparam BURST_ONE_LINE_START = 3'd1;               /////*��ȡ����״̬������ʼ��ȡһ����Ƶ */
localparam BURSTING = 3'd2;                           /////*��ȡ����״̬�����������һ��ͻ����ȡ */
localparam BURST_END = 3'd3;                          /////*��ȡ����״̬����һ��ͻ����ȡ������� */
localparam BURST_ONE_LINE_END = 3'd4;                 /////*��ȡ����״̬����һ����Ƶ���ݶ�ȡ���*/
localparam WAIT = 3'd5;                               /////*��ȡ����״̬��������״̬ */
reg[2:0] burst_state = 3'd0;                          /////*��ȡ����״̬������ǰ״̬ */
reg[2:0] burst_state_next = 3'd0;                     /////*��ȡ����״̬������һ��״̬ */
reg[11:0] burst_line = 12'd0;                         /////*���֣�ÿ��һ�֣��Ѿ���ȡ�������� */
reg[9:0] byte_per_line = 10'd0;                       /////*������Ƶ������16bit��ddr2�ӿ���64bit����Ҫ�ֽڶ������������Ĵ�����������ÿ����Ƶ����Ϊddr2�ӿں�����ݳ��� *//////*�磺��Ƶ�����200���������50����Ƶ�����199������󳤶�Ҳ��50����Ƶ�����201������󳤶���51*/
//reg[11:0] byte_per_line = 12'd0; // ry, 2016.11.7 1280/16bit=2560/8bit
reg[9:0] byte_per_line_at_vout_clk = 10'd0;           /////*ͬ��*/
//reg[11:0] byte_per_line_at_vout_clk = 12'd0;           /////*ͬ��*/
reg[9:0] remain_len = 10'd0;
//reg[11:0] remain_len = 12'd0;
reg[1:0] rd_frame_addr = 2'd0;                        /////*��ȡ֡��ַ */
wire[15:0] mem_buf_q;                                 
wire mem_buf_rd_req;                                  
reg mem_buf_rd_req_d0 = 1'b0;                         
wire mem_buf_rdempty;                                 
reg[11:0] rd_cnt = 12'd0;                             /////*ÿ���Ѿ���ȡ������������Ҫ����������ddr��ȡ�������������ݣ��磺ÿ��201�����أ���ȡddr2������51�������16bit����Ӧ����204����Ҫ����3��*/
reg data_dirty = 1'd0;                                /////*Ҳ�����������������ݣ�ָʾ��ǰ�����ǲ��Ƕ����*/
reg data_dirty_flag = 1'd0;                           /////*Ҳ�����������������ݣ�ָʾÿ�л᲻���ж�������*/
reg frame_flag = 1'b0;                                /////*ÿһ֡��������һ֡��ʼ���ź� ���ж�VS����ͬ�����������ػ��½��ز���������ź�����������λ״̬����FIFO���Ѿ���ȡ��ַ�ı䶯*/
reg vout_vs_mem_clk_d0 = 1'b0;                    
reg vout_vs_mem_clk_d1 = 1'b0;                    
reg vout_vs_d0 = 1'b0;                            
reg vout_vs_d1 = 1'b0;                            
reg frame_flag_at_vout_clk = 1'b0;                
wire[7:0] wrusedw;                                
wire[8:0] fif0_8_16_wrusedw;                               
reg[11:0] wait_time = 12'd0;
//reg[21:0] wait_time = 22'd0;
reg data_fifo_full_d0;
assign mem_buf_rd_req = ~mem_buf_rdempty & ~data_fifo_full_d0;
wire[11:0] vout_width_rec_at_vout_clk;
assign vout_width_rec_at_vout_clk = {1'b0,byte_per_line_at_vout_clk,1'd0};
reg data_fifo_full;

reg mem_rd_buf_wren = 1'b0;

/////*��ddr2��ȡ���ݺ����һ��64bitд��16bit����fifo*/

`ifdef Xilinx
fifo_256_64i_16o vout_frame_buffer_ctrlfifo_256_64i_16o_m0(
	.rst(frame_flag),
	.wr_clk(mem_clk),
	.rd_clk(vout_clk),
	.din(rd_burst_data),
	.wr_en(rd_burst_data_valid && mem_rd_buf_wren),
	.rd_en(mem_buf_rd_req),
	.dout(mem_buf_q),
	.full(),
	.empty(mem_buf_rdempty),
	.rd_data_count(),
	.wr_data_count(wrusedw)
);
`else
fifo_256_64i_16o vout_frame_buffer_ctrlfifo_256_64i_16o_m0(
	.aclr(frame_flag),
	.data(rd_burst_data),
	.rdclk(vout_clk),
	.rdreq(mem_buf_rd_req),
	.wrclk(mem_clk),
	.wrreq(rd_burst_data_valid && mem_rd_buf_wren),
	.q(mem_buf_q),
	.rdempty(mem_buf_rdempty),
	.rdusedw(),
	.wrfull(),
	.wrusedw(wrusedw));
`endif
/////*����ж������ݲ���������������ȥ����д��fifo*/
lite_fifo#
(
	.COMMON_CLOCK(1),
	.ADDR_WIDTH(8),
	.DATA_WIDTH(16)
)  vout_frame_buffer_ctrl_fifo_256_16_m1(
	.aclr(frame_flag),
	.data(mem_buf_q),
	.rdclk(vout_clk),
	.rdreq(vout_rd_req),
	.wrclk(vout_clk),
	.wrreq(mem_buf_rd_req_d0 && ~data_dirty),
	.q(vout_data),
	.rdempty(fifo_rdempty),
	.rdusedw(),
	.wrfull(),
	.wrusedw(fif0_8_16_wrusedw)); 
	
always@(posedge vout_clk)
begin
	mem_buf_rd_req_d0 <= mem_buf_rd_req;
	data_fifo_full <= (fif0_8_16_wrusedw > 240);/////*fifo��������*/
	data_fifo_full_d0 <= data_fifo_full;
end
always@(posedge vout_clk)
begin
	vout_vs_d0 <= vout_vs;
	vout_vs_d1 <= vout_vs_d0;
	frame_flag_at_vout_clk <= vout_vs_d0 && ~vout_vs_d1;
end

///////����ÿ�������������ddr�ӿڵĳ���
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		byte_per_line <= 10'd0;
	else if(frame_flag)
		if(vout_width[1:0] == 2'd0)
			byte_per_line <= vout_width[11:2];
		else
			byte_per_line <= vout_width[11:2] + 10'd1;
	else
		byte_per_line <= byte_per_line;
end

///////����ÿ�������������ddr�ӿڵĳ���
always@(posedge vout_clk or negedge rst_n)
begin
	if(!rst_n)
		byte_per_line_at_vout_clk <= 10'd0;
	else if(frame_flag_at_vout_clk)
		if(vout_width[1:0] == 2'd0)//�жϿ���Ƿ��ܱ�4����
			byte_per_line_at_vout_clk <= vout_width[11:2];
		else
			byte_per_line_at_vout_clk <= vout_width[11:2] + 10'd1;
	else
		byte_per_line_at_vout_clk <= byte_per_line_at_vout_clk;
end
/////*�жϻ᲻���ж��������*/
always@(posedge vout_clk or negedge rst_n)
begin
	if(!rst_n)
		data_dirty <= 1'd0;
	else if(frame_flag_at_vout_clk || ~data_dirty_flag)
		data_dirty <= 1'd0;
	else if(mem_buf_rd_req_d0)
		if(rd_cnt == vout_width_rec_at_vout_clk - 12'd1)
			data_dirty <= 1'd0;
		else if(rd_cnt == vout_width - 12'd1)
			data_dirty <= 1'd1;
	else
		data_dirty <= data_dirty;
end
/////*ddr2��ȡ�׵�ַ���㣬��Ҫע�������Ƶ������������ȡ�ģ����ǰ��ա��С�Ϊ��Ԫ��ȡ*/
/*ͻ��д�׵�ַ�Ĳ���*/
//wire[23:0] ddr_rd_base;
wire[26:0] ddr_rd_base;
generate
	if(WITDH_2K)
		//assign ddr_rd_base = {base_addr,rd_frame_addr[1:0],burst_line[10:0],9'd0};//24bit ddr addr
		assign ddr_rd_base = {base_addr,rd_frame_addr[1:0],burst_line[10:0],9'd0,3'd0};//24bit ddr addr
	else
		//assign ddr_rd_base = {2'b00,base_addr,rd_frame_addr[1:0],burst_line[9:0],8'd0};
		assign ddr_rd_base = {2'b00,base_addr,rd_frame_addr[1:0],burst_line[9:0],8'd0,3'd0};
endgenerate
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		//rd_burst_addr <= 24'd0;
		rd_burst_addr <= 27'd0;
	else if(burst_state_next == BURST_ONE_LINE_START)
		rd_burst_addr <= ddr_rd_base;
	else if(burst_state_next == BURST_END && burst_state != BURST_END)
		//rd_burst_addr <= rd_burst_addr + {16'd0,BURST_LEN[8:0]};
		rd_burst_addr <= rd_burst_addr + {15'd0,BURST_LEN[8:0],3'd0};
	else
		rd_burst_addr <= rd_burst_addr;
end	




///*�жϻ᲻���ж��������*/
always@(posedge vout_clk)
begin
	data_dirty_flag <= (vout_width[0] != 1'd0);
end
///*�����Ѿ���ȡ���������ԡ��С�Ϊ��Ԫ��ÿ�ж����¿�ʼ*/
always@(posedge vout_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_cnt <= 12'd0;
	else if(frame_flag_at_vout_clk)///////////////////////////////////
		rd_cnt <= 12'd0;
	else if(mem_buf_rd_req_d0)
		if(rd_cnt == vout_width_rec_at_vout_clk - 12'd1)
			rd_cnt <= 12'd0;
		else
			rd_cnt <= rd_cnt + 12'd1;
	else
		rd_cnt <= rd_cnt;
end


/////////////////////////////////////////////////////

always@(posedge mem_clk)
begin
	vout_vs_mem_clk_d0 <= vout_vs;
	vout_vs_mem_clk_d1 <= vout_vs_mem_clk_d0;
	frame_flag <= vout_vs_mem_clk_d0 && ~vout_vs_mem_clk_d1;
end
always@(posedge mem_clk or posedge frame_flag)
begin
	if(frame_flag)
		mem_rd_buf_wren <= 1'b0;
	else if(burst_state == BURST_IDLE)
		mem_rd_buf_wren <= 1'b1;
	else
		mem_rd_buf_wren <= mem_rd_buf_wren;
end
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_state <= BURST_IDLE;
	else if(frame_flag)
		burst_state <= WAIT;
	else
		burst_state <= burst_state_next;
end
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		wait_time <= 12'd0;
		//wait_time <= 22'd0;
	else if(frame_flag)
		wait_time <= 12'd0;
		//wait_time <= 22'd0;
	else if(burst_state == WAIT)
		wait_time <= wait_time + 12'd1;
		//wait_time <= wait_time + 22'd1;
	else
		wait_time <= 12'd0;
		//wait_time <= 22'd0;
end


always@(*)
begin
	case(burst_state)
		WAIT: ///*ÿ֡���ݴ���ǰ�ȴ�һ��ʱ��*/
			if(wait_time > 12'd2000)
				burst_state_next <= BURST_IDLE;
			else
				burst_state_next <= WAIT;
		BURST_IDLE:///*���fifo�ռ乻д��һ��ͻȻ�����ݣ������һ�����ݵĵ�һ��ͻ��*/
			if(wrusedw < 8'hff - BURST_LEN[7:0])///*�ж�fifo�ռ�*/
				burst_state_next <= BURST_ONE_LINE_START;
			else
				burst_state_next <= BURST_IDLE;
		BURST_ONE_LINE_START:
			burst_state_next <= BURSTING;
		BURSTING:///*���һ��ͻ��������*/
			if(burst_finish)
				burst_state_next <= BURST_END;
			else
				burst_state_next <= BURSTING;
		BURST_END:
			if(remain_len == 10'd0)///*�ж�һ�������Ƿ���꣬û�ж�����ȴ�fifo������´ζ�*/
				burst_state_next <= BURST_ONE_LINE_END;
			else if(wrusedw < 8'hff - BURST_LEN[7:0])///*�ж�fifo�ռ�*/
				burst_state_next <= BURSTING;
			else
				burst_state_next <= BURST_END;
		BURST_ONE_LINE_END:///*���һ�����ݵĶ�ȡ*/
				burst_state_next <= BURST_IDLE;
		default:
			burst_state_next <= BURST_IDLE;
	endcase
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		burst_line <= 12'd0;
	else if(frame_flag)
		burst_line <= 12'd0;
	else if(burst_state_next == BURST_ONE_LINE_END && burst_state == BURST_END)
		burst_line <= burst_line + 12'd1;///*ÿ�����һ�����ݵĶ�ȡburst_line��1*/
	else
		burst_line <= burst_line;
end

//always@(posedge mem_clk or negedge rst_n)
//begin
//	if(!rst_n)
//		rd_frame_addr <= 2'd0;
//	else if(frame_flag)
//		rd_frame_addr <= wr_frame_addr - 2'd2;///*����ַ����д��ַ*/ // ry, wr_frame_addr = frame_addr
//	else
//		rd_frame_addr <= rd_frame_addr;
//end	
//2016.12.30 zclin
reg [1:0] rd_frame_addr_d0;
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_frame_addr_d0 <= 0;
	else if(s_wr_done)
		rd_frame_addr_d0 <= wr_frame_addr;
	else
		rd_frame_addr_d0 <= rd_frame_addr_d0;
end
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_frame_addr <= 0;
	else if(frame_flag)
		rd_frame_addr <= rd_frame_addr_d0;
	else
		rd_frame_addr <= rd_frame_addr;
end
///*����ÿ��ʣ������*/
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

///*����ͻ����ȡ�ĳ���*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_burst_len <= 10'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		if(remain_len > BURST_LEN)
			rd_burst_len <= BURST_LEN;
		else
			rd_burst_len <= remain_len;
	else
		rd_burst_len <=  rd_burst_len;
end

///*�������źŵķ����볷��*/
always@(posedge mem_clk or negedge rst_n)
begin
	if(!rst_n)
		rd_burst_req <= 1'd0;
	else if(burst_state_next == BURSTING && burst_state != BURSTING)
		rd_burst_req <= 1'b1;
	else if(burst_finish || burst_state == BURST_IDLE || rd_burst_data_valid )
		rd_burst_req <= 1'b0;
	else
		rd_burst_req <= rd_burst_req; 
end

endmodule 