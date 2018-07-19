`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    ethernet_test
//////////////////////////////////////////////////////////////////////////////////
module ethernet_test(
					input reset_n,                           
					input  fpga_gclk,   
					
					output e_reset,
               output e_mdc,
					inout  e_mdio,
					
					input	 e_rxc,                       //125Mhz ethernet gmii rx clock
					input	 e_rxdv,	
					input	 e_rxer,						
					input  [7:0] e_rxd,        

					input	 e_txc,                     //25Mhz ethernet mii tx clock         
					output e_gtxc,                    //25Mhz ethernet gmii tx clock  
					output e_txen, 
					output e_txer, 					
					output [7:0] e_txd	 
  
    );

wire gmii_or_mii;
wire phy_rst_n;

wire g_e_txen;
wire m_e_txen;
wire [7:0] g_e_txd;       
wire [3:0] m_e_txd;  

wire g_e_txer;
wire m_e_txer;         

wire [31:0] ram_wr_data;
wire [31:0] g_ram_wr_data;
wire [31:0] m_ram_wr_data;

wire [31:0] ram_rd_data;

wire [8:0] ram_wr_addr;
wire [8:0] g_ram_wr_addr;
wire [8:0] m_ram_wr_addr;


wire [8:0] ram_rd_addr;
wire [8:0] g_ram_rd_addr;
wire [8:0] m_ram_rd_addr;

wire [15:0] phy_reg;
wire phy_init;

assign e_reset=1'b1;
assign e_gtxc=gmii_or_mii?e_rxc:1'b0;	 

assign e_txen= gmii_or_mii?g_e_txen:m_e_txen;
assign e_txd[3:0]= gmii_or_mii?g_e_txd[3:0]:m_e_txd;
assign e_txd[7:4]= gmii_or_mii?g_e_txd[7:4]:4'b0000;
assign e_txer= gmii_or_mii?g_e_txer:m_e_txer;


wire [31:0] datain_reg;
         
wire [3:0] g_tx_state;
wire [3:0] m_tx_state;

wire [3:0] rx_state;

wire [15:0] rx_total_length;          //rx 的IP包的长度
wire [15:0] g_rx_total_length;          //rx 的IP包的长度
wire [15:0] m_rx_total_length;          //rx 的IP包的长度

wire [15:0] tx_total_length;          //tx 的IP包的长度

wire [15:0] rx_data_length;           //rx 的UDP的数据包长度
wire [15:0] g_rx_data_length;           //rx 的UDP的数据包长度
wire [15:0] m_rx_data_length;           //rx 的UDP的数据包长度

wire [15:0] tx_data_length;           //rx 的UDP的数据包长度

wire data_receive;
wire g_data_receive;
wire m_data_receive;

reg ram_wr_finish;

reg [31:0] udp_data [4:0];                        //存储发送字符
reg ram_wren_i;
reg [8:0] ram_addr_i;
reg [31:0] ram_data_i;
reg [4:0] i;

wire [3:0] m_rx_state;

wire data_o_valid,m_data_o_valid,g_data_o_valid;



assign gmii_or_mii= phy_reg[15]& (~phy_reg[14]);           //1: gmii, 0:mii
assign data_o_valid= gmii_or_mii?g_data_o_valid:m_data_o_valid;
assign ram_wr_data= gmii_or_mii?g_ram_wr_data:m_ram_wr_data;
assign rx_total_length= gmii_or_mii?g_rx_total_length:m_rx_total_length;
assign rx_data_length= gmii_or_mii?g_rx_data_length:m_rx_data_length;
assign ram_wr_addr= gmii_or_mii?g_ram_wr_addr:m_ram_wr_addr;
assign data_receive= gmii_or_mii?g_data_receive:m_data_receive;
assign ram_rd_addr= gmii_or_mii?g_ram_rd_addr:m_ram_rd_addr;


wire wea;
wire [8:0] addra;
wire [31:0] dina;

assign wea=ram_wr_finish?data_o_valid:ram_wren_i;
assign addra=ram_wr_finish?ram_wr_addr:ram_addr_i;
assign dina=ram_wr_finish?ram_wr_data:ram_data_i;


assign tx_data_length=data_receive?rx_data_length:16'd28;
assign tx_total_length=data_receive?rx_total_length:16'd48;



////////udp发送和接收程序/////////////////// 
g_udp g_udp_inst(
	.reset_n(phy_init),
	.e_rxc(e_rxc),
	.e_rxd(e_rxd),
   .e_rxdv(e_rxdv),
	.data_o_valid(g_data_o_valid),                    //数据接收有效信号,写入RAM/
	.ram_wr_data(g_ram_wr_data),                      //接收到的32bit数据写入RAM/	
	.rx_total_length(g_rx_total_length),              //接收IP包的总长度/
	.mydata_num(),                        //for chipscope test
	.rx_state(g_rx_state),                            //for chipscope test
	.rx_data_length(g_rx_data_length),                //接收IP包的数据长度/	
	.ram_wr_addr(g_ram_wr_addr),
	.data_receive(g_data_receive),
	
	.e_txen(g_e_txen),
	.e_txd(g_e_txd),
	.e_txer(g_e_txer),	
	.ram_rd_data(ram_rd_data),                      //RAM读出的32bit数据/
	.tx_state(g_tx_state),                            //for chipscope test
	.datain_reg(datain_reg),                        //for chipscope test
	.tx_data_length(tx_data_length),                //发送IP包的数据长度/	
	.tx_total_length(tx_total_length),              //接发送IP包的总长度/
	.ram_rd_addr(g_ram_rd_addr)

	);

////////udp发送和接收程序/////////////////// 
m_udp m_udp_inst(
	.reset_n(phy_init),
	.e_rxc(e_rxc),
	.e_rxd(e_rxd[3:0]),
   .e_rxdv(e_rxdv),
	.data_o_valid(m_data_o_valid),                    //数据接收有效信号,写入RAM/
	.ram_wr_data(m_ram_wr_data),                      //接收到的32bit数据写入RAM/	
	.rx_total_length(m_rx_total_length),              //接收IP包的总长度/
	.mydata_num(),                                    //for chipscope test
	.rx_state(m_rx_state),                              //for chipscope test
	.rx_data_length(m_rx_data_length),                  //接收IP包的数据长度/	
	.ram_wr_addr(m_ram_wr_addr), 
	.data_receive(m_data_receive),

	.e_txc(e_txc),	
	.e_txen(m_e_txen),
	.e_txd(m_e_txd),
	.e_txer(m_e_txer),	
	.ram_rd_data(ram_rd_data),                      //RAM读出的32bit数据/
	.tx_state(m_tx_state),                            //for chipscope test
	.tx_data_length(tx_data_length),                //发送IP包的数据长度/	
	.tx_total_length(tx_total_length),              //接发送IP包的总长度/
	.ram_rd_addr(m_ram_rd_addr),
	.tx_data_counter()	
	

	);


phy_reg_config phy_reg_config_inst( 
 	 .clock_50m(fpga_gclk),
 	 .reset_n(reset_n),
	 .phy_mdc(e_mdc),
	 .phy_mdio(e_mdio),
	 .phy_reg(phy_reg),
	 .phy_rst_n(phy_rst_n),
	 .phy_init(phy_init)
					);	

		
	
//////////ram用于存储以太网接收到的数据或测试数据///////////////////
/*
ram ram_inst (
  .clka(e_rxc),           // input clka
  .wea(wea),     // input [0 : 0] wea
  .addra(addra),    // input [8 : 0] addra
  .dina(dina),     // input [31 : 0] dina
  .clkb(e_rxc),           // input clkb
  .addrb(ram_rd_addr),    // input [8 : 0] addrb
  .doutb(ram_rd_data)     // output [31 : 0] doutb
);
*/
dp_ram#(.DATA_WIDTH(32),.MEM_SIZE(512)) ram_inst
(
	.data(dina),
	.rdaddress(ram_rd_addr),
	.rdclock(e_rxc),
	.wraddress(addra),
	.wrclock(e_rxc),
	.wren(wea),
	.q(ram_rd_data)
);

/********************************************/
//存储待发送的字符
/********************************************/
always @(*)
begin     //定义发送的字符
	 udp_data[0]<={8'd72,8'd69,8'd76,8'd76};   //存储字符HELL 
	 udp_data[1]<={8'd79,8'd32,8'd65,8'd76};   //存储字符O空格AL 
    udp_data[2]<={8'd73,8'd78,8'd88,8'd32};   //存储字符INX空格
	 udp_data[3]<={8'd65,8'd88,8'd53,8'd49};   //存储字符AX51 	 
	 udp_data[4]<={8'd54,8'd32,8'd10,8'd13};   //存储字符6空格换行符回车符                            

end 


//////////写入默认发送的数据//////////////////
always@(negedge e_rxc)
begin	
  if(reset_n==1'b0) begin
     ram_wr_finish<=1'b0;
	  ram_addr_i<=0;
	  ram_data_i<=0;
	  i<=0;
  end
  else begin
     if(i==5) begin
        ram_wr_finish<=1'b1;
        ram_wren_i<=1'b0;		  
     end
     else begin
        ram_wren_i<=1'b1;
		  ram_addr_i<=ram_addr_i+1'b1;
		  ram_data_i<=udp_data[i];
		  i<=i+1'b1;
	  end
  end 
end  	  
      

endmodule
