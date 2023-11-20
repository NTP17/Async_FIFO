module clock_1sec (
	input clkin, reset,
	output clkout
);

	reg [23:0] count;

	always_ff @ (posedge clkin, negedge reset)
	if (!reset) begin
		clkout <= 0;
		count <= 0;
	end
	else if (count == 24'd12499999) begin
		clkout <= !clkout;
		count <= 0;
	end
	else count <= count + 1;

endmodule
