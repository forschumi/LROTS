//////////////////////////////////////////////////////////////////////////////////
// Module Name:    udp
//////////////////////////////////////////////////////////////////////////////////

module m_udp(
				input  wire           reset_n,
				
				input  wire	          e_rxdv,
				input  wire	          e_rxc,
				input  wire	[3:0]     e_rxd,
			   output wire 	       data_o_valid,                        //����������Ч�ź�// 
			   output wire [31:0]    ram_wr_data,                         //���յ���32bit IP������//  
			   output wire [15:0]    rx_total_length,                     //����IP�����ܳ���
			   output wire [15:0]    mydata_num,                          //for chipscope test
			   output wire [3:0]     rx_state,                            //for chipscope test
			   output wire [15:0]    rx_data_length,		                 //����IP�������ݳ���/
		      output wire [8:0]     ram_wr_addr,
				
				input  wire	          e_txc,
				output wire	          e_txen,
				output wire	          e_txer,
				output wire [3:0]     e_txd,
			   input  wire [31:0]    ram_rd_data,
		      output      [3:0]     tx_state,
			   input  wire [15:0]    tx_data_length,                      //����IP�������ݳ���/
			   input  wire [15:0]    tx_total_length,                     //����IP�����ܳ���/
		      output wire [8:0]     ram_rd_addr,
			   output wire           data_receive,
				output wire [15:0]    tx_data_counter
);






wire	[31:0] crcnext;
wire	[31:0] crc32;
wire	crcreset;
wire	crcen;

	
//IP frame����
m_ipsend m_ipsend_inst(
	.clk(e_txc),
	.txen(e_txen),
	.txer(e_txer),
	.dataout(e_txd),	
	.crc(crc32),
	.crcnext(crcnext[31:28]),
	.datain(ram_rd_data),
	.crcen(crcen),
	.crcre(crcreset),
	.crc_valid(crc_valid),
	.tx_state(tx_state),

	.tx_data_length(tx_data_length),
	.tx_total_length(tx_total_length),
	.ram_rd_addr(ram_rd_addr),
	.tx_data_counter(tx_data_counter)
	);


m_crc	m_crc_inst4(
	.Clk(e_txc),
	.Reset(crcreset),
	.Enable(crcen),
	.Data(e_txd),
	.Crc(crc32),
	.CrcNext(crcnext));
	//defparam	b2v_inst4.Tp = 1;


//IP frame���ճ���
m_iprecieve m_iprecieve_inst(
	.clk(e_rxc),
	.datain(e_rxd),
	.rxdv(e_rxdv),	
	.board_mac(),	
	.pc_mac(),
	.IP_Prtcl(),
	.IP_layer(),
	.pc_IP(),	
	.board_IP(),
	.UDP_layer(),
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
