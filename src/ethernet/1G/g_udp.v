//////////////////////////////////////////////////////////////////////////////////
// Module Name:    udp
//////////////////////////////////////////////////////////////////////////////////

module g_udp(
			input wire           reset_n,
			
			input	 wire           e_rxc,
			input  wire	[7:0]	    e_rxd, 
			input	 wire           e_rxdv,	
			output wire 	       data_o_valid,                        //����������Ч�ź�// 
			output wire [31:0]    ram_wr_data,                         //���յ���32bit IP������//  
			output wire [15:0]    rx_total_length,                     //����IP�����ܳ���
			output wire [15:0]    mydata_num,                          //for chipscope test
			output wire [3:0]     rx_state,                            //for chipscope test
			output wire [15:0]    rx_data_length,		                 //����IP�������ݳ���/
		   output wire [8:0]     ram_wr_addr,
		
			output wire	          e_txen,
			output wire	[7:0]     e_txd,                              
			output wire		       e_txer,
			input  wire [31:0]    ram_rd_data,
		   output      [3:0]     tx_state,
			output      [31:0]    datain_reg,                          //for chipscope test
			input  wire [15:0]    tx_data_length,                      //����IP�������ݳ���/
			input  wire [15:0]    tx_total_length,                     //����IP�����ܳ���/
		   output wire [8:0]     ram_rd_addr,
			output wire           data_receive
);


wire	[31:0] crcnext;
wire	[31:0] crc32;
wire	crcreset;
wire	crcen;


//IP frame����
g_ipsend g_ipsend_inst(
	.clk(e_rxc),
	.txen(e_txen),
	.txer(e_txer),
	.dataout(e_txd),	
	.reset_n(reset_n),
	.crc(crc32),
	.datain(ram_rd_data),
	.crcen(crcen),
	.crcre(crcreset),
	.crc_valid(crc_valid),
	.tx_state(tx_state),
	.datain_reg(datain_reg),
	.tx_data_length(tx_data_length),
	.tx_total_length(tx_total_length),
	.ram_rd_addr(ram_rd_addr)
	);
	
//crc32У��
g_crc	g_crc_inst(
	.Clk(e_rxc),
	.Reset(crcreset),
	.Enable(crcen),
	.Data_in(e_txd),
	.Crc(crc32),
	.CrcNext(crcnext));

//IP frame���ճ���
g_iprecieve g_iprecieve_inst(
	.clk(e_rxc),
	.datain(e_rxd),
	.e_rxdv(e_rxdv),	
	.clr(reset_n),
	.board_mac(),	
	.pc_mac(),
	.IP_Prtcl(),
	.IP_layer(),
	.pc_IP(),	
	.board_IP(),
	.UDP_layer(),
	.mydata_num(mydata_num),
	.data_o(ram_wr_data),	
	.valid_ip_P(),
	.rx_total_length(rx_total_length),
	.data_o_valid(data_o_valid),                                       
	.rx_state(rx_state),
	.rx_data_length(rx_data_length),
	.ram_wr_addr(ram_wr_addr),
	.data_receive(data_receive)	
	
	
	);
	
endmodule
