////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.68d
//  \   \         Application: netgen
//  /   /         Filename: en_fix2flo.v
// /___/   /\     Timestamp: Thu Nov 17 17:03:26 2016
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog "C:/Users/Yuan Ruyue/Desktop/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_fix2flo.ngc" "C:/Users/Yuan Ruyue/Desktop/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_fix2flo.v" 
// Device	: 6slx45fgg484-2
// Input file	: C:/Users/Yuan Ruyue/Desktop/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_fix2flo.ngc
// Output file	: C:/Users/Yuan Ruyue/Desktop/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_fix2flo.v
// # of Modules	: 1
// Design Name	: en_fix2flo
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

module en_fix2flo (
  operation_nd, clk, rdy, a, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  output rdy;
  input [10 : 0] a;
  output [31 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[3] ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[2] ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[1] ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[0] ;
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
  wire sig0000009f;
  wire sig000000a0;
  wire sig000000a1;
  wire sig000000a2;
  wire NLW_blk00000027_O_UNCONNECTED;
  wire NLW_blk0000003a_O_UNCONNECTED;
  wire NLW_blk0000003c_O_UNCONNECTED;
  wire NLW_blk0000003e_O_UNCONNECTED;
  wire NLW_blk00000040_O_UNCONNECTED;
  wire NLW_blk00000042_O_UNCONNECTED;
  wire NLW_blk00000044_O_UNCONNECTED;
  wire NLW_blk00000046_O_UNCONNECTED;
  wire NLW_blk00000048_O_UNCONNECTED;
  wire NLW_blk0000004a_O_UNCONNECTED;
  wire NLW_blk0000004c_O_UNCONNECTED;
  wire NLW_blk0000004e_O_UNCONNECTED;
  wire NLW_blk00000050_O_UNCONNECTED;
  wire NLW_blk00000065_O_UNCONNECTED;
  wire NLW_blk00000067_O_UNCONNECTED;
  wire NLW_blk000000c0_Q15_UNCONNECTED;
  wire NLW_blk000000c2_Q15_UNCONNECTED;
  wire [6 : 6] \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op ;
  wire [22 : 14] \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op ;
  wire [0 : 0] NlwRenamedSig_OI_result;
  assign
    result[31] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op ,
    result[30] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] ,
    result[29] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
    result[28] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
    result[27] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
    result[26] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[3] ,
    result[25] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[2] ,
    result[24] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[1] ,
    result[23] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[0] ,
    result[22] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [22],
    result[21] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [21],
    result[20] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [20],
    result[19] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [19],
    result[18] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [18],
    result[17] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [17],
    result[16] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [16],
    result[15] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [15],
    result[14] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [14],
    result[13] = NlwRenamedSig_OI_result[0],
    result[12] = NlwRenamedSig_OI_result[0],
    result[11] = NlwRenamedSig_OI_result[0],
    result[10] = NlwRenamedSig_OI_result[0],
    result[9] = NlwRenamedSig_OI_result[0],
    result[8] = NlwRenamedSig_OI_result[0],
    result[7] = NlwRenamedSig_OI_result[0],
    result[6] = NlwRenamedSig_OI_result[0],
    result[5] = NlwRenamedSig_OI_result[0],
    result[4] = NlwRenamedSig_OI_result[0],
    result[3] = NlwRenamedSig_OI_result[0],
    result[2] = NlwRenamedSig_OI_result[0],
    result[1] = NlwRenamedSig_OI_result[0],
    result[0] = NlwRenamedSig_OI_result[0],
    rdy = \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(sig00000001)
  );
  GND   blk00000002 (
    .G(NlwRenamedSig_OI_result[0])
  );
  MUXCY   blk00000003 (
    .CI(sig00000002),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig00000004)
  );
  MUXCY   blk00000004 (
    .CI(sig00000003),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000002)
  );
  MUXCY   blk00000005 (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000003)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000006 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000025),
    .Q(sig00000046)
  );
  XORCY   blk00000007 (
    .CI(sig00000049),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(sig00000047)
  );
  XORCY   blk00000008 (
    .CI(sig0000004b),
    .LI(sig00000040),
    .O(sig00000048)
  );
  MUXCY   blk00000009 (
    .CI(sig0000004b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000040),
    .O(sig00000049)
  );
  XORCY   blk0000000a (
    .CI(sig0000004d),
    .LI(sig0000003f),
    .O(sig0000004a)
  );
  MUXCY   blk0000000b (
    .CI(sig0000004d),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003f),
    .O(sig0000004b)
  );
  XORCY   blk0000000c (
    .CI(sig0000004f),
    .LI(sig0000003e),
    .O(sig0000004c)
  );
  MUXCY   blk0000000d (
    .CI(sig0000004f),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003e),
    .O(sig0000004d)
  );
  XORCY   blk0000000e (
    .CI(sig00000051),
    .LI(sig0000003d),
    .O(sig0000004e)
  );
  MUXCY   blk0000000f (
    .CI(sig00000051),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003d),
    .O(sig0000004f)
  );
  XORCY   blk00000010 (
    .CI(sig00000053),
    .LI(sig0000003c),
    .O(sig00000050)
  );
  MUXCY   blk00000011 (
    .CI(sig00000053),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003c),
    .O(sig00000051)
  );
  XORCY   blk00000012 (
    .CI(sig00000055),
    .LI(sig0000003b),
    .O(sig00000052)
  );
  MUXCY   blk00000013 (
    .CI(sig00000055),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003b),
    .O(sig00000053)
  );
  XORCY   blk00000014 (
    .CI(sig00000057),
    .LI(sig0000003a),
    .O(sig00000054)
  );
  MUXCY   blk00000015 (
    .CI(sig00000057),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003a),
    .O(sig00000055)
  );
  XORCY   blk00000016 (
    .CI(sig00000059),
    .LI(sig00000039),
    .O(sig00000056)
  );
  MUXCY   blk00000017 (
    .CI(sig00000059),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000039),
    .O(sig00000057)
  );
  XORCY   blk00000018 (
    .CI(sig0000005b),
    .LI(sig00000038),
    .O(sig00000058)
  );
  MUXCY   blk00000019 (
    .CI(sig0000005b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000038),
    .O(sig00000059)
  );
  XORCY   blk0000001a (
    .CI(a[10]),
    .LI(sig00000037),
    .O(sig0000005a)
  );
  MUXCY   blk0000001b (
    .CI(a[10]),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000037),
    .O(sig0000005b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001c (
    .C(clk),
    .D(sig00000047),
    .Q(sig00000036)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001d (
    .C(clk),
    .D(sig00000048),
    .Q(sig00000035)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001e (
    .C(clk),
    .D(sig0000004a),
    .Q(sig00000034)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000001f (
    .C(clk),
    .D(sig0000004c),
    .Q(sig00000033)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000020 (
    .C(clk),
    .D(sig0000004e),
    .Q(sig00000032)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000021 (
    .C(clk),
    .D(sig00000050),
    .Q(sig00000031)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000022 (
    .C(clk),
    .D(sig00000052),
    .Q(sig00000030)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000023 (
    .C(clk),
    .D(sig00000054),
    .Q(sig0000002f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000024 (
    .C(clk),
    .D(sig00000056),
    .Q(sig0000002e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000025 (
    .C(clk),
    .D(sig00000058),
    .Q(sig0000002d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000026 (
    .C(clk),
    .D(sig0000005a),
    .Q(sig0000002c)
  );
  MUXF7   blk00000027 (
    .I0(sig0000005c),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig0000002b),
    .O(NLW_blk00000027_O_UNCONNECTED)
  );
  MUXF7   blk00000028 (
    .I0(sig0000005d),
    .I1(sig0000009e),
    .S(sig0000002b),
    .O(sig00000028)
  );
  MUXF7   blk00000029 (
    .I0(sig0000005e),
    .I1(sig00000060),
    .S(sig0000002b),
    .O(sig00000029)
  );
  MUXCY   blk0000002a (
    .CI(NlwRenamedSig_OI_result[0]),
    .DI(sig00000001),
    .S(sig00000063),
    .O(sig00000064)
  );
  MUXCY   blk0000002b (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000061),
    .O(sig00000065)
  );
  MUXCY   blk0000002c (
    .CI(sig00000065),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000062),
    .O(sig0000002b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002d (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002b),
    .Q(sig00000008)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002e (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002a),
    .Q(sig00000027)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000002f (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000029),
    .Q(sig00000012)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000030 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000028),
    .Q(sig00000026)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000031 (
    .C(clk),
    .D(sig00000009),
    .Q(sig0000001c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000032 (
    .C(clk),
    .D(sig0000000a),
    .Q(sig0000001d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000033 (
    .C(clk),
    .D(sig0000000b),
    .Q(sig0000001e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000034 (
    .C(clk),
    .D(sig0000000c),
    .Q(sig0000001f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000035 (
    .C(clk),
    .D(sig0000000d),
    .Q(sig00000020)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000036 (
    .C(clk),
    .D(sig0000000e),
    .Q(sig00000021)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000037 (
    .C(clk),
    .D(sig0000000f),
    .Q(sig00000022)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .D(sig00000010),
    .Q(sig00000023)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000039 (
    .C(clk),
    .D(sig00000011),
    .Q(sig00000024)
  );
  XORCY   blk0000003a (
    .CI(sig00000066),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000003a_O_UNCONNECTED)
  );
  MUXCY   blk0000003b (
    .CI(sig00000066),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000005)
  );
  XORCY   blk0000003c (
    .CI(sig00000067),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000003c_O_UNCONNECTED)
  );
  MUXCY   blk0000003d (
    .CI(sig00000067),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000066)
  );
  XORCY   blk0000003e (
    .CI(sig00000068),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000003e_O_UNCONNECTED)
  );
  MUXCY   blk0000003f (
    .CI(sig00000068),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000067)
  );
  XORCY   blk00000040 (
    .CI(sig00000069),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000040_O_UNCONNECTED)
  );
  MUXCY   blk00000041 (
    .CI(sig00000069),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000068)
  );
  XORCY   blk00000042 (
    .CI(sig0000006a),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000042_O_UNCONNECTED)
  );
  MUXCY   blk00000043 (
    .CI(sig0000006a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000069)
  );
  XORCY   blk00000044 (
    .CI(sig0000006b),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000044_O_UNCONNECTED)
  );
  MUXCY   blk00000045 (
    .CI(sig0000006b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006a)
  );
  XORCY   blk00000046 (
    .CI(sig0000006c),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000046_O_UNCONNECTED)
  );
  MUXCY   blk00000047 (
    .CI(sig0000006c),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006b)
  );
  XORCY   blk00000048 (
    .CI(sig0000006d),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000048_O_UNCONNECTED)
  );
  MUXCY   blk00000049 (
    .CI(sig0000006d),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006c)
  );
  XORCY   blk0000004a (
    .CI(sig0000006e),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000004a_O_UNCONNECTED)
  );
  MUXCY   blk0000004b (
    .CI(sig0000006e),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006d)
  );
  XORCY   blk0000004c (
    .CI(sig0000006f),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000004c_O_UNCONNECTED)
  );
  MUXCY   blk0000004d (
    .CI(sig0000006f),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006e)
  );
  XORCY   blk0000004e (
    .CI(sig00000070),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000004e_O_UNCONNECTED)
  );
  MUXCY   blk0000004f (
    .CI(sig00000070),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006f)
  );
  XORCY   blk00000050 (
    .CI(sig00000004),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000050_O_UNCONNECTED)
  );
  MUXCY   blk00000051 (
    .CI(sig00000004),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000070)
  );
  XORCY   blk00000052 (
    .CI(sig00000071),
    .LI(sig00000001),
    .O(sig00000006)
  );
  XORCY   blk00000053 (
    .CI(sig00000072),
    .LI(sig00000088),
    .O(sig0000001b)
  );
  MUXCY   blk00000054 (
    .CI(sig00000072),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000088),
    .O(sig00000071)
  );
  XORCY   blk00000055 (
    .CI(sig00000073),
    .LI(sig00000089),
    .O(sig0000001a)
  );
  MUXCY   blk00000056 (
    .CI(sig00000073),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000089),
    .O(sig00000072)
  );
  XORCY   blk00000057 (
    .CI(sig00000074),
    .LI(sig0000008a),
    .O(sig00000019)
  );
  MUXCY   blk00000058 (
    .CI(sig00000074),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000008a),
    .O(sig00000073)
  );
  XORCY   blk00000059 (
    .CI(sig00000075),
    .LI(sig0000008b),
    .O(sig00000018)
  );
  MUXCY   blk0000005a (
    .CI(sig00000075),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000008b),
    .O(sig00000074)
  );
  XORCY   blk0000005b (
    .CI(sig00000076),
    .LI(sig0000008c),
    .O(sig00000017)
  );
  MUXCY   blk0000005c (
    .CI(sig00000076),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000008c),
    .O(sig00000075)
  );
  XORCY   blk0000005d (
    .CI(sig00000077),
    .LI(sig0000008d),
    .O(sig00000016)
  );
  MUXCY   blk0000005e (
    .CI(sig00000077),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000008d),
    .O(sig00000076)
  );
  XORCY   blk0000005f (
    .CI(sig00000078),
    .LI(sig0000008e),
    .O(sig00000015)
  );
  MUXCY   blk00000060 (
    .CI(sig00000078),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000008e),
    .O(sig00000077)
  );
  XORCY   blk00000061 (
    .CI(sig00000079),
    .LI(sig0000008f),
    .O(sig00000014)
  );
  MUXCY   blk00000062 (
    .CI(sig00000079),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000008f),
    .O(sig00000078)
  );
  XORCY   blk00000063 (
    .CI(sig0000007a),
    .LI(sig00000090),
    .O(sig00000013)
  );
  MUXCY   blk00000064 (
    .CI(sig0000007a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000090),
    .O(sig00000079)
  );
  XORCY   blk00000065 (
    .CI(sig0000007b),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000065_O_UNCONNECTED)
  );
  MUXCY   blk00000066 (
    .CI(sig0000007b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000007a)
  );
  XORCY   blk00000067 (
    .CI(sig00000005),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000067_O_UNCONNECTED)
  );
  MUXCY   blk00000068 (
    .CI(sig00000005),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000007b)
  );
  FD   blk00000069 (
    .C(clk),
    .D(sig00000084),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [22])
  );
  FD   blk0000006a (
    .C(clk),
    .D(sig00000083),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [21])
  );
  FD   blk0000006b (
    .C(clk),
    .D(sig00000082),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [20])
  );
  FD   blk0000006c (
    .C(clk),
    .D(sig00000081),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [19])
  );
  FD   blk0000006d (
    .C(clk),
    .D(sig00000080),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [18])
  );
  FD   blk0000006e (
    .C(clk),
    .D(sig0000007f),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [17])
  );
  FD   blk0000006f (
    .C(clk),
    .D(sig0000007e),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [16])
  );
  FD   blk00000070 (
    .C(clk),
    .D(sig0000007d),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [15])
  );
  FD   blk00000071 (
    .C(clk),
    .D(sig0000007c),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [14])
  );
  LUT3 #(
    .INIT ( 8'h14 ))
  blk00000072 (
    .I0(sig00000046),
    .I1(sig00000026),
    .I2(sig00000006),
    .O(sig00000007)
  );
  LUT6 #(
    .INIT ( 64'h0101011155555555 ))
  blk00000073 (
    .I0(sig00000046),
    .I1(sig00000027),
    .I2(sig00000012),
    .I3(sig00000006),
    .I4(sig00000026),
    .I5(sig00000008),
    .O(sig00000045)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000074 (
    .I0(a[0]),
    .I1(a[10]),
    .O(sig00000037)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000075 (
    .I0(a[1]),
    .I1(a[10]),
    .O(sig00000038)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000076 (
    .I0(a[2]),
    .I1(a[10]),
    .O(sig00000039)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000077 (
    .I0(a[3]),
    .I1(a[10]),
    .O(sig0000003a)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000078 (
    .I0(a[4]),
    .I1(a[10]),
    .O(sig0000003b)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000079 (
    .I0(a[5]),
    .I1(a[10]),
    .O(sig0000003c)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000007a (
    .I0(a[6]),
    .I1(a[10]),
    .O(sig0000003d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000007b (
    .I0(a[7]),
    .I1(a[10]),
    .O(sig0000003e)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000007c (
    .I0(a[8]),
    .I1(a[10]),
    .O(sig0000003f)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000007d (
    .I0(a[9]),
    .I1(a[10]),
    .O(sig00000040)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000007e (
    .I0(sig0000002b),
    .I1(sig00000065),
    .O(sig0000005c)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000007f (
    .I0(sig00000036),
    .I1(sig00000035),
    .I2(sig00000034),
    .I3(sig00000033),
    .O(sig00000061)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000080 (
    .I0(sig00000032),
    .I1(sig00000031),
    .I2(sig00000030),
    .I3(sig0000002f),
    .O(sig00000062)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  blk00000081 (
    .I0(sig0000002c),
    .I1(sig0000002e),
    .I2(sig0000002d),
    .O(sig00000063)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000082 (
    .I0(sig00000046),
    .I1(sig00000014),
    .O(sig0000007d)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000083 (
    .I0(sig00000046),
    .I1(sig00000015),
    .O(sig0000007e)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000084 (
    .I0(sig00000046),
    .I1(sig00000013),
    .O(sig0000007c)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000085 (
    .I0(sig00000046),
    .I1(sig00000017),
    .O(sig00000080)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000086 (
    .I0(sig00000046),
    .I1(sig00000018),
    .O(sig00000081)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000087 (
    .I0(sig00000046),
    .I1(sig00000016),
    .O(sig0000007f)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000088 (
    .I0(sig00000046),
    .I1(sig0000001a),
    .O(sig00000083)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000089 (
    .I0(sig00000046),
    .I1(sig00000019),
    .O(sig00000082)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000008a (
    .I0(sig00000046),
    .I1(sig0000001b),
    .O(sig00000084)
  );
  LUT4 #(
    .INIT ( 16'hAEAF ))
  blk0000008b (
    .I0(sig00000032),
    .I1(sig00000030),
    .I2(sig00000031),
    .I3(sig0000002f),
    .O(sig00000086)
  );
  LUT6 #(
    .INIT ( 64'h0000FFFF44544454 ))
  blk0000008c (
    .I0(sig00000036),
    .I1(sig00000035),
    .I2(sig00000033),
    .I3(sig00000034),
    .I4(sig00000086),
    .I5(sig00000065),
    .O(sig0000005d)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk0000008d (
    .I0(sig00000032),
    .I1(sig00000030),
    .I2(sig0000002f),
    .I3(sig00000031),
    .O(sig00000087)
  );
  LUT6 #(
    .INIT ( 64'h0000FFFF00540054 ))
  blk0000008e (
    .I0(sig00000036),
    .I1(sig00000034),
    .I2(sig00000033),
    .I3(sig00000035),
    .I4(sig00000087),
    .I5(sig00000065),
    .O(sig0000005e)
  );
  FD   blk0000008f (
    .C(clk),
    .D(sig00000045),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] )
  );
  FD   blk00000090 (
    .C(clk),
    .D(sig00000044),
    .Q(\NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6])
  );
  FD   blk00000091 (
    .C(clk),
    .D(sig00000043),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[3] )
  );
  FD   blk00000092 (
    .C(clk),
    .D(sig00000042),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[2] )
  );
  FD   blk00000093 (
    .C(clk),
    .D(sig00000041),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[1] )
  );
  FD   blk00000094 (
    .C(clk),
    .D(sig00000007),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[0] )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000095 (
    .I0(sig00000024),
    .O(sig00000088)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000096 (
    .I0(sig00000023),
    .O(sig00000089)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000097 (
    .I0(sig00000022),
    .O(sig0000008a)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000098 (
    .I0(sig00000021),
    .O(sig0000008b)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000099 (
    .I0(sig00000020),
    .O(sig0000008c)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk0000009a (
    .I0(sig0000001f),
    .O(sig0000008d)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk0000009b (
    .I0(sig0000001e),
    .O(sig0000008e)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk0000009c (
    .I0(sig0000001d),
    .O(sig0000008f)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk0000009d (
    .I0(sig0000001c),
    .O(sig00000090)
  );
  LUT6 #(
    .INIT ( 64'h55550F0F333300FF ))
  blk0000009e (
    .I0(sig00000092),
    .I1(sig00000091),
    .I2(sig00000098),
    .I3(sig00000097),
    .I4(sig00000029),
    .I5(sig00000028),
    .O(sig0000000c)
  );
  LUT6 #(
    .INIT ( 64'h00FFCCCC0F0FAAAA ))
  blk0000009f (
    .I0(sig00000093),
    .I1(sig00000085),
    .I2(sig00000099),
    .I3(sig00000095),
    .I4(sig00000029),
    .I5(sig00000028),
    .O(sig00000011)
  );
  LUT6 #(
    .INIT ( 64'h0F0F333300FFAAAA ))
  blk000000a0 (
    .I0(sig00000085),
    .I1(sig00000099),
    .I2(sig00000096),
    .I3(sig00000095),
    .I4(sig00000029),
    .I5(sig00000028),
    .O(sig00000010)
  );
  LUT6 #(
    .INIT ( 64'h55550F0F333300FF ))
  blk000000a1 (
    .I0(sig00000094),
    .I1(sig00000098),
    .I2(sig00000097),
    .I3(sig00000096),
    .I4(sig00000029),
    .I5(sig00000028),
    .O(sig0000000d)
  );
  LUT6 #(
    .INIT ( 64'h5555333300FF0F0F ))
  blk000000a2 (
    .I0(sig00000098),
    .I1(sig00000096),
    .I2(sig00000095),
    .I3(sig00000097),
    .I4(sig00000029),
    .I5(sig00000028),
    .O(sig0000000e)
  );
  LUT6 #(
    .INIT ( 64'h0F0F333300FF5555 ))
  blk000000a3 (
    .I0(sig00000099),
    .I1(sig00000095),
    .I2(sig00000097),
    .I3(sig00000096),
    .I4(sig00000029),
    .I5(sig00000028),
    .O(sig0000000f)
  );
  LUT6 #(
    .INIT ( 64'h0000000A0000000C ))
  blk000000a4 (
    .I0(sig0000002c),
    .I1(sig0000002d),
    .I2(sig00000065),
    .I3(sig0000002b),
    .I4(sig00000029),
    .I5(sig00000028),
    .O(sig00000009)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk000000a5 (
    .I0(sig0000002e),
    .I1(sig0000002d),
    .O(sig0000009a)
  );
  MUXCY   blk000000a6 (
    .CI(sig00000064),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000009a),
    .O(sig0000005f)
  );
  LUT4 #(
    .INIT ( 16'h0200 ))
  blk000000a7 (
    .I0(sig0000002c),
    .I1(sig0000002e),
    .I2(sig0000002d),
    .I3(sig00000064),
    .O(sig00000060)
  );
  LUT6 #(
    .INIT ( 64'hF000F000CCCCAAAA ))
  blk000000a8 (
    .I0(sig00000034),
    .I1(sig00000030),
    .I2(sig0000002c),
    .I3(sig00000064),
    .I4(sig00000065),
    .I5(sig0000002b),
    .O(sig00000085)
  );
  LUT6 #(
    .INIT ( 64'hF000F000CCCCAAAA ))
  blk000000a9 (
    .I0(sig00000035),
    .I1(sig00000031),
    .I2(sig0000002d),
    .I3(sig00000064),
    .I4(sig00000065),
    .I5(sig0000002b),
    .O(sig00000093)
  );
  LUT3 #(
    .INIT ( 8'h72 ))
  blk000000aa (
    .I0(sig0000002b),
    .I1(sig00000064),
    .I2(sig00000065),
    .O(sig0000002a)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk000000ab (
    .I0(sig00000064),
    .I1(sig0000002b),
    .O(sig00000025)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk000000ac (
    .I0(sig0000002e),
    .I1(sig00000065),
    .O(sig0000009b)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk000000ad (
    .I0(sig0000002d),
    .I1(sig00000065),
    .O(sig0000009c)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk000000ae (
    .I0(sig0000002c),
    .I1(sig00000065),
    .O(sig0000009d)
  );
  LUT6 #(
    .INIT ( 64'h0000111100550505 ))
  blk000000af (
    .I0(sig0000002b),
    .I1(sig0000009c),
    .I2(sig0000009b),
    .I3(sig0000009d),
    .I4(sig00000029),
    .I5(sig00000028),
    .O(sig0000000a)
  );
  LUT4 #(
    .INIT ( 16'hFF35 ))
  blk000000b0 (
    .I0(sig00000032),
    .I1(sig0000002e),
    .I2(sig00000065),
    .I3(sig0000002b),
    .O(sig00000095)
  );
  LUT4 #(
    .INIT ( 16'hFF35 ))
  blk000000b1 (
    .I0(sig00000031),
    .I1(sig0000002d),
    .I2(sig00000065),
    .I3(sig0000002b),
    .O(sig00000096)
  );
  LUT4 #(
    .INIT ( 16'hFF35 ))
  blk000000b2 (
    .I0(sig00000030),
    .I1(sig0000002c),
    .I2(sig00000065),
    .I3(sig0000002b),
    .O(sig00000097)
  );
  LUT3 #(
    .INIT ( 8'hFD ))
  blk000000b3 (
    .I0(sig0000002f),
    .I1(sig00000065),
    .I2(sig0000002b),
    .O(sig00000098)
  );
  LUT4 #(
    .INIT ( 16'hFF35 ))
  blk000000b4 (
    .I0(sig00000033),
    .I1(sig0000002f),
    .I2(sig00000065),
    .I3(sig0000002b),
    .O(sig00000099)
  );
  LUT3 #(
    .INIT ( 8'hFD ))
  blk000000b5 (
    .I0(sig0000002e),
    .I1(sig00000065),
    .I2(sig0000002b),
    .O(sig00000091)
  );
  LUT3 #(
    .INIT ( 8'hFD ))
  blk000000b6 (
    .I0(sig0000002d),
    .I1(sig00000065),
    .I2(sig0000002b),
    .O(sig00000092)
  );
  LUT4 #(
    .INIT ( 16'h4441 ))
  blk000000b7 (
    .I0(sig00000046),
    .I1(sig00000012),
    .I2(sig00000026),
    .I3(sig00000006),
    .O(sig00000041)
  );
  LUT6 #(
    .INIT ( 64'h4444444440404000 ))
  blk000000b8 (
    .I0(sig00000046),
    .I1(sig00000008),
    .I2(sig00000012),
    .I3(sig00000026),
    .I4(sig00000006),
    .I5(sig00000027),
    .O(sig00000044)
  );
  LUT5 #(
    .INIT ( 32'h14141444 ))
  blk000000b9 (
    .I0(sig00000046),
    .I1(sig00000027),
    .I2(sig00000012),
    .I3(sig00000026),
    .I4(sig00000006),
    .O(sig00000042)
  );
  LUT6 #(
    .INIT ( 64'h4441444144414141 ))
  blk000000ba (
    .I0(sig00000046),
    .I1(sig00000008),
    .I2(sig00000027),
    .I3(sig00000012),
    .I4(sig00000026),
    .I5(sig00000006),
    .O(sig00000043)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000000bb (
    .I0(sig0000005f),
    .O(sig0000009e)
  );
  LUT3 #(
    .INIT ( 8'hFB ))
  blk000000bc (
    .I0(sig00000065),
    .I1(sig0000002e),
    .I2(sig0000002b),
    .O(sig00000094)
  );
  MUXF7   blk000000bd (
    .I0(sig0000009f),
    .I1(sig000000a0),
    .S(sig00000029),
    .O(sig0000000b)
  );
  LUT5 #(
    .INIT ( 32'h11100100 ))
  blk000000be (
    .I0(sig00000065),
    .I1(sig0000002b),
    .I2(sig00000028),
    .I3(sig0000002f),
    .I4(sig0000002e),
    .O(sig0000009f)
  );
  LUT5 #(
    .INIT ( 32'h11100100 ))
  blk000000bf (
    .I0(sig00000065),
    .I1(sig0000002b),
    .I2(sig00000028),
    .I3(sig0000002d),
    .I4(sig0000002c),
    .O(sig000000a0)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000c0 (
    .A0(sig00000001),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(NlwRenamedSig_OI_result[0]),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(sig00000001),
    .CLK(clk),
    .D(a[10]),
    .Q(sig000000a1),
    .Q15(NLW_blk000000c0_Q15_UNCONNECTED)
  );
  FDE   blk000000c1 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a1),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op )
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000000c2 (
    .A0(sig00000001),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(NlwRenamedSig_OI_result[0]),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(sig00000001),
    .CLK(clk),
    .D(operation_nd),
    .Q(sig000000a2),
    .Q15(NLW_blk000000c2_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000c3 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a2),
    .Q(\U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
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
