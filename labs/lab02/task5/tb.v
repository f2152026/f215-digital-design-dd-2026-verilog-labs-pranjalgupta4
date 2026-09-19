module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;
  wire [3:0] t_result;

  reg [3:0] exp_result;
  integer errors = 0;
  integer total_tests = 0;
  integer i, j, op_idx;

  alu DUT (
    .a  (t_a),
    .b  (t_b),
    .op (t_op),
    .result  (t_result)
  );

  initial begin
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (op_idx = 0; op_idx < 2; op_idx = op_idx + 1) begin
          t_a = i;
          t_b = j;
          t_op = op_idx;
          #5;

          if (t_op == 0) begin
            exp_result = t_a + t_b;
          end else begin
            exp_result = t_a - t_b;
          end

          total_tests = total_tests + 1;

          if (t_result !== exp_result) begin
            $display("FAIL at time %0t: A=%0d B=%0d op=%0b | got Y=%0d | expected Y=%0d",
                     $time, t_a, t_b, t_op, t_result, exp_result);
            errors = errors + 1;
          end
        end
      end
    end

    t_a = 4'd5;
    t_b = 4'd3;
    t_op = 0; #5;
    if (t_result !== 8) begin
      $display("FAIL [Sensitivity Test]: A=5, B=3, op=0 | got Y=%0d | expected 8", t_result);
      errors = errors + 1;
    end

    t_op = 1; #5;
    if (t_result !== 2) begin
      $display("FAIL [Sensitivity Test]: A=5, B=3, op=1 | got Y=%0d | expected 2", t_result);
      errors = errors + 1;
    end

    if (errors == 0) begin
      $display("SUCCESS: All %0d test cases passed cleanly!", total_tests + 2);
    end else begin
      $display("FAILED: %0d out of %0d tests failed.", errors, total_tests + 2);
    end

    $finish;
  end

endmodule