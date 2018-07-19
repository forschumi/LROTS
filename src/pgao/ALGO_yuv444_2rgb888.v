/*	
	R = 1.164(Y - 16) + 1.793(CR - 128) = 1.164Y + 1.793CR - 248.128;
	G = 1.164(Y - 16) - 0.534(CR - 128) - 0.213(CB - 128) = 1.164Y - 0.213CB - 0.534CR + 76.992;
	B = 1.164(Y - 16) + 2.115(CB - 128) = 1.164Y + 2.115CB - 289.344;
*/
`timescale 1ns/1ps
module	ALGO_yuv444_2rgb888_1(
	clk,
	i_y_8b,
	i_cb_8b,
	i_cr_8b,		
	i_hs,
	i_vs,
	i_data_en,
	o_r_8b,
	o_g_8b,
	o_b_8b,
	o_hs,
	o_vs,                                                                                                    
	o_data_en                                                                                                   
);

input clk;
input wire[7:0] i_y_8b;
input wire[7:0] i_cb_8b;
input wire[7:0] i_cr_8b;            				
input i_hs;
input i_vs;
input i_data_en;
(* keep = "true" *)output[7:0] o_r_8b;
(* keep = "true" *)output[7:0] o_g_8b;
(* keep = "true" *)output[7:0] o_b_8b;
output reg o_hs;
output reg o_vs;                                                                                                    
output reg o_data_en;  

parameter para_1164_10b = 10'd297;	//1.160
parameter para_1793_10b = 10'd459;	//1.793
parameter para_0534_10b = 10'd137;	//0.535
parameter para_0213_10b = 10'd54;		//0.211
parameter para_2115_10b = 10'd541;	//2.113
parameter para_248128_18b = 18'd63521;//248.128
parameter para_76992_18b = 18'd19710; //76.992
parameter para_289344_18b = 18'd74072;//289.344

wire sign_r;
wire sign_g;
wire sign_b;
reg[17:0] mult_y_for_r_18b;
reg[17:0] mult_y_for_g_18b;
reg[17:0] mult_y_for_b_18b;
reg[17:0] mult_cb_for_g_18b;
reg[17:0] mult_cb_for_b_18b;
reg[17:0] mult_cr_for_r_18b;
reg[17:0] mult_cr_for_g_18b;
reg[17:0] add_r_0_18b;
reg[17:0] add_g_0_18b;
reg[17:0] add_b_0_18b;
reg[17:0] add_r_1_18b;
reg[17:0] add_g_1_18b;
reg[17:0] add_b_1_18b;
reg[17:0] result_r_18b;
reg[17:0] result_g_18b;
reg[17:0] result_b_18b;
reg i_hs_delay_1;
reg i_vs_delay_1;
reg i_data_en_delay_1;
reg i_hs_delay_2;
reg i_vs_delay_2;
reg i_data_en_delay_2;

initial begin
	mult_y_for_r_18b <= 18'd0;
	mult_y_for_g_18b <= 18'd0;
	mult_y_for_b_18b <= 18'd0;
	mult_cb_for_g_18b <= 18'd0;
	mult_cb_for_b_18b <= 18'd0;
	mult_cr_for_r_18b <= 18'd0;
	mult_cr_for_g_18b <= 18'd0;

	add_r_0_18b <= 18'd0;
	add_g_0_18b <= 18'd0;
	add_b_0_18b <= 18'd0;
	add_r_1_18b <= 18'd0;
	add_g_1_18b <= 18'd0;
	add_b_1_18b <= 18'd0;
	
	result_r_18b <= 18'd0;
	result_g_18b <= 18'd0;
	result_b_18b <= 18'd0;
	
	i_hs_delay_1 <= 1'd0;
	i_vs_delay_1 <= 1'd0;
	i_data_en_delay_1 <= 1'd0;
	i_hs_delay_2 <= 1'd0;
	i_vs_delay_2 <= 1'd0;
	i_data_en_delay_2 <= 1'd0;

	o_hs <= 1'd0;
	o_vs <= 1'd0;                                                                                                  
	o_data_en <= 1'd0;                                             	
end 
//LV1 pipeline : mult
always @ (posedge clk) begin
	mult_y_for_r_18b <= i_y_8b * para_1164_10b;
	mult_y_for_g_18b <= i_y_8b * para_1164_10b;
	mult_y_for_b_18b <= i_y_8b * para_1164_10b;
end

always @ (posedge clk) begin
	mult_cb_for_g_18b <= i_cb_8b * para_0213_10b;
	mult_cb_for_b_18b <= i_cb_8b * para_2115_10b;
end

always @ (posedge clk) begin
	mult_cr_for_r_18b <= i_cr_8b * para_1793_10b;
	mult_cr_for_g_18b <= i_cr_8b * para_0534_10b;
end
//LV2 pipeline : add
always @ (posedge clk) begin
	add_r_0_18b <= mult_y_for_r_18b + mult_cr_for_r_18b;
	add_r_1_18b <= para_248128_18b;
	add_g_0_18b <= mult_y_for_g_18b + para_76992_18b;
	add_g_1_18b <= mult_cb_for_g_18b + mult_cr_for_g_18b;
	add_b_0_18b <= mult_y_for_b_18b + mult_cb_for_b_18b;
	add_b_1_18b <= para_289344_18b;
end
//LV3 pipeline : y + cb + cr
assign	sign_r = (add_r_0_18b >= add_r_1_18b);
assign	sign_g = (add_g_0_18b >= add_g_1_18b);
assign	sign_b = (add_b_0_18b >= add_b_1_18b);
always @ (posedge clk) begin
	result_r_18b = sign_r ? (add_r_0_18b - add_r_1_18b) : 18'd0;
	result_g_18b = sign_g ? (add_g_0_18b - add_g_1_18b) : 18'd0;
	result_b_18b = sign_b ? (add_b_0_18b - add_b_1_18b) : 18'd0;
end
//overflow
assign	o_r_8b = (result_r_18b[17:16] == 2'b00) ? result_r_18b[15:8] : 8'hff;
assign	o_g_8b = (result_g_18b[17:16] == 2'b00) ? result_g_18b[15:8] : 8'hff;
assign	o_b_8b = (result_b_18b[17:16] == 2'b00) ? result_b_18b[15:8] : 8'hff;

always @ (posedge clk) begin
	i_hs_delay_1 <= i_hs;
	i_vs_delay_1 <= i_vs;
	i_data_en_delay_1 <= i_data_en;

	i_hs_delay_2 <= i_hs_delay_1;
	i_vs_delay_2 <= i_vs_delay_1;
	i_data_en_delay_2 <= i_data_en_delay_1;

	o_hs <= i_hs_delay_2;
	o_vs <= i_vs_delay_2;
	o_data_en <= i_data_en_delay_2;
end

endmodule