`timescale 1ns / 1ps

module practice(
    input  [3:0] X,
    input  [3:0] Y,
    input  [1:0] sel,
    output [3:0] Z
);

    // TODO: Declare internal wires W0 and W1 (both 4 bits wide)


    // TODO: Instantiate the sum module as U1
    //       Connect ports: .a(X), .b(Y), .c(W0)


    // TODO: Instantiate the inc module as U2
    //       Connect ports: .q(X), .r(W1)


    // TODO: Instantiate the mux module as U3
    //       Connect ports: .x0(X), .x1(Y), .x2(W0), .x3(W1), .sel(sel), .v(Z)


endmodule
