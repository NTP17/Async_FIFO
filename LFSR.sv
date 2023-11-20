module LFSR (
  input wire clk,
  input wire reset,
  //input wire enable,
  //input wire [23:0] seed,
  output wire [23:0] lfsr_output
);

  parameter seed = 24'h123456;
  reg [23:0] lfsr_reg;
  reg tap;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      lfsr_reg <= seed;
    end else /*if (enable)*/ begin
      tap = lfsr_reg[8]  ^ lfsr_reg[16];
      lfsr_reg <= {lfsr_reg[22:0], tap};
    end
  end

  assign lfsr_output = lfsr_reg;

endmodule
