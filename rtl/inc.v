`timescale 1ns / 1ps

module inc(
    input  [3:0] q,
    output [3:0] r
);

    assign r = q + 1;

endmodule
