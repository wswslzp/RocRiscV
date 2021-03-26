// Generator : SpinalHDL v1.4.3    git head : 4dd3b62906925bc269aee976e75f8918d4132efb
// Component : VarCir



module VarCir (
  input      [2:0]    io_xin,
  output     [2:0]    io_xout,
  input               clk,
  input               reset
);
  reg        [2:0]    tmp_4;
  reg        [2:0]    tmp_3;
  reg        [2:0]    tmp_2;
  reg        [2:0]    tmp_1;
  wire       [2:0]    tmp;
  reg        [2:0]    tmp_regNext;
  reg        [2:0]    tmp_1_regNext;
  reg        [2:0]    tmp_2_regNext;
  reg        [2:0]    tmp_3_regNext;

  always @ (*) begin
    tmp_4 = tmp_3;
    tmp_4 = tmp_3_regNext;
  end

  always @ (*) begin
    tmp_3 = tmp_2;
    tmp_3 = tmp_2_regNext;
  end

  always @ (*) begin
    tmp_2 = tmp_1;
    tmp_2 = tmp_1_regNext;
  end

  always @ (*) begin
    tmp_1 = tmp;
    tmp_1 = tmp_regNext;
  end

  assign tmp = io_xin;
  assign io_xout = tmp_4;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      tmp_regNext <= 3'b000;
      tmp_1_regNext <= 3'b000;
      tmp_2_regNext <= 3'b000;
      tmp_3_regNext <= 3'b000;
    end else begin
      tmp_regNext <= tmp;
      tmp_1_regNext <= tmp_1;
      tmp_2_regNext <= tmp_2;
      tmp_3_regNext <= tmp_3;
    end
  end


endmodule
