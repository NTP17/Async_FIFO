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
// CREATED		"Fri Sep 29 14:26:48 2023"

module fFFf(
	read_clock,
	write_clock,
	async_reset,
	read_enable,
	write_enable,
	data_in,
	FULL,
	EMPTY,
	data_out,
	read_pointer,
	write_pointer,
	used_words
);


input wire	read_clock;
input wire	write_clock;
input wire	async_reset;
input wire	read_enable;
input wire	write_enable;
input wire	[23:0] data_in;
output wire	FULL;
output wire	EMPTY;
output wire	[23:0] data_out;
output wire [5:0] read_pointer;
output wire [5:0] write_pointer;
output wire [5:0] used_words;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	[5:0] SYNTHESIZED_WIRE_4;
wire	[5:0] SYNTHESIZED_WIRE_5;

assign	SYNTHESIZED_WIRE_0 = 0;
assign	SYNTHESIZED_WIRE_1 = 0;
assign   read_pointer  = SYNTHESIZED_WIRE_4;
assign   write_pointer = SYNTHESIZED_WIRE_5;




dual_RAM	b2v_inst(
	.wren_a(SYNTHESIZED_WIRE_0),
	.rden_a(read_enable),
	.wren_b(write_enable),
	.rden_b(SYNTHESIZED_WIRE_1),
	.clock_a(read_clock),
	.enable_a(SYNTHESIZED_WIRE_2),
	.clock_b(write_clock),
	.enable_b(SYNTHESIZED_WIRE_3),
	.aclr_a(async_reset),
	.aclr_b(async_reset),
	.address_a(SYNTHESIZED_WIRE_4),
	.address_b(SYNTHESIZED_WIRE_5),
	
	.data_b(data_in),
	.q_a(data_out)
	);


controller	b2v_inst3(
	.rclk(read_clock),
	.wclk(write_clock),
	.arst(async_reset),
	.ren(read_enable),
	.wen(write_enable),
	.rclken(SYNTHESIZED_WIRE_2),
	.wclken(SYNTHESIZED_WIRE_3),
	.full(FULL),
	.empty(EMPTY),
	.rptr(SYNTHESIZED_WIRE_4),
	.wptr(SYNTHESIZED_WIRE_5),
	.gauge(used_words));




endmodule
