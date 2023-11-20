module segssel(
	select,
	HEX0a,
	HEX0b,
	HEX1a,
	HEX1b,
	HEX2a,
	HEX2b,
	HEX3a,
	HEX3b,
	HEX4a,
	HEX4b,
	HEX5a,
	HEX5b,
	SEG0,
	SEG1,
	SEG2,
	SEG3,
	SEG4,
	SEG5
);


input wire	select;
input wire	[3:0] HEX0a;
input wire	[3:0] HEX0b;
input wire	[3:0] HEX1a;
input wire	[3:0] HEX1b;
input wire	[3:0] HEX2a;
input wire	[3:0] HEX2b;
input wire	[3:0] HEX3a;
input wire	[3:0] HEX3b;
input wire	[3:0] HEX4a;
input wire	[3:0] HEX4b;
input wire	[3:0] HEX5a;
input wire	[3:0] HEX5b;
output wire	[6:0] SEG0;
output wire	[6:0] SEG1;
output wire	[6:0] SEG2;
output wire	[6:0] SEG3;
output wire	[6:0] SEG4;
output wire	[6:0] SEG5;

wire	[6:0] seg1a;
wire	[6:0] seg1b;
wire	[6:0] seg2a;
wire	[6:0] seg2b;
wire	[6:0] seg3a;
wire	[6:0] seg3b;
wire	[6:0] seg4a;
wire	[6:0] seg4b;
wire	[6:0] seg5a;
wire	[6:0] seg5b;
wire	[6:0] seg0a;
wire	[6:0] seg0b;





binto7seg	b2v_inst(
	.bits(HEX0a),
	.segs(seg0a));


binto7seg	b2v_inst10(
	.bits(HEX1a),
	.segs(seg1a));


binto7seg	b2v_inst11(
	.bits(HEX1b),
	.segs(seg1b));


segsel	b2v_inst12(
	.sel(select),
	.seg0(seg1a),
	.seg1(seg1b),
	.segout(SEG1));


binto7seg	b2v_inst13(
	.bits(HEX2a),
	.segs(seg2a));


binto7seg	b2v_inst14(
	.bits(HEX2b),
	.segs(seg2b));


segsel	b2v_inst15(
	.sel(select),
	.seg0(seg2a),
	.seg1(seg2b),
	.segout(SEG2));


binto7seg	b2v_inst16(
	.bits(HEX3a),
	.segs(seg3a));


binto7seg	b2v_inst17(
	.bits(HEX3b),
	.segs(seg3b));


segsel	b2v_inst18(
	.sel(select),
	.seg0(seg3a),
	.seg1(seg3b),
	.segout(SEG3));


binto7seg	b2v_inst19(
	.bits(HEX4a),
	.segs(seg4a));


binto7seg	b2v_inst20(
	.bits(HEX4b),
	.segs(seg4b));


segsel	b2v_inst21(
	.sel(select),
	.seg0(seg4a),
	.seg1(seg4b),
	.segout(SEG4));


binto7seg	b2v_inst22(
	.bits(HEX5a),
	.segs(seg5a));


binto7seg	b2v_inst23(
	.bits(HEX5b),
	.segs(seg5b));


segsel	b2v_inst24(
	.sel(select),
	.seg0(seg5a),
	.seg1(seg5b),
	.segout(SEG5));


binto7seg	b2v_inst8(
	.bits(HEX0b),
	.segs(seg0b));


segsel	b2v_inst9(
	.sel(select),
	.seg0(seg0a),
	.seg1(seg0b),
	.segout(SEG0));


endmodule
