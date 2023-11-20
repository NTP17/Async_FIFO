module clock_2sec (
	input clkin, reset,
	output clkout
);

	reg [24:0] count;

	always_ff @ (posedge clkin, negedge reset)
	if (!reset) begin
		clkout <= 0;
		count <= 0;
	end
	else if (count == 25'd24999999) begin
		clkout <= !clkout;
		count <= 0;
	end
	else count <= count + 1;

endmodule