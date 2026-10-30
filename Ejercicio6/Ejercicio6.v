module Ejercicio6 (
    output oQ,
    input iT,
    input iCLK,
    input iRST
);

wire D;
assign D = oQ ^ iT;

D_FF D1 (
    .Q(oQ),
    .D(D),
    .CLK(iCLK),
    .RST(iRST)
);

endmodule


module D_FF (
    output reg Q,
    input D,
    input CLK,
    input RST
);

always @(posedge CLK or negedge RST)
begin
    if (!RST)
        Q <= 1'b0;
    else
        Q <= D;
end

endmodule