`timescale 1ns / 1ps

module fff(clk,fifo_rd_en,fifo_r_data,prog_full,reseto);
 input fifo_rd_en;
 input clk;
// input key;
 output reseto;
 output [31:0] fifo_r_data;
 output prog_full;
 
 reg [3:0] count;
 reg reseto;
 
 reg fifo_wr_en;
 reg [31:0] fifo_w_data;
 
 initial 
 begin
 reseto<=0;
 fifo_w_data<=32'h00000000;
 fifo_wr_en<=1'b0;
 count<=4'd0;
 
end
always @(posedge clk )
begin
if(count<4'd10)
 count<=count+1'b1;
 else
 count<=count;
 end
//always @(posedge clk )
//begin
//if(count==4'd10)
//begin
// en<=1 ;
//  reseto<=1 ;
//  end
// else
//reseto <= 0;
//end
//end
//always @(posedge clk )
//begin
// if(rd)
//  cout<=cout+32'h00000001;
// else
//  cout<=cout+32'h00000000;
//end



//写fifo
always @(negedge clk )
begin
  if (full==1'b0)             //如果fifo不满的话
   begin
    fifo_wr_en<=1'b1;
	 fifo_w_data<=fifo_w_data+1'b1;
	end
  else
    fifo_wr_en<=1'b0;
end
	 
    



endmodule