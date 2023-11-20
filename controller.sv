module controller (
	input rclk, wclk, arst, ren, wen,
	output rclken, wclken, full, empty,
	output reg [5:0] rptr, wptr,
	output reg [5:0] gauge
);

	logic f, e;

	always_ff @ (posedge rclk, posedge arst)
		     if (arst)                     rptr <=        0;
		else if (ren && !e && rptr==6'h20) rptr <=        0;
		else if (ren && !e)                rptr <= rptr + 1;
		
	always_ff @ (posedge wclk, posedge arst)
		     if (arst)                     wptr <=        0;
		else if (wen && !f && wptr==6'h20) wptr <=        0;
		else if (wen && !f)                wptr <= wptr + 1;

	always_comb
		if (wptr+1==rptr || (wptr==6'h20 && rptr==0))
		begin
			f <= 1;
			e <= 0;
		end
		else
		if (rptr == wptr)
		begin
			f <= 0;
			e <= 1;
		end
		else
		begin
			f <= 0;
			e <= 0;
		end

	always_comb
		if (wptr >= rptr) gauge =         wptr - rptr;
		else              gauge = 6'd33 + wptr - rptr;
	
	assign full   =  f;
	assign empty  =  e;
	assign wclken = !f;
	assign rclken = !e;

endmodule