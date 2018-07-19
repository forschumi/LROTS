module clock_in
(
	input clk_in,
	output clk_out
);
`ifdef Xilinx
BUFGP BUFGP_INST
   (.O (clk_out),
    .I (clk_in));
`else
assign clk_out = clk_in;
`endif
endmodule 