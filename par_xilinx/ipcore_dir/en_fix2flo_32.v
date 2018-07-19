////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.68d
//  \   \         Application: netgen
//  /   /         Filename: en_fix2flo_32.v
// /___/   /\     Timestamp: Fri Dec 09 09:19:07 2016
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/SoC/Desktop/11/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_fix2flo_32.ngc C:/Users/SoC/Desktop/11/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_fix2flo_32.v 
// Device	: 6slx45fgg484-2
// Input file	: C:/Users/SoC/Desktop/11/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_fix2flo_32.ngc
// Output file	: C:/Users/SoC/Desktop/11/11_ov5640_display/par_xilinx/ipcore_dir/tmp/_cg/en_fix2flo_32.v
// # of Modules	: 1
// Design Name	: en_fix2flo_32
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

module en_fix2flo_32 (
  operation_nd, clk, rdy, a, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  output rdy;
  input [21 : 0] a;
  output [31 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] ;
  wire \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[4] ;
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
  wire sig000000a3;
  wire sig000000a4;
  wire sig000000a5;
  wire sig000000a6;
  wire sig000000a7;
  wire sig000000a8;
  wire sig000000a9;
  wire sig000000aa;
  wire sig000000ab;
  wire sig000000ac;
  wire sig000000ad;
  wire sig000000ae;
  wire sig000000af;
  wire sig000000b0;
  wire sig000000b1;
  wire sig000000b2;
  wire sig000000b3;
  wire sig000000b4;
  wire sig000000b5;
  wire sig000000b6;
  wire sig000000b7;
  wire sig000000b8;
  wire sig000000b9;
  wire sig000000ba;
  wire sig000000bb;
  wire sig000000bc;
  wire sig000000bd;
  wire sig000000be;
  wire sig000000bf;
  wire sig000000c0;
  wire sig000000c1;
  wire sig000000c2;
  wire sig000000c3;
  wire sig000000c4;
  wire sig000000c5;
  wire sig000000c6;
  wire sig000000c7;
  wire sig000000c8;
  wire sig000000c9;
  wire sig000000ca;
  wire sig000000cb;
  wire sig000000cc;
  wire sig000000cd;
  wire sig000000ce;
  wire sig000000cf;
  wire sig000000d0;
  wire sig000000d1;
  wire sig000000d2;
  wire sig000000d3;
  wire sig000000d4;
  wire sig000000d5;
  wire sig000000d6;
  wire sig000000d7;
  wire sig000000d8;
  wire sig000000d9;
  wire sig000000da;
  wire sig000000db;
  wire sig000000dc;
  wire sig000000dd;
  wire sig000000de;
  wire sig000000df;
  wire sig000000e0;
  wire sig000000e1;
  wire sig000000e2;
  wire sig000000e3;
  wire sig000000e4;
  wire sig000000e5;
  wire sig000000e6;
  wire sig000000e7;
  wire sig000000e8;
  wire sig000000e9;
  wire sig000000ea;
  wire sig000000eb;
  wire sig000000ec;
  wire sig000000ed;
  wire sig000000ee;
  wire sig000000ef;
  wire sig000000f0;
  wire sig000000f1;
  wire sig000000f2;
  wire sig000000f3;
  wire sig000000f4;
  wire sig000000f5;
  wire sig000000f6;
  wire sig000000f7;
  wire sig000000f8;
  wire sig000000f9;
  wire sig000000fa;
  wire sig000000fb;
  wire sig000000fc;
  wire sig000000fd;
  wire sig000000fe;
  wire sig000000ff;
  wire sig00000100;
  wire sig00000101;
  wire sig00000102;
  wire sig00000103;
  wire sig00000104;
  wire sig00000105;
  wire sig00000106;
  wire sig00000107;
  wire sig00000108;
  wire sig00000109;
  wire sig0000010a;
  wire sig0000010b;
  wire sig0000010c;
  wire sig0000010d;
  wire sig0000010e;
  wire sig0000010f;
  wire sig00000110;
  wire sig00000111;
  wire sig00000112;
  wire sig00000113;
  wire sig00000114;
  wire sig00000115;
  wire sig00000116;
  wire sig00000117;
  wire sig00000118;
  wire sig00000119;
  wire sig0000011a;
  wire sig0000011b;
  wire sig0000011c;
  wire sig0000011d;
  wire sig0000011e;
  wire sig0000011f;
  wire sig00000120;
  wire sig00000121;
  wire sig00000122;
  wire sig00000123;
  wire sig00000124;
  wire sig00000125;
  wire sig00000126;
  wire sig00000127;
  wire sig00000128;
  wire sig00000129;
  wire sig0000012a;
  wire sig0000012b;
  wire sig0000012c;
  wire sig0000012d;
  wire sig0000012e;
  wire sig0000012f;
  wire sig00000130;
  wire sig00000131;
  wire sig00000132;
  wire sig00000133;
  wire sig00000134;
  wire sig00000135;
  wire sig00000136;
  wire sig00000137;
  wire sig00000138;
  wire sig00000139;
  wire sig0000013a;
  wire sig0000013b;
  wire sig0000013c;
  wire sig0000013d;
  wire sig0000013e;
  wire sig0000013f;
  wire sig00000140;
  wire sig00000141;
  wire sig00000142;
  wire sig00000143;
  wire sig00000144;
  wire sig00000145;
  wire sig00000146;
  wire sig00000147;
  wire sig00000148;
  wire sig00000149;
  wire sig0000014a;
  wire sig0000014b;
  wire sig0000014c;
  wire sig0000014d;
  wire sig0000014e;
  wire sig0000014f;
  wire sig00000150;
  wire sig00000151;
  wire sig00000152;
  wire sig00000153;
  wire sig00000154;
  wire sig00000155;
  wire sig00000156;
  wire sig00000157;
  wire sig00000158;
  wire sig00000159;
  wire sig0000015a;
  wire sig0000015b;
  wire sig0000015c;
  wire sig0000015d;
  wire sig0000015e;
  wire sig0000015f;
  wire sig00000160;
  wire sig00000161;
  wire sig00000162;
  wire sig00000163;
  wire sig00000164;
  wire sig00000165;
  wire sig00000166;
  wire sig00000167;
  wire sig00000168;
  wire sig00000169;
  wire sig0000016a;
  wire sig0000016b;
  wire sig0000016c;
  wire sig0000016d;
  wire sig0000016e;
  wire sig0000016f;
  wire sig00000170;
  wire sig00000171;
  wire sig00000172;
  wire sig00000173;
  wire sig00000174;
  wire sig00000175;
  wire sig00000176;
  wire sig00000177;
  wire sig00000178;
  wire sig00000179;
  wire sig0000017a;
  wire sig0000017b;
  wire sig0000017c;
  wire sig0000017d;
  wire sig0000017e;
  wire sig0000017f;
  wire sig00000180;
  wire sig00000181;
  wire sig00000182;
  wire sig00000183;
  wire sig00000184;
  wire sig00000185;
  wire sig00000186;
  wire sig00000187;
  wire sig00000188;
  wire sig00000189;
  wire sig0000018a;
  wire sig0000018b;
  wire sig0000018c;
  wire sig0000018d;
  wire sig0000018e;
  wire sig0000018f;
  wire sig00000190;
  wire sig00000191;
  wire sig00000192;
  wire NLW_blk00000094_O_UNCONNECTED;
  wire NLW_blk00000096_O_UNCONNECTED;
  wire NLW_blk00000097_O_UNCONNECTED;
  wire NLW_blk00000098_O_UNCONNECTED;
  wire NLW_blk0000009c_O_UNCONNECTED;
  wire NLW_blk000000ce_O_UNCONNECTED;
  wire NLW_blk000000d0_O_UNCONNECTED;
  wire NLW_blk000001b3_Q15_UNCONNECTED;
  wire NLW_blk000001b5_Q15_UNCONNECTED;
  wire NLW_blk000001b7_Q15_UNCONNECTED;
  wire [6 : 6] \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op ;
  wire [22 : 2] \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op ;
  wire [0 : 0] NlwRenamedSig_OI_result;
  assign
    result[31] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op ,
    result[30] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] ,
    result[29] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
    result[28] = \NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6],
    result[27] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[4] ,
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
    result[13] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [13],
    result[12] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [12],
    result[11] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [11],
    result[10] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [10],
    result[9] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [9],
    result[8] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [8],
    result[7] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [7],
    result[6] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [6],
    result[5] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [5],
    result[4] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [4],
    result[3] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [3],
    result[2] = \U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [2],
    result[1] = NlwRenamedSig_OI_result[0],
    result[0] = NlwRenamedSig_OI_result[0],
    rdy = \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(sig00000001)
  );
  GND   blk00000002 (
    .G(NlwRenamedSig_OI_result[0])
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000003 (
    .C(clk),
    .D(sig0000007b),
    .Q(sig00000043)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000004 (
    .C(clk),
    .D(sig00000043),
    .Q(sig000000c9)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000005 (
    .C(clk),
    .D(sig00000003),
    .Q(sig0000004a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000006 (
    .C(clk),
    .D(sig00000044),
    .Q(sig0000004b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000007 (
    .C(clk),
    .D(sig00000045),
    .Q(sig0000004c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000008 (
    .C(clk),
    .D(sig00000046),
    .Q(sig0000004d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .D(sig00000047),
    .Q(sig0000004e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000a (
    .C(clk),
    .D(sig00000048),
    .Q(sig0000004f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000000b (
    .C(clk),
    .D(sig00000049),
    .Q(sig00000050)
  );
  XORCY   blk0000000c (
    .CI(sig000000cc),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(sig000000ca)
  );
  XORCY   blk0000000d (
    .CI(sig000000ce),
    .LI(sig000000c2),
    .O(sig000000cb)
  );
  MUXCY   blk0000000e (
    .CI(sig000000ce),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000c2),
    .O(sig000000cc)
  );
  XORCY   blk0000000f (
    .CI(sig000000d0),
    .LI(sig000000c1),
    .O(sig000000cd)
  );
  MUXCY   blk00000010 (
    .CI(sig000000d0),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000c1),
    .O(sig000000ce)
  );
  XORCY   blk00000011 (
    .CI(sig000000d2),
    .LI(sig000000c0),
    .O(sig000000cf)
  );
  MUXCY   blk00000012 (
    .CI(sig000000d2),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000c0),
    .O(sig000000d0)
  );
  XORCY   blk00000013 (
    .CI(sig000000d4),
    .LI(sig000000bf),
    .O(sig000000d1)
  );
  MUXCY   blk00000014 (
    .CI(sig000000d4),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000bf),
    .O(sig000000d2)
  );
  XORCY   blk00000015 (
    .CI(sig000000d6),
    .LI(sig000000be),
    .O(sig000000d3)
  );
  MUXCY   blk00000016 (
    .CI(sig000000d6),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000be),
    .O(sig000000d4)
  );
  XORCY   blk00000017 (
    .CI(sig000000d8),
    .LI(sig000000bd),
    .O(sig000000d5)
  );
  MUXCY   blk00000018 (
    .CI(sig000000d8),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000bd),
    .O(sig000000d6)
  );
  XORCY   blk00000019 (
    .CI(sig000000da),
    .LI(sig000000bc),
    .O(sig000000d7)
  );
  MUXCY   blk0000001a (
    .CI(sig000000da),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000bc),
    .O(sig000000d8)
  );
  XORCY   blk0000001b (
    .CI(sig000000dc),
    .LI(sig000000bb),
    .O(sig000000d9)
  );
  MUXCY   blk0000001c (
    .CI(sig000000dc),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000bb),
    .O(sig000000da)
  );
  XORCY   blk0000001d (
    .CI(sig000000de),
    .LI(sig000000ba),
    .O(sig000000db)
  );
  MUXCY   blk0000001e (
    .CI(sig000000de),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000ba),
    .O(sig000000dc)
  );
  XORCY   blk0000001f (
    .CI(sig000000e0),
    .LI(sig000000b9),
    .O(sig000000dd)
  );
  MUXCY   blk00000020 (
    .CI(sig000000e0),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b9),
    .O(sig000000de)
  );
  XORCY   blk00000021 (
    .CI(sig000000e2),
    .LI(sig000000b8),
    .O(sig000000df)
  );
  MUXCY   blk00000022 (
    .CI(sig000000e2),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b8),
    .O(sig000000e0)
  );
  XORCY   blk00000023 (
    .CI(sig000000e4),
    .LI(sig000000b7),
    .O(sig000000e1)
  );
  MUXCY   blk00000024 (
    .CI(sig000000e4),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b7),
    .O(sig000000e2)
  );
  XORCY   blk00000025 (
    .CI(sig000000e6),
    .LI(sig000000b6),
    .O(sig000000e3)
  );
  MUXCY   blk00000026 (
    .CI(sig000000e6),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b6),
    .O(sig000000e4)
  );
  XORCY   blk00000027 (
    .CI(sig000000e8),
    .LI(sig000000b5),
    .O(sig000000e5)
  );
  MUXCY   blk00000028 (
    .CI(sig000000e8),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b5),
    .O(sig000000e6)
  );
  XORCY   blk00000029 (
    .CI(sig000000ea),
    .LI(sig000000b4),
    .O(sig000000e7)
  );
  MUXCY   blk0000002a (
    .CI(sig000000ea),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b4),
    .O(sig000000e8)
  );
  XORCY   blk0000002b (
    .CI(sig000000ec),
    .LI(sig000000b3),
    .O(sig000000e9)
  );
  MUXCY   blk0000002c (
    .CI(sig000000ec),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b3),
    .O(sig000000ea)
  );
  XORCY   blk0000002d (
    .CI(sig000000ee),
    .LI(sig000000b2),
    .O(sig000000eb)
  );
  MUXCY   blk0000002e (
    .CI(sig000000ee),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b2),
    .O(sig000000ec)
  );
  XORCY   blk0000002f (
    .CI(sig000000f0),
    .LI(sig000000b1),
    .O(sig000000ed)
  );
  MUXCY   blk00000030 (
    .CI(sig000000f0),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b1),
    .O(sig000000ee)
  );
  XORCY   blk00000031 (
    .CI(sig000000f2),
    .LI(sig000000b0),
    .O(sig000000ef)
  );
  MUXCY   blk00000032 (
    .CI(sig000000f2),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000b0),
    .O(sig000000f0)
  );
  XORCY   blk00000033 (
    .CI(sig000000f4),
    .LI(sig000000af),
    .O(sig000000f1)
  );
  MUXCY   blk00000034 (
    .CI(sig000000f4),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000af),
    .O(sig000000f2)
  );
  XORCY   blk00000035 (
    .CI(a[21]),
    .LI(sig000000ae),
    .O(sig000000f3)
  );
  MUXCY   blk00000036 (
    .CI(a[21]),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig000000ae),
    .O(sig000000f4)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000037 (
    .C(clk),
    .D(sig000000ca),
    .Q(sig000000ad)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000038 (
    .C(clk),
    .D(sig000000cb),
    .Q(sig000000ac)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000039 (
    .C(clk),
    .D(sig000000cd),
    .Q(sig000000ab)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003a (
    .C(clk),
    .D(sig000000cf),
    .Q(sig000000aa)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003b (
    .C(clk),
    .D(sig000000d1),
    .Q(sig000000a9)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003c (
    .C(clk),
    .D(sig000000d3),
    .Q(sig000000a8)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003d (
    .C(clk),
    .D(sig000000d5),
    .Q(sig000000a7)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003e (
    .C(clk),
    .D(sig000000d7),
    .Q(sig000000a6)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000003f (
    .C(clk),
    .D(sig000000d9),
    .Q(sig000000a5)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000040 (
    .C(clk),
    .D(sig000000db),
    .Q(sig000000a4)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000041 (
    .C(clk),
    .D(sig000000dd),
    .Q(sig000000a3)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000042 (
    .C(clk),
    .D(sig000000df),
    .Q(sig000000a2)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000043 (
    .C(clk),
    .D(sig000000e1),
    .Q(sig000000a1)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000044 (
    .C(clk),
    .D(sig000000e3),
    .Q(sig000000a0)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000045 (
    .C(clk),
    .D(sig000000e5),
    .Q(sig0000009f)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000046 (
    .C(clk),
    .D(sig000000e7),
    .Q(sig0000009e)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000047 (
    .C(clk),
    .D(sig000000e9),
    .Q(sig0000009d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000048 (
    .C(clk),
    .D(sig000000eb),
    .Q(sig0000009c)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk00000049 (
    .C(clk),
    .D(sig000000ed),
    .Q(sig0000009b)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004a (
    .C(clk),
    .D(sig000000ef),
    .Q(sig0000009a)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004b (
    .C(clk),
    .D(sig000000f1),
    .Q(sig00000099)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000004c (
    .C(clk),
    .D(sig000000f3),
    .Q(sig00000098)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004d (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000019),
    .Q(sig00000007)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004e (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000001a),
    .Q(sig00000008)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004f (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000001b),
    .Q(sig00000009)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000050 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000001c),
    .Q(sig0000000a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000051 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000001d),
    .Q(sig0000000b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000052 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000001e),
    .Q(sig0000000c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000053 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000001f),
    .Q(sig0000000d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000054 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000020),
    .Q(sig0000000e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000055 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000021),
    .Q(sig0000000f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000056 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000022),
    .Q(sig00000010)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000057 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000023),
    .Q(sig00000011)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000058 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000024),
    .Q(sig00000012)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000059 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000025),
    .Q(sig00000013)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005a (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000026),
    .Q(sig00000014)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005b (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000027),
    .Q(sig00000015)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005c (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000028),
    .Q(sig0000011b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005d (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000029),
    .Q(sig00000016)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005e (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002a),
    .Q(sig0000011c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005f (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002b),
    .Q(sig00000017)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000060 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002c),
    .Q(sig0000011d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000061 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002d),
    .Q(sig00000018)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000062 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002e),
    .Q(sig00000066)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000063 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000002f),
    .Q(sig00000067)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000064 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000030),
    .Q(sig00000068)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000065 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000031),
    .Q(sig00000069)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000066 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000032),
    .Q(sig0000006a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000067 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000033),
    .Q(sig0000006b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000068 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000034),
    .Q(sig0000006c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000069 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000035),
    .Q(sig0000006d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006a (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000036),
    .Q(sig0000006e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006b (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000037),
    .Q(sig0000006f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006c (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000038),
    .Q(sig00000070)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006d (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000039),
    .Q(sig00000071)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006e (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000003a),
    .Q(sig00000072)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006f (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000003b),
    .Q(sig00000073)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000070 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000003c),
    .Q(sig00000074)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000071 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000003d),
    .Q(sig00000075)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000072 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000003e),
    .Q(sig00000076)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000073 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000003f),
    .Q(sig00000077)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000074 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000040),
    .Q(sig00000078)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000075 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000041),
    .Q(sig00000079)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000076 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000042),
    .Q(sig0000007a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000077 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000ad),
    .Q(sig00000097)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000078 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000ac),
    .Q(sig00000096)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000079 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000ab),
    .Q(sig00000095)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007a (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000aa),
    .Q(sig00000094)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007b (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a9),
    .Q(sig00000093)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007c (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a8),
    .Q(sig00000092)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007d (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a7),
    .Q(sig00000091)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007e (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a6),
    .Q(sig00000090)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007f (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a5),
    .Q(sig0000008f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000080 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a4),
    .Q(sig0000008e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000081 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a3),
    .Q(sig0000008d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000082 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a2),
    .Q(sig0000008c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000083 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a1),
    .Q(sig0000008b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000084 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000a0),
    .Q(sig0000008a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000085 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000009f),
    .Q(sig00000089)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000086 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000009e),
    .Q(sig00000088)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000087 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000009d),
    .Q(sig00000087)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000088 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000009c),
    .Q(sig00000086)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000089 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000009b),
    .Q(sig00000085)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008a (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000009a),
    .Q(sig00000084)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008b (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000099),
    .Q(sig00000083)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008c (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000098),
    .Q(sig00000082)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008d (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000f5),
    .Q(sig00000106)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008e (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000f6),
    .Q(sig00000107)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008f (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000f7),
    .Q(sig00000108)
  );
  MUXCY   blk00000090 (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000115),
    .O(sig000000f5)
  );
  MUXCY   blk00000091 (
    .CI(sig000000f5),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000116),
    .O(sig000000f6)
  );
  MUXCY   blk00000092 (
    .CI(sig000000f6),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000117),
    .O(sig000000f7)
  );
  MUXF7   blk00000093 (
    .I0(sig000000f8),
    .I1(sig000000f9),
    .S(sig0000007f),
    .O(sig000000fa)
  );
  MUXF7   blk00000094 (
    .I0(sig000000fb),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig0000007f),
    .O(NLW_blk00000094_O_UNCONNECTED)
  );
  MUXF7   blk00000095 (
    .I0(sig000000fd),
    .I1(sig00000189),
    .S(sig00000081),
    .O(sig00000101)
  );
  MUXF7   blk00000096 (
    .I0(sig000000fe),
    .I1(sig0000018a),
    .S(sig00000081),
    .O(NLW_blk00000096_O_UNCONNECTED)
  );
  MUXF7   blk00000097 (
    .I0(sig000000ff),
    .I1(sig0000018b),
    .S(sig00000081),
    .O(NLW_blk00000097_O_UNCONNECTED)
  );
  MUXF7   blk00000098 (
    .I0(sig00000100),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig00000081),
    .O(NLW_blk00000098_O_UNCONNECTED)
  );
  MUXF7   blk00000099 (
    .I0(sig00000102),
    .I1(sig00000106),
    .S(sig00000081),
    .O(sig00000109)
  );
  MUXF7   blk0000009a (
    .I0(sig00000103),
    .I1(sig00000107),
    .S(sig00000081),
    .O(sig0000010a)
  );
  MUXF7   blk0000009b (
    .I0(sig00000104),
    .I1(sig00000108),
    .S(sig00000081),
    .O(sig0000010b)
  );
  MUXF7   blk0000009c (
    .I0(sig00000105),
    .I1(NlwRenamedSig_OI_result[0]),
    .S(sig00000081),
    .O(NLW_blk0000009c_O_UNCONNECTED)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009d (
    .C(clk),
    .D(sig0000007f),
    .Q(sig00000006)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk0000009e (
    .C(clk),
    .D(sig0000007e),
    .Q(sig0000007c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009f (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000fa),
    .Q(sig00000118)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a0 (
    .C(clk),
    .D(sig00000080),
    .Q(sig000000fc)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000000a1 (
    .C(clk),
    .D(sig000000fc),
    .Q(sig0000007d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a2 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000109),
    .Q(sig0000011a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a3 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000010a),
    .Q(sig0000007f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a4 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000010b),
    .Q(sig00000119)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a5 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000101),
    .Q(sig0000011e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a6 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000010c),
    .Q(sig0000007b)
  );
  MUXCY   blk000000a7 (
    .CI(sig00000127),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000114),
    .O(sig00000126)
  );
  MUXCY   blk000000a8 (
    .CI(sig00000128),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000113),
    .O(sig00000127)
  );
  MUXCY   blk000000a9 (
    .CI(sig00000129),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000112),
    .O(sig00000128)
  );
  MUXCY   blk000000aa (
    .CI(sig0000012a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000111),
    .O(sig00000129)
  );
  MUXCY   blk000000ab (
    .CI(sig0000012b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000110),
    .O(sig0000012a)
  );
  MUXCY   blk000000ac (
    .CI(sig0000012c),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000010f),
    .O(sig0000012b)
  );
  MUXCY   blk000000ad (
    .CI(sig0000012d),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000010e),
    .O(sig0000012c)
  );
  MUXCY   blk000000ae (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000010d),
    .O(sig0000012d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000af (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000126),
    .Q(sig00000081)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b0 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000127),
    .Q(sig00000121)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b1 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000128),
    .Q(sig00000120)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b2 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000129),
    .Q(sig0000011f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b3 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000012a),
    .Q(sig00000125)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b4 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000012b),
    .Q(sig00000124)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b5 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000012c),
    .Q(sig00000123)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000b6 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000012d),
    .Q(sig00000122)
  );
  MUXCY   blk000000b7 (
    .CI(sig0000012e),
    .DI(sig00000001),
    .S(sig00000001),
    .O(sig00000147)
  );
  MUXCY   blk000000b8 (
    .CI(sig0000012f),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000012e)
  );
  MUXCY   blk000000b9 (
    .CI(sig00000001),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000012f)
  );
  XORCY   blk000000ba (
    .CI(sig0000014a),
    .LI(sig00000144),
    .O(sig00000148)
  );
  MUXCY   blk000000bb (
    .CI(sig0000014a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000144),
    .O(sig00000146)
  );
  XORCY   blk000000bc (
    .CI(sig0000014c),
    .LI(sig00000143),
    .O(sig00000149)
  );
  MUXCY   blk000000bd (
    .CI(sig0000014c),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000143),
    .O(sig0000014a)
  );
  XORCY   blk000000be (
    .CI(sig0000014e),
    .LI(sig00000142),
    .O(sig0000014b)
  );
  MUXCY   blk000000bf (
    .CI(sig0000014e),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000142),
    .O(sig0000014c)
  );
  XORCY   blk000000c0 (
    .CI(sig00000150),
    .LI(sig00000141),
    .O(sig0000014d)
  );
  MUXCY   blk000000c1 (
    .CI(sig00000150),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000141),
    .O(sig0000014e)
  );
  XORCY   blk000000c2 (
    .CI(sig00000152),
    .LI(sig00000140),
    .O(sig0000014f)
  );
  MUXCY   blk000000c3 (
    .CI(sig00000152),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000140),
    .O(sig00000150)
  );
  XORCY   blk000000c4 (
    .CI(sig00000154),
    .LI(sig0000013f),
    .O(sig00000151)
  );
  MUXCY   blk000000c5 (
    .CI(sig00000154),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000013f),
    .O(sig00000152)
  );
  XORCY   blk000000c6 (
    .CI(sig00000156),
    .LI(sig0000013e),
    .O(sig00000153)
  );
  MUXCY   blk000000c7 (
    .CI(sig00000156),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000013e),
    .O(sig00000154)
  );
  XORCY   blk000000c8 (
    .CI(sig00000158),
    .LI(sig0000013d),
    .O(sig00000155)
  );
  MUXCY   blk000000c9 (
    .CI(sig00000158),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000013d),
    .O(sig00000156)
  );
  XORCY   blk000000ca (
    .CI(sig0000015a),
    .LI(sig0000013c),
    .O(sig00000157)
  );
  MUXCY   blk000000cb (
    .CI(sig0000015a),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000013c),
    .O(sig00000158)
  );
  XORCY   blk000000cc (
    .CI(sig0000015b),
    .LI(sig0000013b),
    .O(sig00000159)
  );
  MUXCY   blk000000cd (
    .CI(sig0000015b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000013b),
    .O(sig0000015a)
  );
  XORCY   blk000000ce (
    .CI(sig0000015c),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk000000ce_O_UNCONNECTED)
  );
  MUXCY   blk000000cf (
    .CI(sig0000015c),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000015b)
  );
  XORCY   blk000000d0 (
    .CI(sig00000147),
    .LI(NlwRenamedSig_OI_result[0]),
    .O(NLW_blk000000d0_O_UNCONNECTED)
  );
  MUXCY   blk000000d1 (
    .CI(sig00000147),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(NlwRenamedSig_OI_result[0]),
    .O(sig0000015c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d2 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000159),
    .Q(sig00000051)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d3 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000157),
    .Q(sig00000052)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d4 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000155),
    .Q(sig00000053)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d5 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000153),
    .Q(sig00000054)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d6 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000151),
    .Q(sig00000055)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d7 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000014f),
    .Q(sig00000056)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d8 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000014d),
    .Q(sig00000057)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000d9 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000014b),
    .Q(sig00000058)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000da (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000149),
    .Q(sig00000059)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000db (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000148),
    .Q(sig0000005a)
  );
  XORCY   blk000000dc (
    .CI(sig0000015f),
    .LI(sig00000001),
    .O(sig0000015d)
  );
  XORCY   blk000000dd (
    .CI(sig00000161),
    .LI(sig0000013a),
    .O(sig0000015e)
  );
  MUXCY   blk000000de (
    .CI(sig00000161),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig0000013a),
    .O(sig0000015f)
  );
  XORCY   blk000000df (
    .CI(sig00000163),
    .LI(sig00000139),
    .O(sig00000160)
  );
  MUXCY   blk000000e0 (
    .CI(sig00000163),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000139),
    .O(sig00000161)
  );
  XORCY   blk000000e1 (
    .CI(sig00000165),
    .LI(sig00000138),
    .O(sig00000162)
  );
  MUXCY   blk000000e2 (
    .CI(sig00000165),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000138),
    .O(sig00000163)
  );
  XORCY   blk000000e3 (
    .CI(sig00000167),
    .LI(sig00000137),
    .O(sig00000164)
  );
  MUXCY   blk000000e4 (
    .CI(sig00000167),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000137),
    .O(sig00000165)
  );
  XORCY   blk000000e5 (
    .CI(sig00000169),
    .LI(sig00000136),
    .O(sig00000166)
  );
  MUXCY   blk000000e6 (
    .CI(sig00000169),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000136),
    .O(sig00000167)
  );
  XORCY   blk000000e7 (
    .CI(sig0000016b),
    .LI(sig00000135),
    .O(sig00000168)
  );
  MUXCY   blk000000e8 (
    .CI(sig0000016b),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000135),
    .O(sig00000169)
  );
  XORCY   blk000000e9 (
    .CI(sig0000016d),
    .LI(sig00000134),
    .O(sig0000016a)
  );
  MUXCY   blk000000ea (
    .CI(sig0000016d),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000134),
    .O(sig0000016b)
  );
  XORCY   blk000000eb (
    .CI(sig0000016f),
    .LI(sig00000133),
    .O(sig0000016c)
  );
  MUXCY   blk000000ec (
    .CI(sig0000016f),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000133),
    .O(sig0000016d)
  );
  XORCY   blk000000ed (
    .CI(sig00000171),
    .LI(sig00000132),
    .O(sig0000016e)
  );
  MUXCY   blk000000ee (
    .CI(sig00000171),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000132),
    .O(sig0000016f)
  );
  XORCY   blk000000ef (
    .CI(sig00000173),
    .LI(sig00000131),
    .O(sig00000170)
  );
  MUXCY   blk000000f0 (
    .CI(sig00000173),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000131),
    .O(sig00000171)
  );
  XORCY   blk000000f1 (
    .CI(sig00000146),
    .LI(sig00000130),
    .O(sig00000172)
  );
  MUXCY   blk000000f2 (
    .CI(sig00000146),
    .DI(NlwRenamedSig_OI_result[0]),
    .S(sig00000130),
    .O(sig00000173)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f3 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000172),
    .Q(sig0000005b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f4 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000170),
    .Q(sig0000005c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f5 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000016e),
    .Q(sig0000005d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f6 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000016c),
    .Q(sig0000005e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f7 (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000016a),
    .Q(sig0000005f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f8 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000168),
    .Q(sig00000060)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000f9 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000166),
    .Q(sig00000061)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fa (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000164),
    .Q(sig00000062)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fb (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000162),
    .Q(sig00000063)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fc (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000160),
    .Q(sig00000064)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fd (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000015e),
    .Q(sig00000065)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000fe (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000015d),
    .Q(sig00000145)
  );
  FD   blk000000ff (
    .C(clk),
    .D(sig00000188),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [22])
  );
  FD   blk00000100 (
    .C(clk),
    .D(sig00000187),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [21])
  );
  FD   blk00000101 (
    .C(clk),
    .D(sig00000186),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [20])
  );
  FD   blk00000102 (
    .C(clk),
    .D(sig00000185),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [19])
  );
  FD   blk00000103 (
    .C(clk),
    .D(sig00000184),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [18])
  );
  FD   blk00000104 (
    .C(clk),
    .D(sig00000183),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [17])
  );
  FD   blk00000105 (
    .C(clk),
    .D(sig00000182),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [16])
  );
  FD   blk00000106 (
    .C(clk),
    .D(sig00000181),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [15])
  );
  FD   blk00000107 (
    .C(clk),
    .D(sig00000180),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [14])
  );
  FD   blk00000108 (
    .C(clk),
    .D(sig0000017f),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [13])
  );
  FD   blk00000109 (
    .C(clk),
    .D(sig0000017e),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [12])
  );
  FD   blk0000010a (
    .C(clk),
    .D(sig0000017d),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [11])
  );
  FD   blk0000010b (
    .C(clk),
    .D(sig0000017c),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [10])
  );
  FD   blk0000010c (
    .C(clk),
    .D(sig0000017b),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [9])
  );
  FD   blk0000010d (
    .C(clk),
    .D(sig0000017a),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [8])
  );
  FD   blk0000010e (
    .C(clk),
    .D(sig00000179),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [7])
  );
  FD   blk0000010f (
    .C(clk),
    .D(sig00000178),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [6])
  );
  FD   blk00000110 (
    .C(clk),
    .D(sig00000177),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [5])
  );
  FD   blk00000111 (
    .C(clk),
    .D(sig00000176),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [4])
  );
  FD   blk00000112 (
    .C(clk),
    .D(sig00000175),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [3])
  );
  FD   blk00000113 (
    .C(clk),
    .D(sig00000174),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/mant_op [2])
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000114 (
    .I0(sig0000000d),
    .I1(sig00000009),
    .I2(sig00000007),
    .I3(sig0000000b),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000034)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000115 (
    .I0(sig0000000e),
    .I1(sig0000000a),
    .I2(sig00000008),
    .I3(sig0000000c),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000035)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000116 (
    .I0(sig0000000f),
    .I1(sig0000000b),
    .I2(sig00000009),
    .I3(sig0000000d),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000036)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000117 (
    .I0(sig00000010),
    .I1(sig0000000c),
    .I2(sig0000000a),
    .I3(sig0000000e),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000037)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000118 (
    .I0(sig00000014),
    .I1(sig00000010),
    .I2(sig0000000e),
    .I3(sig00000012),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig0000003b)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000119 (
    .I0(sig00000012),
    .I1(sig0000000e),
    .I2(sig0000000c),
    .I3(sig00000010),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000039)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk0000011a (
    .I0(sig00000013),
    .I1(sig0000000f),
    .I2(sig0000000d),
    .I3(sig00000011),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig0000003a)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk0000011b (
    .I0(sig00000011),
    .I1(sig0000000d),
    .I2(sig0000000b),
    .I3(sig0000000f),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000038)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk0000011c (
    .I0(sig00000015),
    .I1(sig00000011),
    .I2(sig0000000f),
    .I3(sig00000013),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig0000003c)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk0000011d (
    .I0(sig0000011b),
    .I1(sig00000012),
    .I2(sig00000010),
    .I3(sig00000014),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig0000003d)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk0000011e (
    .I0(sig00000016),
    .I1(sig00000013),
    .I2(sig00000011),
    .I3(sig00000015),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig0000003e)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk0000011f (
    .I0(sig0000011c),
    .I1(sig00000014),
    .I2(sig00000012),
    .I3(sig0000011b),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig0000003f)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000120 (
    .I0(sig00000017),
    .I1(sig00000016),
    .I2(sig00000015),
    .I3(sig00000013),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000040)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000121 (
    .I0(sig0000011d),
    .I1(sig0000011c),
    .I2(sig0000011b),
    .I3(sig00000014),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000041)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000122 (
    .I0(sig00000018),
    .I1(sig00000017),
    .I2(sig00000016),
    .I3(sig00000015),
    .I4(sig0000007f),
    .I5(sig0000007e),
    .O(sig00000042)
  );
  LUT5 #(
    .INIT ( 32'h1151FFFF ))
  blk00000123 (
    .I0(sig0000007d),
    .I1(sig00000006),
    .I2(sig00000118),
    .I3(sig0000007c),
    .I4(sig00000005),
    .O(sig00000003)
  );
  LUT4 #(
    .INIT ( 16'h6C66 ))
  blk00000124 (
    .I0(sig00000006),
    .I1(sig0000007d),
    .I2(sig0000007c),
    .I3(sig00000118),
    .O(sig00000046)
  );
  LUT3 #(
    .INIT ( 8'hA6 ))
  blk00000125 (
    .I0(sig00000006),
    .I1(sig00000118),
    .I2(sig0000007c),
    .O(sig00000047)
  );
  LUT5 #(
    .INIT ( 32'h44441444 ))
  blk00000126 (
    .I0(sig000000c9),
    .I1(sig0000004c),
    .I2(sig0000004d),
    .I3(sig0000004e),
    .I4(sig00000002),
    .O(sig000000c6)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk00000127 (
    .I0(sig0000007c),
    .I1(sig00000118),
    .O(sig00000048)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000128 (
    .I0(a[0]),
    .I1(a[21]),
    .O(sig000000ae)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000129 (
    .I0(a[10]),
    .I1(a[21]),
    .O(sig000000b8)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000012a (
    .I0(a[11]),
    .I1(a[21]),
    .O(sig000000b9)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000012b (
    .I0(a[12]),
    .I1(a[21]),
    .O(sig000000ba)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000012c (
    .I0(a[13]),
    .I1(a[21]),
    .O(sig000000bb)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000012d (
    .I0(a[14]),
    .I1(a[21]),
    .O(sig000000bc)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000012e (
    .I0(a[15]),
    .I1(a[21]),
    .O(sig000000bd)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000012f (
    .I0(a[16]),
    .I1(a[21]),
    .O(sig000000be)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000130 (
    .I0(a[17]),
    .I1(a[21]),
    .O(sig000000bf)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000131 (
    .I0(a[18]),
    .I1(a[21]),
    .O(sig000000c0)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000132 (
    .I0(a[19]),
    .I1(a[21]),
    .O(sig000000c1)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000133 (
    .I0(a[1]),
    .I1(a[21]),
    .O(sig000000af)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000134 (
    .I0(a[20]),
    .I1(a[21]),
    .O(sig000000c2)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000135 (
    .I0(a[2]),
    .I1(a[21]),
    .O(sig000000b0)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000136 (
    .I0(a[3]),
    .I1(a[21]),
    .O(sig000000b1)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000137 (
    .I0(a[4]),
    .I1(a[21]),
    .O(sig000000b2)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000138 (
    .I0(a[5]),
    .I1(a[21]),
    .O(sig000000b3)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000139 (
    .I0(a[6]),
    .I1(a[21]),
    .O(sig000000b4)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000013a (
    .I0(a[7]),
    .I1(a[21]),
    .O(sig000000b5)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000013b (
    .I0(a[8]),
    .I1(a[21]),
    .O(sig000000b6)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000013c (
    .I0(a[9]),
    .I1(a[21]),
    .O(sig000000b7)
  );
  LUT3 #(
    .INIT ( 8'h41 ))
  blk0000013d (
    .I0(sig000000c9),
    .I1(sig00000050),
    .I2(sig00000145),
    .O(sig00000004)
  );
  LUT3 #(
    .INIT ( 8'hCA ))
  blk0000013e (
    .I0(sig00000097),
    .I1(sig0000008f),
    .I2(sig00000125),
    .O(sig000000fd)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk0000013f (
    .I0(sig00000125),
    .I1(sig00000095),
    .I2(sig0000008d),
    .O(sig000000fe)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000140 (
    .I0(sig00000125),
    .I1(sig00000093),
    .I2(sig0000008b),
    .O(sig000000ff)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000141 (
    .I0(sig00000125),
    .I1(sig00000091),
    .I2(sig00000089),
    .O(sig00000100)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000142 (
    .I0(sig0000011f),
    .I1(sig00000122),
    .I2(sig00000125),
    .O(sig00000102)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000143 (
    .I0(sig00000120),
    .I1(sig00000123),
    .I2(sig00000125),
    .O(sig00000103)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000144 (
    .I0(sig00000121),
    .I1(sig00000124),
    .I2(sig00000125),
    .O(sig00000104)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000145 (
    .I0(sig00000125),
    .I1(sig00000081),
    .O(sig00000105)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000146 (
    .I0(sig00000081),
    .I1(sig00000125),
    .O(sig00000080)
  );
  LUT3 #(
    .INIT ( 8'hD8 ))
  blk00000147 (
    .I0(sig0000018d),
    .I1(sig00000119),
    .I2(sig0000011a),
    .O(sig0000007e)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000148 (
    .I0(sig0000011a),
    .I1(sig0000011e),
    .I2(sig0000011d),
    .O(sig000000f8)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  blk00000149 (
    .I0(sig00000119),
    .I1(sig0000011c),
    .I2(sig0000011b),
    .O(sig000000f9)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000014a (
    .I0(sig0000007f),
    .I1(sig0000011a),
    .O(sig000000fb)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk0000014b (
    .I0(sig00000081),
    .I1(sig00000108),
    .O(sig0000010c)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk0000014c (
    .I0(sig000000ad),
    .I1(sig000000ac),
    .O(sig0000010d)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk0000014d (
    .I0(sig000000ab),
    .I1(sig000000aa),
    .O(sig0000010e)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk0000014e (
    .I0(sig000000a9),
    .I1(sig000000a8),
    .O(sig0000010f)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk0000014f (
    .I0(sig000000a7),
    .I1(sig000000a6),
    .O(sig00000110)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk00000150 (
    .I0(sig000000a5),
    .I1(sig000000a4),
    .O(sig00000111)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk00000151 (
    .I0(sig000000a3),
    .I1(sig000000a2),
    .O(sig00000112)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk00000152 (
    .I0(sig000000a1),
    .I1(sig000000a0),
    .O(sig00000113)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk00000153 (
    .I0(sig0000009f),
    .I1(sig0000009e),
    .O(sig00000114)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk00000154 (
    .I0(sig0000009d),
    .I1(sig0000009c),
    .O(sig00000115)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk00000155 (
    .I0(sig0000009b),
    .I1(sig0000009a),
    .O(sig00000116)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  blk00000156 (
    .I0(sig00000099),
    .I1(sig00000098),
    .O(sig00000117)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000157 (
    .I0(sig00000070),
    .I1(sig0000006f),
    .I2(sig00000118),
    .O(sig00000130)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000158 (
    .I0(sig0000007a),
    .I1(sig00000079),
    .I2(sig00000118),
    .O(sig0000013a)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000159 (
    .I0(sig00000071),
    .I1(sig00000070),
    .I2(sig00000118),
    .O(sig00000131)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk0000015a (
    .I0(sig00000072),
    .I1(sig00000071),
    .I2(sig00000118),
    .O(sig00000132)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk0000015b (
    .I0(sig00000073),
    .I1(sig00000072),
    .I2(sig00000118),
    .O(sig00000133)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk0000015c (
    .I0(sig00000074),
    .I1(sig00000073),
    .I2(sig00000118),
    .O(sig00000134)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk0000015d (
    .I0(sig00000075),
    .I1(sig00000074),
    .I2(sig00000118),
    .O(sig00000135)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk0000015e (
    .I0(sig00000076),
    .I1(sig00000075),
    .I2(sig00000118),
    .O(sig00000136)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk0000015f (
    .I0(sig00000077),
    .I1(sig00000076),
    .I2(sig00000118),
    .O(sig00000137)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000160 (
    .I0(sig00000078),
    .I1(sig00000077),
    .I2(sig00000118),
    .O(sig00000138)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000161 (
    .I0(sig00000079),
    .I1(sig00000078),
    .I2(sig00000118),
    .O(sig00000139)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000162 (
    .I0(sig0000006e),
    .I1(sig0000006d),
    .I2(sig00000118),
    .O(sig00000143)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000163 (
    .I0(sig0000006f),
    .I1(sig0000006e),
    .I2(sig00000118),
    .O(sig00000144)
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  blk00000164 (
    .I0(sig00000066),
    .I1(sig0000018f),
    .O(sig0000013b)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000165 (
    .I0(sig00000067),
    .I1(sig00000066),
    .I2(sig0000018f),
    .O(sig0000013c)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000166 (
    .I0(sig00000068),
    .I1(sig00000067),
    .I2(sig0000018f),
    .O(sig0000013d)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000167 (
    .I0(sig00000069),
    .I1(sig00000068),
    .I2(sig0000018f),
    .O(sig0000013e)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000168 (
    .I0(sig0000006a),
    .I1(sig00000069),
    .I2(sig0000018f),
    .O(sig0000013f)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk00000169 (
    .I0(sig0000006b),
    .I1(sig0000006a),
    .I2(sig0000018f),
    .O(sig00000140)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk0000016a (
    .I0(sig0000006c),
    .I1(sig0000006b),
    .I2(sig0000018f),
    .O(sig00000141)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk0000016b (
    .I0(sig0000006d),
    .I1(sig0000006c),
    .I2(sig0000018f),
    .O(sig00000142)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000016c (
    .I0(sig000000c9),
    .I1(sig00000052),
    .O(sig00000175)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000016d (
    .I0(sig000000c9),
    .I1(sig00000053),
    .O(sig00000176)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000016e (
    .I0(sig000000c9),
    .I1(sig00000051),
    .O(sig00000174)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000016f (
    .I0(sig000000c9),
    .I1(sig00000055),
    .O(sig00000178)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000170 (
    .I0(sig000000c9),
    .I1(sig00000056),
    .O(sig00000179)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000171 (
    .I0(sig000000c9),
    .I1(sig00000054),
    .O(sig00000177)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000172 (
    .I0(sig000000c9),
    .I1(sig00000058),
    .O(sig0000017b)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000173 (
    .I0(sig000000c9),
    .I1(sig00000059),
    .O(sig0000017c)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000174 (
    .I0(sig000000c9),
    .I1(sig00000057),
    .O(sig0000017a)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000175 (
    .I0(sig000000c9),
    .I1(sig0000005b),
    .O(sig0000017e)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000176 (
    .I0(sig000000c9),
    .I1(sig0000005c),
    .O(sig0000017f)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000177 (
    .I0(sig000000c9),
    .I1(sig0000005a),
    .O(sig0000017d)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000178 (
    .I0(sig000000c9),
    .I1(sig0000005e),
    .O(sig00000181)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000179 (
    .I0(sig000000c9),
    .I1(sig0000005f),
    .O(sig00000182)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000017a (
    .I0(sig000000c9),
    .I1(sig0000005d),
    .O(sig00000180)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000017b (
    .I0(sig000000c9),
    .I1(sig00000061),
    .O(sig00000184)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000017c (
    .I0(sig000000c9),
    .I1(sig00000062),
    .O(sig00000185)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000017d (
    .I0(sig000000c9),
    .I1(sig00000060),
    .O(sig00000183)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000017e (
    .I0(sig000000c9),
    .I1(sig00000064),
    .O(sig00000187)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk0000017f (
    .I0(sig000000c9),
    .I1(sig00000063),
    .O(sig00000186)
  );
  LUT2 #(
    .INIT ( 4'h4 ))
  blk00000180 (
    .I0(sig000000c9),
    .I1(sig00000065),
    .O(sig00000188)
  );
  FD   blk00000181 (
    .C(clk),
    .D(sig000000c8),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[7] )
  );
  FD   blk00000182 (
    .C(clk),
    .D(sig000000c7),
    .Q(\NlwRenamedSignal_U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op [6])
  );
  FD   blk00000183 (
    .C(clk),
    .D(sig000000c6),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[4] )
  );
  FD   blk00000184 (
    .C(clk),
    .D(sig000000c5),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[3] )
  );
  FD   blk00000185 (
    .C(clk),
    .D(sig000000c4),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[2] )
  );
  FD   blk00000186 (
    .C(clk),
    .D(sig000000c3),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[1] )
  );
  FD   blk00000187 (
    .C(clk),
    .D(sig00000004),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/exp_op[0] )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000188 (
    .I0(sig00000087),
    .O(sig00000189)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk00000189 (
    .I0(sig00000085),
    .O(sig0000018a)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk0000018a (
    .I0(sig00000083),
    .O(sig0000018b)
  );
  LUT6 #(
    .INIT ( 64'h2222222202222222 ))
  blk0000018b (
    .I0(sig0000004b),
    .I1(sig000000c9),
    .I2(sig0000004d),
    .I3(sig0000004e),
    .I4(sig0000004c),
    .I5(sig00000002),
    .O(sig000000c7)
  );
  LUT4 #(
    .INIT ( 16'hFBFF ))
  blk0000018c (
    .I0(sig0000018e),
    .I1(sig0000004f),
    .I2(sig00000145),
    .I3(sig00000050),
    .O(sig00000002)
  );
  LUT4 #(
    .INIT ( 16'h7FFF ))
  blk0000018d (
    .I0(sig0000004d),
    .I1(sig0000004e),
    .I2(sig0000004f),
    .I3(sig00000050),
    .O(sig0000018c)
  );
  LUT6 #(
    .INIT ( 64'h0000AAAA0000AA6A ))
  blk0000018e (
    .I0(sig0000004a),
    .I1(sig0000004b),
    .I2(sig0000004c),
    .I3(sig00000145),
    .I4(sig000000c9),
    .I5(sig0000018c),
    .O(sig000000c8)
  );
  LUT5 #(
    .INIT ( 32'hAAAA9959 ))
  blk0000018f (
    .I0(sig00000005),
    .I1(sig00000006),
    .I2(sig00000118),
    .I3(sig0000007c),
    .I4(sig0000007d),
    .O(sig00000045)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000190 (
    .I0(sig0000007f),
    .I1(sig0000011a),
    .I2(sig00000009),
    .I3(sig00000007),
    .O(sig00000030)
  );
  LUT4 #(
    .INIT ( 16'h5410 ))
  blk00000191 (
    .I0(sig0000007f),
    .I1(sig0000011a),
    .I2(sig0000000a),
    .I3(sig00000008),
    .O(sig00000031)
  );
  LUT4 #(
    .INIT ( 16'h4144 ))
  blk00000192 (
    .I0(sig000000c9),
    .I1(sig0000004f),
    .I2(sig00000145),
    .I3(sig00000050),
    .O(sig000000c3)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000193 (
    .I0(sig0000007f),
    .I1(sig0000011a),
    .I2(sig00000008),
    .O(sig0000002f)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000194 (
    .I0(sig0000007f),
    .I1(sig0000011a),
    .I2(sig00000007),
    .O(sig0000002e)
  );
  LUT6 #(
    .INIT ( 64'h22222222F0F0FF00 ))
  blk00000195 (
    .I0(sig00000007),
    .I1(sig00000119),
    .I2(sig00000009),
    .I3(sig0000000b),
    .I4(sig0000011a),
    .I5(sig0000007f),
    .O(sig00000032)
  );
  LUT6 #(
    .INIT ( 64'h22222222F0F0FF00 ))
  blk00000196 (
    .I0(sig00000008),
    .I1(sig00000119),
    .I2(sig0000000a),
    .I3(sig0000000c),
    .I4(sig0000011a),
    .I5(sig0000007f),
    .O(sig00000033)
  );
  LUT5 #(
    .INIT ( 32'h0000C6CC ))
  blk00000197 (
    .I0(sig0000004f),
    .I1(sig0000004e),
    .I2(sig00000145),
    .I3(sig00000050),
    .I4(sig000000c9),
    .O(sig000000c4)
  );
  LUT5 #(
    .INIT ( 32'hF0F0CCAA ))
  blk00000198 (
    .I0(sig00000096),
    .I1(sig0000008e),
    .I2(sig00000086),
    .I3(sig00000125),
    .I4(sig00000081),
    .O(sig0000002d)
  );
  LUT5 #(
    .INIT ( 32'hF0F0CCAA ))
  blk00000199 (
    .I0(sig00000095),
    .I1(sig0000008d),
    .I2(sig00000085),
    .I3(sig00000125),
    .I4(sig00000081),
    .O(sig0000002c)
  );
  LUT5 #(
    .INIT ( 32'hF0F0CCAA ))
  blk0000019a (
    .I0(sig00000094),
    .I1(sig0000008c),
    .I2(sig00000084),
    .I3(sig00000125),
    .I4(sig00000081),
    .O(sig0000002b)
  );
  LUT5 #(
    .INIT ( 32'hF0F0CCAA ))
  blk0000019b (
    .I0(sig00000093),
    .I1(sig0000008b),
    .I2(sig00000083),
    .I3(sig00000125),
    .I4(sig00000081),
    .O(sig0000002a)
  );
  LUT5 #(
    .INIT ( 32'hF0F0CCAA ))
  blk0000019c (
    .I0(sig00000092),
    .I1(sig0000008a),
    .I2(sig00000082),
    .I3(sig00000125),
    .I4(sig00000081),
    .O(sig00000029)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk0000019d (
    .I0(sig0000008d),
    .I1(sig00000085),
    .I2(sig00000125),
    .I3(sig00000081),
    .O(sig00000024)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk0000019e (
    .I0(sig0000008c),
    .I1(sig00000084),
    .I2(sig00000125),
    .I3(sig00000081),
    .O(sig00000023)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk0000019f (
    .I0(sig0000008b),
    .I1(sig00000083),
    .I2(sig00000125),
    .I3(sig00000081),
    .O(sig00000022)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk000001a0 (
    .I0(sig0000008a),
    .I1(sig00000082),
    .I2(sig00000125),
    .I3(sig00000081),
    .O(sig00000021)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk000001a1 (
    .I0(sig00000091),
    .I1(sig00000089),
    .I2(sig00000125),
    .I3(sig00000081),
    .O(sig00000028)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk000001a2 (
    .I0(sig00000090),
    .I1(sig00000088),
    .I2(sig00000125),
    .I3(sig00000081),
    .O(sig00000027)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk000001a3 (
    .I0(sig0000008f),
    .I1(sig00000087),
    .I2(sig00000125),
    .I3(sig00000081),
    .O(sig00000026)
  );
  LUT4 #(
    .INIT ( 16'h00CA ))
  blk000001a4 (
    .I0(sig0000008e),
    .I1(sig00000086),
    .I2(sig00000125),
    .I3(sig00000081),
    .O(sig00000025)
  );
  LUT6 #(
    .INIT ( 64'h00000000AA6AAAAA ))
  blk000001a5 (
    .I0(sig0000004d),
    .I1(sig0000004e),
    .I2(sig0000004f),
    .I3(sig00000145),
    .I4(sig00000050),
    .I5(sig000000c9),
    .O(sig000000c5)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001a6 (
    .I0(sig00000081),
    .I1(sig00000125),
    .I2(sig00000087),
    .O(sig0000001e)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001a7 (
    .I0(sig00000081),
    .I1(sig00000125),
    .I2(sig00000086),
    .O(sig0000001d)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001a8 (
    .I0(sig00000081),
    .I1(sig00000125),
    .I2(sig00000085),
    .O(sig0000001c)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001a9 (
    .I0(sig00000081),
    .I1(sig00000125),
    .I2(sig00000084),
    .O(sig0000001b)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001aa (
    .I0(sig00000081),
    .I1(sig00000125),
    .I2(sig00000083),
    .O(sig0000001a)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001ab (
    .I0(sig00000081),
    .I1(sig00000125),
    .I2(sig00000082),
    .O(sig00000019)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001ac (
    .I0(sig00000081),
    .I1(sig00000125),
    .I2(sig00000089),
    .O(sig00000020)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk000001ad (
    .I0(sig00000081),
    .I1(sig00000125),
    .I2(sig00000088),
    .O(sig0000001f)
  );
  LUT5 #(
    .INIT ( 32'hAAAA8088 ))
  blk000001ae (
    .I0(sig00000005),
    .I1(sig00000006),
    .I2(sig0000007c),
    .I3(sig00000118),
    .I4(sig0000007d),
    .O(sig00000044)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000001af (
    .C(clk),
    .CE(sig00000001),
    .D(sig0000010a),
    .Q(sig0000018d)
  );
  FD #(
    .INIT ( 1'b0 ))
  blk000001b0 (
    .C(clk),
    .D(sig00000043),
    .Q(sig0000018e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000001b1 (
    .C(clk),
    .CE(sig00000001),
    .D(sig000000fa),
    .Q(sig0000018f)
  );
  INV   blk000001b2 (
    .I(sig00000118),
    .O(sig00000049)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000001b3 (
    .A0(NlwRenamedSig_OI_result[0]),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(sig00000001),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(sig00000001),
    .CLK(clk),
    .D(operation_nd),
    .Q(sig00000190),
    .Q15(NLW_blk000001b3_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000001b4 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000190),
    .Q(\U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000001b5 (
    .A0(NlwRenamedSig_OI_result[0]),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(NlwRenamedSig_OI_result[0]),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(sig00000001),
    .CLK(clk),
    .D(sig00000081),
    .Q(sig00000191),
    .Q15(NLW_blk000001b5_Q15_UNCONNECTED)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000001b6 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000191),
    .Q(sig00000005)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000001b7 (
    .A0(NlwRenamedSig_OI_result[0]),
    .A1(NlwRenamedSig_OI_result[0]),
    .A2(sig00000001),
    .A3(NlwRenamedSig_OI_result[0]),
    .CE(sig00000001),
    .CLK(clk),
    .D(a[21]),
    .Q(sig00000192),
    .Q15(NLW_blk000001b7_Q15_UNCONNECTED)
  );
  FDE   blk000001b8 (
    .C(clk),
    .CE(sig00000001),
    .D(sig00000192),
    .Q(\U0/op_inst/FLT_PT_OP/FIX_TO_FLT_OP.SPD.OP/OP/sign_op )
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
