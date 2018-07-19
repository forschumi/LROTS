/*
alpha越大，透明度越低,有三拍延时
*/
`timescale	1ps/1ps
module	alpha_blend(
	input sys_clk,
	
	input i_h_sync,
	input i_v_sync,
	input i_de,
	
	input [7 : 0] i_back_ground_0_8b,
	input [7 : 0] i_back_ground_1_8b,
	input [7 : 0] i_back_ground_2_8b,

	input [7 : 0] i_alpha_8b,
		
	input [7 : 0] i_front_ground_0_8b,
	input [7 : 0] i_front_ground_1_8b,
	input [7 : 0] i_front_ground_2_8b,
	
	//output
	output	reg	o_h_sync,
	output	reg	o_v_sync,
	output	reg	o_de,
	
	output	wire[7 : 0] o_data_0_8b,
	output	wire[7 : 0]	o_data_1_8b,
	output	wire[7 : 0]	o_data_2_8b,
	output[11:0] o_x,
	output[11:0] o_y
);
/*******************************************************************************/


reg [7 : 0]	alpha_8b;	
wire[7 : 0]	alpha_n_8b;

reg [7 : 0]	front_ground_0_8b_delay_1;
reg [7 : 0]	front_ground_1_8b_delay_1;
reg [7 : 0]	front_ground_2_8b_delay_1;

reg [7 : 0]	back_ground_0_8b_delay_1;
reg [7 : 0]	back_ground_1_8b_delay_1;
reg [7 : 0]	back_ground_2_8b_delay_1;
	
reg [15: 0]	mult_front_ground_0_16b;
reg [15: 0]	mult_front_ground_1_16b;
reg [15: 0]	mult_front_ground_2_16b;
	
reg [15: 0]	mult_back_ground_0_16b;
reg [15: 0]	mult_back_ground_1_16b;
reg [15: 0]	mult_back_ground_2_16b;
	
reg [16 : 0] add_data_0_17b;
reg [16 : 0] add_data_1_17b;
reg [16 : 0] add_data_2_17b;	

reg[8:0] data_0_tmp;
reg[8:0] data_1_tmp;
reg[8:0] data_2_tmp;


reg h_sync_delay_1;
reg	h_sync_delay_2;
reg	h_sync_delay_3; 
    			
reg	v_sync_delay_1;
reg	v_sync_delay_2; 
reg	v_sync_delay_3; 
        			
reg	de_delay_1;
reg	de_delay_2;
reg	de_delay_3;

assign alpha_n_8b = ~alpha_8b;
/*******************************************************************************/
//LV1
always @ (posedge	sys_clk)
	begin
		front_ground_0_8b_delay_1 <= i_front_ground_0_8b;
		front_ground_1_8b_delay_1 <= i_front_ground_1_8b;
		front_ground_2_8b_delay_1 <= i_front_ground_2_8b; 

		back_ground_0_8b_delay_1 <= i_back_ground_0_8b;
		back_ground_1_8b_delay_1 <= i_back_ground_1_8b;
		back_ground_2_8b_delay_1 <= i_back_ground_2_8b;
		alpha_8b <= i_alpha_8b;
	end

//LV2:mult
always @ (posedge	sys_clk)
	begin
		mult_front_ground_0_16b <= front_ground_0_8b_delay_1 * alpha_8b;
		mult_front_ground_1_16b <= front_ground_1_8b_delay_1 * alpha_8b;
		mult_front_ground_2_16b <= front_ground_2_8b_delay_1 * alpha_8b;
		
		mult_back_ground_0_16b <= back_ground_0_8b_delay_1 * alpha_n_8b;
		mult_back_ground_1_16b <= back_ground_1_8b_delay_1 * alpha_n_8b;
		mult_back_ground_2_16b <= back_ground_2_8b_delay_1 * alpha_n_8b;
	end
	
//LV3:add
always @ (posedge	sys_clk)
	begin
		add_data_0_17b <= {1'b0,mult_front_ground_0_16b} + {1'b0,mult_back_ground_0_16b};
		add_data_1_17b <= {1'b0,mult_front_ground_1_16b} + {1'b0,mult_back_ground_1_16b};
		add_data_2_17b <= {1'b0,mult_front_ground_2_16b} + {1'b0,mult_back_ground_2_16b};
	end
always @ (posedge	sys_clk)
	begin
		data_0_tmp <= add_data_0_17b[16:8] + {8'd0,{|add_data_0_17b[7:5]}};
		data_1_tmp <= add_data_1_17b[16:8] + {8'd0,{|add_data_1_17b[7:5]}};
		data_2_tmp <= add_data_2_17b[16:8] + {8'd0,{|add_data_2_17b[7:5]}};
	end 
	
assign	o_data_0_8b = data_0_tmp[8] ? 8'hff : data_0_tmp[7 : 0];
assign	o_data_1_8b = data_1_tmp[8] ? 8'hff : data_1_tmp[7 : 0];
assign	o_data_2_8b = data_2_tmp[8] ? 8'hff : data_2_tmp[7 : 0];
/*******************************************************************************/

always @ (posedge	sys_clk)
	begin
		h_sync_delay_1 	<= i_h_sync;
		h_sync_delay_2 	<= h_sync_delay_1;
		h_sync_delay_3 	<= h_sync_delay_2;
		o_h_sync		<= h_sync_delay_3;
		               	
		v_sync_delay_1 	<= i_v_sync;
		v_sync_delay_2 	<= v_sync_delay_1;
		v_sync_delay_3 	<= v_sync_delay_2;
		o_v_sync		<= v_sync_delay_3;
		
		de_delay_1 	 	<= i_de;
		de_delay_2 	 	<= de_delay_1;
		de_delay_3 	 	<= de_delay_2;
		o_de			<= de_delay_3;
	end
	
timing_gen_xy timing_gen_xy_m0(
	.rst_n(1'b1),
	.clk(sys_clk),
	.i_hs(h_sync_delay_2),
	.i_vs(v_sync_delay_2),
	.i_de(de_delay_2),
	.i_data(),
	.o_hs(),
	.o_vs(),
	.o_de(),
	.o_data(),
	.x(o_x),
	.y(o_y)
);
endmodule
											
