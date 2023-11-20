`timescale 1ps/1ps

module testFIFObench;

	/* INITIALIZATION */

	logic ar, rc, wc, re, we, f, e;
	logic [5:0] rp, wp, uw;
	logic [23:0] din, dout;
	
	fFFf dut (
		.read_clock(rc),
		.write_clock(wc),
		.async_reset(ar),
		.read_enable(re),
		.write_enable(we),
		.data_in(din),
		.FULL(f),
		.EMPTY(e),
		.data_out(dout),
		.read_pointer(rp),
		.write_pointer(wp),
		.used_words(uw)
	);

	logic [23:0] temps[31:0];
	
	/* WAVES FORMATION */

	initial begin
		ar = 'b1;
		rc = 'b0;
		re = 'b1;
		wc = 'b0;
		we = 'b1;
		din = $random;
		$dumpfile("firsttestfirstbench.vcd");
		$dumpvars;
	end

	initial #2 forever #2 din = $random;
	
	initial #1 rc = 'b1;
	
	initial repeat (70) #1 wc = !wc;
	
	initial repeat (32) #2 temps[wp] = din;
	
	initial begin
		#2;
		rc = 'b0;
		re = 'b0;
		ar = 'b0;
	end
	
	initial begin
		#70;
		we = 'b0;
		re = 'b1;
	end

	initial #70 repeat (76) #1 rc = !rc;
	
	initial #140 we = 'b1;
	
	initial #140 repeat (6) #1 wc = !wc;
	
	initial #146 do #1 wc = !wc; while (!f);
	
	initial #208 repeat (6) #1 begin
		wc = !wc;
		rc = !rc;
	end

	/* ASSERTIONS */

	property on_reset;
		@(posedge wc or posedge rc) ar |-> (!wp && !rp && e && !f);
	endproperty

	property write_op;
		@(posedge wc) (!ar && we && !f) |-> (((wp-1'b1 == $past(wp)) || (wp == 6'h0 && $past(wp) == 6'h20)) && !e)
		                                   && (uw-6'b1 == $past(uw)                                         && !e)
										   && (rp      == $past(rp)                                         && !e);
	endproperty

	property read_op;
		@(posedge rc) (!ar && re && !e) |-> (((rp-1'b1 == $past(rp)) || (rp == 6'h0 && $past(rp) == 6'h20)) && !f)
		                                   && (uw+6'b1 == $past(uw)                                         && !f)
										   && (wp      == $past(wp)                                         && !f);
	endproperty

	property dont_read_if_empty;
		@(posedge rc) (!ar && e) |-> rp == $past(rp);
	endproperty

	property dont_write_if_full;
		@(posedge wc) (!ar && f) |-> wp == $past(wp);
	endproperty
	
	property both_ops_same_time;
		@(posedge wc or posedge rc) (!ar && re && we) |-> (((wp-1'b1 == $past(wp)) || (wp == 6'h0 && $past(wp) == 6'h20)))
		                                               && (((rp-1'b1 == $past(rp)) || (rp == 6'h0 && $past(rp) == 6'h20)))
													   &&   (uw      == $past(uw));
	endproperty

	property both_ops_when_empty;
		@(posedge wc or posedge rc) (!ar && re && we) |-> (((wp-1'b1 == $past(wp)) || (wp == 6'h0 && $past(wp) == 6'h20)))
		                                                 && (uw-6'b1 == $past(uw))
														 && (rp      == $past(rp));
	endproperty

	property both_ops_when_full;
		@(posedge wc or posedge rc) (!ar && re && we) |-> (((rp-1'b1 == $past(rp)) || (rp == 6'h0 && $past(rp) == 6'h20)))
		                                                 && (uw+6'b1 == $past(uw))
														 && (wp      == $past(wp));
	endproperty

	initial #1
	assert (!(f && e))
	$display("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: FAILED", $time);

	initial #3
	assert (!(f && e))
	$display("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: FAILED", $time);

	initial #65
	assert (!(f && e))
	$display("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: FAILED", $time);

	initial #71
	assert (!(f && e))
	$display("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: FAILED", $time);

	initial #133
	assert (!(f && e))
	$display("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 1 - Full and Empty flag must NEVER BOTH be 1: FAILED", $time);
	
	initial #1
	assert property (on_reset)
	$display("@%0t: Test Case 2 - No operation can be carried when reset is raised: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 2 - No operation can be carried when reset is raised: FAILED", $time);
	
	initial #3 repeat (31) #2
	assert property (write_op)
	$display("@%0t: Test Case 3 - On write operation, both flags should be 0, write pointer and used words should increment by 1, and read pointer should stay the same: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 3 - On write operation, both flags should be 0, write pointer and used words should increment by 1, and read pointer should stay the same: FAILED", $time);
	
	initial #71 repeat (31) #2
	assert property (read_op)
	$display("@%0t: Test Case 4 - On read operation, both flags should be 0, write pointer should stay the same, read pointer should increment by 1, and used words should decrement by 1: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 4 - On read operation, both flags should be 0, write pointer should stay the same, read pointer should increment by 1, and used words should decrement by 1: FAILED", $time);

	initial #137
	assert property (dont_read_if_empty)
	$display("@%0t: Test Case 5 - Nothing should happen when attempting to read from an empty FIFO: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 5 - Nothing should happen when attempting to read from an empty FIFO: FAILED", $time);

	initial #69
	assert property (dont_write_if_full)
	$display("@%0t: Test Case 6 - Nothing should happen when attempting to write to a full FIFO: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 6 - Nothing should happen when attempting to write to a full FIFO: FAILED", $time);
	
	initial #70 repeat (32) #2
	assert (temps[rp-1] == dout)
	$display("@%0t: Test Case 7 - Data MUST be First In, First Out: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 7 - Data MUST be First In, First Out: FAILED", $time);
	
	initial #145
	assert property (both_ops_same_time)
	$display("@%0t: Test Case 8 - When neither empty nor full, attempting to read and write at the same time should increment both write and read pointer by 1, and used words should stay the same: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 8 - When neither empty nor full, attempting to read and write at the same time should increment both write and read pointer by 1, and used words should stay the same: FAILED", $time);
	
	initial #142
	assert property (both_ops_when_empty)
	$display("@%0t: Test Case 9 - When empty, attempting to read and write at the same time should be the same as Test Case 3: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 9 - When empty, attempting to read and write at the same time should be the same as Test Case 3: FAILED", $time);

	initial #210
	assert property (both_ops_when_full)
	$display("@%0t: Test Case 10 - When full, attempting to read and write at the same time should be the same as Test Case 4: PASSED", $time);
	else
	$fatal  ("@%0t: Test Case 10 - When full, attempting to read and write at the same time should be the same as Test Case 4: FAILED", $time);

	initial #220 $stop;

endmodule