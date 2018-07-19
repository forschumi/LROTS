module video_mux(
	input clk,
	input[2:0] sel,
	input vin_vs_ch0,
	input vin_hs_ch0,
	input vin_de_ch0,
	input[15:0] vin_yc_ch0,
	
	input vin_vs_ch1,
	input vin_hs_ch1,
	input vin_de_ch1,
	input[15:0] vin_yc_ch1,

	input vin_vs_ch2,
	input vin_hs_ch2,
	input vin_de_ch2,
	input[15:0] vin_yc_ch2,

	input vin_vs_ch3,
	input vin_hs_ch3,
	input vin_de_ch3,
	input[15:0] vin_yc_ch3,

	input vin_vs_ch4,
	input vin_hs_ch4,
	input vin_de_ch4,
	input[15:0] vin_yc_ch4,
	
	output reg vout_vs,
	output reg vout_hs,
	output reg vout_de,
	output reg[15:0] vout_yc
);
always@(posedge clk)
begin
	case(sel)
		3'd0:
			begin
				vout_vs <= vin_vs_ch0;
				vout_hs <= vin_hs_ch0;
				vout_de <= vin_de_ch0;
				vout_yc <= vin_yc_ch0;
			end
		3'd1:
			begin
				vout_vs <= vin_vs_ch1;
				vout_hs <= vin_hs_ch1;
				vout_de <= vin_de_ch1;
				vout_yc <= vin_yc_ch1;
			end	
		3'd2:
			begin
				vout_vs <= vin_vs_ch2;
				vout_hs <= vin_hs_ch2;
				vout_de <= vin_de_ch2;
				vout_yc <= vin_yc_ch2;
			end	
		3'd3:
			begin
				vout_vs <= vin_vs_ch3;
				vout_hs <= vin_hs_ch3;
				vout_de <= vin_de_ch3;
				vout_yc <= vin_yc_ch3;
			end
		3'd4:
			begin
				vout_vs <= vin_vs_ch4;
				vout_hs <= vin_hs_ch4;
				vout_de <= vin_de_ch4;
				vout_yc <= vin_yc_ch4;
			end
		default:
			begin
				vout_vs <= vin_vs_ch0;
				vout_hs <= vin_hs_ch0;
				vout_de <= vin_de_ch0;
				vout_yc <= vin_yc_ch0;
			end			
	endcase
end

endmodule 