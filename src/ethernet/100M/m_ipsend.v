`timescale 1ns / 1ps
module m_ipsend(
				  input              clk,
				  output reg         txen,
				  output reg         txer,
				  output reg [3:0]   dataout,

				  input      [31:0]  crc,	
				  input      [31:28] crcnext,				  
				  input      [31:0]  datain,
				  output reg         crcen,
				  output reg         crcre,
				  output reg         crc_valid,
				  output reg [3:0]   tx_state,
				  input      [15:0]  tx_total_length,	 				  
				  input      [15:0]  tx_data_length, 
				  output reg [8:0]   ram_rd_addr,
				  
				  output reg  [15:0]  tx_data_counter


  );
	 

reg [31:0] ip_header [6:0];                       //���ݶ�Ϊ1K
reg [3:0] preamble [43:0];
	 
reg [31:0] check_buffer;
reg [31:0] time_counter;

reg [7:0] i,j;

parameter idle=3'b000,start=3'b001,make=3'b010,sendmac=3'b011,sendheader=3'b100,senddata=3'b101,sendcrc=3'b110;
	 
initial
  begin
	 preamble[0]<=4'h5;               //7��ǰ����55,һ��֡��ʼ��d5
	 preamble[1]<=4'h5;
	 preamble[2]<=4'h5;
	 preamble[3]<=4'h5;
	 preamble[4]<=4'h5;
	 preamble[5]<=4'h5;
	 preamble[6]<=4'h5;
	 preamble[7]<=4'h5;
	 preamble[8]<=4'h5;
	 preamble[9]<=4'h5;
	 preamble[10]<=4'h5;
	 preamble[11]<=4'h5;
	 preamble[12]<=4'h5;
	 preamble[13]<=4'h5;
	 preamble[14]<=4'h5;
	 preamble[15]<=4'hd;
	 preamble[16]<=4'hf;               //Ŀ��MAC��ַ ff-ff-ff-ff-ff-ff �㲥��
    preamble[17]<=4'hf;
    preamble[18]<=4'hf;
    preamble[19]<=4'hf;
    preamble[20]<=4'hf;
    preamble[21]<=4'hf;
    preamble[22]<=4'hf;
    preamble[23]<=4'hf;
    preamble[24]<=4'hf;
    preamble[25]<=4'hf;
    preamble[26]<=4'hf;
    preamble[27]<=4'hf;
	 preamble[28]<=4'h0;               //ԴMAC��ַ000a3501fec0
	 preamble[29]<=4'h0;
	 preamble[30]<=4'ha;
	 preamble[31]<=4'h0;
	 preamble[32]<=4'h5;
	 preamble[33]<=4'h3;
	 preamble[34]<=4'h1;
	 preamble[35]<=4'h0;
	 preamble[36]<=4'he;
	 preamble[37]<=4'hf;
	 preamble[38]<=4'h0;
	 preamble[39]<=4'hc;
	 preamble[40]<=4'h8;               //���ݶγ���033c,����0800��ip��
	 preamble[41]<=4'h0;
	 preamble[42]<=4'h0;
	 preamble[43]<=4'h0;
 end
	 
always@(posedge clk)
begin
		case(tx_state)
		  idle:begin
			    crc_valid<=0;
			    check_buffer<=0;
			    i<=0;
				 j<=0;
				 txer<=0;
				 txen<=0;
				 crcen<=0;
				 crcre<=1;				 
				 ram_rd_addr<=1;
				 tx_data_counter<=0;
             if (time_counter==32'h02000000) begin          //�ȴ��ӳ�
				     tx_state<=start;  
                 time_counter<=0;
             end
             else
                 time_counter<=time_counter+1'b1;	
		  end
		  start:begin
					ip_header[0]<={16'h4500,tx_total_length};              //�汾�ţ�4�� ��ͷ���ȣ�20��IP���ܳ�
				   ip_header[1][31:16]<=ip_header[1][31:16]+1;            //�����к�
					ip_header[1][15:0]<=16'h4000;                          //Fragment offset
				   ip_header[2]<=32'h80110000;                            //ip_header[2][15:0] Э�飺17(UDP)
				   ip_header[3]<=32'hc0a80002;                            //192.168.0.2Դ��ַ
				   ip_header[4]<=32'hc0a80003;                            //192.168.0.3Ŀ�ĵ�ַ�㲥��ַ
					ip_header[5]<=32'h1f901f90;                            //2���ֽڵ�Դ�˿ںź�2���ֽڵ�Ŀ�Ķ˿ں�8080
				   ip_header[6]<={tx_data_length,16'h0000};               //2���ֽڵ����ݳ���(24byte����)��2���ֽڵ�У��ͣ��ޣ�
				   i<=0;
					tx_state<=make;
              end	
         make:begin                               //���ɰ�ͷ��У���
			    if(i==0) begin
					  check_buffer<=ip_header[0][15:0]+ip_header[0][31:16]+ip_header[1][15:0]+ip_header[1][31:16]+ip_header[2][15:0]+
					                ip_header[2][31:16]+ip_header[3][15:0]+ip_header[3][31:16]+ip_header[4][15:0]+ip_header[4][31:16];
                 i<=i+1;
				 end
             else if(i==1) begin
					   check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
					   i<=i+1;
				 end
			    else	begin
				      ip_header[2][15:0]<=~check_buffer[15:0];
				 	   i<=0;
					   tx_state<=sendmac;
					end
				end
			sendmac: begin                     //����Premble,Mac address
			    txen<=1;
			    if(i==43) begin
                dataout[3:0]<=preamble[i][3:0];
				    tx_state<=sendheader;
					 i<=0;
				 end
				 else if(i<=15)  begin
				    crcre<=1;                         //reset crc 
				    dataout[3:0]<=preamble[i][3:0];
				    i<=i+1;
				 end
				 else begin
				    crcen<=1;                        //crcУ��ʹ��	
				    crcre<=0;
				    dataout[3:0]<=preamble[i][3:0];
				    i<=i+1;
				   end
			end
			sendheader:begin                                 //����7��32bit��IP ��ͷ
			     if(j==6) begin
                   if(i==0) begin
					        dataout[3:0]<=ip_header[j][27:24];
					        i<=i+1;
					    end
					    else if(i==1) begin
					        dataout[3:0]<=ip_header[j][31:28];
					        i<=i+1;
					    end
					    else if(i==2) begin
					        dataout[3:0]<=ip_header[j][19:16];
  				           i<=i+1;
					 	 end
					    else if(i==3) begin
					        dataout[3:0]<=ip_header[j][23:20];
					        i<=i+1;
					    end
						 else if(i==4) begin
					        dataout[3:0]<=ip_header[j][11:8];
					        i<=i+1;
					    end
						 else if(i==5) begin
					        dataout[3:0]<=ip_header[j][15:12];
					        i<=i+1;
					    end
						 else if(i==6) begin
					        dataout[3:0]<=ip_header[j][3:0];
					        i<=i+1;					
					    end
						 else if(i==7) begin
					        dataout[3:0]<=ip_header[j][7:4];
							  tx_state<=senddata;
                       i<=0;
							  j<=0;
					    end
					    else
							txer<=1;
					end
					else begin
					    if(i==0) begin
					        dataout[3:0]<=ip_header[j][27:24];
					        i<=i+1;
					    end
					    else	if(i==1) begin
					        dataout[3:0]<=ip_header[j][31:28];
					        i<=i+1;
					    end
					    else if(i==2) begin
					        dataout[3:0]<=ip_header[j][19:16];
					        i<=i+1;
						 end
					    else if(i==3) begin
					        dataout[3:0]<=ip_header[j][23:20];
					        i<=i+1;
					    end
						 else if(i==4) begin
					        dataout[3:0]<=ip_header[j][11:8];
					        i<=i+1;
					    end
						 else if(i==5) begin
					        dataout[3:0]<=ip_header[j][15:12];
					        i<=i+1;
					    end
						 else if(i==6) begin
					        dataout[3:0]<=ip_header[j][3:0];
					        i<=i+1;
					    end
						 else if(i==7) begin
					        dataout[3:0]<=ip_header[j][7:4];
					        i<=0;
							  j<=j+1;
					    end
					    else
							txer<=1;
					end
			 end
			 senddata:begin                                //��������
			 		 if(tx_data_counter==tx_data_length-9) begin       //������������	 
                  if(i==0) begin
					         dataout[3:0]<=datain[27:24];
					         i<=i+1;
					    end
					    else if(i==1) begin
					         dataout[3:0]<=datain[31:28];
					         i<=0;
								tx_state<=sendcrc;	
					    end
					    else if(i==2) begin
					         dataout[3:0]<=datain[19:16];
					         i<=i+1;
					    end
					    else if(i==3) begin
                        dataout[3:0]<=datain[23:20];
	                     i<=0;
								tx_state<=sendcrc;
	                end
						 else if(i==4) begin
                        dataout[3:0]<=datain[11:8];
	                     i<=i+1;					
					    end
						 else if(i==5) begin
								dataout[3:0]<=datain[15:12];
	                     i<=0;
								tx_state<=sendcrc;
	   			    end
						 else if(i==6) begin
	                     dataout[3:0]<=datain[3:0];
	                     i<=i+1;                    
	  			       end
  					    else if(i==7) begin
	                    dataout[3:0]<=datain[7:4];
	                    i<=0;
							  tx_state<=sendcrc;
						 end
					    else
						    txer<=1;
				    end
			 		 else begin       //���ͷ������������ݰ�
                   if(i==0) begin
					         dataout[3:0]<=datain[27:24];
					         i<=i+1;
					    end
					    else if(i==1) begin
					         dataout[3:0]<=datain[31:28];
					         i<=i+1;
								tx_data_counter<=tx_data_counter+1'b1;	
					    end
					    else if(i==2) begin
					         dataout[3:0]<=datain[19:16];
					         i<=i+1;
					    end
					    else if(i==3) begin
                        dataout[3:0]<=datain[23:20];
					         i<=i+1;
								tx_data_counter<=tx_data_counter+1'b1;									
	                end
						 else if(i==4) begin
                        dataout[3:0]<=datain[11:8];
	                     i<=i+1;					
					    end
						 else if(i==5) begin
								dataout[3:0]<=datain[15:12];
					         i<=i+1;
								tx_data_counter<=tx_data_counter+1'b1;	
	   			    end
						 else if(i==6) begin
	                     dataout[3:0]<=datain[3:0];
	                     i<=i+1;                    
	  			       end
  					    else if(i==7) begin
	                    dataout[3:0]<=datain[7:4];
					        i<=0;
							  tx_data_counter<=tx_data_counter+1'b1;	
                       ram_rd_addr<=ram_rd_addr+1'b1;		                        //ram addresss add 1						  
						 end
					    else
						    txer<=1;
				    end
         end					 
			sendcrc:begin                           //����CRC32					
					crcen<=0;
					crc_valid<=1;
					if(i==0)  begin
					     dataout[3:0] <= {~crcnext[28], ~crcnext[29], ~crcnext[30], ~crcnext[31]};
					     i<=i+1;
					end
					else if(i==1) begin
					     dataout[3:0]<={~crc[24], ~crc[25], ~crc[26], ~crc[27]};
					     i<=i+1;
					end
					else if(i==2) begin
					     dataout[3:0]<={~crc[20], ~crc[21], ~crc[22], ~crc[23]};
					     i<=i+1;
					end
					else if(i==3) begin
					     dataout[3:0]<={~crc[16], ~crc[17], ~crc[18], ~crc[19]};
					     i<=i+1;
					end
					else if(i==4) begin
					     dataout[3:0]<={~crc[12], ~crc[13], ~crc[14], ~crc[15]};
					     i<=i+1;
					end
					else if(i==5) begin
					     dataout[3:0]<={~crc[8], ~crc[9], ~crc[10], ~crc[11]};
					     i<=i+1;
					end
					else if(i==6) begin
					     dataout[3:0]<={~crc[4], ~crc[5], ~crc[6], ~crc[7]};
					     i<=i+1;
					end
					else if(i==7) begin
				        dataout[3:0]<={~crc[0], ~crc[1], ~crc[2], ~crc[3]};
					     i<=i+1;
					end
					else  begin
							txen<=0;
							tx_state<=idle;
							crc_valid<=0;
					end
			end		
			default:tx_state<=idle;		
       endcase		  
	end
	
endmodule
