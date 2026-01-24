`timescale 1ns / 1ps

module practice_tb;

    reg  [3:0] X, Y;
    reg  [1:0] sel;
    wire [3:0] Z;

    integer errors;
    integer test_num;
    reg [3:0] expected;

    // Instantiate the Unit Under Test (UUT)
    practice uut (
        .X(X),
        .Y(Y),
        .sel(sel),
        .Z(Z)
    );

    task check_output;
        input [3:0] exp;
        begin
            if (Z !== exp) begin
                $display("FAIL Test %0d: X=%b, Y=%b, sel=%b, Z=%b (expected %b)",
                         test_num, X, Y, sel, Z, exp);
                errors = errors + 1;
            end else begin
                $display("PASS Test %0d: X=%b, Y=%b, sel=%b, Z=%b",
                         test_num, X, Y, sel, Z);
            end
            test_num = test_num + 1;
        end
    endtask

    initial begin
        errors = 0;
        test_num = 1;

        $display("==============================================");
        $display("   Practice Module Testbench - Starting Tests");
        $display("==============================================");
        $display("   sel=00: Z = X (passthrough)");
        $display("   sel=01: Z = Y (passthrough)");
        $display("   sel=10: Z = X + Y (sum)");
        $display("   sel=11: Z = X + 1 (increment)");
        $display("==============================================");

        // -----------------------------------------------
        // Test sel=00: Z should equal X
        // -----------------------------------------------
        $display("\n--- Testing sel=00: Z = X ---");

        X = 4'b0000; Y = 4'b0000; sel = 2'b00; #10;
        check_output(4'b0000);

        X = 4'b1010; Y = 4'b0101; sel = 2'b00; #10;
        check_output(4'b1010);

        X = 4'b1111; Y = 4'b0001; sel = 2'b00; #10;
        check_output(4'b1111);

        // -----------------------------------------------
        // Test sel=01: Z should equal Y
        // -----------------------------------------------
        $display("\n--- Testing sel=01: Z = Y ---");

        X = 4'b0000; Y = 4'b0000; sel = 2'b01; #10;
        check_output(4'b0000);

        X = 4'b1010; Y = 4'b0101; sel = 2'b01; #10;
        check_output(4'b0101);

        X = 4'b0001; Y = 4'b1111; sel = 2'b01; #10;
        check_output(4'b1111);

        // -----------------------------------------------
        // Test sel=10: Z should equal X + Y (4-bit sum)
        // -----------------------------------------------
        $display("\n--- Testing sel=10: Z = X + Y ---");

        X = 4'b0000; Y = 4'b0000; sel = 2'b10; #10;
        check_output(4'b0000);

        X = 4'b0011; Y = 4'b0001; sel = 2'b10; #10;
        check_output(4'b0100);  // 3 + 1 = 4

        X = 4'b0101; Y = 4'b0011; sel = 2'b10; #10;
        check_output(4'b1000);  // 5 + 3 = 8

        X = 4'b1111; Y = 4'b0001; sel = 2'b10; #10;
        check_output(4'b0000);  // 15 + 1 = 0 (overflow)

        X = 4'b0110; Y = 4'b0110; sel = 2'b10; #10;
        check_output(4'b1100);  // 6 + 6 = 12

        // -----------------------------------------------
        // Test sel=11: Z should equal X + 1 (increment)
        // -----------------------------------------------
        $display("\n--- Testing sel=11: Z = X + 1 ---");

        X = 4'b0000; Y = 4'b0000; sel = 2'b11; #10;
        check_output(4'b0001);  // 0 + 1 = 1

        X = 4'b0100; Y = 4'b1010; sel = 2'b11; #10;
        check_output(4'b0101);  // 4 + 1 = 5

        X = 4'b1110; Y = 4'b0000; sel = 2'b11; #10;
        check_output(4'b1111);  // 14 + 1 = 15

        X = 4'b1111; Y = 4'b0000; sel = 2'b11; #10;
        check_output(4'b0000);  // 15 + 1 = 0 (overflow)

        // -----------------------------------------------
        // Summary
        // -----------------------------------------------
        $display("\n==============================================");
        if (errors == 0) begin
            $display("   ALL TESTS PASSED!");
            $display("==============================================");
            $finish;
        end else begin
            $display("   TESTS FAILED: %0d errors", errors);
            $display("==============================================");
            $fatal(1, "Testbench failed");
        end
    end

endmodule
