////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.68d
//  \   \         Application: netgen
//  /   /         Filename: int8tofloat32.v
// /___/   /\     Timestamp: Fri Nov 04 15:30:25 2016
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog D:/User/Desktop/OT_prj/ipcore/tmp/_cg/int8tofloat32.ngc D:/User/Desktop/OT_prj/ipcore/tmp/_cg/int8tofloat32.v 
// Device	: 6slx45fgg484-2
// Input file	: D:/User/Desktop/OT_prj/ipcore/tmp/_cg/int8tofloat32.ngc
// Output file	: D:/User/Desktop/OT_prj/ipcore/tmp/_cg/int8tofloat32.v
// # of Modules	: 1
// Design Name	: int8tofloat32
// Xilinx        : D:\Xilinx\14.6\ISE_DS\ISE\
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

module int8tofloat32 (
  clk, sclr, a, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input clk;
  input sclr;
  input [8 : 0] a;
  output [31 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[2] ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[1] ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[0] ;
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
  wire NLW_blk00000018_O_UNCONNECTED;
  wire NLW_blk0000002b_O_UNCONNECTED;
  wire NLW_blk0000002d_O_UNCONNECTED;
  wire NLW_blk0000002f_O_UNCONNECTED;
  wire NLW_blk00000031_O_UNCONNECTED;
  wire NLW_blk00000033_O_UNCONNECTED;
  wire NLW_blk00000035_O_UNCONNECTED;
  wire NLW_blk00000037_O_UNCONNECTED;
  wire NLW_blk00000039_O_UNCONNECTED;
  wire NLW_blk0000003b_O_UNCONNECTED;
  wire NLW_blk0000003d_O_UNCONNECTED;
  wire NLW_blk0000003f_O_UNCONNECTED;
  wire NLW_blk00000041_O_UNCONNECTED;
  wire NLW_blk00000052_O_UNCONNECTED;
  wire NLW_blk00000054_O_UNCONNECTED;
  wire NLW_blk00000056_O_UNCONNECTED;
  wire NLW_blk00000058_O_UNCONNECTED;
  wire [6 : 6] \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op ;
  wire [22 : 16] \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op ;
  wire [0 : 0] NlwRenamedSig_OI_result;
  assign
    result[31] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op ,
    result[30] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] ,
    result[29] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
    result[28] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
    result[27] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
    result[26] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
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
    result[15] = NlwRenamedSig_OI_result[0],
    result[14] = NlwRenamedSig_OI_result[0],
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
    result[0] = NlwRenamedSig_OI_result[0];
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
    .D(a[8]),
    .Q(sig0000003f)
  );
  XORCY   blk00000007 (
    .CI(sig00000044),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(sig00000036)
  );
  XORCY   blk00000008 (
    .CI(sig00000045),
    .LI(sig0000003e),
    .O(sig00000035)
  );
  MUXCY   blk00000009 (
    .CI(sig00000045),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003e),
    .O(sig00000044)
  );
  XORCY   blk0000000a (
    .CI(sig00000046),
    .LI(sig0000003d),
    .O(sig00000034)
  );
  MUXCY   blk0000000b (
    .CI(sig00000046),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003d),
    .O(sig00000045)
  );
  XORCY   blk0000000c (
    .CI(sig00000047),
    .LI(sig0000003c),
    .O(sig00000033)
  );
  MUXCY   blk0000000d (
    .CI(sig00000047),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003c),
    .O(sig00000046)
  );
  XORCY   blk0000000e (
    .CI(sig00000048),
    .LI(sig0000003b),
    .O(sig00000032)
  );
  MUXCY   blk0000000f (
    .CI(sig00000048),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003b),
    .O(sig00000047)
  );
  XORCY   blk00000010 (
    .CI(sig00000049),
    .LI(sig0000003a),
    .O(sig00000031)
  );
  MUXCY   blk00000011 (
    .CI(sig00000049),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000003a),
    .O(sig00000048)
  );
  XORCY   blk00000012 (
    .CI(sig0000004a),
    .LI(sig00000039),
    .O(sig00000030)
  );
  MUXCY   blk00000013 (
    .CI(sig0000004a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000039),
    .O(sig00000049)
  );
  XORCY   blk00000014 (
    .CI(sig0000004b),
    .LI(sig00000038),
    .O(sig0000002f)
  );
  MUXCY   blk00000015 (
    .CI(sig0000004b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000038),
    .O(sig0000004a)
  );
  XORCY   blk00000016 (
    .CI(a[8]),
    .LI(sig00000037),
    .O(sig0000002e)
  );
  MUXCY   blk00000017 (
    .CI(a[8]),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000037),
    .O(sig0000004b)
  );
  MUXF7   blk00000018 (
    .I0(sig0000004c),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig0000002d),
    .O(NLW_blk00000018_O_UNCONNECTED)
  );
  MUXF7   blk00000019 (
    .I0(sig0000004d),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig0000002d),
    .O(sig0000004f)
  );
  MUXF7   blk0000001a (
    .I0(sig0000004e),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig0000002d),
    .O(sig00000050)
  );
  MUXCY   blk0000001b (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000054),
    .O(sig00000055)
  );
  MUXCY   blk0000001c (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000051),
    .O(sig00000056)
  );
  MUXCY   blk0000001d (
    .CI(sig00000056),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000052),
    .O(sig0000002d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001e (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002d),
    .Q(sig00000018)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000001f (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002c),
    .Q(sig0000002b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000020 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000004f),
    .Q(sig00000029)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000021 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000050),
    .Q(sig0000002a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000022 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000053),
    .Q(sig00000028)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000023 (
    .C(clk),
    .D(sig00000010),
    .Q(sig00000008)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000024 (
    .C(clk),
    .D(sig00000011),
    .Q(sig00000009)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000025 (
    .C(clk),
    .D(sig00000012),
    .Q(sig0000000a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000026 (
    .C(clk),
    .D(sig00000013),
    .Q(sig0000000b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000027 (
    .C(clk),
    .D(sig00000014),
    .Q(sig0000000c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000028 (
    .C(clk),
    .D(sig00000015),
    .Q(sig0000000d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000029 (
    .C(clk),
    .D(sig00000016),
    .Q(sig0000000e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000002a (
    .C(clk),
    .D(sig00000017),
    .Q(sig0000000f)
  );
  XORCY   blk0000002b (
    .CI(sig00000057),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000002b_O_UNCONNECTED)
  );
  MUXCY   blk0000002c (
    .CI(sig00000057),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000005)
  );
  XORCY   blk0000002d (
    .CI(sig00000058),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000002d_O_UNCONNECTED)
  );
  MUXCY   blk0000002e (
    .CI(sig00000058),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000057)
  );
  XORCY   blk0000002f (
    .CI(sig00000059),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000002f_O_UNCONNECTED)
  );
  MUXCY   blk00000030 (
    .CI(sig00000059),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000058)
  );
  XORCY   blk00000031 (
    .CI(sig0000005a),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000031_O_UNCONNECTED)
  );
  MUXCY   blk00000032 (
    .CI(sig0000005a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000059)
  );
  XORCY   blk00000033 (
    .CI(sig0000005b),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000033_O_UNCONNECTED)
  );
  MUXCY   blk00000034 (
    .CI(sig0000005b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000005a)
  );
  XORCY   blk00000035 (
    .CI(sig0000005c),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000035_O_UNCONNECTED)
  );
  MUXCY   blk00000036 (
    .CI(sig0000005c),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000005b)
  );
  XORCY   blk00000037 (
    .CI(sig0000005d),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000037_O_UNCONNECTED)
  );
  MUXCY   blk00000038 (
    .CI(sig0000005d),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000005c)
  );
  XORCY   blk00000039 (
    .CI(sig0000005e),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000039_O_UNCONNECTED)
  );
  MUXCY   blk0000003a (
    .CI(sig0000005e),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000005d)
  );
  XORCY   blk0000003b (
    .CI(sig0000005f),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000003b_O_UNCONNECTED)
  );
  MUXCY   blk0000003c (
    .CI(sig0000005f),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000005e)
  );
  XORCY   blk0000003d (
    .CI(sig00000060),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000003d_O_UNCONNECTED)
  );
  MUXCY   blk0000003e (
    .CI(sig00000060),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000005f)
  );
  XORCY   blk0000003f (
    .CI(sig00000061),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk0000003f_O_UNCONNECTED)
  );
  MUXCY   blk00000040 (
    .CI(sig00000061),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000060)
  );
  XORCY   blk00000041 (
    .CI(sig00000004),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000041_O_UNCONNECTED)
  );
  MUXCY   blk00000042 (
    .CI(sig00000004),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig00000061)
  );
  XORCY   blk00000043 (
    .CI(sig00000062),
    .LI(sig00000001),
    .O(sig00000006)
  );
  XORCY   blk00000044 (
    .CI(sig00000063),
    .LI(sig00000027),
    .O(sig0000001f)
  );
  MUXCY   blk00000045 (
    .CI(sig00000063),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000027),
    .O(sig00000062)
  );
  XORCY   blk00000046 (
    .CI(sig00000064),
    .LI(sig00000026),
    .O(sig0000001e)
  );
  MUXCY   blk00000047 (
    .CI(sig00000064),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000026),
    .O(sig00000063)
  );
  XORCY   blk00000048 (
    .CI(sig00000065),
    .LI(sig00000025),
    .O(sig0000001d)
  );
  MUXCY   blk00000049 (
    .CI(sig00000065),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000025),
    .O(sig00000064)
  );
  XORCY   blk0000004a (
    .CI(sig00000066),
    .LI(sig00000024),
    .O(sig0000001c)
  );
  MUXCY   blk0000004b (
    .CI(sig00000066),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000024),
    .O(sig00000065)
  );
  XORCY   blk0000004c (
    .CI(sig00000067),
    .LI(sig00000023),
    .O(sig0000001b)
  );
  MUXCY   blk0000004d (
    .CI(sig00000067),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000023),
    .O(sig00000066)
  );
  XORCY   blk0000004e (
    .CI(sig00000068),
    .LI(sig00000022),
    .O(sig0000001a)
  );
  MUXCY   blk0000004f (
    .CI(sig00000068),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000022),
    .O(sig00000067)
  );
  XORCY   blk00000050 (
    .CI(sig00000069),
    .LI(sig00000021),
    .O(sig00000019)
  );
  MUXCY   blk00000051 (
    .CI(sig00000069),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000021),
    .O(sig00000068)
  );
  XORCY   blk00000052 (
    .CI(sig0000006a),
    .LI(sig00000020),
    .O(NLW_blk00000052_O_UNCONNECTED)
  );
  MUXCY   blk00000053 (
    .CI(sig0000006a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000020),
    .O(sig00000069)
  );
  XORCY   blk00000054 (
    .CI(sig0000006b),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000054_O_UNCONNECTED)
  );
  MUXCY   blk00000055 (
    .CI(sig0000006b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006a)
  );
  XORCY   blk00000056 (
    .CI(sig0000006c),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000056_O_UNCONNECTED)
  );
  MUXCY   blk00000057 (
    .CI(sig0000006c),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006b)
  );
  XORCY   blk00000058 (
    .CI(sig00000005),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk00000058_O_UNCONNECTED)
  );
  MUXCY   blk00000059 (
    .CI(sig00000005),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000006c)
  );
  FD   blk0000005a (
    .C(clk),
    .D(sig00000073),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [22])
  );
  FD   blk0000005b (
    .C(clk),
    .D(sig00000072),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [21])
  );
  FD   blk0000005c (
    .C(clk),
    .D(sig00000071),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [20])
  );
  FD   blk0000005d (
    .C(clk),
    .D(sig00000070),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [19])
  );
  FD   blk0000005e (
    .C(clk),
    .D(sig0000006f),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [18])
  );
  FD   blk0000005f (
    .C(clk),
    .D(sig0000006e),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [17])
  );
  FD   blk00000060 (
    .C(clk),
    .D(sig0000006d),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [16])
  );
  LUT5 #(
    .INIT ( 32'h00CCAAF0 ))
  blk00000061 (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000000a),
    .I3(sig0000002a),
    .I4(sig00000029),
    .O(sig00000022)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000062 (
    .I0(sig0000000b),
    .I1(sig00000009),
    .I2(sig00000008),
    .I3(sig0000000a),
    .I4(sig0000002a),
    .I5(sig00000029),
    .O(sig00000023)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000063 (
    .I0(sig0000000c),
    .I1(sig0000000a),
    .I2(sig00000009),
    .I3(sig0000000b),
    .I4(sig0000002a),
    .I5(sig00000029),
    .O(sig00000024)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000064 (
    .I0(sig0000000d),
    .I1(sig0000000b),
    .I2(sig0000000a),
    .I3(sig0000000c),
    .I4(sig0000002a),
    .I5(sig00000029),
    .O(sig00000025)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000065 (
    .I0(sig0000000f),
    .I1(sig0000000e),
    .I2(sig0000000d),
    .I3(sig0000000c),
    .I4(sig0000002a),
    .I5(sig00000029),
    .O(sig00000027)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000066 (
    .I0(sig0000000e),
    .I1(sig0000000d),
    .I2(sig0000000c),
    .I3(sig0000000b),
    .I4(sig0000002a),
    .I5(sig00000029),
    .O(sig00000026)
  );
  LUT3 #(
    .INIT ( 8'h14 ))
  blk00000067 (
    .I0(sig00000028),
    .I1(sig00000029),
    .I2(sig00000006),
    .O(sig00000007)
  );
  LUT6 #(
    .INIT ( 64'h1111111111111115 ))
  blk00000068 (
    .I0(sig00000028),
    .I1(sig00000018),
    .I2(sig0000002a),
    .I3(sig0000002b),
    .I4(sig00000029),
    .I5(sig00000006),
    .O(sig00000043)
  );
  LUT4 #(
    .INIT ( 16'h1114 ))
  blk00000069 (
    .I0(sig00000028),
    .I1(sig0000002a),
    .I2(sig00000029),
    .I3(sig00000006),
    .O(sig00000040)
  );
  LUT5 #(
    .INIT ( 32'h05050514 ))
  blk0000006a (
    .I0(sig00000028),
    .I1(sig0000002a),
    .I2(sig0000002b),
    .I3(sig00000029),
    .I4(sig00000006),
    .O(sig00000041)
  );
  LUT4 #(
    .INIT ( 16'h0A0C ))
  blk0000006b (
    .I0(sig00000008),
    .I1(sig00000009),
    .I2(sig0000002a),
    .I3(sig00000029),
    .O(sig00000021)
  );
  LUT3 #(
    .INIT ( 8'h02 ))
  blk0000006c (
    .I0(sig00000008),
    .I1(sig0000002a),
    .I2(sig00000029),
    .O(sig00000020)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006d (
    .I0(a[0]),
    .I1(a[8]),
    .O(sig00000037)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006e (
    .I0(a[1]),
    .I1(a[8]),
    .O(sig00000038)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000006f (
    .I0(a[2]),
    .I1(a[8]),
    .O(sig00000039)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000070 (
    .I0(a[3]),
    .I1(a[8]),
    .O(sig0000003a)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000071 (
    .I0(a[4]),
    .I1(a[8]),
    .O(sig0000003b)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000072 (
    .I0(a[5]),
    .I1(a[8]),
    .O(sig0000003c)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000073 (
    .I0(a[6]),
    .I1(a[8]),
    .O(sig0000003d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000074 (
    .I0(a[7]),
    .I1(a[8]),
    .O(sig0000003e)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000075 (
    .I0(sig0000002d),
    .I1(sig00000056),
    .I2(sig00000055),
    .O(sig0000002c)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000076 (
    .I0(sig0000002d),
    .I1(sig00000056),
    .O(sig0000004c)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000077 (
    .I0(sig00000036),
    .I1(sig00000035),
    .I2(sig00000034),
    .I3(sig00000033),
    .O(sig00000051)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000078 (
    .I0(sig00000032),
    .I1(sig00000031),
    .I2(sig00000030),
    .I3(sig0000002f),
    .O(sig00000052)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000079 (
    .I0(sig0000002d),
    .I1(sig00000055),
    .O(sig00000053)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000007a (
    .I0(sig00000028),
    .I1(sig00000019),
    .O(sig0000006d)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000007b (
    .I0(sig00000028),
    .I1(sig0000001b),
    .O(sig0000006f)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000007c (
    .I0(sig00000028),
    .I1(sig0000001c),
    .O(sig00000070)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000007d (
    .I0(sig00000028),
    .I1(sig0000001a),
    .O(sig0000006e)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000007e (
    .I0(sig00000028),
    .I1(sig0000001e),
    .O(sig00000072)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000007f (
    .I0(sig00000028),
    .I1(sig0000001d),
    .O(sig00000071)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000080 (
    .I0(sig00000028),
    .I1(sig0000001f),
    .O(sig00000073)
  );
  LUT4 #(
    .INIT ( 16'hFF45 ))
  blk00000081 (
    .I0(sig00000031),
    .I1(sig00000030),
    .I2(sig0000002f),
    .I3(sig00000032),
    .O(sig00000074)
  );
  LUT6 #(
    .INIT ( 64'h11110100BBBBABAA ))
  blk00000082 (
    .I0(sig00000056),
    .I1(sig00000036),
    .I2(sig00000034),
    .I3(sig00000033),
    .I4(sig00000035),
    .I5(sig00000074),
    .O(sig0000004d)
  );
  LUT4 #(
    .INIT ( 16'hFFAB ))
  blk00000083 (
    .I0(sig00000032),
    .I1(sig00000030),
    .I2(sig0000002f),
    .I3(sig00000031),
    .O(sig00000075)
  );
  LUT6 #(
    .INIT ( 64'h01010100ABABABAA ))
  blk00000084 (
    .I0(sig00000056),
    .I1(sig00000035),
    .I2(sig00000036),
    .I3(sig00000033),
    .I4(sig00000034),
    .I5(sig00000075),
    .O(sig0000004e)
  );
  FD   blk00000085 (
    .C(clk),
    .D(sig0000003f),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op )
  );
  FD   blk00000086 (
    .C(clk),
    .D(sig00000043),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] )
  );
  FD   blk00000087 (
    .C(clk),
    .D(sig00000042),
    .Q(\NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6])
  );
  FD   blk00000088 (
    .C(clk),
    .D(sig00000041),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[2] )
  );
  FD   blk00000089 (
    .C(clk),
    .D(sig00000040),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[1] )
  );
  FD   blk0000008a (
    .C(clk),
    .D(sig00000007),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[0] )
  );
  LUT6 #(
    .INIT ( 64'h4444444444444440 ))
  blk0000008b (
    .I0(sig00000028),
    .I1(sig00000018),
    .I2(sig0000002a),
    .I3(sig0000002b),
    .I4(sig00000029),
    .I5(sig00000006),
    .O(sig00000042)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk0000008c (
    .I0(sig0000002d),
    .I1(sig00000056),
    .I2(sig00000035),
    .I3(sig00000031),
    .O(sig00000017)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk0000008d (
    .I0(sig0000002d),
    .I1(sig00000056),
    .I2(sig00000034),
    .I3(sig00000030),
    .O(sig00000016)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk0000008e (
    .I0(sig0000002d),
    .I1(sig00000056),
    .I2(sig00000033),
    .I3(sig0000002f),
    .O(sig00000015)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk0000008f (
    .I0(sig0000002d),
    .I1(sig00000056),
    .I2(sig00000032),
    .I3(sig0000002e),
    .O(sig00000014)
  );
  LUT3 #(
    .INIT ( 8'h04 ))
  blk00000090 (
    .I0(sig0000002d),
    .I1(sig0000002e),
    .I2(sig00000056),
    .O(sig00000010)
  );
  LUT3 #(
    .INIT ( 8'h04 ))
  blk00000091 (
    .I0(sig0000002d),
    .I1(sig00000031),
    .I2(sig00000056),
    .O(sig00000013)
  );
  LUT3 #(
    .INIT ( 8'h04 ))
  blk00000092 (
    .I0(sig0000002d),
    .I1(sig00000030),
    .I2(sig00000056),
    .O(sig00000012)
  );
  LUT3 #(
    .INIT ( 8'h04 ))
  blk00000093 (
    .I0(sig0000002d),
    .I1(sig0000002f),
    .I2(sig00000056),
    .O(sig00000011)
  );
  INV   blk00000094 (
    .I(sig0000002e),
    .O(sig00000054)
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
