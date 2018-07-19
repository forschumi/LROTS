/*
	缩放模块的双线性插值运算
	c = a * a_coff + b * b_coff
	4级流水线处理
*/
`timescale 1ns/100ps
module calu(
	input sys_clk,
	input[23:0] a,
	input[23:0] b,
	input[7:0] a_coff,
	input[7:0] b_coff,
	output[23:0] c,
	input[7:0] a_coff_next,//下级系数
	input[7:0] b_coff_next,//下级系数
	output reg[7:0] a_coff_next_out,//下级系数
	output reg[7:0] b_coff_next_out,//下级系数
	input data_en_in,
	input scale_en_in,//指示有效数据
	output reg data_en_out,
	output reg scale_en_out
);
reg[23:0] a_reg;
reg[23:0] b_reg;
reg[7:0] a_coff_reg;
reg[7:0] b_coff_reg;

//(* multstyle = "dsp" *) reg[15:0] a_mult0;
//(* multstyle = "dsp" *) reg[15:0] a_mult1;
//(* multstyle = "dsp" *) reg[15:0] a_mult2;
//(* multstyle = "dsp" *) reg[15:0] b_mult0;
//(* multstyle = "dsp" *) reg[15:0] b_mult1;
//(* multstyle = "dsp" *) reg[15:0] b_mult2;

reg[15:0] a_mult0;
reg[15:0] a_mult1;
reg[15:0] a_mult2;
reg[15:0] b_mult0;
reg[15:0] b_mult1;
reg[15:0] b_mult2;

reg[15:0] add0;
reg[15:0] add1;
reg[15:0] add2;

reg[8:0] add_tmp0;
reg[8:0] add_tmp1;
reg[8:0] add_tmp2;

reg data_en_in_d0;
reg data_en_in_d1;
reg data_en_in_d2;
reg scale_en_in_d0;
reg scale_en_in_d1;
reg scale_en_in_d2;
reg[7:0] a_coff_next_d0;
reg[7:0] a_coff_next_d1;
reg[7:0] a_coff_next_d2;
reg[7:0] b_coff_next_d0;
reg[7:0] b_coff_next_d1;
reg[7:0] b_coff_next_d2;
always@(posedge sys_clk)
begin
	a_reg <= a;
	b_reg <= b;
	a_coff_reg <= a_coff;
	b_coff_reg <= b_coff;
	data_en_in_d0 <= data_en_in;
	scale_en_in_d0 <= scale_en_in;
	a_coff_next_d0 <= a_coff_next;
	b_coff_next_d0 <= b_coff_next;
end

always@(posedge sys_clk)
begin
	a_mult0 <= a_reg[7:0] * a_coff_reg;
	a_mult1 <= a_reg[15:8] * a_coff_reg;
	a_mult2 <= a_reg[23:16] * a_coff_reg;
	
	b_mult0 <= b_reg[7:0] * b_coff_reg;
	b_mult1 <= b_reg[15:8] * b_coff_reg;
	b_mult2 <= b_reg[23:16] * b_coff_reg;
	data_en_in_d1 <= data_en_in_d0;
	scale_en_in_d1 <= scale_en_in_d0;
	a_coff_next_d1 <= a_coff_next_d0;
	b_coff_next_d1 <= b_coff_next_d0;
end

always@(posedge sys_clk)
begin
	add0 <= a_mult0 + b_mult0;
	add1 <= a_mult1 + b_mult1;
	add2 <= a_mult2 + b_mult2;
	data_en_in_d2 <= data_en_in_d1;
	scale_en_in_d2 <= scale_en_in_d1;
	a_coff_next_d2 <= a_coff_next_d1;
	b_coff_next_d2 <= b_coff_next_d1;
end

always@(posedge sys_clk)
begin
	add_tmp0 <= {1'b0,add0[15:8]} + {8'd0,{(add0[7:0] > 8'h66)}};
	add_tmp1 <= {1'b0,add1[15:8]} + {8'd0,{(add1[7:0]  > 8'h66)}};
	add_tmp2 <= {1'b0,add2[15:8]} + {8'd0,{(add2[7:0] > 8'h66)}};
	
	data_en_out <= data_en_in_d2;
	scale_en_out <= scale_en_in_d2;
	a_coff_next_out <= a_coff_next_d2;
	b_coff_next_out <= b_coff_next_d2;
end

assign c = {add_tmp2[8] ? 8'hf0 : add_tmp2[7:0],add_tmp1[8] ? 8'hf0 : add_tmp1[7:0],add_tmp0[8] ? 8'hf0 : add_tmp0[7:0]};
endmodule 