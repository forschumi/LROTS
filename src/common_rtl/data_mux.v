module data_mux
#(
parameter WIDTH = 16
)
(
	input[2:0] sel,
	input clk,
	input[WIDTH - 1 : 0] din0,
	input[WIDTH - 1 : 0] din1,
	input[WIDTH - 1 : 0] din2,
	input[WIDTH - 1 : 0] din3,
	input[WIDTH - 1 : 0] din4,
	output reg[WIDTH - 1 : 0] dout
);
always@(posedge clk)
begin
	case(sel)
		3'd0: dout <= din0;
		3'd1: dout <= din1;
		3'd2: dout <= din2;
		3'd3: dout <= din3;
		3'd4: dout <= din4;
		default:
			dout <= din0;
	endcase
end

endmodule 