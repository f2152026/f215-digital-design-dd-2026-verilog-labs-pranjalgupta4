module tb;

  reg [1:0] t_a, t_b;
  wire t_gt, t_lt, t_eq;

  reg exp_gt, exp_lt, exp_eq;
  integer errors = 0;
  integer i, j;

  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  initial begin
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;

        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b | got GT=%b LT=%b EQ=%b | expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    if (errors == 0) begin
      $display("SUCCESS: All 16 test combinations passed!");
    end else begin
      $display("FAILED: %0d out of 16 test combinations failed.", errors);
    end

    $finish;
  end

endmodule