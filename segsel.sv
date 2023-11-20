module segsel (
	input [6:0] seg0, seg1,
	input sel,
	output [6:0] segout
);

	assign segout = sel ? seg1 : seg0;

endmodule
