////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.68d
//  \   \         Application: netgen
//  /   /         Filename: en_flo2fix.v
// /___/   /\     Timestamp: Thu Nov 17 16:49:22 2016
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog "C:/Users/Yuan Ruyue/Desktop/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_flo2fix.ngc" "C:/Users/Yuan Ruyue/Desktop/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_flo2fix.v" 
// Device	: 6slx45fgg484-2
// Input file	: C:/Users/Yuan Ruyue/Desktop/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_flo2fix.ngc
// Output file	: C:/Users/Yuan Ruyue/Desktop/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_flo2fix.v
// # of Modules	: 1
// Design Name	: en_flo2fix
// Xilinx        : d:\Xilinx\14.6\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module en_flo2fix (
  operation_nd, clk, rdy, a, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  output rdy;
  input [31 : 0] a;
  output [10 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  wire sig00000001;
  wire sig00000002;
  wire sig00000003;
  wire sig00000004;
  wire sig00000005;
  wire sig00000006;
  wire sig00000007;
  wire sig00000008;
  wire sig00000009;
  wire sig0000000a;
  wire sig0000000b;
  wire sig0000000c;
  wire sig0000000d;
  wire sig0000000e;
  wire sig0000000f;
  wire sig00000010;
  wire sig00000011;
  wire sig00000012;
  wire sig00000013;
  wire sig00000014;
  wire sig00000015;
  wire sig00000016;
  wire sig00000017;
  wire sig00000018;
  wire sig00000019;
  wire sig0000001a;
  wire sig0000001b;
  wire sig0000001c;
  wire sig0000001d;
  wire sig0000001e;
  wire sig0000001f;
  wire sig00000020;
  wire sig00000021;
  wire sig00000022;
  wire sig00000023;
  wire sig00000024;
  wire sig00000025;
  wire sig00000026;
  wire sig00000027;
  wire sig00000028;
  wire sig00000029;
  wire sig0000002a;
  wire sig0000002b;
  wire sig0000002c;
  wire sig0000002d;
  wire sig0000002e;
  wire sig0000002f;
  wire sig00000030;
  wire sig00000031;
  wire sig00000032;
  wire sig00000033;
  wire sig00000034;
  wire sig00000035;
  wire sig00000036;
  wire sig00000037;
  wire sig00000038;
  wire sig00000039;
  wire sig0000003a;
  wire sig0000003b;
  wire sig0000003c;
  wire sig0000003d;
  wire sig0000003e;
  wire sig0000003f;
  wire sig00000040;
  wire sig00000041;
  wire sig00000042;
  wire sig00000043;
  wire sig00000044;
  wire sig00000045;
  wire sig00000046;
  wire sig00000047;
  wire sig00000048;
  wire sig00000049;
  wire sig0000004a;
  wire sig0000004b;
  wire sig0000004c;
  wire sig0000004d;
  wire sig0000004e;
  wire sig0000004f;
  wire sig00000050;
  wire sig00000051;
  wire sig00000052;
  wire sig00000053;
  wire sig00000054;
  wire sig00000055;
  wire sig00000056;
  wire sig00000057;
  wire sig00000058;
  wire sig00000059;
  wire sig0000005a;
  wire sig0000005b;
  wire sig0000005c;
  wire sig0000005d;
  wire sig0000005e;
  wire sig0000005f;
  wire sig00000060;
  wire sig00000061;
  wire sig00000062;
  wire sig00000063;
  wire sig00000064;
  wire sig00000065;
  wire sig00000066;
  wire sig00000067;
  wire sig00000068;
  wire sig00000069;
  wire sig0000006a;
  wire sig0000006b;
  wire sig0000006c;
  wire sig0000006d;
  wire sig0000006e;
  wire sig0000006f;
  wire sig00000070;
  wire sig00000071;
  wire sig00000072;
  wire sig00000073;
  wire sig00000074;
  wire sig00000075;
  wire sig00000076;
  wire sig00000077;
  wire sig00000078;
  wire sig00000079;
  wire sig0000007a;
  wire sig0000007b;
  wire sig0000007c;
  wire sig0000007d;
  wire sig0000007e;
  wire sig0000007f;
  wire sig00000080;
  wire sig00000081;
  wire sig00000082;
  wire sig00000083;
  wire sig00000084;
  wire sig00000085;
  wire sig00000086;
  wire sig00000087;
  wire sig00000088;
  wire sig00000089;
  wire sig0000008a;
  wire sig0000008b;
  wire sig0000008c;
  wire sig0000008d;
  wire sig0000008e;
  wire sig0000008f;
  wire sig00000090;
  wire sig00000091;
  wire sig00000092;
  wire sig00000093;
  wire sig00000094;
  wire sig00000095;
  wire sig00000096;
  wire sig00000097;
  wire sig00000098;
  wire sig00000099;
  wire sig0000009a;
  wire sig0000009b;
  wire sig0000009c;
  wire sig0000009d;
  wire sig0000009e;
  wire NLW_blk0000001c_O_UNCONNECTED;
  wire NLW_blk00000035_O_UNCONNECTED;
  wire NLW_blk0000004c_O_UNCONNECTED;
  wire [10 : 0] \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT ;
  assign
    result[10] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [10],
    result[9] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [9],
    result[8] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [8],
    result[7] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [7],
    result[6] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [6],
    result[5] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [5],
    result[4] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [4],
    result[3] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [3],
    result[2] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [2],
    result[1] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [1],
    result[0] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [0],
    rdy = \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(sig00000001)
  );
  GND   blk00000002 (
    .G(sig00000002)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000003 (
    .C(clk),
    .D(operation_nd),
    .Q(sig00000003)
  );
  FDR #(
    .INIT ( 1'b0 ))
  blk00000004 (
    .C(clk),
    .D(sig00000003),
    .R(sig00000002),
    .Q(\U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  MUXCY   blk00000005 (
    .CI(sig00000015),
    .DI(sig00000002),
    .S(sig00000014),
    .O(sig00000051)
  );
  MUXCY   blk00000006 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000013),
    .O(sig00000015)
  );
  MUXCY   blk00000007 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000017),
    .O(sig00000016)
  );
  MUXCY   blk00000008 (
    .CI(sig00000016),
    .DI(sig00000002),
    .S(sig00000018),
    .O(sig00000050)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .D(a[31]),
    .Q(sig00000036)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000a (
    .C(clk),
    .D(sig00000026),
    .Q(sig0000004f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000b (
    .C(clk),
    .D(sig00000027),
    .Q(sig0000004e)
  );
  FD   blk0000000c (
    .C(clk),
    .D(sig00000019),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [10])
  );
  FD   blk0000000d (
    .C(clk),
    .D(sig00000025),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [9])
  );
  FD   blk0000000e (
    .C(clk),
    .D(sig00000024),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [8])
  );
  FD   blk0000000f (
    .C(clk),
    .D(sig00000023),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [7])
  );
  FD   blk00000010 (
    .C(clk),
    .D(sig00000022),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [6])
  );
  FD   blk00000011 (
    .C(clk),
    .D(sig00000021),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [5])
  );
  FD   blk00000012 (
    .C(clk),
    .D(sig00000020),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [4])
  );
  FD   blk00000013 (
    .C(clk),
    .D(sig0000001f),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [3])
  );
  FD   blk00000014 (
    .C(clk),
    .D(sig0000001e),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [2])
  );
  FD   blk00000015 (
    .C(clk),
    .D(sig0000001d),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [1])
  );
  FD   blk00000016 (
    .C(clk),
    .D(sig0000001c),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [0])
  );
  MUXCY   blk00000017 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig0000005b),
    .O(sig00000052)
  );
  MUXCY   blk00000018 (
    .CI(sig00000052),
    .DI(sig00000002),
    .S(sig0000005a),
    .O(sig00000053)
  );
  MUXCY   blk00000019 (
    .CI(sig00000053),
    .DI(sig00000002),
    .S(sig00000059),
    .O(sig00000054)
  );
  MUXCY   blk0000001a (
    .CI(sig00000054),
    .DI(sig00000002),
    .S(sig00000058),
    .O(sig00000055)
  );
  MUXCY   blk0000001b (
    .CI(sig00000055),
    .DI(sig00000002),
    .S(sig00000057),
    .O(sig00000056)
  );
  MUXCY   blk0000001c (
    .CI(sig00000056),
    .DI(sig00000002),
    .S(sig0000005c),
    .O(NLW_blk0000001c_O_UNCONNECTED)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001d (
    .C(clk),
    .D(sig00000060),
    .Q(sig00000064)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001e (
    .C(clk),
    .D(sig0000005f),
    .Q(sig00000063)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001f (
    .C(clk),
    .D(sig00000001),
    .Q(sig00000062)
  );
  MUXF8   blk00000020 (
    .I0(sig0000005e),
    .I1(sig0000005d),
    .S(sig00000002),
    .O(sig0000004d)
  );
  MUXF7   blk00000021 (
    .I0(sig0000009b),
    .I1(sig0000009c),
    .S(sig00000061),
    .O(sig0000005d)
  );
  MUXF7   blk00000022 (
    .I0(sig0000009d),
    .I1(sig0000009e),
    .S(sig00000061),
    .O(sig0000005e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000023 (
    .C(clk),
    .D(sig0000002b),
    .Q(sig00000061)
  );
  MUXCY   blk00000024 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig0000006f),
    .O(sig0000006a)
  );
  MUXCY   blk00000025 (
    .CI(sig0000006a),
    .DI(sig00000002),
    .S(sig0000006e),
    .O(sig00000069)
  );
  MUXCY   blk00000026 (
    .CI(sig00000069),
    .DI(sig00000002),
    .S(sig0000006d),
    .O(sig00000068)
  );
  MUXCY   blk00000027 (
    .CI(sig00000068),
    .DI(sig00000002),
    .S(sig0000006c),
    .O(sig00000065)
  );
  MUXCY   blk00000028 (
    .CI(sig00000065),
    .DI(sig00000002),
    .S(sig0000006b),
    .O(sig00000067)
  );
  MUXCY   blk00000029 (
    .CI(sig00000067),
    .DI(sig00000002),
    .S(sig00000002),
    .O(sig00000066)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002a (
    .C(clk),
    .D(sig00000008),
    .Q(sig0000004c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002b (
    .C(clk),
    .D(sig00000009),
    .Q(sig0000004b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002c (
    .C(clk),
    .D(sig0000000a),
    .Q(sig0000004a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002d (
    .C(clk),
    .D(sig0000000b),
    .Q(sig00000049)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002e (
    .C(clk),
    .D(sig0000000c),
    .Q(sig00000048)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002f (
    .C(clk),
    .D(sig0000000d),
    .Q(sig00000047)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000030 (
    .C(clk),
    .D(sig0000000e),
    .Q(sig00000046)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000031 (
    .C(clk),
    .D(sig0000000f),
    .Q(sig00000045)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000032 (
    .C(clk),
    .D(sig00000010),
    .Q(sig00000044)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000033 (
    .C(clk),
    .D(sig00000011),
    .Q(sig00000043)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000034 (
    .C(clk),
    .D(sig00000012),
    .Q(sig00000042)
  );
  XORCY   blk00000035 (
    .CI(sig00000070),
    .LI(sig00000002),
    .O(NLW_blk00000035_O_UNCONNECTED)
  );
  XORCY   blk00000036 (
    .CI(sig00000071),
    .LI(sig0000009a),
    .O(sig00000041)
  );
  MUXCY   blk00000037 (
    .CI(sig00000071),
    .DI(sig00000002),
    .S(sig0000009a),
    .O(sig00000070)
  );
  XORCY   blk00000038 (
    .CI(sig00000072),
    .LI(sig00000035),
    .O(sig00000040)
  );
  MUXCY   blk00000039 (
    .CI(sig00000072),
    .DI(sig00000002),
    .S(sig00000035),
    .O(sig00000071)
  );
  XORCY   blk0000003a (
    .CI(sig00000073),
    .LI(sig00000034),
    .O(sig0000003f)
  );
  MUXCY   blk0000003b (
    .CI(sig00000073),
    .DI(sig00000002),
    .S(sig00000034),
    .O(sig00000072)
  );
  XORCY   blk0000003c (
    .CI(sig00000074),
    .LI(sig00000033),
    .O(sig0000003e)
  );
  MUXCY   blk0000003d (
    .CI(sig00000074),
    .DI(sig00000002),
    .S(sig00000033),
    .O(sig00000073)
  );
  XORCY   blk0000003e (
    .CI(sig00000075),
    .LI(sig00000032),
    .O(sig0000003d)
  );
  MUXCY   blk0000003f (
    .CI(sig00000075),
    .DI(sig00000002),
    .S(sig00000032),
    .O(sig00000074)
  );
  XORCY   blk00000040 (
    .CI(sig00000076),
    .LI(sig00000031),
    .O(sig0000003c)
  );
  MUXCY   blk00000041 (
    .CI(sig00000076),
    .DI(sig00000002),
    .S(sig00000031),
    .O(sig00000075)
  );
  XORCY   blk00000042 (
    .CI(sig00000077),
    .LI(sig00000030),
    .O(sig0000003b)
  );
  MUXCY   blk00000043 (
    .CI(sig00000077),
    .DI(sig00000002),
    .S(sig00000030),
    .O(sig00000076)
  );
  XORCY   blk00000044 (
    .CI(sig00000078),
    .LI(sig0000002f),
    .O(sig0000003a)
  );
  MUXCY   blk00000045 (
    .CI(sig00000078),
    .DI(sig00000002),
    .S(sig0000002f),
    .O(sig00000077)
  );
  XORCY   blk00000046 (
    .CI(sig00000079),
    .LI(sig0000002e),
    .O(sig00000039)
  );
  MUXCY   blk00000047 (
    .CI(sig00000079),
    .DI(sig00000002),
    .S(sig0000002e),
    .O(sig00000078)
  );
  XORCY   blk00000048 (
    .CI(sig0000007a),
    .LI(sig0000002d),
    .O(sig00000038)
  );
  MUXCY   blk00000049 (
    .CI(sig0000007a),
    .DI(sig00000002),
    .S(sig0000002d),
    .O(sig00000079)
  );
  XORCY   blk0000004a (
    .CI(sig0000007b),
    .LI(sig0000002c),
    .O(sig00000037)
  );
  MUXCY   blk0000004b (
    .CI(sig0000007b),
    .DI(sig00000002),
    .S(sig0000002c),
    .O(sig0000007a)
  );
  XORCY   blk0000004c (
    .CI(sig00000001),
    .LI(sig0000001b),
    .O(NLW_blk0000004c_O_UNCONNECTED)
  );
  MUXCY   blk0000004d (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig0000001b),
    .O(sig0000007b)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000004e (
    .I0(a[26]),
    .I1(a[23]),
    .I2(a[24]),
    .I3(a[25]),
    .O(sig00000017)
  );
  LUT4 #(
    .INIT ( 16'h0002 ))
  blk0000004f (
    .I0(a[26]),
    .I1(a[23]),
    .I2(a[24]),
    .I3(a[25]),
    .O(sig00000008)
  );
  LUT6 #(
    .INIT ( 64'h0002F00000023000 ))
  blk00000050 (
    .I0(a[21]),
    .I1(a[23]),
    .I2(a[24]),
    .I3(a[25]),
    .I4(a[26]),
    .I5(a[22]),
    .O(sig0000000a)
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  blk00000051 (
    .I0(a[30]),
    .I1(a[27]),
    .I2(a[29]),
    .I3(a[28]),
    .O(sig00000014)
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  blk00000052 (
    .I0(a[23]),
    .I1(a[25]),
    .I2(a[24]),
    .I3(a[26]),
    .O(sig00000013)
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  blk00000053 (
    .I0(a[26]),
    .I1(a[24]),
    .I2(a[25]),
    .O(sig0000002a)
  );
  LUT5 #(
    .INIT ( 32'h40024000 ))
  blk00000054 (
    .I0(a[26]),
    .I1(a[23]),
    .I2(a[24]),
    .I3(a[25]),
    .I4(a[22]),
    .O(sig00000009)
  );
  LUT4 #(
    .INIT ( 16'h6A66 ))
  blk00000055 (
    .I0(sig00000036),
    .I1(sig00000042),
    .I2(sig00000043),
    .I3(sig0000004d),
    .O(sig0000001b)
  );
  LUT4 #(
    .INIT ( 16'hC999 ))
  blk00000056 (
    .I0(a[26]),
    .I1(a[27]),
    .I2(a[24]),
    .I3(a[25]),
    .O(sig0000002b)
  );
  LUT4 #(
    .INIT ( 16'hD580 ))
  blk00000057 (
    .I0(a[24]),
    .I1(a[17]),
    .I2(a[25]),
    .I3(a[19]),
    .O(sig00000005)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000058 (
    .I0(a[24]),
    .I1(a[20]),
    .I2(a[18]),
    .O(sig00000006)
  );
  LUT4 #(
    .INIT ( 16'h9888 ))
  blk00000059 (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig00000041),
    .O(sig00000019)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000005a (
    .I0(sig00000043),
    .I1(sig00000036),
    .O(sig0000002c)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000005b (
    .I0(sig00000044),
    .I1(sig00000036),
    .O(sig0000002d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000005c (
    .I0(sig00000045),
    .I1(sig00000036),
    .O(sig0000002e)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000005d (
    .I0(sig00000046),
    .I1(sig00000036),
    .O(sig0000002f)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000005e (
    .I0(sig00000047),
    .I1(sig00000036),
    .O(sig00000030)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000005f (
    .I0(sig00000048),
    .I1(sig00000036),
    .O(sig00000031)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000060 (
    .I0(sig00000049),
    .I1(sig00000036),
    .O(sig00000032)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000061 (
    .I0(sig0000004a),
    .I1(sig00000036),
    .O(sig00000033)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000062 (
    .I0(sig0000004b),
    .I1(sig00000036),
    .O(sig00000034)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000063 (
    .I0(sig0000004c),
    .I1(sig00000036),
    .O(sig00000035)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000064 (
    .I0(a[25]),
    .I1(a[24]),
    .O(sig00000029)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000065 (
    .I0(a[27]),
    .I1(a[28]),
    .I2(a[29]),
    .I3(a[30]),
    .O(sig00000018)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000066 (
    .I0(a[16]),
    .I1(a[17]),
    .I2(a[18]),
    .I3(a[19]),
    .O(sig00000057)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000067 (
    .I0(a[12]),
    .I1(a[13]),
    .I2(a[14]),
    .I3(a[15]),
    .O(sig00000058)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000068 (
    .I0(a[8]),
    .I1(a[9]),
    .I2(a[10]),
    .I3(a[11]),
    .O(sig00000059)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000069 (
    .I0(a[4]),
    .I1(a[5]),
    .I2(a[6]),
    .I3(a[7]),
    .O(sig0000005a)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000006a (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .O(sig0000005b)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  blk0000006b (
    .I0(a[20]),
    .I1(a[21]),
    .I2(a[22]),
    .O(sig0000005c)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000006c (
    .I0(a[16]),
    .I1(a[17]),
    .I2(a[18]),
    .I3(a[19]),
    .O(sig0000006b)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000006d (
    .I0(a[12]),
    .I1(a[13]),
    .I2(a[14]),
    .I3(a[15]),
    .O(sig0000006c)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000006e (
    .I0(a[8]),
    .I1(a[9]),
    .I2(a[10]),
    .I3(a[11]),
    .O(sig0000006d)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000006f (
    .I0(a[4]),
    .I1(a[5]),
    .I2(a[6]),
    .I3(a[7]),
    .O(sig0000006e)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000070 (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .O(sig0000006f)
  );
  LUT5 #(
    .INIT ( 32'hFFFFAAA8 ))
  blk00000071 (
    .I0(a[26]),
    .I1(a[25]),
    .I2(a[24]),
    .I3(a[23]),
    .I4(a[27]),
    .O(sig0000007c)
  );
  LUT6 #(
    .INIT ( 64'h2020202020202000 ))
  blk00000072 (
    .I0(sig00000007),
    .I1(sig00000051),
    .I2(a[30]),
    .I3(a[29]),
    .I4(a[28]),
    .I5(sig0000007c),
    .O(sig0000001a)
  );
  LUT5 #(
    .INIT ( 32'hFBD97351 ))
  blk00000073 (
    .I0(a[24]),
    .I1(a[23]),
    .I2(a[22]),
    .I3(a[21]),
    .I4(a[20]),
    .O(sig0000007d)
  );
  LUT5 #(
    .INIT ( 32'hB003B000 ))
  blk00000074 (
    .I0(a[22]),
    .I1(a[23]),
    .I2(a[24]),
    .I3(a[25]),
    .I4(a[13]),
    .O(sig0000007f)
  );
  LUT5 #(
    .INIT ( 32'hDF8FD888 ))
  blk00000075 (
    .I0(a[26]),
    .I1(sig0000007f),
    .I2(a[23]),
    .I3(sig0000007e),
    .I4(sig00000004),
    .O(sig00000012)
  );
  LUT6 #(
    .INIT ( 64'h5545150551411101 ))
  blk00000076 (
    .I0(a[25]),
    .I1(a[24]),
    .I2(a[23]),
    .I3(a[22]),
    .I4(a[20]),
    .I5(a[21]),
    .O(sig00000080)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000077 (
    .I0(a[24]),
    .I1(a[18]),
    .I2(a[16]),
    .O(sig00000081)
  );
  LUT6 #(
    .INIT ( 64'h5545454554444444 ))
  blk00000078 (
    .I0(a[26]),
    .I1(sig00000080),
    .I2(a[23]),
    .I3(a[25]),
    .I4(sig00000081),
    .I5(sig00000005),
    .O(sig00000082)
  );
  LUT5 #(
    .INIT ( 32'hFFFF0010 ))
  blk00000079 (
    .I0(a[25]),
    .I1(a[24]),
    .I2(a[15]),
    .I3(a[23]),
    .I4(sig00000082),
    .O(sig00000010)
  );
  LUT5 #(
    .INIT ( 32'h80000000 ))
  blk0000007a (
    .I0(a[28]),
    .I1(a[27]),
    .I2(a[26]),
    .I3(a[25]),
    .I4(a[24]),
    .O(sig00000083)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF88888000 ))
  blk0000007b (
    .I0(sig00000007),
    .I1(sig00000051),
    .I2(a[29]),
    .I3(sig00000083),
    .I4(a[30]),
    .I5(sig0000001a),
    .O(sig00000027)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000007c (
    .I0(a[24]),
    .I1(a[22]),
    .I2(a[20]),
    .O(sig00000084)
  );
  LUT6 #(
    .INIT ( 64'hF788D588A2888088 ))
  blk0000007d (
    .I0(a[23]),
    .I1(a[24]),
    .I2(a[19]),
    .I3(a[25]),
    .I4(a[21]),
    .I5(sig00000084),
    .O(sig00000085)
  );
  LUT6 #(
    .INIT ( 64'h2E0E26062A0A2202 ))
  blk0000007e (
    .I0(a[24]),
    .I1(a[25]),
    .I2(a[23]),
    .I3(a[22]),
    .I4(a[19]),
    .I5(a[21]),
    .O(sig00000086)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000007f (
    .I0(a[23]),
    .I1(a[25]),
    .O(sig00000087)
  );
  LUT6 #(
    .INIT ( 64'hFFFF544454445444 ))
  blk00000080 (
    .I0(a[26]),
    .I1(sig00000086),
    .I2(sig00000087),
    .I3(sig00000006),
    .I4(a[17]),
    .I5(sig00000008),
    .O(sig0000000e)
  );
  LUT4 #(
    .INIT ( 16'hE6A2 ))
  blk00000081 (
    .I0(a[23]),
    .I1(a[24]),
    .I2(a[21]),
    .I3(a[22]),
    .O(sig00000088)
  );
  LUT6 #(
    .INIT ( 64'h7636662654144404 ))
  blk00000082 (
    .I0(a[25]),
    .I1(a[23]),
    .I2(a[24]),
    .I3(a[21]),
    .I4(a[22]),
    .I5(sig00000006),
    .O(sig00000089)
  );
  LUT6 #(
    .INIT ( 64'hFFFF544454445444 ))
  blk00000083 (
    .I0(a[26]),
    .I1(sig00000089),
    .I2(sig00000005),
    .I3(a[23]),
    .I4(a[16]),
    .I5(sig00000008),
    .O(sig0000000f)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000084 (
    .I0(a[24]),
    .I1(a[25]),
    .I2(a[20]),
    .I3(a[16]),
    .I4(a[18]),
    .I5(a[22]),
    .O(sig0000008a)
  );
  LUT4 #(
    .INIT ( 16'h8180 ))
  blk00000085 (
    .I0(a[23]),
    .I1(a[24]),
    .I2(a[25]),
    .I3(a[14]),
    .O(sig0000008b)
  );
  LUT5 #(
    .INIT ( 32'hFDF88D88 ))
  blk00000086 (
    .I0(a[26]),
    .I1(sig0000008b),
    .I2(a[23]),
    .I3(sig0000008a),
    .I4(sig00000004),
    .O(sig00000011)
  );
  LUT6 #(
    .INIT ( 64'h7FFFFFFFFFFFFFFF ))
  blk00000087 (
    .I0(a[28]),
    .I1(a[29]),
    .I2(a[27]),
    .I3(a[26]),
    .I4(a[25]),
    .I5(a[24]),
    .O(sig0000008c)
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  blk00000088 (
    .I0(sig0000008c),
    .I1(a[30]),
    .O(sig0000008d)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFEEE55555404 ))
  blk00000089 (
    .I0(sig0000001a),
    .I1(sig00000051),
    .I2(sig00000028),
    .I3(sig00000050),
    .I4(sig0000008d),
    .I5(a[31]),
    .O(sig00000026)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000008a (
    .I0(a[24]),
    .I1(a[21]),
    .I2(a[19]),
    .O(sig0000008e)
  );
  LUT6 #(
    .INIT ( 64'hDC54DC1010541010 ))
  blk0000008b (
    .I0(a[26]),
    .I1(a[25]),
    .I2(sig0000008e),
    .I3(a[24]),
    .I4(a[17]),
    .I5(a[15]),
    .O(sig00000004)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000008c (
    .I0(a[0]),
    .I1(a[10]),
    .I2(a[9]),
    .I3(a[8]),
    .I4(a[7]),
    .I5(a[6]),
    .O(sig0000008f)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000008d (
    .I0(a[4]),
    .I1(a[5]),
    .I2(a[3]),
    .I3(a[2]),
    .I4(a[1]),
    .I5(a[11]),
    .O(sig00000090)
  );
  LUT6 #(
    .INIT ( 64'h0000000000000001 ))
  blk0000008e (
    .I0(a[14]),
    .I1(a[15]),
    .I2(a[13]),
    .I3(a[22]),
    .I4(a[21]),
    .I5(a[20]),
    .O(sig00000091)
  );
  LUT5 #(
    .INIT ( 32'h00000001 ))
  blk0000008f (
    .I0(a[18]),
    .I1(a[19]),
    .I2(a[17]),
    .I3(a[16]),
    .I4(a[12]),
    .O(sig00000092)
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  blk00000090 (
    .I0(sig0000008f),
    .I1(sig00000090),
    .I2(sig00000091),
    .I3(sig00000092),
    .O(sig00000028)
  );
  LUT5 #(
    .INIT ( 32'h1011F5F5 ))
  blk00000091 (
    .I0(a[12]),
    .I1(a[13]),
    .I2(a[23]),
    .I3(a[14]),
    .I4(a[24]),
    .O(sig00000094)
  );
  LUT6 #(
    .INIT ( 64'hD555800080008000 ))
  blk00000092 (
    .I0(sig0000002a),
    .I1(sig00000029),
    .I2(sig00000068),
    .I3(sig00000094),
    .I4(sig00000093),
    .I5(sig0000006a),
    .O(sig00000095)
  );
  LUT6 #(
    .INIT ( 64'h0100010155115511 ))
  blk00000093 (
    .I0(sig0000002a),
    .I1(a[0]),
    .I2(a[1]),
    .I3(a[23]),
    .I4(a[2]),
    .I5(a[24]),
    .O(sig00000096)
  );
  LUT6 #(
    .INIT ( 64'h04000404FF44FF44 ))
  blk00000094 (
    .I0(a[8]),
    .I1(sig0000002a),
    .I2(a[9]),
    .I3(a[23]),
    .I4(a[10]),
    .I5(a[24]),
    .O(sig00000097)
  );
  LUT6 #(
    .INIT ( 64'h02000202AA22AA22 ))
  blk00000095 (
    .I0(sig00000065),
    .I1(a[16]),
    .I2(a[17]),
    .I3(a[23]),
    .I4(a[18]),
    .I5(a[24]),
    .O(sig00000098)
  );
  LUT5 #(
    .INIT ( 32'h1011F5F5 ))
  blk00000096 (
    .I0(a[20]),
    .I1(a[21]),
    .I2(a[23]),
    .I3(a[22]),
    .I4(a[24]),
    .O(sig00000099)
  );
  LUT6 #(
    .INIT ( 64'hFFD5AAD5FF80AA80 ))
  blk00000097 (
    .I0(sig00000029),
    .I1(sig00000067),
    .I2(sig00000099),
    .I3(sig0000002a),
    .I4(sig00000066),
    .I5(sig00000098),
    .O(sig0000005f)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000098 (
    .I0(sig00000036),
    .O(sig0000009a)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000099 (
    .I0(sig00000062),
    .O(sig0000009b)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk0000009a (
    .I0(sig00000062),
    .O(sig0000009c)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk0000009b (
    .I0(sig00000064),
    .O(sig0000009d)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk0000009c (
    .I0(sig00000063),
    .O(sig0000009e)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk0000009d (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig00000038),
    .I4(sig00000041),
    .O(sig0000001d)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk0000009e (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig00000039),
    .I4(sig00000041),
    .O(sig0000001e)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk0000009f (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig0000003c),
    .I4(sig00000041),
    .O(sig00000021)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000000a0 (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig0000003b),
    .I4(sig00000041),
    .O(sig00000020)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000000a1 (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig0000003a),
    .I4(sig00000041),
    .O(sig0000001f)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000000a2 (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig0000003e),
    .I4(sig00000041),
    .O(sig00000023)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000000a3 (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig0000003d),
    .I4(sig00000041),
    .O(sig00000022)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000000a4 (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig0000003f),
    .I4(sig00000041),
    .O(sig00000024)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000000a5 (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig00000040),
    .I4(sig00000041),
    .O(sig00000025)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000000a6 (
    .I0(sig0000004e),
    .I1(sig0000004f),
    .I2(sig00000036),
    .I3(sig00000037),
    .I4(sig00000041),
    .O(sig0000001c)
  );
  LUT6 #(
    .INIT ( 64'h4444446400000020 ))
  blk000000a7 (
    .I0(a[26]),
    .I1(a[25]),
    .I2(a[19]),
    .I3(a[23]),
    .I4(a[24]),
    .I5(sig0000007d),
    .O(sig0000000c)
  );
  LUT6 #(
    .INIT ( 64'h4444446400000020 ))
  blk000000a8 (
    .I0(a[26]),
    .I1(a[25]),
    .I2(a[20]),
    .I3(a[23]),
    .I4(a[24]),
    .I5(sig00000088),
    .O(sig0000000b)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk000000a9 (
    .I0(a[25]),
    .I1(a[24]),
    .I2(a[16]),
    .I3(a[14]),
    .I4(a[18]),
    .I5(a[20]),
    .O(sig0000007e)
  );
  LUT6 #(
    .INIT ( 64'h5555555D00000008 ))
  blk000000aa (
    .I0(a[26]),
    .I1(a[18]),
    .I2(a[23]),
    .I3(a[24]),
    .I4(a[25]),
    .I5(sig00000085),
    .O(sig0000000d)
  );
  LUT6 #(
    .INIT ( 64'h04FF04FF00110411 ))
  blk000000ab (
    .I0(a[4]),
    .I1(a[25]),
    .I2(a[5]),
    .I3(a[24]),
    .I4(a[6]),
    .I5(a[23]),
    .O(sig00000093)
  );
  LUT5 #(
    .INIT ( 32'h7FFFFFFF ))
  blk000000ac (
    .I0(sig00000050),
    .I1(sig0000008f),
    .I2(sig00000090),
    .I3(sig00000091),
    .I4(sig00000092),
    .O(sig00000007)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFF66666000 ))
  blk000000ad (
    .I0(a[25]),
    .I1(a[24]),
    .I2(sig00000097),
    .I3(sig00000069),
    .I4(sig00000096),
    .I5(sig00000095),
    .O(sig00000060)
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
