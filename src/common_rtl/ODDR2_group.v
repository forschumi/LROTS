module ODDR2_group
#(
	parameter DATA_BITS = 1
)
(
	input clk,
	input[DATA_BITS-1:0] din_h,
	input[DATA_BITS-1:0] din_l,
	output[DATA_BITS-1:0] dout
);
 
genvar i;
generate
for (i = 0; i < DATA_BITS; i = i + 1) begin:ODRR_F
`ifdef Xilinx
	ODDR2 #(
			.DDR_ALIGNMENT("C0"), // Sets output alignment to "NONE", "C0" or "C1" 
			.INIT(1'b0),    // Sets initial state of the Q output to 1'b0 or 1'b1
			.SRTYPE("ASYNC") // Specifies "SYNC" or "ASYNC" set/reset
			) U_ODDR2
		(
			  .Q(dout[i]),   // 1-bit DDR output data
			  .C0(clk),   // 1-bit clock input
			  .C1(~clk),   // 1-bit clock input
			  .CE(1'b1), // 1-bit clock enable input
			  .D0(din_h[i]), // 1-bit data input (associated with C0)
			  .D1(din_l[i]), // 1-bit data input (associated with C1)
			  .R(1'b0),   // 1-bit reset input
			  .S(1'b0)    // 1-bit set input
		);
`else
	altddio_out	ALTDDIO_OUT_component (
				.datain_h (din_h[i]),
				.datain_l (din_l[i]),
				.outclock (clk),
				.dataout (dout[i]),
				.aclr (1'b0),
				.aset (1'b0),
				.oe (1'b1),
				.oe_out (),
				.outclocken (1'b1),
				.sclr (1'b0),
				.sset (1'b0));
	defparam
		ALTDDIO_OUT_component.extend_oe_disable = "OFF",
		ALTDDIO_OUT_component.intended_device_family = "Cyclone III",
		ALTDDIO_OUT_component.invert_output = "OFF",
		ALTDDIO_OUT_component.lpm_hint = "UNUSED",
		ALTDDIO_OUT_component.lpm_type = "altddio_out",
		ALTDDIO_OUT_component.oe_reg = "UNREGISTERED",
		ALTDDIO_OUT_component.power_up_high = "OFF",
		ALTDDIO_OUT_component.width = 1;
`endif
end
endgenerate
endmodule 