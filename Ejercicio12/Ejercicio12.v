

module Ejercicio12 (
    input x,
    input CLK,
    input RST,
    output y,
    output A,
    output B
);

    wire TA, TB;

    // Ecuaciones de entrada
    assign TB = x;
    assign TA = x & B;

    // Ecuacion de salida
    assign y = A & B;

    // Flip-flops tipo T
    T_FF BF (
        .Q(B),
        .T(TB),
        .CLK(CLK),
        .RST(RST)
    );

    T_FF AF (
        .Q(A),
        .T(TA),
        .CLK(CLK),
        .RST(RST)
    );

endmodule


module T_FF (
    output reg Q,
    input T,
    input CLK,
    input RST
);

    always @(posedge CLK or negedge RST) begin
        if (!RST)
            Q <= 1'b0;
        else
            Q <= Q ^ T;
    end

endmodule


