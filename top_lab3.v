// Copyright (C) 2023  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 22.1std.2 Build 922 07/20/2023 SC Lite Edition"
// CREATED		"Tue Oct  3 16:55:55 2023"

module top_lab3(
	CLOCK_50,
	KEY,
	SW,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	LEDR
);


input wire	CLOCK_50;
input wire	[2:0] KEY;
input wire  [0:0] SW;
output wire	[6:0] HEX0;
output wire	[6:0] HEX1;
output wire	[6:0] HEX2;
output wire	[6:0] HEX3;
output wire	[6:0] HEX4;
output wire	[6:0] HEX5;
output wire	[2:0] LEDR;

wire	[23:0] dout;
wire	[5:0] fullness;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	[23:0] SYNTHESIZED_WIRE_6;





LFSR	b2v_inst(
	.clk(SYNTHESIZED_WIRE_7),
	.reset(KEY[2]),
	.lfsr_output(SYNTHESIZED_WIRE_6));
	defparam	b2v_inst.seed = 24'b000100100011010001010110;


clock_1sec	b2v_inst1(
	.clkin(CLOCK_50),
	.reset(KEY[2]),
	.clkout(SYNTHESIZED_WIRE_1));


clock_2sec	b2v_inst2(
	.clkin(CLOCK_50),
	.reset(KEY[2]),
	.clkout(SYNTHESIZED_WIRE_7));

assign	SYNTHESIZED_WIRE_3 =  ~KEY[2];


fFFf	b2v_inst4(
	.read_clock(SYNTHESIZED_WIRE_1),
	.write_clock(SYNTHESIZED_WIRE_7),
	.async_reset(SYNTHESIZED_WIRE_3),
	.read_enable(SYNTHESIZED_WIRE_4),
	.write_enable(SYNTHESIZED_WIRE_5),
	.data_in(SYNTHESIZED_WIRE_6),
	.FULL(LEDR[0]),
	.EMPTY(LEDR[2]),
	.data_out(dout),
	.used_words(fullness)
	);


segssel	b2v_inst5(
	.select(SW[0]),
	.HEX0a(dout[3:0]),
	.HEX0b(fullness[3:0]),
	.HEX1a(dout[7:4]),
	.HEX1b({2'b0, fullness[5:4]}),
	.HEX2a(dout[11:8]),
	.HEX2b(4'b0),
	.HEX3a(dout[15:12]),
	.HEX3b(4'b0),
	.HEX4a(dout[19:16]),
	.HEX4b(4'b0),
	.HEX5a(dout[23:20]),
	.HEX5b(4'b0),
	.SEG0(HEX0),
	.SEG1(HEX1),
	.SEG2(HEX2),
	.SEG3(HEX3),
	.SEG4(HEX4),
	.SEG5(HEX5));

assign	SYNTHESIZED_WIRE_4 =  ~KEY[1];

assign	SYNTHESIZED_WIRE_5 =  ~KEY[0];


endmodule
