`timescale 1ns / 1ps
module ipsend(
				  input              clk,
				  output reg         txen,
				  output reg         txer,
				  output reg [7:0]   dataout,
				  input              clr,  				  
				  input      [31:0]  crc,
				  input      [31:0]  datain,
				  output reg         crcen,
				  output reg         crcre,
				  output reg         crc_valid,
				  output reg [3:0]   tx_state,
				  output reg [31:0]  datain_reg,
				  input      [15:0]  tx_data_length,
				  input      [15:0]  tx_total_length,
				  output reg [8:0]   ram_rd_addr
				  
	  );


	  
reg [31:0] ip_header [6:0];                  //���ݶ�Ϊ1K

reg [7:0] preamble [7:0];                    //preamble
reg [7:0] mac_addr [13:0];                   //mac address
reg [4:0] i,j;

reg [31:0] check_buffer;
reg [31:0] time_counter;
reg [15:0] tx_data_counter;

parameter idle=4'b0000,start=4'b0001,make=4'b0010,send55=4'b0011,sendmac=4'b0100,sendheader=4'b0101,
          senddata=4'b0110,sendcrc=4'b0111;



initial
  begin
	 // tx_state<=idle;
	 //����IP ��ͷ
	 preamble[0]<=8'h55;                 //7��ǰ����55,һ��֡��ʼ��d5
	 preamble[1]<=8'h55;
	 preamble[2]<=8'h55;
	 preamble[3]<=8'h55;
	 preamble[4]<=8'h55;
	 preamble[5]<=8'h55;
	 preamble[6]<=8'h55;
	 preamble[7]<=8'hD5;
	 mac_addr[0]<=8'h28;                 //Ŀ��MAC��ַ 28-D2-44-DC-6E-FE
	 mac_addr[1]<=8'hD2;
	 mac_addr[2]<=8'h44;
	 mac_addr[3]<=8'hDC;
	 mac_addr[4]<=8'h6E;
	 mac_addr[5]<=8'hFE;
	 mac_addr[6]<=8'h00;                 //ԴMAC��ַ 00-0A-35-01-FE-C0
	 mac_addr[7]<=8'h0A;
	 mac_addr[8]<=8'h35;
	 mac_addr[9]<=8'h01;
	 mac_addr[10]<=8'hFE;
	 mac_addr[11]<=8'hC0;
	 mac_addr[12]<=8'h08;                //0800: IP������
	 mac_addr[13]<=8'h00;
	 i<=0;
 end


	 
always@(negedge clk)
begin		
		case(tx_state)
		  idle:begin
			    crc_valid<=1'b0;
				 txer<=1'b0;
				 txen<=1'b0;
				 crcen<=1'b0;
				 crcre<=1;
				 j<=0;
				 ram_rd_addr<=1;
				 tx_data_counter<=0;
             if (time_counter==32'h0fffffff) begin          //�ȴ��ӳ�
				     tx_state<=start;  
                 time_counter<=0;
             end
             else
                 time_counter<=time_counter+1'b1;				
			end
		   start:begin
					ip_header[0]<={16'h4500,tx_total_length};        //�汾�ţ�4�� ��ͷ���ȣ�20��IP���ܳ�
				   ip_header[1][31:16]<=ip_header[1][31:16]+1'b1;   //�����к�
					ip_header[1][15:0]<=16'h4000;                    //Fragment offset
				   ip_header[2]<=32'h80110000;                      //mema[2][15:0] Э�飺17(UDP)
				   ip_header[3]<=32'hc0a80002;                      //192.168.0.2Դ��ַ
				   ip_header[4]<=32'hc0a80003;                      //192.168.0.3Ŀ�ĵ�ַ�㲥��ַ
					ip_header[5]<=32'h80008000;                      //2���ֽڵ�Դ�˿ںź�2���ֽڵ�Ŀ�Ķ˿ں�
				   ip_header[6]<={tx_data_length,16'h0000};         //2���ֽڵ����ݳ��Ⱥ�2���ֽڵ�У��ͣ��ޣ�
	   			tx_state<=make;
         end	
         make:begin            //���ɰ�ͷ��У���
			    if(i==0) begin
					  check_buffer<=ip_header[0][15:0]+ip_header[0][31:16]+ip_header[1][15:0]+ip_header[1][31:16]+ip_header[2][15:0]+
					               ip_header[2][31:16]+ip_header[3][15:0]+ip_header[3][31:16]+ip_header[4][15:0]+ip_header[4][31:16];
                 i<=i+1'b1;
				   end
             else if(i==1) begin
					   check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
					   i<=i+1'b1;
				 end
			    else	begin
				      ip_header[2][15:0]<=~check_buffer[15:0];                 //header checksum
					   i<=0;
					   tx_state<=send55;
					end
		   end
			send55: begin                    //����8��IPǰ����:7��55, 1��d5                    
 				 txen<=1'b1;
				 crcre<=1'b1;                            //reset crc  
				 if(i==7) begin
               dataout[7:0]<=preamble[i][7:0];
					i<=0;
				   tx_state<=sendmac;
				 end
				 else begin                        
				    dataout[7:0]<=preamble[i][7:0];
				    i<=i+1;
				 end
			end	
			sendmac: begin                           //����Ŀ��MAC address��ԴMAC address  
			 	 crcen<=1'b1;                            //crcУ��ʹ��		
				 crcre<=1'b0;                            			
             if(i==13) begin
               dataout[7:0]<=mac_addr[i][7:0];
					i<=0;
				   tx_state<=sendheader;
				 end
				 else begin                        
				    dataout[7:0]<=mac_addr[i][7:0];
				    i<=i+1'b1;
				 end
			end
			sendheader: begin                        //����7��32bit��IP ��ͷ
			   if(j==6) begin                             
					  if(i==0) begin
						 dataout[7:0]<=ip_header[j][31:24];
						 i<=i+1'b1;
					  end
					  else if(i==1) begin
						 dataout[7:0]<=ip_header[j][23:16];
						 i<=i+1'b1;
					  end
					  else if(i==2) begin
						 dataout[7:0]<=ip_header[j][15:8];
						 i<=i+1'b1;
					  end
					  else if(i==3) begin
						 dataout[7:0]<=ip_header[j][7:0];
						 i<=0;
						 j<=0;
						 tx_state<=senddata;			 
					  end
					  else
						 txer<=1'b1;
				end		 
				else begin
					  if(i==0) begin
						 dataout[7:0]<=ip_header[j][31:24];
						 i<=i+1'b1;
					  end
					  else if(i==1) begin
						 dataout[7:0]<=ip_header[j][23:16];
						 i<=i+1'b1;
					  end
					  else if(i==2) begin
						 dataout[7:0]<=ip_header[j][15:8];
						 i<=i+1'b1;
					  end
					  else if(i==3) begin
						 dataout[7:0]<=ip_header[j][7:0];
						 i<=0;
						 j<=j+1'b1;
					  end					
					  else
						 txer<=1'b1;
				end
			 end
			 senddata:begin                                      //����UDP���ݰ�
			   if(tx_data_counter==tx_data_length-9) begin       //������������
				   tx_state<=sendcrc;	
					if(i==0) begin    
					  dataout[7:0]<=datain[31:24];
					  i<=0;
					end
					else if(i==1) begin
					  dataout[7:0]<=datain[23:16];
					  i<=0;
					end
					else if(i==2) begin
					  dataout[7:0]<=datain[15:8];
					  i<=0;
					end
					else if(i==3) begin
			        dataout[7:0]<=datain[7:0];
					  i<=0;
					end
            end
            else begin                                     //�������������ݰ�
               tx_data_counter<=tx_data_counter+1'b1;			
					if(i==0) begin    
					  dataout[7:0]<=datain[31:24];
					  i<=i+1'b1;
					end
					else if(i==1) begin
					  dataout[7:0]<=datain[23:16];
					  i<=i+1'b1;
					end
					else if(i==2) begin
					  dataout[7:0]<=datain[15:8];
					  i<=i+1'b1;
					end
					else if(i==3) begin
			        dataout[7:0]<=datain[7:0];
					  i<=0; 
                 ram_rd_addr<=ram_rd_addr+1'b1;						  
					end
				end
			end	
			sendcrc: begin                              //����32λ��crcУ��
				crcen<=1'b0;
				crc_valid<=1'b1;
				if(i==0)	begin
					  dataout[7:0] <= {~crc[24], ~crc[25], ~crc[26], ~crc[27], ~crc[28], ~crc[29], ~crc[30], ~crc[31]};
					  i<=i+1'b1;
					end
				else begin
				  if(i==1) begin
					   dataout[7:0]<={~crc[16], ~crc[17], ~crc[18], ~crc[19], ~crc[20], ~crc[21], ~crc[22], ~crc[23]};
						i<=i+1'b1;
				  end
				  else if(i==2) begin
					   dataout[7:0]<={~crc[8], ~crc[9], ~crc[10], ~crc[11], ~crc[12], ~crc[13], ~crc[14], ~crc[15]};
						i<=i+1'b1;
				  end
				  else if(i==3) begin
					   dataout[7:0]<={~crc[0], ~crc[1], ~crc[2], ~crc[3], ~crc[4], ~crc[5], ~crc[6], ~crc[7]};
						i<=0;
						tx_state<=idle;
						crc_valid<=1'b0;
				  end
				  else begin
                  txer<=1'b1;
				  end
				end
			end					
			default:tx_state<=idle;		
       endcase	  
 end
endmodule


