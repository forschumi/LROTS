module meanshift_1
	(
		input           clk,
		input           rst_n,
		input           m_en,
		input           almost_full,
		input   [7:0]   h_data,
		input   [10:0]  r_min_i,
		input   [10:0]  r_max_i,
		input   [10:0]  c_min_i,
		input   [10:0]  c_max_i,
		input           almost_empty,
		
		output reg        rd_en,
		output 	   [32:0] addr_length,
		output 	   [21:0] m_00,
		output reg        wr_en,
		output reg        m_done,
		output reg [10:0] cen_x,
		output reg [10:0] cen_y
	);
	
	(* keep = "true" *)reg		[10:0]	addr_h;
	(* keep = "true" *)reg		[10:0]	addr_v;
	(* keep = "true" *)reg		[10:0]	h_c;
	(* keep = "true" *)reg		[10:0]	v_c;
	(* keep = "true" *)reg				rd_done;
	(* keep = "true" *)reg 	[4:0]	c_state;
	reg		[31:0]	u1_i_1;
	reg		[21:0]	u1_i_2;
	reg				u1_op;
	wire 			u1_rdy;
	wire	[31:0]	u1_o;
	wire 	[31:0]	m_01;
	wire 	[31:0]	m_10;
	wire	[31:0]	m_00_d0;
	(* keep = "true" *)wire 			m00_done;
	parameter 	IDLE	 =5'b00001,
				X        =5'b00010,
				X_RDY    =5'b00100,
				Y        =5'b01000,
				Y_RDY    =5'b10000;
	//----------------------------addr_length------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin	
				addr_h <= 11'd1280;
				addr_v <= 11'd720;
				wr_en  <= 0;
			end
		else if(m_en)
			begin
				if(!almost_full)
					begin
						addr_h <= c_min_i; 
						addr_v <= r_min_i;
						wr_en  <= 1;
					end
				else
					begin	
						addr_h <= c_min_i - 1'd1;
						addr_v <= r_min_i;
						wr_en  <= 0;
					end
			end
		else if(!almost_full)
			begin
				if((addr_h == c_min_i - 1'd1) && (addr_v == r_min_i)) 
					begin
						addr_h <= c_min_i;
						addr_v <= r_min_i;
						wr_en  <= 1;
					end
				else if(c_max_i == 0)
					begin
						addr_h <= addr_h;
						addr_v <= addr_v;
						wr_en  <= 0;
					end
				else
					begin
						if(addr_v < r_max_i)
							begin
								addr_h <= c_min_i;
								addr_v <= addr_v + 1'd1;
								wr_en  <= 1;
							end
						else
							begin
								addr_h <= 11'd1280;
								addr_v <= 11'd720;
								wr_en  <= 0;
							end
					end
			end
		else
			begin
				addr_h <= addr_h;
				addr_v <= addr_v;
				wr_en  <= 0;
			end
	end
	assign 	addr_length = {addr_h,addr_v,c_max_i - c_min_i + 1'd1};
	//----------------------------m count----------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				h_c     <= 11'd1280;
				v_c     <= 11'd720;
				rd_en   <= 0;
				rd_done <= 0;
			end
		else if(m_en)
			begin
				if(!almost_empty)
					begin
						h_c   <= c_min_i;
						v_c   <= r_min_i;
						rd_en <= 1;
					end
				else
					begin
						h_c   <= c_min_i - 1'd1;
						v_c   <= r_min_i;
						rd_en <= 0;
					end
			end
		else if(!almost_empty)
			begin
				if(h_c == c_min_i - 1'd1 && v_c == r_min_i)
					begin
						h_c   <= c_min_i;
						v_c   <= r_min_i;
						rd_en <= 1;
					end
					//zclin 2017.1.7
				//else if(h_c <= c_max_i - 4'd8)
				/* else if(c_max_i < 4'd8 && v_c < r_max_i)
					begin
						h_c   <= c_min_i;
						v_c   <= v_c + 1'd1;
						rd_en <= 1;
					end */
				else if(c_max_i >= 4'd8 && h_c <= c_max_i - 4'd8)
					begin	
						h_c <= h_c + 4'd8;
						v_c <= v_c;
						rd_en <= 1;
					end
				else if(v_c < r_max_i)
					begin
						h_c   <= c_min_i;
						v_c   <= v_c + 1'd1;
						rd_en <= 1;
					end
			end
		else if((h_c > c_max_i - 4'd8 && v_c == r_max_i && c_max_i >= 4'd8) || (c_max_i < 4'd8 && v_c == r_max_i))
			begin
				h_c   	<= 11'd1280;
				v_c   	<= 11'd720;
				rd_en 	<= 0;
				rd_done <= 1;
			end
		else if(rd_done)
			rd_done <= 0;
		else
			begin
				h_c     <= h_c;
				v_c 	<= v_c;
				rd_en	<= 0;
				rd_done	<= 0;
			end
	end
	//----------------------------calc cen---------------------------
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				c_state <= IDLE;
				m_done  <= 0;
				u1_i_1	<= 0;
				u1_i_2 	<= 0;
				u1_op	<= 0;
				cen_x	<= 0;
				cen_y	<= 0;
			end
		else
			case(c_state)
				IDLE 		:begin
								m_done <= 0;
								
								if(m00_done)
									c_state <= X;
								else
									c_state <= IDLE;
							end
				X			:begin
								if(m_00_d0 == 32'd0)
									u1_i_2 <= 22'd1;
								else
									u1_i_2 <= m_00_d0[21:0];
								
								u1_i_1  <= m_10;
								u1_op   <= 1;
								c_state <= X_RDY;
							end
				X_RDY		:begin
								u1_op <= 0;
								if(u1_rdy)
									begin
										cen_x   <= u1_o[10:0];
										c_state <= Y;
									end
								else
									c_state <= X_RDY;
							end
				Y			:begin
								u1_i_1  <= m_01;
								u1_op   <= 1;
								c_state <= Y_RDY;
							end
				Y_RDY 		:begin
								u1_op <= 0;
								if(u1_rdy)
									begin
										cen_y   <= u1_o[10:0];
										c_state <= IDLE;
										m_done  <= 1;
									end
								else c_state <= Y_RDY;
							end
				default 	:c_state <= IDLE;
			endcase
	end
	assign m_00 = m_00_d0[21:0];
	//----------------------------m calc-----------------------------
	calc_m01_1	m01_calc
					(
						.nrst(rst_n),
						.clk(clk),
						.cnt_en(m_en),
						.vcount(v_c),
						.rd_done(rd_done),
						.idata(h_data),
						.odata(m_01),
						.m01_done()
					);
						
	calc_m10_1	m10_calc
					(
						.nrst(rst_n),
						.clk(clk),
						.rd_done(rd_done),
						.cnt_en(m_en),
						.idata(h_data),
						.odata(m_10),
						.hcount(h_c),
						.m10_done()
					);	
	calc_m00_1	m00_calc
					(
						.nrst(rst_n),
						.clk(clk),
						.cnt_en(m_en),
						.rd_done(rd_done),
						.data_in(h_data),
						.data_out(m_00_d0),
						.m00_done(m00_done)
					);
	//----------------------------IP core----------------------------
	divint u1_div_int 
				(
					.clk(clk), // input clk
					.nd(u1_op), // input nd
					.rdy(u1_rdy), // output rdy
					.rfd(), // output rfd
					.dividend(u1_i_1), // input [31 : 0] dividend
					.divisor(u1_i_2), // input [21 : 0] divisor
					.quotient(u1_o)
				); // output [31 : 0] quotient
	endmodule